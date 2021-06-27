package com.bee.beeMarket.customer.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.AlarmVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.CustomerEmailVO;
import com.bee.beeMarket.vo.CustomerGradeVO;
import com.bee.beeMarket.vo.CustomerPointDetailVO;
import com.bee.beeMarket.vo.CustomerPointVO;
import com.bee.beeMarket.vo.CustomerQnACategoryVO;
import com.bee.beeMarket.vo.CustomerQnAImageVO;
import com.bee.beeMarket.vo.CustomerQnAVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.CustomerWalletVO;
import com.bee.beeMarket.vo.LikeProductVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductCommentVO;

public interface CustomerSQLMapper {

	public int createCustomerKey();

	public void insertCustomerData(CustomerVO customerVO);

	public void insertAddressData(AddressListVO addressListVO);

	public CustomerVO selectByIdAndPw(

			@Param("id") String id, @Param("pw") String pw);

	public CustomerVO selectByNo(int customer_no);

	// id 존재여부 확인
	public int selectById(String id);

	// 인증 관련
	public void insertMailAuth(CustomerEmailVO cutomerEmailVO);

	public void updateMailAuth(String authKey);

	// 배송지 관련
	public ArrayList<AddressListVO> getAddressListByCustomerNo(int customer_no);

	public AddressListVO getAddressVOByAddNo(int address_no);

	// qna
	public int createCustomerQnAkey();

	public void insertqna(CustomerQnAVO customerQnAVO);

	public CustomerQnAVO selectByQnANo(int customerQnA_no);

	public ArrayList<CustomerQnAVO> selectCustomerQnAContent(@Param("customerNo") int customerNo,
			@Param("pageNum") int pageNum);

	public int selectContentCount();

	public int createCustomerQnAImagekey();

	public void insertCustomerQnAImage(CustomerQnAImageVO customerQnAImageVO);

	public ArrayList<CustomerQnAImageVO> selectCustomerQnAImageByQnANo(int customerQnA_no);

	public ArrayList<CustomerQnACategoryVO> getCustomerQnACategory();

	public CustomerQnACategoryVO getCustomerQnACategoryName(int customerQnA_no);

	public ArrayList<MyCouponVO> getMyCouponListByCustomerNo(int customer_no);

	public CouponVO getCoupondataByCouponNo(int coupon_no);

	public MyCouponVO getCouponVOByMyCouponNo(int mycoupon_no);

	public ArrayList<MyCouponVO> getMyCouponByNo(int customer_no);

	public int getMyCouponCount(int customer_no);

	public ArrayList<ProductCommentVO> getMyCommentByNo(int customer_no);

	public int getMyPoint(int customer_no);

	public int getMyDeliveryCount(int customer_no);

	public int checkCustomerInfo(@Param("customer_id") String customer_id, @Param("customerPw") String customerPw);

	public ArrayList<CustomerPointVO> getJellyListByNo(int customer_no);

	public CustomerPointDetailVO selectPointDetailByNo(int pointdetail_no);

	public ArrayList<AddressListVO> getmyAddressListByNo(int customer_no);

	public void addDelivery(@Param("customer_no") int customer_no, @Param("address_number") String address_number,
			@Param("address_location") String address_location);

	public ArrayList<OrderVO> getmyOrderListByNo(@Param("order_status_no") int order_status_no,
			@Param("customer_no") int customer_no);

	public ProductCommentVO getCommentByNo(@Param("product_no") int product_no, @Param("customer_no") int customer_no);

	public void deleteDelivery(int address_no);

	public void insertGiftJelly(@Param("customer_no") int customer_no, @Param("point_minus") int point_minus);

	// 선물할 사람 아이디를 통해 customer_no 찾고 인서트 시켜주기
	public int getCustomerNOById(String toCustomer_id);

	public void takeGiftJelly(@Param("point_minus") int point_minus, @Param("tocustomer_no") int tocustomer_no);

	// orderDetail 가져오기
	public CustomerVO getCustomerByNo(int customer_no);

	public AddressListVO getDeliveryByNo(int address_no);

	// 채팅관련
	public ArrayList<ChatVO> getChatList(int channel_no);

	public void insertChatLogProcessToAdmin(@Param("message") String message, @Param("fromMember") String fromMember,
			@Param("channel_no") int channel_no);

	public int selectChatChannel(String fromMember);

	public void createChatChannel(@Param("channel_no") int channel_no, @Param("fromMember") String fromMember);

	public int createChatChannelKey();

	public ChatChannelVO getChannelByCustomer_id(String fromMember);

	public double getPointRate(@Param("customer_no") int customer_no, @Param("customergrade_no") int customergrade_no);

	
	
	// 0529
	// 환불 젤리
	public int createCustomerJellykey();

	public int createCustomerJellyLogkey();

	public void giveBackJelly(@Param("jelly") int jelly, @Param("jelly_no") int jelly_no);

	public void giveBackJellylog(@Param("jellylog_no") int jellylog_no, @Param("jelly_no") int jelly_no,
			@Param("jelly") int jelly);

	// 0531
	public void insertCustomerWallet(CustomerWalletVO customerWalletVO);

	public int createCustomerWalletkey();

	public int createCustomerPointkey();

	public int createCustomerPointLogkey();

	public CustomerWalletVO getWalletByJellyNo(int jelly_no);

	public CustomerWalletVO getWalletByPointNo(int point_no);

	public CustomerWalletVO getWalletByCustomerNo(int customer_no);

	public CustomerGradeVO getCustomerRate(int customergrade_no);

	public void updatePointPlus(@Param("order_price_customer") int order_price_customer,
			@Param("point_no") int point_no);

	// 0601
	public ChatVO getLastChatNo(int channel_no);

	public int createChatKey();

	// 0602
	public int getNextChat(@Param("channel_no") int channel_no, @Param("chat_no") int chat_no);

	public ArrayList<ChatVO> getAddChatList(@Param("channel_no") int channel_no, @Param("chat_no") int chat_no);

	public ArrayList<ChatVO> getAddChatListTen(@Param("channel_no") int channel_no);

	public ChatChannelVO getChannelByNo(int customer_no);

	public void createChatChannel(ChatChannelVO chatChannelVO);

	// 0604
	public void cancelOrder(@Param("order_no") int order_no, @Param("cancel_description") String cancel_description);

	public void refundOrder(@Param("order_no") int order_no, @Param("refund_description") String refund_description);

	public void changeOrder(@Param("order_no") int order_no,
			@Param("change_productdetail_no") int change_productdetail_no,
			@Param("change_description") String change_description);

	// 0605
	public void insertCustomerPoint(CustomerPointVO customerPointVO); // 구매적립

	public void insertCustomerPointCancel(CustomerPointVO customerPointVO); // 취소,반품적립

	public ArrayList<LikeProductVO> getLikeVOByProductNo(int product_no);

	public void insertAlarm(AlarmVO alarmVO);

	public void insertLikeVO(@Param("customer_no") int cutomer_no, @Param("product_no") int product_no);

	public void deleteLikeVO(@Param("customer_no") int cutomer_no, @Param("product_no") int product_no);

	public int getMyLikeCount(@Param("customer_no") int cutomer_no, @Param("product_no") int product_no);

}
