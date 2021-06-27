package com.bee.beeMarket.fleeorder.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CancelVO;
import com.bee.beeMarket.vo.ChangeVO;
import com.bee.beeMarket.vo.FleeMarketCartVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.OrderDeliveryVO;
import com.bee.beeMarket.vo.OrderFleeMarketVO;
import com.bee.beeMarket.vo.OrderStatusVO;
import com.bee.beeMarket.vo.RefundVO;
import com.bee.beeMarket.vo.SellerVO;


public interface FleeOrderSQLMapper {

	public void insertFleeMarketCart(FleeMarketCartVO feeMarketCartVO);
	
	public ArrayList<FleeMarketCartVO> getFleeCartByCustomerNo(int customer_no);

	public void deleteFleeCart(int fleemarketcart_no);
	
	//총 수량
	public HashMap<String, Object> selectFleeMarketDetailTotalByNo(int fleemarketdetail_no);
	
	
	//카트에 담긴 개수
	public int getFleeCartCountByCustomerNo(int customer_no);
	
	public void plusFleeCartCount(int fleemarketcart_no);
	public void minusFleeCartCount(int fleemarketcart_no);
	
	//??
	public FleeMarketDetailVO getFleeMarketDetailVOByNo(int fleemarketdetail_no);
	
	//??
	public FleeMarketCartVO getFleeCartByFleeCartNo(int fleemarketcart_no);
	
	
	
	
	//젠더 챠트 (06.08)
	public ArrayList<HashMap<String, Object>> getOrderFleeGenderChartData(int fleemarket_no);
	public ArrayList<HashMap<String, Object>> getOrderFleeAgeChartData(int fleemarket_no);
	
	
	
	
	
	
	//주문
	public void insertOrderFlee(OrderFleeMarketVO orderFleeMarketVO);
	
	//seller_no의 주문 리스트 뽑
	public ArrayList<SellerVO> getOrderFleeListBySellerNo(int seller_no);
	
	//fleemarketdetail_no 로 주문받기 
	public ArrayList<OrderFleeMarketVO> getOrderByFleeMarketDetailNo(int fleemarketdetail_no);
	
	//OrderStatus
	public OrderStatusVO getOrderStatus(int order_status_no);
	
	public ArrayList<OrderStatusVO> getOrderStatusList();
	
	public ArrayList<OrderStatusVO> getOrderStatusListSeller();
	
	public ArrayList<OrderStatusVO> getOrderStatusListCustomer();
	
	//AddressList
	public AddressListVO getAddressList(int address_no);
	
	//OrderDelivery
	public ArrayList<OrderDeliveryVO> getOrderDelivery(int order_no);
	
	
	//CancelOrderList
	public CancelVO getCancelOrderList(int orderflee_no);
	
	//ChangeOrderList
	public ChangeVO getChangeOrderList(int orderflee_no);
	
	//RefundOrderList
	public RefundVO getRefundOrderList(int orderflee_no);
	
	//오더 주문받기
	public ArrayList<HashMap<String,Object>> getFleeOrderList(@Param("fleemarket_no")int fleemarket_no,
						@Param("fleemarket_price")int fleemarket_price,
						@Param("fleemarketdetail_count")int fleemarketdetail_count);
	
	public ArrayList<OrderFleeMarketVO> getOrderFleeByCustomerNo(int customer_no);
	

	public void updateOrderFleeStatusByNo(@Param("order_status_no")int order_status_no, @Param("orderflee_no")int orderflee_no);
	
	
	public void insertInvoiceNum(OrderDeliveryVO orderDeliveryVO);
	
	public int countInvoiceNum(int order_no);

	public void deleteInvoiceNum(int order_no);
	
	
	
	//마이페이지
	public ArrayList<OrderFleeMarketVO> getOrderListByCustomerNo(int customer_no);
	public OrderStatusVO getOrderStatusName(int order_status_no);
	
	
	
	
	
}
