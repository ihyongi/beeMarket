package com.bee.beeMarket.fleemarket.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.fleemarket.service.FleeMarketServiceImpl;
import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketCommentVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketImageVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.SellerVO;
//0507
@Controller
@RequestMapping("fleemarket/*")
public class FleeMarketController {
	
	@Autowired
	private FleeMarketServiceImpl fleeMarketServiceImpl;
	//고객용 공동구매리스트
	@RequestMapping("customerFleeMarketPage.do")
	public String customerFleeMarketPage(HttpSession session,Model model, String search_word, String search_type,
			// 페이지넘버 int page num 추가
			@RequestParam(defaultValue = "1") int page_num) {
		
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		 int count=fleeMarketServiceImpl.getFleeMarketCount();
		ArrayList<HashMap<String, Object>> fleeMarketList = fleeMarketServiceImpl.getCustomerFleeMarketList(search_word, search_type, page_num);
		ArrayList<HashMap<String, Object>> bestFleeMarketList = fleeMarketServiceImpl.bestFleeMarketList();
		
		int totalPageCount = (int) Math.ceil(count/10.0);
		int currentPage = page_num;
		
		int beginPage = ((currentPage - 1)/5)*5 + 1;
		int endPage = ((currentPage - 1)/5 + 1)*(5);
		
		if(endPage > totalPageCount) {
			
			endPage = totalPageCount;
		}
		
		model.addAttribute("beginPage", beginPage);
	    model.addAttribute("endPage", endPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPageCount", totalPageCount);
		
		model.addAttribute("bestFleeMarketList", bestFleeMarketList);
		model.addAttribute("fleeMarketList", fleeMarketList);
		model.addAttribute("fleeMarketCount", count);
		
		return "fleemarket/customerFleeMarketPage";
	}
	//판매자시선 공동구매리스트
	@RequestMapping("sellerMainPage.do")
	public String sellerMainPage(HttpSession session, Model model, String search_word, String search_type, 
		      // 페이지넘버  int page num 추가
		      @RequestParam(defaultValue = "1") int page_num) {
		
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		
		if(sessionSeller != null) {
			
			int sessionNo=sessionSeller.getSeller_no();
		
		ArrayList<HashMap<String, Object>> fleeMarketList=fleeMarketServiceImpl.getSellerFleeMarketList(sessionNo, search_word, search_type, page_num);
		
		 int count=fleeMarketServiceImpl.getFleeMarketCount();
		
		// 페이지넘버 지정 -----
	      int totalPageCount = (int)Math.ceil(count/10.0);
	      int currentPage = page_num;
	      
	      int beginPage = ((currentPage-1)/5)*5 +1;
	      int endPage = ((currentPage-1)/5+1)*(5);
	      
	      if(endPage > totalPageCount) {
	         endPage = totalPageCount;
	      }
	      model.addAttribute("beginPage", beginPage);
	      model.addAttribute("endPage", endPage);
	      model.addAttribute("currentPage", currentPage);
	      model.addAttribute("totalPageCount", totalPageCount);
	      //페이지넘버 지정 끝 ----
	    model.addAttribute("fleeMarketCount", count);
		model.addAttribute("fleeMarketList", fleeMarketList);
		
		return "fleemarket/sellerMainPage";
		}else {
			return "redirect:../commons/loginPage.do";
		}
	}
	
	//판매자 게시글작성 페이지
	@RequestMapping("writeFleeMarketPage.do")
	public String writeFleeMarketPage(Model model) {
		ArrayList<HashMap<String, Object>> categoryList = fleeMarketServiceImpl.getCategoryList();
	      
	      model.addAttribute("categoryList" , categoryList);
	      
	      ArrayList<HashMap<String, Object>> categoryDetailList = fleeMarketServiceImpl.getCategoryDetailList();
	      
	      model.addAttribute("categoryDetailList", categoryDetailList);
		return "fleemarket/writeFleeMarketPage";
	}
	
	@RequestMapping("writeFleeMarketProcess.do")
	public String writeFleeMarketProcess(MultipartFile [] upload_files,FleeMarketVO fleeMarketVO, HttpSession session, Model model , HttpServletRequest request) {
		
		
		
		SellerVO sellerVO = (SellerVO)session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		fleeMarketVO.setSeller_no(seller_no);
		
		 ArrayList<FleeMarketImageVO> fleeMarketImageList=new ArrayList<FleeMarketImageVO>();
	      //파일업로드--배열로 받는다
	       if(upload_files !=null) {
	       for(MultipartFile file :upload_files) {
	          if(file.isEmpty()) {
	             continue;
	          }                                   
	       
	         String oriFileName=file.getOriginalFilename();
	         //확장자 추출필요.. oriFileName에서 뒤에.jpg만 추출(많이쓰는 api)
	         String ext=oriFileName.substring(oriFileName.lastIndexOf("."));
	         
	         //파일명을 바꿔서 업로드 함..
	         //이유..중복배제..
	         //방법: 랜덤+시간+확장자
	         long currentTime=System.currentTimeMillis();
	         UUID uuid=UUID.randomUUID();
	         String uuidName=uuid.toString();
	         String randomFileName=uuidName+"_"+currentTime+ext;
	            
	         //날짜별 폴더자동생성
	         Date date=new Date();
	         SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
	         String newFolderName=sdf.format(date);
	         String uploadFolderName="C:/upload_files/"+newFolderName;
	            
	         File folder=new File(uploadFolderName);
	         if(!folder.exists()) {
	            folder.mkdirs(); //폴더구조대로 싹 만들어줌
	         }
	         String FleeMarketImageFileLocation=uploadFolderName+"/"+randomFileName;
	         
	         try {
	            file.transferTo(new File(FleeMarketImageFileLocation));
	         } catch (IllegalStateException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }
	         FleeMarketImageVO fleeMarketImageVO=new FleeMarketImageVO();
	         fleeMarketImageVO.setFleemarketimage_location(newFolderName+"/"+randomFileName);
	         fleeMarketImageVO.setFleemarketimage_orifilename(oriFileName);
	            
	         fleeMarketImageList.add(fleeMarketImageVO);
	          }
	           
	       }
	       
	       //인풋(네임 productdetail_option)개수 받아오기
		    String[] option = request.getParameterValues("fleemarketdetail_option");
			
		    //받아온 값만큼 for문돌려서 삽입
		    ArrayList<FleeMarketDetailVO>  fleeMarketDetailList = new ArrayList<>();
		    
		    for( int i = 0; i<option.length; i++) {
		    	//fleeMarketDetail정보 리스트에 담아서 service에 전달
		    	FleeMarketDetailVO fleeMarketDetailVO = new FleeMarketDetailVO();
		    	fleeMarketDetailVO.setFleemarketdetail_option(option[i]);
		    	System.out.println("상품번호" + fleeMarketVO.getFleemarket_no());
		    	System.out.println("옵션" + option[i]);
		    	fleeMarketDetailList.add(fleeMarketDetailVO);
		    }
		
		
		fleeMarketServiceImpl.writeFleeContent(fleeMarketVO, fleeMarketImageList,fleeMarketDetailList);
		
		return "redirect:./sellerMainPage.do";
		
	}
	//게시물 글읽기
	@RequestMapping("readFleeMarketContentPage.do")
	public String readFleeMarketContentPage(Model model, int fleemarket_no, HttpSession session) {
		//글읽기
		HashMap<String,Object> map=fleeMarketServiceImpl.getFleeMarketContent(fleemarket_no, true);
		model.addAttribute("data", map);
		fleeMarketServiceImpl.increaseReadCount(fleemarket_no);
		//댓글목록
		ArrayList<HashMap<String, Object>> commentList = fleeMarketServiceImpl.getCommentList(fleemarket_no);
		//내 신청수
		CustomerVO sessionCustomer=(CustomerVO)session.getAttribute("sessionCustomer");
		if(sessionCustomer!=null) {
			int customer_no=sessionCustomer.getCustomer_no();
			int myApplicantCount=fleeMarketServiceImpl.getMyApplicantCount(fleemarket_no, customer_no);
			model.addAttribute("myApplicantCount", myApplicantCount);
		}
		
		
		//총 신청개수
		int allApplicantCount=fleeMarketServiceImpl.getFleeMarketApplicantCount(fleemarket_no);
	       model.addAttribute("commentList", commentList);
	       model.addAttribute("fleemarket_no", fleemarket_no);
	       model.addAttribute("allApplicantCount", allApplicantCount);
		
		
		return "fleemarket/readFleeMarketContentPage";
	}
	
	@RequestMapping("insertFleeMarketCartPage.do")
	public String insertFleeMarketCartPage(HttpSession session , int fleemarket_no , Model model ) {
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		
		
		
		
		return "fleemarket/insertFleeMarketCartPage.do";
	}
	
	
	// 판매자 게시물 글읽기
	@RequestMapping("readSellerFleeMarketContentPage.do")
	public String readSellerFleeMarketContentPageModel(Model model, int fleemarket_no, HttpSession session) {
		//글읽기
		HashMap<String,Object> map=fleeMarketServiceImpl.getFleeMarketContent(fleemarket_no, true);
		model.addAttribute("data", map);
		fleeMarketServiceImpl.increaseReadCount(fleemarket_no);
		//댓글목록
		ArrayList<HashMap<String, Object>> commentList = fleeMarketServiceImpl.getCommentList(fleemarket_no);


		//총 신청개수
		int allApplicantCount=fleeMarketServiceImpl.getFleeMarketApplicantCount(fleemarket_no);
	       model.addAttribute("commentList", commentList);
	       model.addAttribute("fleemarket_no", fleemarket_no);
	       model.addAttribute("allApplicantCount", allApplicantCount);
		
		return "fleemarket/readSellerFleeMarketContentPage";
	}
	
	
	//글수정 작업
	//작성한 글내용가져오기
	@RequestMapping("updateFleeMarketPage.do")
	public String updateFleeMarketPage(int fleemarket_no, Model model) {
		HashMap<String,Object> map=fleeMarketServiceImpl.getFleeMarketContent(fleemarket_no, false);
		model.addAttribute("data", map);
		
		return "fleemarket/updateFleeMarketPage";
	}
	
	//여기서 글수정작업
	@RequestMapping("updateFleeMarketProcess.do")
	public String updateFleeMarketProcess(FleeMarketVO fleeMarketVO) {
		fleeMarketServiceImpl.updateFleeMarket(fleeMarketVO);
		
		return "redirect:./sellerMainPage.do";
	}
	// 글 삭제 작업
	@RequestMapping("deleteFleeMarketProcess.do")
	public String deleteFleeMarketProcess(int fleemarket_no) {
		fleeMarketServiceImpl.deleteFleeMarket(fleemarket_no);
		return "redirect:./sellerMainPage.do";
	}
	
	
	
	
	
	
	
	
//	// **댓글 쓰기**
//	// score에 대한 실현가능성
//	@RequestMapping("insertCommentProcess.do")
//	public String insertCommentProcess(Model model, HttpSession session, int fleemarket_no, FleeMarketCommentVO fleeMarketCommentVO) {
//		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
//		int sessionNo = customerVO.getCustomer_no();
//		fleeMarketCommentVO.setCustomer_no(sessionNo);
//		fleeMarketServiceImpl.insertComment(fleemarket_no, fleeMarketCommentVO);
//		
//		
//		
//		return "redirect:./readFleeMarketContentPage.do?fleemarket_no="+fleemarket_no;
//	}
//	
//	// 댓글 내용 가져오기
//	@RequestMapping("updateCommentPage.do")
//	public String updateCommentPage(Model model, int comment_no, int fleemarket_no) {
//		
//		HashMap<String, Object> map= fleeMarketServiceImpl.getRepliyContent(comment_no, fleemarket_no);
//		FleeMarketCommentVO fleeMarketCommentVO = (FleeMarketCommentVO)map.get("fleeMarketCommentVO");
//		
//		System.out.println("updateCommentPage.do Start!!!");
//		System.out.println("글번호 =" + comment_no);       //글번호 
//		System.out.println("점수 =" + fleeMarketCommentVO.getFleemarket_score());    //점수 
//		System.out.println("내용 =" + fleeMarketCommentVO.getComment_content());  //내용
//		
//		 model.addAttribute("comment_no", comment_no);  //글번호
//		 model.addAttribute("fleemarket_score", fleeMarketCommentVO.getFleemarket_score()); //점수 
//		 model.addAttribute("comment_content", fleeMarketCommentVO.getComment_content()); //내용
//		 model.addAttribute("fleemarket_no", fleemarket_no);
//		
//		
//		return "fleemarket/updateCommentPage";
//	}
//	
//	// (수강평)댓글 수정하기 
//	@RequestMapping("updateCommentProcess.do")
//	public String updateCommentProcess(FleeMarketCommentVO fleeMarketCommentVO, int fleemarket_no) {
//		fleeMarketServiceImpl.updateComment(fleeMarketCommentVO);
//		
//		return "redirect:./readFleeMarketContentPage.do?fleemarket_no="+fleemarket_no;
//	}
//	
//	// 댓글 삭제하기
//	@RequestMapping("deleteCommentProcess.do")
//	public String deleteCommentProcess(int fleemarket_no, int comment_no) {
//		fleeMarketServiceImpl.deleteComment(comment_no);
//		
//		return "redirect:./readFleeMarketContentPage.do?fleemarket_no="+fleemarket_no;
//	}
//	
	// *******신청 작업*********
	@RequestMapping("applicantProcess.do")
	public String applicantProcess(int fleemarket_no,HttpSession session) {
		CustomerVO customerVO=(CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no=customerVO.getCustomer_no();
		fleeMarketServiceImpl.applicant(fleemarket_no, customer_no);
		
		
		
		return "redirect:./readFleeMarketContentPage.do?fleemarket_no="+fleemarket_no;
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
