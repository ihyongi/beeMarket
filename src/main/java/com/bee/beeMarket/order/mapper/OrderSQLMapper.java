package com.bee.beeMarket.order.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.CancelVO;
import com.bee.beeMarket.vo.CartVO;
import com.bee.beeMarket.vo.ChangeVO;
import com.bee.beeMarket.vo.OrderDeliveryVO;
import com.bee.beeMarket.vo.OrderStatusVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.RefundVO;
import com.bee.beeMarket.vo.SellerVO;

public interface OrderSQLMapper {

	public void inserCart(CartVO cartVO);

	public ArrayList<CartVO> getCartByCustomerNo(int customer_no);

	public void deleteCart(int cart_no);

	public CartVO getCartByCartNo(int cart_no);

	public void insertOrder(OrderVO orderVO);

	// 카트 담긴 개수
	public int getCartCountByCustomerNo(int customer_no);

	public void plusCartCount(int cart_no);

	public void minusCartCount(int cart_no);

	public ProductDetailVO getproductDetailVOByNo(int productdetail_no);

	// 주문내역조회
	public ArrayList<SellerVO> getOrderListBySellerNo(int seller_no);

	public ArrayList<OrderVO> getOrderByProductdetailNo(int productdetail_no);

	public OrderStatusVO getOrderStatus(int order_status_no);

	public ArrayList<OrderStatusVO> getOrderStatusList();

	public ArrayList<OrderStatusVO> getOrderStatusListSeller();

	public ArrayList<OrderStatusVO> getOrderStatusListCustomer();

	public void updateOrderStatusByNo(@Param("order_status_no") int order_status_no, @Param("order_no") int order_no);

	public AddressListVO getAddressList(int address_no);

	public ArrayList<OrderDeliveryVO> getOrderDelivery(int order_no);

	public void insertInvoiceNum(OrderDeliveryVO orderDeliveryVO);

	public int countInvoiceNum(int order_no);

	public void deleteInvoiceNum(int order_no);

	public CancelVO getCancelOrderList(int order_no);

	public ChangeVO getChangeOrderList(int order_no);

	public RefundVO getRefundOrderList(int order_no);

	public OrderVO getOrderVO(int order_no);

	// 마이페이지
	public ArrayList<OrderVO> getOrderListByCustomerNo(int customer_no);

	public OrderStatusVO getOrderStatusName(int order_status_no);

	// authDate
	public void updateCancelAuthDate(int order_no);

	public void updateChangeAuthDate(@Param("order_no") int order_no, @Param("change_addCost") int change_addCost);

	public void updateRefundAuthDate(@Param("order_no") int order_no, @Param("refund_addCost") int refund_addCost);

	// update status
	public void withdrawingProduct(int order_no);// 회수중

	public void withdrawedProduct(int order_no);// 회수완료

	public void updateTwoSteps(int order_no);// 신청->진행

	public void updateOneStep(int order_no);// 배송중->배송완료

	// 사유별 송장번호발급
	public void insertChangeInvoiceNum(OrderDeliveryVO orderDeliveryVO);

	public void insertRefundInvoiceNum(OrderDeliveryVO orderDeliveryVO);

	public ArrayList<HashMap<String, Object>> getOrderGenderChartData(int product_no);

	public ArrayList<HashMap<String, Object>> getOrderAgeChartData(int product_no);

	public void minusRJ(@Param("customer_no")int customer_no, @Param("order_price")int order_price);
	
	public void plusRJByOrder(@Param("customer_no")int customer_no, @Param("get_point")int get_point);
	
	//0529
    //구매확정시 구매확정일,상태 update
    public void updateConfrimdate(int order_no);

    public void updateCancelStatus(int order_no);
    //0529 update status
    public void withdrawingChangeProduct(int order_no);//교환회수중
    public void withdrawingRefundProduct(int order_no);//반품회수중
    public void retrievedProduct(int order_no);//회수완료
    public void preparingProduct(int order_no);//교환상품 배송준비중
    public void successRefund(int order_no);//환불완료

    //0531
    public void updateConfirmPurchase(int order_no);

	// 0604
	public void updateRefundStatus(int order_no);
	public void updateChangeStatus(int order_no);
    
}
