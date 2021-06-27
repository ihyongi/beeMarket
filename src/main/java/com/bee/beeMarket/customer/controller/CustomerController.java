package com.bee.beeMarket.customer.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.product.service.ProductServiceImpl;
import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CustomerQnAImageVO;
import com.bee.beeMarket.vo.CustomerQnAVO;
import com.bee.beeMarket.vo.CustomerVO;

@Controller
@RequestMapping("customer/*")
public class CustomerController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private CustomerServiceImpl customerService;
	
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	
	@Autowired
	private ProductServiceImpl productService;
	
	@Autowired
	private FleeOrderServiceImpl fleeOrderService;
	
	@RequestMapping("loginCustomerPage.do")
	public String loginCustomerPage() {
		return "customer/loginCustomerPage" ;
		}
	
	@RequestMapping("joinCustomerPage.do")
	public String joinCustomerPage() {
		return "customer/joinCustomerPage";
		}
	
	@RequestMapping("joinCustomerProcess.do")
	public String joinCustomerProcess(CustomerVO customerVO, AddressListVO addressListVO) {
		//인증 키 생성
		UUID uuid = UUID.randomUUID();
		String authKey = uuid.toString();
		
		//메일보내기 (쓰레드) 시작
		MailSendThread mailSendThread =
				new MailSendThread(mailSender, customerVO.getCustomer_email(),authKey);
		mailSendThread.start();
		//메일보내기 끝
		
		customerService.JoinCustomer(customerVO, addressListVO, authKey);
		return "customer/joinCustomerSuccess";
		
		}
	@RequestMapping("loginCustomerProcess.do")
	public String loginCustomerProcess(CustomerVO customerVO , HttpSession session) {
		CustomerVO sessionCustomer = customerService.login(customerVO);
		
		if(sessionCustomer != null) {
		// 로그인 성공	
		session.setAttribute("sessionCustomer", sessionCustomer);
		return "redirect:../product/productMainPage.do";
		}else {
			//실패 
			return "customer/loginCustomerFail";
			}
		}
	@RequestMapping("logoutCustomerProcess.do")
	public String logoutCustomerProcess(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:../product/productMainPage.do";
		}
	@RequestMapping("authMail.do")
	public String authMail(String authKey) {
		
		customerService.authMail(authKey);
		
		return "customer/authMailComplete";
		}
	
	//  QnA 문의내역 확인 페이지
	@RequestMapping("readQnAPage.do")
	public String readQnAPage(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page_num) {
		
		
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		
		
		if (sessionCustomer != null) {
			int customerNo = sessionCustomer.getCustomer_no();
			
			//QnA 리스트 
			ArrayList<HashMap<String, Object>> customerQnAList = customerService.getCustomerQnAList(customerNo, page_num);
			//QnA 카테고리
			ArrayList<HashMap<String, Object>> customerQnACategoryList = customerService.getCustomerQnACategory();
			
			/*
			 * ArrayList<HashMap<String, Object>> categoryList =
			 * productService.getCategoryList(); model.addAttribute("categoryList",
			 * categoryList);
			 */
			
			
			int count = customerService.getContentCount();

			int totalPageCount = (int) Math.ceil(count / 10.0);

			int currentPage = page_num;

			int beginPage = ((currentPage - 1) / 5) * 5 + 1;
			int endPage = ((currentPage - 1) / 5 + 1) * (5);

			if (endPage > totalPageCount) {
				endPage = totalPageCount;
			}

			model.addAttribute("beginPage", beginPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("totalPageCount", totalPageCount);
			model.addAttribute("customerQnAList", customerQnAList);
			model.addAttribute("customerQnACategoryList", customerQnACategoryList);
			model.addAttribute("contentCount", count);

			return "customer/readQnAPage";
		} else {
			return "redirect:./loginCustomerPage.do";
		}
	}

	// 문의게시판 글쓰기
	@RequestMapping("writeQnAPage.do")
	public String writeQnAPage(Model model) {
		
		/*
		 * ArrayList<HashMap<String, Object>> categoryList =
		 * productService.getCategoryList(); model.addAttribute("categoryList",
		 * categoryList);
		 */
		
		//qna 카테고리
		ArrayList<HashMap<String, Object>> customerQnACategory = customerService.getCustomerQnACategory();
		model.addAttribute("customerQnACategory", customerQnACategory);
		
		return "customer/writeQnAPage";
	}

	// qna 내용 쓰기
	@RequestMapping("qnaWriteContentProcess.do")
	public String qnaWriteContentProcess(MultipartFile[] upload_files, CustomerQnAVO customerQnAVO, Model model, HttpSession session) {
		
		/*
		 * ArrayList<HashMap<String, Object>> categoryList =
		 * productService.getCategoryList(); model.addAttribute("categoryList",
		 * categoryList);
		 */		
		//세션 customer
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		int sessionCustomerNo = sessionCustomer.getCustomer_no();
		customerQnAVO.setCustomer_no(sessionCustomerNo);
		
		// 파일업로드
		ArrayList<CustomerQnAImageVO> customerQnAImageList = new ArrayList<CustomerQnAImageVO>();
		if (upload_files != null) {
			for (MultipartFile file : upload_files) {
				if (file.isEmpty()) {
					continue;
				}
				
				// 파일명 변경
				String oriFileName = file.getOriginalFilename();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String randomFileName = uuidName + "_" + currentTime + ext;

				// 날짜별 폴더 자동생성
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				String uploadFolderName = "C:/upload_files/" + newFolderName;

				// 폴더만들기
				File folder = new File(uploadFolderName);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String customerQnAImageFileLocation = uploadFolderName + "/" + randomFileName;
				try {
					file.transferTo(new File(customerQnAImageFileLocation));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				CustomerQnAImageVO customerQnAImageVO = new CustomerQnAImageVO();
				customerQnAImageVO.setCustomerqnaimage_location(newFolderName + "/" + randomFileName);
				customerQnAImageVO.setCustomerqnaimage_orifilename(oriFileName);
				customerQnAImageList.add(customerQnAImageVO);
			}
		} // 업로드 끝
		

		// .....
		customerService.writeContent(customerQnAVO, customerQnAImageList);
		return "redirect:./readQnAPage.do";
	}

	

	//마이페이지 관련
	
	//마이페이지로 이동
	@RequestMapping("myPageMain.do")
	public String myPageMain(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		
		ArrayList<HashMap<String, Object>> myPageData = customerService.getMyPageData(customer_no, session);
		model.addAttribute("myPageData", myPageData);
		
		return "customer/myPageMain";
	}
	
	//교환환불
	@RequestMapping("myExchangePage.do")
	public String exchangeMyPage(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		
		ArrayList<HashMap<String, Object>> myPageData = customerService.getMyPageData(customer_no, session);
		model.addAttribute("myPageData", myPageData);
		
		return "customer/myExchangePage";
	}
	
	@RequestMapping("myCoupon.do")
	public String myCoupon(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		
		int myCouponCount = customerSQLMapper.getMyCouponCount(customer_no);
		
		ArrayList<HashMap<String, Object>> myCouponData = customerService.getMyCouponData(customer_no, session);
		model.addAttribute("myCouponCount", myCouponCount);
		model.addAttribute("myCouponData", myCouponData);
		return "customer/myCoupon";
	}
	
	@RequestMapping("myCommentPage.do")
	public String myCommentPage(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		
		ArrayList<HashMap<String, Object>> myCommentData = customerService.getMyCommentData(customer_no, session);
		model.addAttribute("myCommentData", myCommentData);
		
		return "customer/myCommentPage";
	}
	
	@RequestMapping("confirmCustomerInformation.do")
	public String confirmCustomerInformation(HttpSession session) {
		return "customer/confirmCustomerInformation";
	}
	
	@RequestMapping("customerInfoPwCheck.do")
	public String customerInfoPwCheck(HttpServletRequest request, HttpSession session) {
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		String customer_id = customerVO.getCustomer_id();
		String customer_pw = request.getParameter("customer_pw");
		int result = customerService.checkCustomerInfo(customer_id, customer_pw);

		if(result==0) {
			return "redirect:./confirmCustomerInformation.do?error=pwError";
		}else{
			return "customer/myInformation";										
		}

	}
	
	@RequestMapping("myInformation.do")
	public String myInformation() {
		return "customer/myInformation";
	}
	
	@RequestMapping("myJellyPage.do")
	public String myJellyPage(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		int myJelly = customerSQLMapper.getMyPoint(customer_no);
		
		ArrayList<HashMap<String, Object>> myJellyData = customerService.getMyJellyData(customer_no,session);
		
		model.addAttribute("myJelly", myJelly);
		model.addAttribute("myJellyData",myJellyData);
		return "customer/myJellyPage";
	}
	
	@RequestMapping("myDeliveryPage.do")
	public String myDeliveryPage(Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no= customerVO.getCustomer_no();
		
		ArrayList<HashMap<String, Object>> myDeliveryData = customerService.getMyDeliveryData(customer_no, session);
		
		model.addAttribute("myDeliveryData",myDeliveryData);
		return "customer/myDeliveryPage";
	}
	
	@RequestMapping("myFleeMainPage.do")
	   public String myFleeMainPage(Model model , HttpSession session) {

		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = sessionCustomer.getCustomer_no();
		HashMap<String , Object> totalMap = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> fleeCartList = fleeOrderService.getFleeCartByCustomerNo(customer_no);
		
		int fleeCartCount = fleeOrderService.getFleeCartCount(customer_no);
		
		totalMap = fleeOrderService.selectFleeMarketDetailTotalByNo(customer_no);
//		System.out.println("cart: "+ totalMap);
		model.addAttribute("fleeCartList" , fleeCartList);
		model.addAttribute("totalMap" , totalMap);
		model.addAttribute("fleeCartCount", fleeCartCount);
		
//		System.out.println("totalMap:" +totalMap.toString());
	      
	      
	      return "customer/myFleeMainPage";
	   }
	
	
	
	
}	



class MailSendThread extends Thread{
	
	private JavaMailSender mailSender;         
	private String mailAddress;
	private String authKey;
	
	public MailSendThread(JavaMailSender mailSender, String mailAddress, String authKey) {
		super();
		this.mailSender = mailSender;
		this.mailAddress = mailAddress;
		this.authKey = authKey;
	}
	
	public void run() {
		try {                                        
		    MimeMessage message = null;
		    MimeMessageHelper messageHelper = null;
	        message = mailSender.createMimeMessage();
	        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	        messageHelper.setSubject("[회원가입]안녕하세요 회원 가입을 축하드립니다. 이메일 인증을 해주세요!");
	        
	        String text = "<a href='http://localhost:8181/beeMarket/customer/authMail.do?authKey="+authKey+"'>";
	        text += "메일 인증하기";
	        text += "</a>";
	        
	        messageHelper.setText(text, true);
	        messageHelper.setFrom("admin", "관리자");
	        messageHelper.setTo(mailAddress);
	        //messageHelper.addInline(contentId, dataSource);
	        mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
}


