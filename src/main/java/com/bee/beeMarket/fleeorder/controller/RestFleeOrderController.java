package com.bee.beeMarket.fleeorder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.OrderDeliveryVO;
import com.bee.beeMarket.vo.OrderFleeMarketVO;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("fleeorder/*")
@ResponseBody
public class RestFleeOrderController {
	
	@Autowired
	private FleeOrderServiceImpl fleeOrderService;


	
//	@RequestMapping("addCart.do")
//	public void addCart(HttpSession session, CartVO cartVO) {
//		
//		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
//		int customer_no = customerVO.getCustomer_no();
//		cartVO.setCustomer_no(customer_no);
//		
//		orderService.insertCart(cartVO);
//	}
	
//	@RequestMapping("plusCartCount.do")
//	public void plusCartCount(int cart_no) {
//		orderService.plusCartCount(cart_no);
//	}
//	
//	@RequestMapping("minusCartCount.do")
//	public void minusCartCount(int cart_no) {
//		orderService.minusCartCount(cart_no);
//	}
	
//	@RequestMapping("updateCartCount.do")
//	public HashMap<String, Object> updateCartCount(int cart_no) {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		CartVO cartVO = orderService.updateCartCount(cart_no);
//		map.put("cartVO", cartVO);
//		
//		return map;
//	}
	
	@RequestMapping("orderDataLoarding.do")
	public HashMap<String, Object> orderDataLoarding(int[] fleemarketdetail_no, int[] fleemarketdetail_count, Model model) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> orderData = fleeOrderService.getOrderData(fleemarketdetail_no, fleemarketdetail_count);
		model.addAttribute("orderData", orderData);
		map.put("orderData", orderData);

		return map;
	}
	
	@RequestMapping("purchaseProcess.do")
	public void purchaseProcess(HttpSession session, int[] fleemarketdetail_no, int[] orderpayment_no, int[] orderflee_count , int[] address_no) {
		
		OrderFleeMarketVO orderFleeMarketVO = new OrderFleeMarketVO();
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		
		for (int i = 0; i < fleemarketdetail_no.length; i++) {
			
			orderFleeMarketVO.setCustomer_no(customer_no);
			orderFleeMarketVO.setFleemarketdetail_no(fleemarketdetail_no[i]);
			orderFleeMarketVO.setOrderpayment_no(orderpayment_no[i]);
			orderFleeMarketVO.setOrderflee_count(orderflee_count[i]);
			orderFleeMarketVO.setAddress_no(address_no[i]);
			
//			if (mycoupon_no.length != 0) {
//				orderVO.setMycoupon_no(mycoupon_no[i]);;
//			}
			

			fleeOrderService.insertOrderFleeMarket(orderFleeMarketVO);
		}

	}
	
	@RequestMapping("orderProcess.do")
	public void orderProcess(HttpSession session, OrderFleeMarketVO orderFleeMarketVO, FleeMarketVO fleeMarketVO) {
		
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		orderFleeMarketVO.setCustomer_no(customer_no);
		
		
		FleeMarketDetailVO fleeMarketDetailVO = fleeOrderService.getFleeMarketDetailVOByNo(orderFleeMarketVO.getFleemarketdetail_no());
		
		
		int orderflee_price = fleeMarketVO.getFleemarket_price()*orderFleeMarketVO.getOrderflee_count();
		orderFleeMarketVO.setOrderflee_price(orderflee_price);
		
		fleeOrderService.insertOrderFleeMarket(orderFleeMarketVO);
		
	}
	
	@RequestMapping("getCustomerDeliveryProcess.do")
	public HashMap<String, Object> getCustomerDeliveryProcess(int customer_no, Model model){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> addressData = fleeOrderService.addressData(customer_no);
		model.addAttribute("addressData", addressData);
		map.put("addressData", addressData);
		
		return map;
	}
	
	@RequestMapping("getAddressVOByAddNo.do")
	public HashMap<String, Object> getAddressVOByAddNo(int address_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		AddressListVO addressVO = fleeOrderService.getAddressVOByAddNo(address_no);
		map.put("addressVO", addressVO);
		
		return map;
		
	}
	
//	@RequestMapping("getCustomerCouponListProcess.do")
//	public HashMap<String, Object> getCustomerCouponListProcess(int customer_no, Model model){
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		ArrayList<HashMap<String, Object>> couponData = fleeOrderService.couponData(customer_no);
//		model.addAttribute("couponData", couponData);
//		
//		map.put("couponData", couponData);
//		
//		return map;
//	}
//	
//	
//	@RequestMapping("getCouponVOByMyCouponNo.do")
//	public HashMap<String, Object> getCouponVOByMyCouponNo(int mycoupon_no){
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		CouponVO couponVO = fleeOrderService.getCouponVOByMyCouponNo(mycoupon_no);
//		map.put("couponVO", couponVO);
//		
//		return map;
//		
//	}
	
	
	
	@RequestMapping("updateOrderStatus.do")
	public void updateOrderStatus(int order_status_no, int order_no) {
		fleeOrderService.updateOrderStatusByNo(order_status_no, order_no);
		//송장번호 발급, orderDeliveryVO insert
		if(order_status_no==3) {
			Random random = new Random();
			String orderdelivery_invoiceNumber = Integer.toString(random.nextInt(12)+1);
			for(int i=0; i < 12; i++){
				orderdelivery_invoiceNumber += Integer.toString(random.nextInt(12));
				}
			
			System.out.println("운송장번호 : " + orderdelivery_invoiceNumber);
			 OrderDeliveryVO orderDeliveryVO = new OrderDeliveryVO();
			 orderDeliveryVO.setOrder_no(order_no);
			 orderDeliveryVO.setOrderdelivery_invoiceNumber(orderdelivery_invoiceNumber);
			 orderDeliveryVO.setOrder_status_no(order_status_no);
			 fleeOrderService.insertInvoiceNum(orderDeliveryVO);
			 
		}
		//송장번호 발급취소, orderDeliveryVO delete
		if(order_status_no==2) {
			fleeOrderService.deleteInvoiceNum(order_status_no, order_no);
		}
	}
	
	@RequestMapping("orderList1.do")
	public HashMap<String, Object> orderList1(HttpSession session, Model model) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		SellerVO sellerVO=(SellerVO) session.getAttribute("sessionSeller");
		int seller_no=sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList=fleeOrderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList=fleeOrderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);
		map.put("orderStatusList", orderStatusList);
		
		return map;
	}

	@RequestMapping("prepareList.do")
	public HashMap<String, Object> prepareList(HttpSession session, Model model) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		SellerVO sellerVO=(SellerVO) session.getAttribute("sessionSeller");
		int seller_no=sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList=fleeOrderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList=fleeOrderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);
		map.put("orderStatusList", orderStatusList);
		
		return map;
	}
	@RequestMapping("deliverySuccessRest.do")
	public HashMap<String, Object> delivierySuccessList(HttpSession session, Model model) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		SellerVO sellerVO=(SellerVO) session.getAttribute("sessionSeller");
		int seller_no=sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList=fleeOrderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList=fleeOrderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);
		map.put("orderStatusList", orderStatusList);
		
		return map;
	}
//	@RequestMapping("refundListRest.do")
//	public HashMap<String, Object> refundList(HttpSession session, Model model) {
//		HashMap<String, Object> map=new HashMap<String, Object>();
//		SellerVO sellerVO=(SellerVO) session.getAttribute("sessionSeller");
//		int seller_no=sellerVO.getSeller_no();
//		ArrayList<HashMap<String, Object>> orderList=orderService.getOrderList(seller_no);
//		model.addAttribute("orderList", orderList);
//		map.put("orderList", orderList);
//		ArrayList<HashMap<String, Object>> orderStatusList=orderService.getOrderStatusListCustomer();
//		model.addAttribute("orderStatusList", orderStatusList);
//		map.put("orderStatusList", orderStatusList);
//		
//		return map;
//	}
//	
//	//여기부터
//	   @RequestMapping("updateCancelAuthDate.do")
//	   public void updateCancelAuthDate(int order_no) {
//	      orderService.updateCancelAuthDate(order_no);
//	      
//	   }
//	   
//	   @RequestMapping("updateChangeAuthDate.do")
//	   public void updateChangeAuthDate(int order_no, int change_addCost) {
//	      orderService.updateChangeAuthDate(order_no,change_addCost);
//	   }
//	   
//	   @RequestMapping("updateRefundAuthDate.do")
//	   public void updateRefundAuthDate(int order_no,int refund_addCost) {
//	      orderService.updateRefundAuthDate(order_no,refund_addCost);
//	   }
//	   
//	   @RequestMapping("insertChangeWithdrawing.do")
//	   public void insertChangeWithdrawing(int order_no) {
//	      Random random = new Random();
//	      String orderdelivery_invoiceNumber = Integer.toString(random.nextInt(12)+1);
//	      for(int i=0; i < 12; i++){
//	         orderdelivery_invoiceNumber += Integer.toString(random.nextInt(12));
//	      }
//	      System.out.println("운송장번호 : " + orderdelivery_invoiceNumber);
//	      OrderDeliveryVO orderDeliveryVO=new OrderDeliveryVO();
//	      orderDeliveryVO.setOrder_no(order_no);
//	      orderDeliveryVO.setOrderdelivery_invoiceNumber(orderdelivery_invoiceNumber);
//	      orderService.insertChangeInvoiceNum(orderDeliveryVO);
//	   }
//	   
//	   @RequestMapping("updateDeliverySuccess.do")
//	   public void updateDeliverySuccess(int order_no) {
//		   fleeOrderService.updateDeliverySuccess(order_no);
//	   }
	
}
