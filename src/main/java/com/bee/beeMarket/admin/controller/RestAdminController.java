package com.bee.beeMarket.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bee.beeMarket.admin.service.AdminServiceImpl;
import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.seller.service.SellerServiceImpl;
import com.bee.beeMarket.vo.AdminVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CustomerQnAAnswerVO;
import com.bee.beeMarket.vo.SellerQnAAnswerVO;

@Controller
@RequestMapping("/admin/*")
@ResponseBody
public class RestAdminController {

	@Autowired
	AdminServiceImpl adminService;
	@Autowired
	CustomerServiceImpl customerService;
	@Autowired
	SellerServiceImpl sellerService;

	@RequestMapping("getSessionAdminNo.do")
	public HashMap<String, Object> getSessionAdminNo(HttpSession session) {

		AdminVO adminVO = (AdminVO) session.getAttribute("sessionAdmin");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("result", "success"); // 에러,예외,인증에 문제가 있을때 fail...이유를 전달해야된다.

		if (adminVO != null) {
			map.put("admin_no", adminVO.getAdmin_no());
		} else {
			map.put("admin_no", null);
		}

		return map;
	}

	// 관리자 답변 쓰기
	@RequestMapping("writeCustomerQnAAnswer.do")
	public void writeCustomerQnAAnswer(HttpSession session, CustomerQnAAnswerVO customerQnAAnswerVO) {

		AdminVO adminVO = (AdminVO) session.getAttribute("sessionAdmin");
		customerQnAAnswerVO.setAdmin_no(adminVO.getAdmin_no());

		adminService.writeCustomerQnAAnswer(customerQnAAnswerVO);
	}

	@RequestMapping("writeSellerQnAAnswer.do")
	public void writeSellerQnAAnswer(HttpSession session, SellerQnAAnswerVO sellerQnAAnswerVO) {

		AdminVO adminVO = (AdminVO) session.getAttribute("sessionAdmin");
		sellerQnAAnswerVO.setAdmin_no(adminVO.getAdmin_no());

		adminService.writeSellerQnAAnswer(sellerQnAAnswerVO);
	}

	// 관리자 답변삭제
	@RequestMapping("deleteCustomerQnAAnswer.do")
	public void deleteCustomerQnAAnswer(int customerQnAAnswer_no) {
		adminService.deleteCustomerQnAAnswer(customerQnAAnswer_no);
	}

	@RequestMapping("deleteSellerQnAAnswer.do")
	public void deleteSellerQnAAnswer(int sellerQnAAnswer_no) {
		adminService.deleteSellerQnAAnswer(sellerQnAAnswer_no);
	}

	// 관리자 - 고객답변리스트
	@RequestMapping("getCustomerQnAAnswerList.do")
	public ArrayList<HashMap<String, Object>> getCustomerQnAAnswerList(int customerQnA_no) {

		return adminService.getCustomerQnAAnswerList(customerQnA_no);

	}

	// 관리자 - 판매자 답변리스트
	@RequestMapping("getSellerQnAAnswerList.do")
	public ArrayList<HashMap<String, Object>> getSellerQnAAnswerList(int sellerQnA_no) {

		return adminService.getSellerQnAAnswerList(sellerQnA_no);

	}
	
	
	
	
	/* 관리자 채팅 */
	// 필터안된거
	@RequestMapping("joinChatProcess")
	public HashMap<String, Object> joinChatProcess(int chat_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ChatChannelVO> channelList = adminService.getChannelList();
		ArrayList<ChatVO> chatList = adminService.getChatList(chat_no);
		for (ChatVO chatVO : chatList) {
			int channel_no = chatVO.getChannel_no();
			ChatChannelVO chatChannelVO = adminService.getChannelVO(channel_no);
			int unreadCount = adminService.getUnreadCount(channel_no);
			map.put("chatChannelVO", chatChannelVO);
			map.put("unreadCount", unreadCount);
		}
		map.put("chatList", chatList);
		map.put("channelList", channelList);

		return map;
	}

	// 필터된거
	@RequestMapping("joinChatProcessByNo")
	public HashMap<String, Object> joinChatProcessByNo(int chat_no, int channel_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ChatVO> chatListByNo = adminService.getChatListByNo(chat_no, channel_no);
		map.put("chatListByNo", chatListByNo);

		return map;
	}

	// 이거 작업필요!! adminvo...
	@RequestMapping("insertChatLogProcessToCustomer.do")
	public void insertChatLogProcessToCustomer(HttpServletRequest request, String message, String receiver,
			int channel_no) {
		//System.out.println("msg:" + message);
		//System.out.println("rcvr:" + receiver);
		//System.out.println("chno:" + channel_no);

		adminService.insertChatLogProcessToCustomer(message, receiver, channel_no);
	}

}
