package com.bee.beeMarket.review.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.review.service.ReviewServiceImpl;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.ProductCategoryVO;
import com.bee.beeMarket.vo.ReviewCommentVO;
import com.bee.beeMarket.vo.ReviewImageVO;
import com.bee.beeMarket.vo.ReviewProductVO;
import com.bee.beeMarket.vo.ReviewVO;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
		
	@Autowired
	private ReviewServiceImpl reviewService;
	
	@RequestMapping("mainReviewPage.do")
	public String mainReviewPage(Model model, String search_word, String search_type , @RequestParam(defaultValue = "1") int page_num) {
		//메인 글 갯수 출력
		int count = reviewService.getReviewContentCount();
		
		model.addAttribute("count", count);
		//메인 목록 출력
		ArrayList<HashMap<String, Object>> reviewList = reviewService.getReviewList(search_word , search_type , page_num);
		
		int totalPageCount = (int)Math.ceil(count/10.0);
		
		int currentPage = page_num;
		
		int beginPage = ((currentPage-1)/5)*5+1;
		int endPage = ((currentPage-1)/5+1)*(5);
		
		if(endPage > totalPageCount) {
			endPage = totalPageCount;
		}
		
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPageCount", totalPageCount);
		
		model.addAttribute("reviewList", reviewList);
	
		return "review/mainReviewPage";
	}

	@RequestMapping(value="writeReviewPage.do", method = RequestMethod.GET)
	public String writeReviewPage(Model model) {
	
		//System.out.println("------------------------------1");
		ArrayList<ProductCategoryVO> productCategoryList = reviewService.getProductCategoryList();
		//System.out.println("---------------------------------2");
		model.addAttribute("productCategoryList", productCategoryList);
		//System.out.println("-----------------------------3");
		for(ProductCategoryVO productCategoryVO : productCategoryList) {
			System.out.println(productCategoryVO.getProduct_category_name());
		}
		
		return "review/writeReviewPage";
	}
	
	@RequestMapping("writeReviewProcess.do")
	public String writeReviewProcess(@RequestParam("product_category_name") String product_category_name,MultipartFile [] upload_files, ReviewVO reviewVO, HttpSession session) {
		
		int review_no = reviewService.createReviewNo();
	     
		ArrayList<ReviewImageVO> reviewImageVOList = 
				new ArrayList<ReviewImageVO>();
		
		if(upload_files !=null) {
			for(MultipartFile upload_file : upload_files) {
				
				if(upload_file.isEmpty()) {
					continue;
				}
				
				String oriFileName = upload_file.getOriginalFilename();
				
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				
				String randomFileName = uuidName + "_" + currentTime + ext;
				
				//날짜별 폴더 자동 생성...
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				
				String uploadFolderName = "c:/upload_files/" + newFolderName;
				
				File folder = new File(uploadFolderName);
				
				if(!folder.exists()) {
					folder.mkdirs();
				}
				
				String communicationImageFileLocation = uploadFolderName + "/" + randomFileName;
				
				try {
					upload_file.transferTo(new File(communicationImageFileLocation));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				ReviewImageVO reviewImageVO = new ReviewImageVO();
				
				reviewImageVO.setReview_no(review_no);
				reviewImageVO.setImage_location(newFolderName + "/" + randomFileName);
				reviewImageVO.setImage_original_filename(oriFileName);
				
				reviewImageVOList.add(reviewImageVO);
				
				for(ReviewImageVO ReviewImageVO : reviewImageVOList) {
					System.out.println(ReviewImageVO.getImage_original_filename());
				}
				
			}
		}
		
		
		CustomerVO sessionCustomer=(CustomerVO)session.getAttribute("sessionCustomer");
		
		int sessionNO = sessionCustomer.getCustomer_no();
		
		System.out.println(sessionNO+"Test");
		
		
		reviewVO.setCustomer_no(sessionNO);
		reviewVO.setReview_no(review_no);//따로 크리에이트키를 빼게 되면 이렇게 변수를 생성을 해야 한다..
	
		reviewService.writeReviewContent(reviewVO, reviewImageVOList);  //테이블 1개에  insert
		
		
		
		ReviewProductVO productVO = new ReviewProductVO();
		productVO.setProduct_category_name(product_category_name);
		
		productVO.getReview_no();
		//System.out.println(productVO.getProduct_category_name()+"//"+productVO.getReview_no());
		//System.out.println(productVO.getReview_no());
		
		//System.out.println("test01");
		reviewService.writeReviewProduct(productVO);  //상품  글번호, 상품이름  
		//System.out.println("test04");
		
		
		
		
		return "redirect:./mainReviewPage.do";
	}
	@RequestMapping("readReviewPage.do")
	public String readReviewPage(HttpSession session , Model model, int review_no) {
		
		
		CustomerVO sessionCustomer= (CustomerVO) session.getAttribute("sessionCustomer");
		
		if(sessionCustomer !=null) {
			int customer_no = sessionCustomer.getCustomer_no();
			int myRecommendCount = reviewService.getMyRecommendCount(review_no , customer_no);
			model.addAttribute("myRecommendCount" , myRecommendCount);
		}
		
		//조회수...
		reviewService.increaseReviewCount(review_no);
		
		
		//리뷰목록....
		HashMap<String, Object> map = reviewService.getReviewContent(review_no,true);//아직 쓰이는것이 아니다.
		model.addAttribute("data", map);
		
		//추천수
		int recommendcount = reviewService.Recommendcount(review_no);
		
		
		
		//댓글 불러오기
		
		ArrayList<HashMap<String, Object>> reviewCommentList = //이것이 있어야 내용이 출력이 된다.
				reviewService.getReviewCommentList(review_no);
		
		model.addAttribute("reviewCommentList" , reviewCommentList);
		
		model.addAttribute("recommendcount",recommendcount);
	
		return "review/readReviewPage";
	}
	@RequestMapping("updateReviewPage.do")
	public String updateReviewPage(Model model , int review_no) {
		
		HashMap<String, Object> map = reviewService.getReviewContent(review_no,false);
		
		model.addAttribute("data", map);
		
		return "review/updateReviewPage";
	}
	
	@RequestMapping("updateReviewProcess.do")
	public String updateReviewProcess(ReviewVO reviewVO) {
		
		reviewService.updateReviewContent(reviewVO);
		
		return "redirect:./mainReviewPage.do";
	}
	
	@RequestMapping("deleteReviewProcess.do")
	public String deleteReviewProcess(int review_no) {
		
		reviewService.deleteReviewContent(review_no);
		
		return "redirect:./mainReviewPage.do";
	}
	
	@RequestMapping("writeReviewCommentPage.do")
	public String writeReviewCommentPage() {
		
		return "review/readReviewPage";
	}
	
	@RequestMapping("writeReviewCommentProcess.do")
	public String writeReviewCommentProcess(ReviewCommentVO reviewCommentVO , HttpSession session , int review_no) {
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		
		int sessionNO = sessionCustomer.getCustomer_no();
		
		reviewCommentVO.setCustomer_no(sessionNO);
		
		reviewService.writeReviewComment(reviewCommentVO);
		
		return "redirect:./readReviewPage.do?review_no="+review_no;
		
	}
	
	@RequestMapping("updatewriteReviewCommentPage.do")
	public String updatewriteReviewCommentPage(int reviewcomment_no , Model model , int review_no) {
		
		HashMap<String, Object> map = reviewService.getReviewComment(reviewcomment_no, review_no);
		
		ReviewCommentVO reviewCommentVO = (ReviewCommentVO) map.get("reviewCommentVO");
		
		model.addAttribute("reviewcomment_no" , reviewcomment_no);
		model.addAttribute("reviewcomment_content", reviewCommentVO.getReviewcomment_content());//reviewCommentVO.getReviewcomment_content()이걸쓰기 위해서 ReviewCommentVO reviewCommentVO = (ReviewCommentVO) map.get("reviewCommentVO");을 작성을 하였다.. 
		model.addAttribute("review_no" , review_no);
		
		return "review/updatewriteReviewCommentPage";
	}
	
	
	
	@RequestMapping("updatewriteReviewCommentProcess.do")
	public String updatewriteReviewCommentProcess(ReviewCommentVO reviewCommentVO , int review_no) {
		
		reviewService.updatewriteReviewComment(reviewCommentVO);
		
		return "redirect:./readReviewPage.do?review_no="+ review_no;
	}
	
	@RequestMapping("deletewriteReviewCommentProcess.do")
	public String deletewriteReviewCommentProcess(ReviewCommentVO reviewCommentVO , int review_no) {
		reviewService.deleteReviewComment(reviewCommentVO);
		
		return "redirect:./readReviewPage.do?review_no="+ review_no;
	}
	
	@RequestMapping("recommendProcess.do")
	public String recommendProcess(HttpSession session , int review_no) {
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = sessionCustomer.getCustomer_no();
		
		reviewService.recommend(review_no , customer_no);//넣는 순서도 동일해야 하는것 같다.(review_no , customer_no)이렇게 했으면 저것대로 해야 한다.(customer_no, review_no)이렇게 하면 오류가 뜬다.
		
		return "redirect:./readReviewPage.do?review_no="+ review_no;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
