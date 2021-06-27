package com.bee.beeMarket.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bee.beeMarket.admin.service.AdminServiceImpl;
import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.seller.service.SellerServiceImpl;
import com.bee.beeMarket.vo.AdminVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@Autowired
	private AdminServiceImpl adminService;
	@Autowired
	private CustomerServiceImpl customerService;
	@Autowired
	private SellerServiceImpl sellerService;

	// 고객 qna 목록 받아오기
	@RequestMapping("CustomerQnAPage.do")
	public String CustomerQnAPage(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page_num) {

		AdminVO sessionAdmin = (AdminVO) session.getAttribute("sessionAdmin");

		int adminNo = sessionAdmin.getAdmin_no();
		
		ArrayList<HashMap<String, Object>> customerQnAList = customerService.getCustomerQnAList(adminNo, page_num);
		model.addAttribute("customerQnAList", customerQnAList);

		return "admin/CustomerQnAPage";
	}

	// 고객 qna 게시판 글 받아오기
	@RequestMapping("readCustomerQnAPage.do")
	public String readCustomerQnAPage(HttpSession session, Model model, int customerQnA_no) {

		HashMap<String, Object> map = customerService.getContent(customerQnA_no, true);
		model.addAttribute("data", map);

		return "admin/readCustomerQnAPage";
	}

	// 판매자 qna 목록 받아오기
	@RequestMapping("SellerQnAPage.do")
	public String SellerQnAPage(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page_num) {

		AdminVO sessionAdmin = (AdminVO) session.getAttribute("sessionAdmin");

		int adminNo = sessionAdmin.getAdmin_no();
		ArrayList<HashMap<String, Object>> sellerQnAList = sellerService.getSellerQnAList(adminNo, page_num);

		int count = sellerService.getContentCount();

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
		model.addAttribute("sellerQnAList", sellerQnAList);
		model.addAttribute("contentCount", count);

		return "admin/SellerQnAPage";

	}

	// 판매자 qna 게시판 글 받아오기
	@RequestMapping("readSellerQnAPage.do")
	public String readSellerQnAPage(HttpSession session, Model model, int sellerQnA_no) {

		HashMap<String, Object> map = sellerService.getContent(sellerQnA_no, true);
		model.addAttribute("data", map);

		return "admin/readSellerQnAPage";
	}

	// 관리자 로그인
	@RequestMapping("loginAdminPage.do")
	public String loginAdminPage() {
		return "admin/loginAdminPage";
	}

	// 관리자 로그인 프로세스
	@RequestMapping("loginAdminProcess.do")
	public String loginAdminProcess(AdminVO adminVO, HttpSession session) {
		AdminVO sessionAdmin = adminService.login(adminVO);

		if (sessionAdmin != null) {
			// 로그인 성공
			session.setAttribute("sessionAdmin", sessionAdmin);
			return "admin/adminMainPage";
		} else {
			// 실패
			return "admin/loginAdminFail";
		}
	}

	// 관리자 회원가입
	@RequestMapping("joinAdminPage.do")
	public String joinAdminPage() {
		return "admin/joinAdminPage";
	}

	// 관리자 회원가입 프로세스
	@RequestMapping("joinAdminProcess.do")
	public String joinAdminProcess(AdminVO adminVO) {
		adminService.JoinAdmin(adminVO);
		return "admin/joinAdminSuccess";
	}

	// 관리자 로그아웃
	@RequestMapping("logoutAdminProcess.do")
	public String logoutAdminProcess(HttpSession session) {

		session.invalidate();

		return "redirect:../admin/adminMainPage.do";
	}

	// 임시 관리자용 채팅 - 0606 수정
	   @RequestMapping("tempChatviewPage.do")
	   public String tempChatviewPage(Model model) {
	      ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
	      ArrayList<ChatChannelVO> channelList = adminService.getChannelList();
	      for (ChatChannelVO chatChannelVO : channelList) {
	         HashMap<String, Object> map = new HashMap<String, Object>();
	         map.put("chatChannelVO", chatChannelVO);
	         int channel_no=chatChannelVO.getChannel_no();
	         ArrayList<ChatVO> chatList = adminService.getChatForList(channel_no);
	         int unreadCount = adminService.getUnreadCount(channel_no);
	         map.put("chatList", chatList);
	         map.put("unreadCount", unreadCount);
	         result.add(map);
	      }
	      model.addAttribute("result", result);
	      return "admin/tempChatviewPage";
	   }

}
