package com.bee.beeMarket.customer.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bee.beeMarket.admin.service.AdminServiceImpl;
import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.vo.CustomerVO;

@Controller
@RequestMapping("/customer/*")
@ResponseBody
public class RestCustomerController {

	@Autowired
	private CustomerServiceImpl customerService;
	@Autowired
	private AdminServiceImpl adminService;
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	@Autowired
	private FleeOrderServiceImpl fleeOrderService;

	@RequestMapping("getSessionCustomerNo.do")
	public HashMap<String, Object> getSessionCustomerNo(HttpSession session) {

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("result", "success");

		if (customerVO != null) {
			map.put("customer_no", customerVO.getCustomer_no());
		} else {
			map.put("customer_no", null);
		}

		return map;
	}

	@RequestMapping("existId.do")
	public HashMap<String, Object> existId(String customer_id) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		boolean existId = customerService.existId(customer_id);

		map.put("result", "success");
		map.put("existId", existId);

		return map;
	}

	// qna 내용 불러오기
	@RequestMapping("getQnAContent.do")
	public HashMap<String, Object> getQnAContent(int no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> map2 = customerService.getContent(no, false);
		ArrayList<HashMap<String, Object>> commentlist = adminService.getCustomerQnAAnswerList(no);
		map.put("data", map2);
		map.put("commentlist", commentlist);
		return map;
	}
	
	@RequestMapping("likeProduct.do")
	public void likeProduct(int product_no, int customer_no) {
		customerService.likeProduct(customer_no, product_no);
		
	}
	
	@RequestMapping("deleteLikeProduct.do")
	public void deleteLikeProduct(int product_no, int customer_no) {
		customerService.deleteLikeProduct(customer_no, product_no);
		
	}

	// 마이페이지 개인정보수정 비밀번호 확인 과정
	@RequestMapping("confirmPw.do")
	public HashMap<String, Object> confirmPw(Model model, HttpSession session) {
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		String customer_pw = customerVO.getCustomer_pw();

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("customerVO", customerVO);
		return map;

	}

	// 마이페이지의 상단네비 회원 정보 가져오기
	@RequestMapping("getSessionInformation.do")
	public HashMap<String, Object> getSessionInformation(HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		int myCouponCount = customerSQLMapper.getMyCouponCount(customer_no);
		int myJelly = customerSQLMapper.getMyPoint(customer_no);
		int myDeliveryCount = customerSQLMapper.getMyDeliveryCount(customer_no);

		map.put("myDeliveryCount", myDeliveryCount);
		map.put("myJelly", myJelly);
		map.put("myCouponCount", myCouponCount);

		return map;
	}

	@RequestMapping("addDelivery.do")
	public void addDelivery(HttpSession session, HttpServletRequest request) {
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		String address_number = request.getParameter("address_number");
		String address_location = request.getParameter("address_location");
		int customer_no = customerVO.getCustomer_no();

		customerService.addDelivery(customer_no, address_number, address_location);
	}

	@RequestMapping("orderList.do")
	public HashMap<String, Object> orderList(int order_status_no, int customer_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		ArrayList<HashMap<String, Object>> sortOrderData = customerService.sortList(order_status_no, customer_no);
		map.put("sortOrderData", sortOrderData);

		return map;
	}

	@RequestMapping("getOrderDetail.do")
	public HashMap<String, Object> getOrderDetail(int order_no, int customer_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		HashMap<String, Object> OrderDetailData = customerService.getOrderDetail(order_no, customer_no);
		map.put("OrderDetailData", OrderDetailData);

		return map;
	}

	@RequestMapping("getComment.do")
	public HashMap<String, Object> getComment(int product_no, int customer_no) {

		HashMap<String, Object> commentData = customerService.getComment(product_no, customer_no);

		return commentData;
	}

	@RequestMapping("deleteDelivery.do")
	public void deleteDelivery(HttpSession session, HttpServletRequest request) {

		int address_no = Integer.parseInt(request.getParameter("address_no"));

		customerService.deleteDelivery(address_no);
	}

	@RequestMapping("jellyGift.do")
	public void jellyGift(int customer_no, int point_minus, String toCustomer_id) {

		customerService.giftJelly(customer_no, point_minus, toCustomer_id);
	}

	// 내가신청한 목록을 보는건가..?
	@RequestMapping("getChangeOrder.do")
	public HashMap<String, Object> getChangeOrder(int order_no, int customer_no) {
		HashMap<String, Object> changeOrderData = customerService.getChangeOrder(order_no, customer_no);
		return changeOrderData;
	}

	// 0604
	@RequestMapping("cancelOrder.do")
	public void cancelOrder(int order_no, String cancel_description) {
		customerService.cancelOrder(order_no, cancel_description); // 취소상태
		// 추가해야할거...커스토머한테 젤리로환불해줘야지
	}

	@RequestMapping("changeOrder.do")
	public void changeOrder(int order_no, int change_productdetail_no, String change_description) {
		customerService.changeOrder(order_no, change_productdetail_no, change_description);
	}

	@RequestMapping("changeDetailList.do")
	public HashMap<String, Object> changeDetailList(int product_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> changeDetailList = customerService.changeDetailList(product_no);
		map.put("changeDetailList", changeDetailList);
		return map;
	}

	@RequestMapping("refundOrder.do")
	public void refundOrder(int order_no, String refund_description) {
		customerService.refundOrder(order_no, refund_description);
		// 추가해야할거.. 커스토머에게 젤리로 환불해야줘야대
	}

	// 취소내역데이터
	@RequestMapping("cancelHistory.do")
	public HashMap<String, Object> cancelHistory(int order_no) {
		HashMap<String, Object> cancelHistory = customerService.getCancelHistory(order_no);

		return cancelHistory;
	}

	// 교환내역데이터
	@RequestMapping("changeHistory.do")
	public HashMap<String, Object> changeHistory(int order_no) {
		HashMap<String, Object> changeHistory = customerService.getChangeHistory(order_no);

		return changeHistory;
	}

	// 환불내역데이터
	@RequestMapping("refundHistory.do")
	public HashMap<String, Object> refundHistory(int order_no) {
		HashMap<String, Object> refundHistory = customerService.getRefundHistory(order_no);

		return refundHistory;
	}
	
	// (06.10)
	@RequestMapping("getFleeOrderDetail.do")
	public HashMap<String, Object> getFleeOrderDetail(Model model, int customer_no,int fleemarketcart_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> FleeOrderDetailData = customerService.getFleeOrderDetail(fleemarketcart_no, customer_no);
		ArrayList<HashMap<String, Object>> addressData = fleeOrderService.addressData(customer_no);
		model.addAttribute("addressData", addressData);
		map.put("addressData", addressData);
		map.put("FleeOrderDetailData", FleeOrderDetailData);
		
		return map;
	}

}