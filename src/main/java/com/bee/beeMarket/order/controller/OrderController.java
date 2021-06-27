package com.bee.beeMarket.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bee.beeMarket.order.service.OrderServiceImpl;
import com.bee.beeMarket.product.service.ProductServiceImpl;
import com.bee.beeMarket.seller.service.SellerServiceImpl;
import com.bee.beeMarket.vo.CartVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.SellerGradeVO;
import com.bee.beeMarket.vo.SellerVO;
import com.bee.beeMarket.vo.SellerWalletVO;
import com.bee.beeMarket.vo.SellerWithdrawVO;

@Controller
@RequestMapping("order/*")
public class OrderController {

	@Autowired
	private OrderServiceImpl orderService;
	
	@Autowired
	private SellerServiceImpl sellerService;

	@RequestMapping("cartProcess.do")
	public String cartProcess(HttpSession session, CartVO cartVO) {

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		cartVO.setCustomer_no(customer_no);

		orderService.insertCart(cartVO);

		return "redirect:./cartPage.do";
	}

	@RequestMapping("cartPage.do")
	public String cartPage(HttpSession session, Model model) {
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		ArrayList<HashMap<String, Object>> cartDataList = orderService.getCartByCustomerNo(customer_no);
		model.addAttribute("cartDataList", cartDataList);

		int cartCount = orderService.getCartCount(customer_no);
		model.addAttribute("cartCount", cartCount);

		return "order/cartPage";
	}

	@RequestMapping("deleteCartProcess.do")
	public String deleteCartProcess(int cart_no) {

		orderService.deleteCart(cart_no);

		return "redirect:./cartPage.do";
	}

	@RequestMapping("orderPage.do")
	public String orderPage(HttpSession session, int productdetail_no, int productdetail_count, Model model) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> orderData = orderService.getOrderData(session, productdetail_no, productdetail_count);
		model.addAttribute("orderData", orderData);
		map.put("orderData", orderData);

		return "order/orderPage";
	}

	@RequestMapping("deliverySuccess.do")
	public String deliverySuccess(HttpSession session, Model model) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList = orderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList = orderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);

		return "order/deliverySuccess";
	}

	// 여기부터
	@RequestMapping("orderList.do")
	public String orderList(HttpSession session, Model model) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList = orderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList = orderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);

		return "order/orderList";
	}

	@RequestMapping("prepareDeliveryList.do")
	public String prepareDeliveryList(HttpSession session, Model model) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList = orderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList = orderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);

		return "order/prepareDeliveryList";
	}

	@RequestMapping("refundList.do")
	public HashMap<String, Object> refundList(HttpSession session, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList = orderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList = orderService.getOrderStatusListCustomer();
		model.addAttribute("orderStatusList", orderStatusList);
		map.put("orderStatusList", orderStatusList);

		return map;
	}

	@RequestMapping("totalIncomeList.do")
	public HashMap<String, Object> totalIncome(HttpSession session, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> orderList = orderService.getOrderList(seller_no);
		model.addAttribute("orderList", orderList);
		map.put("orderList", orderList);
		ArrayList<HashMap<String, Object>> orderStatusList = orderService.getOrderStatusList();
		model.addAttribute("orderStatusList", orderStatusList);
		map.put("orderStatusList", orderStatusList);

		return map;
	}

	// 0529수정
	@RequestMapping("withdrawPage.do")
	public String withdrawPage(int seller_no, Model model) {
		// 필요한정보 sellerVO, bankVO, SellerWalletVO,
		HashMap<String, Object> sellerWallet = sellerService.getSellerWallet(seller_no);
		model.addAttribute("sellerWallet", sellerWallet);

		return "order/withdrawPage";
	}

	// 0529수정
	@RequestMapping("withdrawProcess.do")
	public String withdrawProcess(HttpSession session, HttpServletRequest request) {
		
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		String seller_id = sellerVO.getSeller_id();
		int seller_no = sellerVO.getSeller_no();
		int sellergrade_no = sellerVO.getSellergrade_no();
		int bank_no = sellerVO.getBank_no();
		String seller_account = sellerVO.getSeller_account();
		String seller_pw = request.getParameter("seller_pw");

		SellerWalletVO sellerWalletVO = sellerService.getWalletVO(seller_no);
		int wallet_no = sellerWalletVO.getWallet_no();
		int withdraw_amount = Integer.parseInt((request.getParameter("withdraw_amount")));

		SellerGradeVO sellerGradeVO = sellerService.getSellerGradeRate(sellergrade_no);
		int sellergrade_rate = sellerGradeVO.getSellergrade_rate(); // 3
		double withdraw_commission = (sellergrade_rate / 100) * withdraw_amount; // 수수료
		int totalMinus = (int) (withdraw_amount + withdraw_commission);

		int result = sellerService.checkSellerInfo(seller_id, seller_pw);
		if (result == 1) {
			SellerWithdrawVO sellerWithdrawVO = new SellerWithdrawVO();
			sellerWithdrawVO.setBank_no(bank_no);
			sellerWithdrawVO.setSeller_account(seller_account);
			sellerWithdrawVO.setWithdraw_commission((int) withdraw_commission);
			sellerWithdrawVO.setWallet_no(wallet_no);
			sellerWithdrawVO.setWithdraw_amount(withdraw_amount);

			System.out.println("암호일치:" + result);
			sellerService.insertWithdraw(sellerWithdrawVO);
			sellerService.updateWalletMinus(totalMinus, seller_no);

			return "redirect:./withdrawPage.do?success=withdraw&seller_no=" + seller_no;
		} else {
			return "redirect:./withdrawPage.do?error=pwError&seller_no=" + seller_no;
		}
	}

	@RequestMapping("withdrawList.do")
	   public String withdrawList(HttpSession session, Model model, @RequestParam(defaultValue = "1")int page_num)  {
	      SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
	      int seller_no = sellerVO.getSeller_no();
	      SellerWalletVO sellerWalletVO = sellerService.getWalletVO(seller_no);
	      int wallet_no = sellerWalletVO.getWallet_no();
	      System.out.println("sno:" + seller_no + "wno:" + wallet_no);      

	       ArrayList<HashMap<String, Object>> withdrawList = sellerService.getWithdrawListByWno(wallet_no, page_num);
	      model.addAttribute("withdrawList", withdrawList);
	      
	            //총 게시글 개수,게시물당 댓글개수, 게시물당 추천개수      
	               int totalCount = sellerService.getTotalWithdrawCount(wallet_no);
	               System.out.println("토탈카운트위드로우:"+totalCount);
	            
	            //페이징처리--검색전
	            int totalPageCount=(int)Math.ceil(totalCount/7.0);
	            int currentPage=page_num;
	            model.addAttribute("totalPageCount", totalPageCount);
	            model.addAttribute("currentPage", currentPage);
	         
	            //뭘까............흠 긁어오기 ㅎ
	            int totalBeginPage=((currentPage-1)/7)*7+1;
	            int totalEndPage=((currentPage-1)/7+1)*(7);
	            if(totalEndPage>totalPageCount) {
	               totalEndPage=totalPageCount;
	               //
	               System.out.println("비긴페이지:"+totalBeginPage);
	               // 
	               System.out.println("엔드페이지:"+totalEndPage);
	               // 
	               System.out.println("토탈페이지:"+totalPageCount);
	               // 
	            }
	             model.addAttribute("totalBeginPage", totalBeginPage);
	             model.addAttribute("totalEndPage", totalEndPage);
	             model.addAttribute("totalCount", totalCount);

	      return "order/withdrawList";
	   }
	   

	@RequestMapping("cancelTemp.do")
	public String cancelTemp(int order_no, Model model) {
		HashMap<String, Object> cancelOrder = orderService.getCancelOrderList(order_no);
		model.addAttribute("cancelOrder", cancelOrder);
		return "order/cancelTemp";
	}

	@RequestMapping("changeTemp.do")
	public String changeTemp(int order_no, Model model) {
		HashMap<String, Object> changeOrder = orderService.getChangeOrderList(order_no);
		model.addAttribute("changeOrder", changeOrder);
		return "order/changeTemp";
	}

	@RequestMapping("refundTemp.do")
	public String refundTemp(int order_no, Model model) {
		HashMap<String, Object> refundOrder = orderService.getRefundOrderList(order_no);
		model.addAttribute("refundOrder", refundOrder);
		return "order/refundTemp";
	}

}
