package com.bee.beeMarket.fleeorder.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketCartVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.OrderFleeMarketVO;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("fleeorder/*")
public class FleeOrderController {
	
	@Autowired
	private FleeOrderServiceImpl fleeOrderService;
	
	@RequestMapping("fleeCartPage.do")
	public String fleeCartPage(HttpSession session, Model model) {
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
		
		return "fleeorder/fleeCartPage";
		
	}
	
	@RequestMapping("fleeCartProcess.do")
	public String fleeCartProcess(HttpSession session, FleeMarketCartVO fleeMarketCartVO) {
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = sessionCustomer.getCustomer_no();
			fleeMarketCartVO.setCustomer_no(customer_no);
			
			fleeOrderService.insertFleeMarketCart(fleeMarketCartVO);
		
		
		return "redirect:./fleeCartPage.do";
	
	}
	
	@RequestMapping("deleteFleeCartProcess.do")
	public String deleteFleeCartProcess(int fleemarketcart_no) {
		
		fleeOrderService.deleteFleeCart(fleemarketcart_no);
		
		return "redirect:./fleeCartPage.do?fleemarketcart_no=" + fleemarketcart_no;
	}
	@RequestMapping("fleeOrderPage.do")
	public String fleeOrderPage(HttpSession session, Model model,int fleemarketdetail_no, int fleemarketdetail_count) {
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = sessionCustomer.getCustomer_no();
		
		HashMap<String,Object> orderData = fleeOrderService.getOrderData(session, fleemarketdetail_no, fleemarketdetail_count);
		
		model.addAttribute("orderData", orderData);
		map.put("orderData",orderData);
		
		
		return "fleeorder/fleeOrderPage";
	}
	
	//몬진모르지만...
	@RequestMapping("fleeOrderList.do")
	public HashMap<String, Object> orderList(HttpSession session, Model model){
		HashMap<String,Object> map = new HashMap<String, Object>();
		SellerVO sellerVO = (SellerVO)session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		
		ArrayList<HashMap<String,Object>> orderList = fleeOrderService.getOrderList(seller_no);
		model.addAttribute("orderList",orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String,Object>> orderStatusList=fleeOrderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);
		
		return map;
		
	}
	
	@RequestMapping("prepareDeliveryList.do")
	   public String prepareDeliveryList(HttpSession session, Model model) {
	      SellerVO sellerVO=(SellerVO) session.getAttribute("sessionSeller");
	      int seller_no=sellerVO.getSeller_no();
	      ArrayList<HashMap<String, Object>> orderList=fleeOrderService.getOrderList(seller_no);
	      model.addAttribute("orderList", orderList);
	      ArrayList<HashMap<String, Object>> orderStatusList=fleeOrderService.getOrderStatusList();
	      model.addAttribute("orderStatusList", orderStatusList);
	      
	      return "fleeorder/prepareDeliveryList";
	   }
	
	@RequestMapping("totalIncomeList")
	   public HashMap<String, Object> totalIncome(HttpSession session, Model model) {
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
	
	
	
	
}
