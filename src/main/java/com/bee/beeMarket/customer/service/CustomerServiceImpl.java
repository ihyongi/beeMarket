package com.bee.beeMarket.customer.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.fleemarket.mapper.FleeMarketSQLMapper;
import com.bee.beeMarket.fleeorder.mapper.FleeOrderSQLMapper;
import com.bee.beeMarket.order.mapper.OrderSQLMapper;
import com.bee.beeMarket.product.mapper.ProductSQLMapper;
import com.bee.beeMarket.vo.AddressListVO;
import com.bee.beeMarket.vo.AlarmVO;
import com.bee.beeMarket.vo.CancelVO;
import com.bee.beeMarket.vo.ChangeVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.CustomerEmailVO;
import com.bee.beeMarket.vo.CustomerPointDetailVO;
import com.bee.beeMarket.vo.CustomerPointVO;
import com.bee.beeMarket.vo.CustomerQnACategoryVO;
import com.bee.beeMarket.vo.CustomerQnAImageVO;
import com.bee.beeMarket.vo.CustomerQnAVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketCartVO;
import com.bee.beeMarket.vo.FleeMarketCommentVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketImageVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.LikeProductVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.OrderFleeMarketVO;
import com.bee.beeMarket.vo.OrderStatusVO;
import com.bee.beeMarket.vo.OrderVO;
import com.bee.beeMarket.vo.ProductCommentVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.ProductWarehouseVO;
import com.bee.beeMarket.vo.RefundVO;

@Service
public class CustomerServiceImpl {

	@Autowired
	private CustomerSQLMapper customerSQLMapper;

	@Autowired
	private OrderSQLMapper orderSQLMapper;

	@Autowired
	private ProductSQLMapper productSQLMapper;
	
	@Autowired
	private FleeMarketSQLMapper fleeMarketSQLMapper;
	
	@Autowired
	private FleeOrderSQLMapper fleeOrderSQLMapper;
	
	public void JoinCustomer(CustomerVO customerVO, AddressListVO addressListVO, String authKey) {

		// 비밀번호를 SHA-1 방식으로 해싱 하겠다...(복호화 불가능하게 만들겠다)
		String password = customerVO.getCustomer_pw();
		// System.out.println("[변경 전 pw] " + password);

		password = MessageDigestUtil.getPasswordHashCode(password);
		// System.out.println("[변경 후 pw] " + password);

		customerVO.setCustomer_pw(password);

		int customerPK = customerSQLMapper.createCustomerKey();
		customerVO.setCustomer_no(customerPK);
		addressListVO.setCustomer_no(customerPK);

		customerSQLMapper.insertCustomerData(customerVO);
		customerSQLMapper.insertAddressData(addressListVO);

		CustomerEmailVO cutomerEmailVO = new CustomerEmailVO();
		cutomerEmailVO.setCustomer_no(customerPK);
		cutomerEmailVO.setCustomeremail_auth_key(authKey);

		customerSQLMapper.insertMailAuth(cutomerEmailVO);

		// 0604 채널VO insert
		int channelPK = customerSQLMapper.createChatChannelKey();
		ChatChannelVO chatChannelVO = new ChatChannelVO();
		chatChannelVO.setChannel_no(channelPK);
		chatChannelVO.setCustomer_id(customerVO.getCustomer_id());
		customerSQLMapper.createChatChannel(chatChannelVO);
		// 0604

	}

	public CustomerVO login(CustomerVO param) {

		String password = param.getCustomer_pw();
		password = MessageDigestUtil.getPasswordHashCode(password);

		CustomerVO result = customerSQLMapper.selectByIdAndPw(param.getCustomer_id(), password);

		return result;
	}

	public void authMail(String authKey) {

		customerSQLMapper.updateMailAuth(authKey);

	}

	public boolean existId(String id) {

		int count = customerSQLMapper.selectById(id);

		if (count <= 0) {
			return false;
		} else {
			return true;
		}

	}
	
	
	// qna 게시판 글쓰기
		public void writeContent(CustomerQnAVO customerQnAVO,ArrayList<CustomerQnAImageVO> customerQnAImageList) {

			int customerQnA_no = customerSQLMapper.createCustomerQnAkey();
			customerQnAVO.setCustomerQnA_no(customerQnA_no);

			customerSQLMapper.insertqna(customerQnAVO);
			for(CustomerQnAImageVO customerQnAImageVO : customerQnAImageList) {
				customerQnAImageVO.setCustomerQnA_no(customerQnA_no);
				customerSQLMapper.insertCustomerQnAImage(customerQnAImageVO);
			}

		}

	// qna 게시글내용 가져오기
	public HashMap<String, Object> getContent(int customerQnA_no, boolean isEscapeHtml) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		CustomerQnAVO customerQnAVO = customerSQLMapper.selectByQnANo(customerQnA_no);

		int customer_no = customerQnAVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
		customerQnAVO.setCustomer_no(customer_no);
		
		CustomerQnACategoryVO customerQnACategoryVO = customerSQLMapper.getCustomerQnACategoryName(customerQnA_no);
		
		ArrayList<CustomerQnAImageVO> customerQnAImageList = customerSQLMapper.selectCustomerQnAImageByQnANo(customerQnA_no);
				

		// enter키
		if (isEscapeHtml) {
			String content = customerQnAVO.getCustomerQnA_content();

			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");

			customerQnAVO.setCustomerQnA_content(content);
		}

		map.put("customerVO", customerVO);
		map.put("customerQnAVO", customerQnAVO);
		map.put("customerQnACategoryVO", customerQnACategoryVO);
		map.put("customerQnAImageList", customerQnAImageList);
		return map;
	}

	

	//qna 리스트
	public ArrayList<HashMap<String, Object>> getCustomerQnAList(int customerNo , int pageNum) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<CustomerQnAVO> customerQnAlist = customerSQLMapper.selectCustomerQnAContent(customerNo, pageNum);
		for (CustomerQnAVO customerQnAVO : customerQnAlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int customer_no = customerQnAVO.getCustomer_no();
			CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
			
			int customerqnacategory_no = customerQnAVO.getCustomerqnacategory_no();
			CustomerQnACategoryVO customerQnACategoryVO = new CustomerQnACategoryVO();
			customerQnACategoryVO = customerSQLMapper.getCustomerQnACategoryName(customerqnacategory_no);
			
			ArrayList<CustomerQnAImageVO> customerQnAImageVO=customerSQLMapper.selectCustomerQnAImageByQnANo(customerNo);
			
			map.put("customerVO", customerVO);
			map.put("customerQnAVO", customerQnAVO);
			map.put("customerQnACategoryVO", customerQnACategoryVO);
			map.put("customerQnAImageVO", customerQnAImageVO);
			

			result.add(map);
		}
		return result;

	}
	
	
	
	// QnA 카테고리 리스트
			public ArrayList<HashMap<String, Object>> getCustomerQnACategory() {
				ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
				ArrayList<CustomerQnACategoryVO> customerQnACategoryList = customerSQLMapper.getCustomerQnACategory();
				for (CustomerQnACategoryVO customerQnACategoryVO: customerQnACategoryList) {
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("customerQnACategoryVO", customerQnACategoryVO);
					result.add(map);
				}
				return result;
			}

	

	// qna 게시글 개수
	public int getContentCount() {
		int count = customerSQLMapper.selectContentCount();
		return count;
	}
	
	
	/* 찜 기능 */
	public void likeProduct(int customer_no, int product_no) {
		customerSQLMapper.insertLikeVO(customer_no, product_no);
	}
	
	public void deleteLikeProduct(int customer_no, int product_no) {
		customerSQLMapper.deleteLikeVO(customer_no, product_no);
	}
	
	public void insertAlarm(int productdetail_no) {
		// TODO Auto-generated method stub
		
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int product_no =  productDetailVO.getProduct_no();
		String productdetail_option = productDetailVO.getProductdetail_option();
		
		ProductVO productVO = productSQLMapper.getProductByNo(product_no);
		String product_title = productVO.getProduct_title();
		
		ArrayList<LikeProductVO> likeProductVOList = customerSQLMapper.getLikeVOByProductNo(product_no);
		
		if (likeProductVOList.size() != 0) {
			
			for (LikeProductVO likeProductVO : likeProductVOList) {
				
				AlarmVO alarmVO = new AlarmVO();
				int customer_no = likeProductVO.getCustomer_no();
				String alarm_comment = "기다리시던" + product_title + "상품의" + productdetail_option + "이 입고되었습니다.";
				
				alarmVO.setCustomer_no(customer_no);
				alarmVO.setProduct_no(product_no);
				alarmVO.setAlarm_comment(alarm_comment);
				
				customerSQLMapper.insertAlarm(alarmVO);
				
			}
			
		}
	}
	/* 찜 기능 */
	

	// 마이페이지 관련(06/02 수정)
	public ArrayList<HashMap<String, Object>> getMyPageData(int customer_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		customer_no = customerVO.getCustomer_no();

		ArrayList<OrderVO> orderVOList = orderSQLMapper.getOrderListByCustomerNo(customer_no);
		for (OrderVO orderVO : orderVOList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(orderVO.getProductdetail_no());
			ProductVO productVO = productSQLMapper.readProduct(productDetailVO.getProduct_no());
			ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(productDetailVO.getProduct_no());
			OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatusName(orderVO.getOrder_status_no());
			ArrayList<ProductCommentVO> productCommentVO = productSQLMapper
					.selectCommentByProductNo(productDetailVO.getProduct_no());

			map.put("productCommentVO", productCommentVO);
			map.put("orderVO", orderVO);
			map.put("productDetailVO", productDetailVO);
			map.put("productVO", productVO);
			map.put("productImageVO", productImageVO);
			map.put("orderStatusVO", orderStatusVO);

			result.add(map);
		}
		return result;
	}
	
	
	//공동구매마이페이지 관련( 06/07 수정)
	public ArrayList<HashMap<String, Object>> getMyFleePageData(int customer_no, HttpSession session){
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		customer_no = customerVO.getCustomer_no();
		
		ArrayList<OrderFleeMarketVO> orderVOList = fleeOrderSQLMapper.getOrderListByCustomerNo(customer_no);
		for (OrderFleeMarketVO orderFleeMarketVO : orderVOList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.getFleeMarketDetailByNo(orderFleeMarketVO.getFleemarketdetail_no());
			FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.readFleeMarket(fleeMarketDetailVO.getFleemarket_no());
			FleeMarketImageVO fleeMarketImageVO = fleeMarketSQLMapper.getMainImageByFleeMarketNo(fleeMarketDetailVO.getFleemarket_no());
			ArrayList<FleeMarketCommentVO> fleeMarketCommentVO = fleeMarketSQLMapper.selectCommentByFleeMarketNo(fleeMarketDetailVO.getFleemarket_no());
			
			map.put("fleeMarketCommentVO", fleeMarketCommentVO);
			map.put("fleeMarketDetailVO", fleeMarketDetailVO);
			map.put("fleeMarketVO", fleeMarketVO);
			map.put("fleeMarketImageVO", fleeMarketImageVO);
		
			result.add(map);
		}
		
		return result;
		
	}
	
	// 공동구매 (06.09)
		public HashMap<String, Object> getFleeOrderDetail(int fleemarketcart_no, int customer_no) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			FleeMarketCartVO fleeMarketCartVO = fleeOrderSQLMapper.getFleeCartByFleeCartNo(fleemarketcart_no);
			CustomerVO customerVO = customerSQLMapper.getCustomerByNo(customer_no);
			int fleemarketdetail_no = fleeMarketCartVO.getFleemarketdetail_no();
			FleeMarketDetailVO fleeMarketDetailVO = fleeMarketSQLMapper.getFleeMarketDetailByNo(fleemarketdetail_no);
			int fleemarket_no = fleeMarketDetailVO.getFleemarket_no();
			FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
			
			map.put("fleeMarketCartVO", fleeMarketCartVO);
			map.put("customerVO", customerVO);
			map.put("fleeMarketDetailVO", fleeMarketDetailVO);
			map.put("fleeMarketVO", fleeMarketVO);

			return map;
		}
	

	public ArrayList<HashMap<String, Object>> getMyCouponData(int customer_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		customer_no = customerVO.getCustomer_no();

		ArrayList<MyCouponVO> myCouponVOList = customerSQLMapper.getMyCouponByNo(customer_no);
		for (MyCouponVO myCouponVO : myCouponVOList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			CouponVO couponVO = productSQLMapper.getCouponByNo(myCouponVO.getCoupon_no());

			map.put("myCouponVO", myCouponVO);
			map.put("couponVO", couponVO);

			result.add(map);
		}
		return result;
	}

	public ArrayList<HashMap<String, Object>> getMyCommentData(int customer_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		customer_no = customerVO.getCustomer_no();

		ArrayList<ProductCommentVO> myProductCommentList = customerSQLMapper.getMyCommentByNo(customer_no);
		for (ProductCommentVO productCommentVO : myProductCommentList) {
			HashMap<String, Object> map = new HashMap<String, Object>();

			ProductVO productVO = productSQLMapper.selectProductByNo(productCommentVO.getProduct_no());
			map.put("productCommentVO", productCommentVO);
			map.put("productVO", productVO);

			result.add(map);
		}
		return result;
	}

	public int checkCustomerInfo(String customer_id, String customer_pw) {
		String customerPw = MessageDigestUtil.getPasswordHashCode(customer_pw);
		int result = customerSQLMapper.checkCustomerInfo(customer_id, customerPw);

		return result;
	}

	public ArrayList<HashMap<String, Object>> getMyJellyData(int customer_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<CustomerPointVO> myJellyList = customerSQLMapper.getJellyListByNo(customer_no);
		for (CustomerPointVO customerPointVO : myJellyList) {
			HashMap<String, Object> map = new HashMap<String, Object>();

			CustomerPointDetailVO customerPointDetailVO = customerSQLMapper
					.selectPointDetailByNo(customerPointVO.getPointdetail_no());
			map.put("customerPointVO", customerPointVO);
			map.put("customerPointDetailVO", customerPointDetailVO);
			result.add(map);
		}
		return result;
	}

	public ArrayList<HashMap<String, Object>> getMyDeliveryData(int customer_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<AddressListVO> myAddressList = customerSQLMapper.getmyAddressListByNo(customer_no);
		for (AddressListVO addressListVO : myAddressList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("addressListVO", addressListVO);
			result.add(map);
		}
		return result;
	}

	public void addDelivery(int customer_no, String address_number, String address_location) {
		customerSQLMapper.addDelivery(customer_no, address_number, address_location);
	}

	public ArrayList<HashMap<String, Object>> sortList(int order_status_no, int customer_no) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<OrderVO> orderVOList = customerSQLMapper.getmyOrderListByNo(order_status_no, customer_no);

		for (OrderVO orderVO : orderVOList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(orderVO.getProductdetail_no());
			ProductVO productVO = productSQLMapper.readProduct(productDetailVO.getProduct_no());
			ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(productDetailVO.getProduct_no());
			OrderStatusVO orderStatusVO = orderSQLMapper.getOrderStatusName(orderVO.getOrder_status_no());
			ArrayList<ProductCommentVO> productCommentVO = productSQLMapper.selectCommentByProductNo(productDetailVO.getProduct_no());

			map.put("productCommentVO", productCommentVO);
			map.put("orderVO", orderVO);
			map.put("productDetailVO", productDetailVO);
			map.put("productVO", productVO);
			map.put("productImageVO", productImageVO);
			map.put("orderStatusVO", orderStatusVO);

			result.add(map);
		}
		return result;
	}

	public HashMap<String, Object> getComment(int product_no, int customer_no) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		ProductCommentVO productCommentVO = customerSQLMapper.getCommentByNo(product_no, customer_no);
		map.put("productCommentVO", productCommentVO);

		return map;
	}

	// 교환신청 서비스(수정 필요)
	public HashMap<String, Object> getChangeOrder(int order_no, int customer_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(orderVO.getProductdetail_no());
		ArrayList<ProductDetailVO> productDetailName = productSQLMapper
				.selectDetailByProductNO(productDetailVO.getProduct_no());

		map.put("orderVO", orderVO);
		map.put("productDetailVO", productDetailVO);
		map.put("productDetailName", productDetailName);

		return null;
	}

	// 배송지 삭제
	public void deleteDelivery(int address_no) {
		customerSQLMapper.deleteDelivery(address_no);
	}

	public void giftJelly(int customer_no, int point_minus, String toCustomer_id) {
		customerSQLMapper.insertGiftJelly(customer_no, point_minus);
		int tocustomer_no = customerSQLMapper.getCustomerNOById(toCustomer_id);
		customerSQLMapper.takeGiftJelly(point_minus, tocustomer_no);
	}

	public HashMap<String, Object> getOrderDetail(int order_no, int customer_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
		CustomerVO customerVO = customerSQLMapper.getCustomerByNo(customer_no);
		int address_no = orderVO.getAddress_no();
		AddressListVO addressListVO = customerSQLMapper.getDeliveryByNo(address_no);
		int productdetail_no = orderVO.getProductdetail_no();
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		int mycoupon_no = orderVO.getMycoupon_no();
		if (mycoupon_no != 0) {
			MyCouponVO myCouponVO = customerSQLMapper.getCouponVOByMyCouponNo(mycoupon_no);
			int coupon_no = myCouponVO.getCoupon_no();
			CouponVO couponVO = customerSQLMapper.getCoupondataByCouponNo(coupon_no);
			map.put("couponVO", couponVO);
		}

		map.put("orderVO", orderVO);
		map.put("customerVO", customerVO);
		map.put("addressListVO", addressListVO);
		map.put("productDetailVO", productDetailVO);

		return map;
	}

	// 마이페이지 끝

	   //채팅관련
	   public ArrayList<ChatVO> getChatList(int channel_no) {
	      return customerSQLMapper.getChatList(channel_no);
	   }

	   public void insertChatLogProcessToAdmin(String message, String fromMember, int channel_no) {
	      customerSQLMapper.insertChatLogProcessToAdmin(message, fromMember, channel_no);
	   }

	   public int selectChatChannel(String fromMember) {
	      return customerSQLMapper.selectChatChannel(fromMember);
	   }


	   public ChatChannelVO getChannelByCustomer_id(String fromMember) {
	      System.out.println("[qqqq]" + fromMember);
	      return customerSQLMapper.getChannelByCustomer_id(fromMember);
	   }

	   public int createChannel_no() {
	      return customerSQLMapper.createChatChannelKey();
	   }
	   
	   //0601
	   public ChatVO getLastChatNo(int channel_no) {
	      return customerSQLMapper.getLastChatNo(channel_no);
	   }

	   //0602
	   public int getNextChat(int channel_no, int chat_no) {
	      return customerSQLMapper.getNextChat(channel_no,chat_no);
	   }

	   public ArrayList<ChatVO> getAddChatList(int channel_no, int chat_no) {
	      if(chat_no == 0) {
	         return customerSQLMapper.getAddChatListTen(channel_no);
	      }
	      
	      return customerSQLMapper.getAddChatList(channel_no, chat_no);
	   }

	   public ChatChannelVO getChannelByCustomer_no(int customer_no) {
	      return customerSQLMapper.getChannelByNo(customer_no);
	   }

	   //0604
	   public void cancelOrder(int order_no, String cancel_description) {
	      customerSQLMapper.cancelOrder(order_no,cancel_description);
	      orderSQLMapper.updateCancelStatus(order_no);
	      OrderVO orderVO= orderSQLMapper.getOrderVO(order_no);
	      int order_price=orderVO.getOrder_price();
	      int point_plus =order_price-2500;
	      int customer_no=orderVO.getCustomer_no();
	      CustomerPointVO customerPointVO= new CustomerPointVO();
	      customerPointVO.setCustomer_no(customer_no);
	      customerPointVO.setPoint_plus(point_plus);
	      customerSQLMapper.insertCustomerPointCancel(customerPointVO);//취소적립
	      
	   }
	   
	   public void refundOrder(int order_no, String refund_description) {
	      customerSQLMapper.refundOrder(order_no, refund_description);
	      orderSQLMapper.updateRefundStatus(order_no);
	         
	   }

	   public void changeOrder(int order_no, int change_productdetail_no, String change_description) {
	      customerSQLMapper.changeOrder(order_no, change_productdetail_no, change_description);
	      orderSQLMapper.updateChangeStatus(order_no);
	   }

	   public ArrayList<HashMap<String,Object>> changeDetailList(int product_no) {
	       ArrayList<HashMap<String,Object>> result= new ArrayList<HashMap<String,Object>>();
	       ArrayList<ProductDetailVO> productdetailList = productSQLMapper.selectDetailByProductNO(product_no);
	       for(ProductDetailVO productDetailVO:productdetailList) {
	         HashMap<String, Object> map=new HashMap<String, Object>();
	         int productdetail_no=productDetailVO.getProductdetail_no();
	         ProductWarehouseVO productWarehouseVO=productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
	         map.put("productDetailVO", productDetailVO);
	         map.put("productWarehouseVO", productWarehouseVO);
	         result.add(map);
	      }
	      
	      return result;
	   }

	   //0605
	   public HashMap<String, Object> getCancelHistory(int order_no) {
	      
	      HashMap<String, Object> CancelHistory = new HashMap<String, Object>();
	      OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
	      int customer_no = orderVO.getCustomer_no();
	      CustomerVO customerVO = customerSQLMapper.getCustomerByNo(customer_no);
	      int productdetail_no = orderVO.getProductdetail_no();
	      ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
	      int product_no = productDetailVO.getProduct_no();
	      ProductVO productVO = productSQLMapper.getProductByNo(product_no);
	      CancelVO cancelVO = orderSQLMapper.getCancelOrderList(order_no);
	      
	      CancelHistory.put("orderVO", orderVO);
	      CancelHistory.put("customerVO", customerVO);
	      CancelHistory.put("productDetailVO", productDetailVO);
	      CancelHistory.put("productVO", productVO);
	      CancelHistory.put("cancelVO", cancelVO);
	   
	      return CancelHistory;
	   }

	   public HashMap<String, Object> getChangeHistory(int order_no) {
	      HashMap<String, Object> ChangelHistory = new HashMap<String, Object>();
	      ChangeVO changeVO = orderSQLMapper.getChangeOrderList(order_no);
	      OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
	      int customer_no = orderVO.getCustomer_no();
	      CustomerVO customerVO = customerSQLMapper.getCustomerByNo(customer_no);
	      int productdetail_no = orderVO.getProductdetail_no();
	      ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
	      int product_no = productDetailVO.getProduct_no();
	      ProductVO productVO = productSQLMapper.getProductByNo(product_no);
	      int AfProductDetail_no = changeVO.getChange_productdetail_no();
	      ProductDetailVO AfProductDetailOption = productSQLMapper.getProductDetailByNo(AfProductDetail_no);
	      
	      ChangelHistory.put("orderVO", orderVO);
	      ChangelHistory.put("customerVO", customerVO);
	      ChangelHistory.put("productDetailVO", productDetailVO);
	      ChangelHistory.put("productVO", productVO);
	      ChangelHistory.put("changeVO", changeVO);
	      ChangelHistory.put("AfProductDetailOption", AfProductDetailOption);
	   
	      return ChangelHistory;
	   }

	   public HashMap<String, Object> getRefundHistory(int order_no) {
	      HashMap<String, Object> refundHistory = new HashMap<String, Object>();
	      RefundVO refundVO = orderSQLMapper.getRefundOrderList(order_no);
	      OrderVO orderVO = orderSQLMapper.getOrderVO(order_no);
	      int customer_no = orderVO.getCustomer_no();
	      CustomerVO customerVO = customerSQLMapper.getCustomerByNo(customer_no);
	      int productdetail_no = orderVO.getProductdetail_no();
	      ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
	      int product_no = productDetailVO.getProduct_no();
	      ProductVO productVO = productSQLMapper.getProductByNo(product_no);
	      
	      refundHistory.put("orderVO", orderVO);
	      refundHistory.put("customerVO", customerVO);
	      refundHistory.put("productDetailVO", productDetailVO);
	      refundHistory.put("productVO", productVO);
	      refundHistory.put("refundVO", refundVO);
	   
	      return refundHistory;
	   }

	public int getMyLikeCount(int customer_no, int product_no) {
		int count = customerSQLMapper.getMyLikeCount(customer_no,product_no);
		return count;
	}


}
