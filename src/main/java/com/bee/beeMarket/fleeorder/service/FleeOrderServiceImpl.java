package com.bee.beeMarket.fleeorder.service;
	
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.fleemarket.mapper.FleeMarketImageSQLMapper;
import com.bee.beeMarket.fleemarket.mapper.FleeMarketSQLMapper;
import com.bee.beeMarket.fleeorder.mapper.FleeOrderSQLMapper;
import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CancelVO;
import com.bee.beeMarket.vo.ChangeVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.DeliveryVO;
import com.bee.beeMarket.vo.FleeMarketCartVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketImageVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.OrderDeliveryVO;
import com.bee.beeMarket.vo.OrderFleeMarketVO;
import com.bee.beeMarket.vo.OrderStatusVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.RefundVO;
import com.bee.beeMarket.vo.SellerVO;
@Service
public class FleeOrderServiceImpl {
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	@Autowired
	private FleeOrderSQLMapper fleeOrderSQLMapper;
	@Autowired
	private FleeMarketSQLMapper fleeMarketSQLMapper;
	@Autowired
	private FleeMarketImageSQLMapper fleeMarketImageSQLMapper;
	
	
	//장바구니 추가
	public void insertFleeMarketCart(FleeMarketCartVO fleeMarketCartVO) {
		fleeOrderSQLMapper.insertFleeMarketCart(fleeMarketCartVO);
	}	
		
		
	//고객이 보는 장바구니
	public ArrayList<HashMap<String, Object>> getFleeCartByCustomerNo(int customer_no) {
			
		ArrayList<HashMap<String , Object>> result = new ArrayList<HashMap<String,Object>>();
			
		ArrayList<FleeMarketCartVO> fleeCartList = fleeOrderSQLMapper.getFleeCartByCustomerNo(customer_no); 
		for(FleeMarketCartVO fleeMarketCartVO : fleeCartList) {
			
			HashMap<String , Object> map = new HashMap<String, Object>();
			
			int fleemarketdetail_no = fleeMarketCartVO.getFleemarketdetail_no();
			
			FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.selectFleeMarketDetailByNo(fleemarketdetail_no);
			
			int fleemarket_no = fleeMarketDetailVO.getFleemarket_no();
			FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
			
			int customerNo = fleeMarketCartVO.getCustomer_no();
			CustomerVO customerVO = customerSQLMapper.selectByNo(customerNo);
			
			FleeMarketImageVO fleeMarketImageVO = fleeMarketImageSQLMapper.getFleeMarketImageByNo(fleemarket_no);
			
			map.put("customerVO", customerVO);
			map.put("fleeMarketImageVO", fleeMarketImageVO);
			map.put("fleeMarketVO", fleeMarketVO);
			map.put("fleeMarketDetailVO" , fleeMarketDetailVO);
			map.put("fleeMarketCartVO", fleeMarketCartVO);
			
			
			result.add(map);
		}
		
		
		return result;
	}
	
		
	//장바구니 삭제
	public void deleteFleeCart(int fleemarketcart_no) {
		fleeOrderSQLMapper.deleteFleeCart(fleemarketcart_no);
		
	}	
	
	//카트에 담긴 개수
	public int getFleeCartCount(int customer_no) {
		return fleeOrderSQLMapper.getFleeCartCountByCustomerNo(customer_no);
	}

	//장바구니 총합계
	public HashMap<String, Object> selectFleeMarketDetailTotalByNo(int customer_no) {
	
		HashMap<String , Object> result = new HashMap<String,Object>();
		
		result = fleeOrderSQLMapper.selectFleeMarketDetailTotalByNo(customer_no);
//		System.out.println("1 : " + result.get("TOT_FLEEMARKETDETAIL_COUNT").toString());
//		System.out.println("2 : " + result.get("FLEEMARKET_PRICE").toString());
//		System.out.println("3 : " + result.get("TOTPRICE").toString());
//		System.out.println("result: " + result.toString());
		
	return result;
}
	

	
	//주문 인서트
	public void insertOrderFleeMarket(OrderFleeMarketVO orderFleeMarketVO) {
		int fleemarketdetail_no = orderFleeMarketVO.getFleemarketdetail_no();
		FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.getFleeMarketDetailByNo(fleemarketdetail_no);
		int fleemarket_no = fleeMarketDetailVO.getFleemarket_no();
		FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
		int fleemarket_price = fleeMarketVO.getFleemarket_price();
		
		int orderflee_price = (fleemarket_price * orderFleeMarketVO.getOrderflee_count());
		orderFleeMarketVO.setOrderflee_price(orderflee_price);
		
		fleeOrderSQLMapper.insertOrderFlee(orderFleeMarketVO);
		
		CustomerVO customerVO = customerSQLMapper.selectByNo(orderFleeMarketVO.getCustomer_no());
		
		double getPointRate = customerSQLMapper.getPointRate(orderFleeMarketVO.getCustomer_no(), customerVO.getCustomergrade_no());
		double get_point = orderflee_price * getPointRate;
		
//		if (orderFleeMarketVO.getOrderpayment_no() == 2) {
//			fleeOrderSQLMapper.minusRJ(orderVO.getCustomer_no(), order_price);
//			fleeOrderSQLMapper.plusRJByOrder(orderVO.getCustomer_no(), (int)get_point);
//		}
		
		
	}
	
	
	//주소 데이타
	public ArrayList<HashMap<String, Object>> addressData(int customer_no){
		
		ArrayList<HashMap<String,Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<AddressListVO> addressListVOs = customerSQLMapper.getAddressListByCustomerNo(customer_no);
		
		for(AddressListVO addressListVO : addressListVOs) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("addressListVO", addressListVO);
			
			resultList.add(map);
		}
		return resultList;
	}
	
	
	//주문 리스트
	public ArrayList<HashMap<String,Object>> getOrderData(int[] fleemarketdetail_no, int[] fleemarketdetail_count){
		
		ArrayList<HashMap<String,Object>> getOrderData = new ArrayList<HashMap<String, Object>>();
		
		for(int i =0; i< fleemarketdetail_no.length; i++) {
			
			HashMap<String,Object> resultMap = new HashMap<String, Object>();
			
			System.out.println("fleemarketdetail_no"+fleemarketdetail_no[i]);
			System.out.println("fleemarketdetail_count"+fleemarketdetail_count[i]);
			
			FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.selectFleeMarketDetailByNo(fleemarketdetail_no[i]);
			
			int fleemarket_no = fleeMarketDetailVO.getFleemarket_no();
			FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
			
			int total_price= fleeMarketVO.getFleemarket_price() * fleemarketdetail_count[i];
			
			System.out.println(total_price);
			
			resultMap.put("fleeMarketDetailVO", fleeMarketDetailVO);
			resultMap.put("fleeMarketVO", fleeMarketVO);
			resultMap.put("fleemarketCount", fleemarketdetail_count[i]);
			resultMap.put("total_price", total_price);
			
			getOrderData.add(resultMap);
			
		}
		
		return getOrderData;
		
	}
	
	//주문데이타
	public HashMap<String,Object> getOrderData(HttpSession session, int fleemarketdetail_no, int fleemarketdetail_count){
		
		HashMap<String, Object> resultMap = new HashMap<String,Object>();
		
		System.out.println(fleemarketdetail_no);

		
		
		FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.selectFleeMarketDetailByNo(fleemarketdetail_no);
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		int fleemarket_no = fleeMarketDetailVO.getFleemarket_no();
		FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
		
		int total_price = fleeMarketVO.getFleemarket_price() * fleemarketdetail_count;
		
		resultMap.put("fleeMarketVO", fleeMarketVO);
		resultMap.put("fleeMarketDetailVO", fleeMarketDetailVO);
		resultMap.put("fleemarketCount", fleemarketdetail_count);
		resultMap.put("total_price", total_price);
		
		return resultMap;
		
	}
	
	
	
	public ArrayList<HashMap<String, Object>> getOrderList(int seller_no){
	      ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
	      ArrayList<SellerVO> orderList = fleeOrderSQLMapper.getOrderFleeListBySellerNo(seller_no);
	      for(SellerVO sellerVO : orderList) {
	         HashMap<String, Object> map = new HashMap<String, Object>();
	         result=new ArrayList<HashMap<String,Object>>();
	         sellerVO.setSeller_no(seller_no);
	         ArrayList<FleeMarketVO> fleeList=fleeMarketSQLMapper.getFleeMarketBySellerNo(seller_no);
	            for(FleeMarketVO fleeMarketVO : fleeList) {
	               int fleemarket_no=fleeMarketVO.getFleemarket_no();
	               DeliveryVO deliveryVO=fleeMarketSQLMapper.getDeliveryCompanyName(fleemarket_no);
	               ArrayList<FleeMarketDetailVO> fleemarketList=fleeMarketSQLMapper.selectFleeMarketDetailByFleeMarketNo(fleemarket_no);
	                  for(FleeMarketDetailVO fleeMarketDetailVO : fleemarketList) {
	                     int fleemarketdetail_no=fleeMarketDetailVO.getFleemarketdetail_no();
	                     ArrayList<OrderFleeMarketVO> list=fleeOrderSQLMapper.getOrderByFleeMarketDetailNo(fleemarketdetail_no);
	                        for(OrderFleeMarketVO orderFleeMarketVO : list) {
	                        int orderflee_no=orderFleeMarketVO.getOrderflee_no();
	                        int order_status_no=orderFleeMarketVO.getOrder_status_no();
	                        int customer_no=orderFleeMarketVO.getCustomer_no();
	                        CustomerVO customerVO=customerSQLMapper.selectByNo(customer_no);
	                        OrderStatusVO orderStatusVO=fleeOrderSQLMapper.getOrderStatus(order_status_no);
	                        int address_no=orderFleeMarketVO.getAddress_no();
	                        AddressListVO addressListVO=fleeOrderSQLMapper.getAddressList(address_no);
//	                        ArrayList<OrderDeliveryVO> orderDeliveryList =orderSQLMapper.getOrderDelivery(order_no);
//	                           for(OrderDeliveryVO orderDeliveryVO:orderDeliveryList) {
//	                        
//	                        CancelVO cancelVO=orderSQLMapper.getCancelOrderList(order_no);
//	                        ChangeVO changeVO=orderSQLMapper.getChangeOrderList(order_no);
//	                        RefundVO refundVO=orderSQLMapper.getRefundOrderList(order_no);	                        
//
                            map=new HashMap<String, Object>();
//	                        System.out.println(order_no);
//	                        map.put("cancelVO", cancelVO);
//	                        map.put("changeVO", changeVO);
//	                        map.put("refundVO", refundVO);
//	                        map.put("orderDeliveryVO", orderDeliveryVO);
	                        map.put("addressListVO", addressListVO);
	                        map.put("orderFleeMarketVO", orderFleeMarketVO);
	                        map.put("customerVO", customerVO);
	                        map.put("orderStatusVO", orderStatusVO);
	                        map.put("fleeMarketDetailVO", fleeMarketDetailVO);
	                        map.put("deliveryVO", deliveryVO);
	                        map.put("fleeMarketVO", fleeMarketVO);
	                        map.put("sellerVO", sellerVO);
	                        
	                        result.add(map);
	                   }
	               }
	            }
	         }
	      
	
	      return result;
	   }
	
	public ArrayList<HashMap<String, Object>> getOrderStatusList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<OrderStatusVO> orderStatusListSeller = fleeOrderSQLMapper.getOrderStatusListSeller();
		for(OrderStatusVO orderStatusVO : orderStatusListSeller) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderStatusVO", orderStatusVO);
			result.add(map);
		}
		return result;
	}
	public ArrayList<HashMap<String, Object>> getOrderStatusListCustomer() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<OrderStatusVO> orderStatusListCustomer = fleeOrderSQLMapper.getOrderStatusListCustomer();
		for(OrderStatusVO orderStatusVO : orderStatusListCustomer) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderStatusVO", orderStatusVO);
			result.add(map);
		}
		return result;
	}

	public void updateOrderStatusByNo(int order_status_no, int orderflee_no) {
		fleeOrderSQLMapper.updateOrderFleeStatusByNo(order_status_no, orderflee_no);
	}

	public void insertInvoiceNum(OrderDeliveryVO orderDeliveryVO) {
		fleeOrderSQLMapper.insertInvoiceNum(orderDeliveryVO);
		
	}

	public void deleteInvoiceNum(int order_status_no, int orderflee_no) {
		int num=fleeOrderSQLMapper.countInvoiceNum(orderflee_no);
		if(num==1) {
			fleeOrderSQLMapper.deleteInvoiceNum(orderflee_no);
		}else {
			fleeOrderSQLMapper.updateOrderFleeStatusByNo(order_status_no, orderflee_no);
		}
		
	}
	
	
	

	
	//fleemarketdetailVO
	public FleeMarketDetailVO getFleeMarketDetailVOByNo(int fleemarketdetail_no) {
		return fleeOrderSQLMapper.getFleeMarketDetailVOByNo(fleemarketdetail_no);
	}
	
	public AddressListVO getAddressVOByAddNo(int address_no) {
		
		return customerSQLMapper.getAddressVOByAddNo(address_no);
	}
	
	
//	   //배송중->배송완료
//	   public void updateDeliverySuccess(int order_no) {
//	      fleeOrderSQLMapper.updateOneStep(order_no);
//	   }
	
	
	
	// (06.08)
	public ArrayList<HashMap<String, Object>> getOrderFleeGenderChartData(int fleemarket_no) {
		return fleeOrderSQLMapper.getOrderFleeGenderChartData(fleemarket_no);
	}
	
	// (06.08)
	public ArrayList<HashMap<String, Object>> getOrderFleeAgeChartData(int fleemarket_no) {
		return fleeOrderSQLMapper.getOrderFleeAgeChartData(fleemarket_no);
	}
	
}
	