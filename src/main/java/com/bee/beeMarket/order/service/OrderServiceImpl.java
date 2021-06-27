package com.bee.beeMarket.order.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.order.mapper.OrderSQLMapper;
import com.bee.beeMarket.product.mapper.ProductSQLMapper;
import com.bee.beeMarket.seller.mapper.SellerSQLMapper;
import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CancelVO;
import com.bee.beeMarket.vo.CartVO;
import com.bee.beeMarket.vo.ChangeVO;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.CustomerGradeVO;
import com.bee.beeMarket.vo.CustomerPointVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.DeliveryVO;
import com.bee.beeMarket.vo.DiscountVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.OrderDeliveryVO;
import com.bee.beeMarket.vo.OrderStatusVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.RefundVO;
import com.bee.beeMarket.vo.SellerVO;

@Service
public class OrderServiceImpl {

	@Autowired
	private OrderSQLMapper orderSQLMapper;

	@Autowired
	private ProductSQLMapper productSQLMapper;

	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	
	@Autowired
	private SellerSQLMapper sellerSQLMapper;

	
	public void insertCart(CartVO cartVO) {
		orderSQLMapper.inserCart(cartVO);

	}

	public ArrayList<HashMap<String, Object>> getCartByCustomerNo(int customer_no) {
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<CartVO> cartList = orderSQLMapper.getCartByCustomerNo(customer_no);
		for (CartVO cartVO : cartList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int productdetail_no = cartVO.getProductdetail_no();
			ProductDetailVO productdetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
			int product_no = productdetailVO.getProduct_no();
			ProductVO productVO = productSQLMapper.selectProductByNo(product_no);
			ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(product_no);
			
			DiscountVO discountVO = productSQLMapper.getDiscountByDetailNo1(productdetail_no);
			if (discountVO == null) {
				map.put("productVO", productVO);
				map.put("productdetailVO", productdetailVO);
				map.put("productImageVO", productImageVO);
				map.put("cartVO", cartVO);

				result.add(map);
			} else {
				map.put("discountVO", discountVO);
				map.put("productVO", productVO);
				map.put("productdetailVO", productdetailVO);
				map.put("productImageVO", productImageVO);
				map.put("cartVO", cartVO);

				result.add(map);
			}
			

		}

		return result;

	}

	public int getCartCount(int customer_no) {
		return orderSQLMapper.getCartCountByCustomerNo(customer_no);
	}

	public void deleteCart(int cart_no) {
		orderSQLMapper.deleteCart(cart_no);

	}

	public void plusCartCount(int cart_no) {
		orderSQLMapper.plusCartCount(cart_no);
	}

	public void minusCartCount(int cart_no) {
		orderSQLMapper.minusCartCount(cart_no);

	}

	public CartVO updateCartCount(int cart_no) {
		return orderSQLMapper.getCartByCartNo(cart_no);
	};

	public ArrayList<HashMap<String, Object>> getCartOrderData(int[] cartNo) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<CartVO> cartList = new ArrayList<CartVO>();

		for (int i = 0; i < cartNo.length; i++) {
			CartVO cartVO = orderSQLMapper.getCartByCartNo(cartNo[i]);
			cartList.add(cartVO);
		}

		for (CartVO cartVO : cartList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int productdetail_no = cartVO.getProductdetail_no();
			ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
			int productdetail_price = productDetailVO.getProductdetail_price();
			int productdetail_count = cartVO.getProductdetail_count();

			int total_price = productdetail_price * productdetail_count;

			map.put("cartVO", cartVO);
			map.put("productDetailVO", productDetailVO);
			map.put("total_price", total_price);

			result.add(map);
		}

		return result;
	}

	public ArrayList<HashMap<String, Object>> getOrderData(int[] productdetail_no, int[] productdetail_count) {

		ArrayList<HashMap<String, Object>> getOrderData = new ArrayList<HashMap<String, Object>>();

		for (int i = 0; i < productdetail_no.length; i++) {

			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			// System.out.println(productdetail_no[i]);
			ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no[i]);
			int product_no = productDetailVO.getProduct_no();
			ProductVO productVO = productSQLMapper.getProductByNo(product_no);
			ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(product_no);

			// System.out.println(total_price);
			
			if (productDetailVO.getDiscount_status().equals("Y")) {
				
				DiscountVO discountVO = productSQLMapper.getDiscountByDetailNo1(productdetail_no[i]);
				int total_price = discountVO.getDiscount_price() * productdetail_count[i];
				int delivery_price = total_price + 2500;
				
				resultMap.put("productImageVO", productImageVO);
				resultMap.put("discountVO", discountVO);
				resultMap.put("productVO", productVO);
				resultMap.put("productDetailVO", productDetailVO);
				resultMap.put("productDetailCount", productdetail_count[i]);
				resultMap.put("total_price", total_price);
				resultMap.put("delivery_price", delivery_price);
				
				getOrderData.add(resultMap);
				
				
			} else {
				int total_price = productDetailVO.getProductdetail_price() * productdetail_count[i];
				int delivery_price = total_price + 2500;
				resultMap.put("productImageVO", productImageVO);
				resultMap.put("productVO", productVO);
				resultMap.put("productDetailVO", productDetailVO);
				resultMap.put("productDetailCount", productdetail_count[i]);
				resultMap.put("total_price", total_price);
				resultMap.put("delivery_price", delivery_price);

				getOrderData.add(resultMap);
			}
			
		}

		return getOrderData;
	}
	
	/*
	public HashMap<String, Object> getOrderData(HttpSession session, int productdetail_no, int productdetail_count) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println(productdetail_no);
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		
		int total_price = productDetailVO.getProductdetail_price() * productdetail_count;
		int delivery_price = total_price + 2500;
		
		System.out.println(total_price);
		
		resultMap.put("productDetailVO", productDetailVO);
		resultMap.put("productDetailCount", productdetail_count);
		resultMap.put("total_price", total_price);
		resultMap.put("delivery_price", delivery_price);
		
		return resultMap;
	}
	*/
	
	
	// 0530
	public HashMap<String, Object> getOrderData(HttpSession session, int productdetail_no, int productdetail_count) {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(productdetail_no);
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		int total_priceN = productDetailVO.getProductdetail_price() * productdetail_count;
		int delivery_priceN = total_priceN + 2500;
		// System.out.println(total_priceN);

		int product_no = productDetailVO.getProduct_no();
		ProductVO productVO = productSQLMapper.getProductByNo(product_no);
		ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(product_no);

		DiscountVO discountVO = productSQLMapper.getDiscountByDetailNo1(productdetail_no);
		if (discountVO != null) {
			int total_priceY = discountVO.getDiscount_price() * productdetail_count;
			int delivery_priceY = total_priceY + 2500;
			// System.out.println(total_priceN);

			resultMap.put("discountVO", discountVO);
			resultMap.put("total_priceY", total_priceY);
			resultMap.put("delivery_priceY", delivery_priceY);
			resultMap.put("productDetailVO", productDetailVO);
			resultMap.put("productDetailCount", productdetail_count);
			resultMap.put("total_priceN", total_priceN);
			resultMap.put("delivery_priceN", delivery_priceN);
			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);

		} else {
			resultMap.put("productDetailVO", productDetailVO);
			resultMap.put("productDetailCount", productdetail_count);
			resultMap.put("total_priceN", total_priceN);
			resultMap.put("delivery_priceN", delivery_priceN);
			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);
		}

		return resultMap;
	}
	
	public void insertOrderData(OrderVO orderVO) {

		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		
		DiscountVO discountVO = productSQLMapper.getDiscountByDetailNo1(productdetail_no);
		
		int productdetail_price = 0;
		
		String discount_status =  productDetailVO.getDiscount_status();
		if (discount_status.equals("Y")) {
			productdetail_price = discountVO.getDiscount_price();
		}else {
			productdetail_price = productDetailVO.getProductdetail_price();
		}
		
		int order_price = (productdetail_price * orderVO.getOrder_count()) + 2500;
		orderVO.setOrder_price(order_price);

		orderSQLMapper.insertOrder(orderVO);
		
		if (orderVO.getOrderpayment_no() == 2) {
			orderSQLMapper.minusRJ(orderVO.getCustomer_no(), order_price);
		}

	}

	public ArrayList<HashMap<String, Object>> addressData(int customer_no) {

		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<AddressListVO> addressListVOs = customerSQLMapper.getAddressListByCustomerNo(customer_no);

		for (AddressListVO addressListVO : addressListVOs) {

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("addressListVO", addressListVO);

			resultList.add(map);
		}

		return resultList;
	}

	public AddressListVO getAddressVOByAddNo(int address_no) {

		return customerSQLMapper.getAddressVOByAddNo(address_no);
	}

	public ArrayList<HashMap<String, Object>> couponData(int customer_no) {
		ArrayList<HashMap<String, Object>> couponDataList = new ArrayList<HashMap<String, Object>>();
		ArrayList<MyCouponVO> myCouponVOList = customerSQLMapper.getMyCouponListByCustomerNo(customer_no);

		for (MyCouponVO myCouponVO : myCouponVOList) {

			HashMap<String, Object> map = new HashMap<String, Object>();

			int coupon_no = myCouponVO.getCoupon_no();
			CouponVO couponVO = customerSQLMapper.getCoupondataByCouponNo(coupon_no);

			map.put("myCouponVO", myCouponVO);
			map.put("couponVO", couponVO);

			couponDataList.add(map);

		}
		return couponDataList;
	}

	public CouponVO getCouponVOByMyCouponNo(int mycoupon_no) {

		MyCouponVO myCouponVO = customerSQLMapper.getCouponVOByMyCouponNo(mycoupon_no);
		int coupon_no = myCouponVO.getCoupon_no();

		return customerSQLMapper.getCoupondataByCouponNo(coupon_no);
	}

	// 0528 효은
	public ProductDetailVO getproductDetailVOByNo(int productdetail_no) {
		return orderSQLMapper.getproductDetailVOByNo(productdetail_no);
	}

	public ArrayList<HashMap<String, Object>> getOrderList(int seller_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<SellerVO> orderList = orderSQLMapper.getOrderListBySellerNo(seller_no);
		for (SellerVO sellerVO : orderList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			result = new ArrayList<HashMap<String, Object>>();
			sellerVO.setSeller_no(seller_no);
			ArrayList<ProductVO> productList = productSQLMapper.getProductBySellerNo(seller_no);
			for (ProductVO productVO : productList) {
				int product_no = productVO.getProduct_no();
				DeliveryVO deliveryVO = productSQLMapper.getDeliveryCompanyName(product_no);
				ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
				for (ProductDetailVO productDetailVO : productDetailList) {
					int productdetail_no = productDetailVO.getProductdetail_no();
					System.out.println(productdetail_no);
					ArrayList<OrderVO> list = orderSQLMapper.getOrderByProductdetailNo(productdetail_no);
					for (OrderVO orderVO : list) {
						int order_no = orderVO.getOrder_no();
						int order_status_no = orderVO.getOrder_status_no();
						int customer_no = orderVO.getCustomer_no();
						CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
						OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatus(order_status_no);
						int address_no = orderVO.getAddress_no();
						AddressListVO addressListVO = orderSQLMapper.getAddressList(address_no);

						map = new HashMap<String, Object>();
						System.out.println(order_no);
						map.put("addressListVO", addressListVO);
						map.put("orderVO", orderVO);
						map.put("customerVO", customerVO);
						map.put("orderStatusVO", orderStatusVO);
						map.put("productDetailVO", productDetailVO);
						map.put("deliveryVO", deliveryVO);
						map.put("productVO", productVO);
						map.put("sellerVO", sellerVO);

						ArrayList<OrderDeliveryVO> orderDeliveryList = orderSQLMapper.getOrderDelivery(order_no);
						for (OrderDeliveryVO orderDeliveryVO : orderDeliveryList) {
							CancelVO cancelVO = orderSQLMapper.getCancelOrderList(order_no);
							ChangeVO changeVO = orderSQLMapper.getChangeOrderList(order_no);
							RefundVO refundVO = orderSQLMapper.getRefundOrderList(order_no);
							map.put("cancelVO", cancelVO);
							map.put("changeVO", changeVO);
							map.put("refundVO", refundVO);
							map.put("orderDeliveryVO", orderDeliveryVO);
							System.out.println("송장이요:"+orderDeliveryVO.getOrderdelivery_invoiceNumber());
							System.out.println("날짜요:"+orderDeliveryVO.getOrderdelivery_sendDate());
						}
						result.add(map);


					}
				}
			}
		}
		return result;
	}

	public ArrayList<HashMap<String, Object>> getOrderStatusList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<OrderStatusVO> orderStatusListSeller = orderSQLMapper.getOrderStatusListSeller();
		for (OrderStatusVO orderStatusVO : orderStatusListSeller) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderStatusVO", orderStatusVO);
			result.add(map);
		}
		return result;
	}

	public ArrayList<HashMap<String, Object>> getOrderStatusListCustomer() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<OrderStatusVO> orderStatusListCustomer = orderSQLMapper.getOrderStatusListCustomer();
		for (OrderStatusVO orderStatusVO : orderStatusListCustomer) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderStatusVO", orderStatusVO);
			result.add(map);
		}
		return result;
	}

	public void updateOrderStatusByNo(int order_status_no, int order_no) {
		orderSQLMapper.updateOrderStatusByNo(order_status_no, order_no);
	}

	public void insertInvoiceNum(OrderDeliveryVO orderDeliveryVO) {
		orderSQLMapper.insertInvoiceNum(orderDeliveryVO);

	}

	public void deleteInvoiceNum(int order_status_no, int order_no) {
		int num = orderSQLMapper.countInvoiceNum(order_no);
		if (num == 1) {
			orderSQLMapper.deleteInvoiceNum(order_no);
		} else {
			orderSQLMapper.updateOrderStatusByNo(order_status_no, order_no);
		}

	}

	public HashMap<String, Object> getCancelOrderList(int order_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		CancelVO cancelVO = orderSQLMapper.getCancelOrderList(order_no);
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		int order_status_no = orderVO.getOrder_status_no();
		OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatus(order_status_no);
		int customer_no = orderVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int product_no = productDetailVO.getProduct_no();
		ProductVO productVO = productSQLMapper.selectProductByNo(product_no);

		map.put("cancelVO", cancelVO);
		map.put("orderStatusVO", orderStatusVO);
		map.put("orderVO", orderVO);
		map.put("customerVO", customerVO);
		map.put("productDetailVO", productDetailVO);
		map.put("productVO", productVO);
		return map;
	}

	public HashMap<String, Object> getChangeOrderList(int order_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ChangeVO changeVO = orderSQLMapper.getChangeOrderList(order_no);
		int change_productdetail_no = changeVO.getChange_productdetail_no();
		ProductDetailVO changeProductDetailVO = productSQLMapper.getProductDetailByNo(change_productdetail_no);
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		int order_status_no = orderVO.getOrder_status_no();
		OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatus(order_status_no);
		int customer_no = orderVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int product_no = productDetailVO.getProduct_no();
		ProductVO productVO = productSQLMapper.selectProductByNo(product_no);
		ArrayList<ProductDetailVO> productdetailList = productSQLMapper.selectDetailByProductNO(product_no);

		map.put("changeVO", changeVO);
		map.put("changeProductDetailVO", changeProductDetailVO);
		map.put("orderVO", orderVO);
		map.put("orderStatusVO", orderStatusVO);
		map.put("customerVO", customerVO);
		map.put("productDetailVO", productDetailVO);
		map.put("productVO", productVO);
		map.put("productdetailList", productdetailList);
		return map;
	}

	public HashMap<String, Object> getRefundOrderList(int order_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		RefundVO refundVO = orderSQLMapper.getRefundOrderList(order_no);
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		int order_status_no = orderVO.getOrder_status_no();
		OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatus(order_status_no);
		int customer_no = orderVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int product_no = productDetailVO.getProduct_no();
		ProductVO productVO = productSQLMapper.selectProductByNo(product_no);

		map.put("refundVO", refundVO);
		map.put("orderStatusVO", orderStatusVO);
		map.put("orderVO", orderVO);
		map.put("customerVO", customerVO);
		map.put("productDetailVO", productDetailVO);
		map.put("productVO", productVO);
		return map;
	}

	// 여기부터
	// 신청->진행
	public void updateCancelAuthDate(int order_no) {
		orderSQLMapper.updateCancelAuthDate(order_no);
	}

	public void updateChangeAuthDate(int order_no, int change_addCost) {
		ChangeVO changeVO = orderSQLMapper.getChangeOrderList(order_no);
		changeVO.setChange_addCost(change_addCost);
		orderSQLMapper.updateChangeAuthDate(order_no, change_addCost);
		orderSQLMapper.updateTwoSteps(order_no); // 교환신청->교환진행 5분뒤에 상품회수중으로 바뀌게 만들까..?(자동)
	}

	public void updateRefundAuthDate(int order_no, int refund_addCost) {
		RefundVO refundVO = orderSQLMapper.getRefundOrderList(order_no);
		refundVO.setRefund_addCost(refund_addCost);
		orderSQLMapper.updateRefundAuthDate(order_no, refund_addCost);
		orderSQLMapper.updateTwoSteps(order_no); // 환불신청->환불진행 5분뒤에 상품회수중으로 바뀌게 만들까..?(자동)
	}

	// 상품회수중..송장번호 부여
	public void insertChangeInvoiceNum(OrderDeliveryVO orderDeliveryVO) {
		orderSQLMapper.insertChangeInvoiceNum(orderDeliveryVO);
		orderSQLMapper.withdrawingProduct(orderDeliveryVO.getOrder_no());

	}

	public void insertRefundInvoiceNum(OrderDeliveryVO orderDeliveryVO) {
		orderSQLMapper.insertRefundInvoiceNum(orderDeliveryVO);
		orderSQLMapper.withdrawingProduct(orderDeliveryVO.getOrder_no());
	}


	public ArrayList<HashMap<String, Object>> getOrderGenderChartData(int product_no) {
		// TODO Auto-generated method stub
		return orderSQLMapper.getOrderGenderChartData(product_no);
	}

	public ArrayList<HashMap<String, Object>> getOrderAgeChartData(int product_no) {
		// TODO Auto-generated method stub
		return orderSQLMapper.getOrderAgeChartData(product_no);
	}
	
	 //0529수정 상품회수중..송장번호 부여
    public void changeRetrieveing(OrderDeliveryVO orderDeliveryVO) {
       orderSQLMapper.insertChangeInvoiceNum(orderDeliveryVO);
       orderSQLMapper.withdrawingChangeProduct(orderDeliveryVO.getOrder_no()); //상품회수중
       
    }
    
    public void refundRetrieveing(OrderDeliveryVO orderDeliveryVO) {
       orderSQLMapper.insertRefundInvoiceNum(orderDeliveryVO);
       orderSQLMapper.withdrawingRefundProduct(orderDeliveryVO.getOrder_no()); //상품회수중
    }
    
    //배송중->배송완료
    public void updateDeliverySuccess(int order_no) {
       orderSQLMapper.updateOneStep(order_no);
    }
 
	// 0603
	// 구매확정(확정일, 상태바꾸기) 구매확정일 찍히게 판매자 지갑에 임시저장
	public void updateConfrimdate(int order_no) {
		orderSQLMapper.updateConfrimdate(order_no); // 상태바뀌면서
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		int order_price = orderVO.getOrder_price();
		int total_price = order_price - 2500;// 배송비뺀금액
		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int product_no = productDetailVO.getProduct_no();
		ProductVO productVO = productSQLMapper.getProductByNo(product_no);
		int seller_no = productVO.getSeller_no();
		sellerSQLMapper.earnWallet(total_price, seller_no); // 판매자 지갑에도 insert

		// 구매자에게 등급별로 젤리적립
		int customer_no = orderVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
		int customergrade_no = customerVO.getCustomergrade_no();
		CustomerGradeVO customerGradeVO = customerSQLMapper.getCustomerRate(customergrade_no);
		int customergrade_rate = customerGradeVO.getCustomergrade_rate(); // 1
		CustomerPointVO customerPointVO = new CustomerPointVO();
		int point_plus = (int) (((double) customergrade_rate / 100) * total_price);
		//System.out.println("customergrade_rate:" + customergrade_rate);
		//System.out.println("point_plus:" + point_plus);
		int pointPk = customerSQLMapper.createCustomerPointkey();
		customerPointVO.setPoint_no(pointPk);
		customerPointVO.setCustomer_no(customer_no);
		customerPointVO.setPoint_plus(point_plus);
		customerSQLMapper.insertCustomerPoint(customerPointVO); // 구매적립

	}

	// 상품회수완료
	public void retrievedProduct(int order_no) {
		orderSQLMapper.retrievedProduct(order_no); // 상품회수완료
	}

	// 교환상품 배송준비중
	public void preparingProduct(int order_no) {
		orderSQLMapper.preparingProduct(order_no);
	}

	// 0605
	// 환불완료상태 ->바뀌면서 customer한테 젤리적립(배송비는 선불이라는 가정하에..)
	public void successRefund(int order_no) {
		orderSQLMapper.successRefund(order_no); // 상태바꾸고
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		int order_price = orderVO.getOrder_price();
		int point_plus = order_price - 2500;
		int customer_no = orderVO.getCustomer_no();
		CustomerPointVO customerPointVO = new CustomerPointVO();
		customerPointVO.setCustomer_no(customer_no);
		customerPointVO.setPoint_plus(point_plus);
		customerSQLMapper.insertCustomerPointCancel(customerPointVO);// 반품적립
	}

}
