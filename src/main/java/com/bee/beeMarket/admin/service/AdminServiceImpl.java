package com.bee.beeMarket.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.admin.mapper.AdminSQLMapper;
import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.customer.service.MessageDigestUtil;
import com.bee.beeMarket.seller.mapper.SellerSQLMapper;
import com.bee.beeMarket.vo.AdminVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CustomerQnAAnswerVO;
import com.bee.beeMarket.vo.CustomerQnAVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.SellerQnAAnswerVO;
import com.bee.beeMarket.vo.SellerQnAVO;
import com.bee.beeMarket.vo.SellerVO;

@Service
public class AdminServiceImpl {

	@Autowired
	private AdminSQLMapper adminSQLMapper;
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	@Autowired
	private SellerSQLMapper sellerSQLMapper;

	// 관리자 회원가입
	public void JoinAdmin(AdminVO adminVO) {

		// 비밀번호를 SHA-1 방식으로 해싱 하겠다...(복호화 불가능하게 만들겠다)
		String password = adminVO.getAdmin_pw();
		System.out.println("[변경 전 pw] " + password);

		password = MessageDigestUtil.getPasswordHashCode(password);
		System.out.println("[변경 후 pw] " + password);

		adminVO.setAdmin_pw(password);

		int adminPK = adminSQLMapper.createAdminKey();
		adminVO.setAdmin_no(adminPK);

		adminSQLMapper.insert(adminVO);
	}

	// 관리자 로그인
	public AdminVO login(AdminVO param) {

		String password = param.getAdmin_pw();
		password = MessageDigestUtil.getPasswordHashCode(password);

		AdminVO result = adminSQLMapper.selectByIdAndPw(param.getAdmin_id(), password);

		return result;
	}

	// 관리자 -고객 답변
	public void writeCustomerQnAAnswer(CustomerQnAAnswerVO customerQnAAnswerVO) {
		adminSQLMapper.writeCustomerQnAAnswer(customerQnAAnswerVO);
	}

	public void deleteCustomerQnAAnswer(int no) {
		adminSQLMapper.deleteCustomerQnAAnswer(no);
	}

	public ArrayList<HashMap<String, Object>> getCustomerQnAAnswerList(int customerQnA_no) {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<CustomerQnAAnswerVO> customerQnAAnswerList = adminSQLMapper
				.selectCustomerQnAAnswerByCustomerQnANo(customerQnA_no);

		for (CustomerQnAAnswerVO customerQnAAnswerVO : customerQnAAnswerList) {
			AdminVO adminVO = adminSQLMapper.selectByNo(customerQnAAnswerVO.getAdmin_no());

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("adminVO", adminVO);
			map.put("customerQnAAnswerVO", customerQnAAnswerVO);
			list.add(map);
		}

		return list;
	}

	public ArrayList<HashMap<String, Object>> getCustomerQnAList(int customerNo, int pageNum) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<CustomerQnAVO> customerQnAlist = customerSQLMapper.selectCustomerQnAContent(customerNo, pageNum);
		for (CustomerQnAVO customerQnAVO : customerQnAlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			customerQnAVO.getCustomer_no();
			CustomerVO customerVO = customerSQLMapper.selectByNo(customerQnAVO.getCustomer_no());

			map.put("customerQnAVO", customerQnAVO);
			map.put("customerVO", customerVO);

			result.add(map);
		}
		return result;
	}

	public HashMap<String, Object> getCustomerQnAContent(int customerQnA_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		CustomerQnAVO customerQnAVO = customerSQLMapper.selectByQnANo(customerQnA_no);
		int customer_no = customerQnAVO.getCustomer_no();
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);

		map.put("customerVO", customerVO);
		map.put("customerQnAVO", customerQnAVO);

		return map;
	}

	// 판매자 답변
	public void writeSellerQnAAnswer(SellerQnAAnswerVO sellerQnAAnswerVO) {
		adminSQLMapper.writeSellerQnAAnswer(sellerQnAAnswerVO);
	}

	public void deleteSellerQnAAnswer(int no) {
		adminSQLMapper.deleteSellerQnAAnswer(no);
	}

	public ArrayList<HashMap<String, Object>> getSellerQnAAnswerList(int sellerQnA_no) {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<SellerQnAAnswerVO> sellerQnAAnswerList = adminSQLMapper
				.selectSellerQnAAnswerBySellerQnANo(sellerQnA_no);

		for (SellerQnAAnswerVO sellerQnAAnswerVO : sellerQnAAnswerList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			AdminVO adminVO = adminSQLMapper.selectByNo(sellerQnAAnswerVO.getAdmin_no());
			SellerQnAVO sellerQnAVO = sellerSQLMapper.selectByQnANo(sellerQnAAnswerVO.getSellerQnA_no());

			map.put("sellerQnAVO", sellerQnAVO);
			map.put("adminVO", adminVO);
			map.put("sellerQnAAnswerVO", sellerQnAAnswerVO);
			list.add(map);
		}

		return list;
	}

	public ArrayList<HashMap<String, Object>> getSellerQnAList(int sellerNo, int pageNum) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<SellerQnAVO> sellerQnAList = sellerSQLMapper.selectSellerQnAContent(sellerNo, pageNum);

		for (SellerQnAVO sellerQnAVO : sellerQnAList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int seller_no = sellerQnAVO.getSeller_no();
			SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);

			map.put("sellerVO", sellerVO);
			map.put("sellerQnAVO", sellerQnAVO);

			result.add(map);
		}
		return result;
	}

	public HashMap<String, Object> getSellerQnAContent(int sellerQnA_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		SellerQnAVO sellerQnAVO = sellerSQLMapper.selectByQnANo(sellerQnA_no);
		int seller_no = sellerQnAVO.getSeller_no();
		SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);

		map.put("sellerVO", sellerVO);
		map.put("sellerQnAVO", sellerQnAVO);

		return map;
	}

	
	
	/* 관리자 채팅 */
	public ArrayList<ChatChannelVO> getChannelList() {
		return (ArrayList<ChatChannelVO>) adminSQLMapper.getChannelList();
	}

	public void insertChatLogProcessToCustomer(String message, String receiver, int channel_no) {
		adminSQLMapper.insertChatLogProcessToCustomer(message, receiver, channel_no);
	}

	public ArrayList<ChatVO> getChatForList(int channel_no) {
		return adminSQLMapper.getChatForList(channel_no);
	}

	public int getUnreadCount(int channel_no) {
		return adminSQLMapper.getUnreadCount(channel_no);
	}

	public ArrayList<ChatVO> getChatListByNo(int chat_no, int channel_no) {
		adminSQLMapper.updateReadStatus(channel_no);
		return (ArrayList<ChatVO>) adminSQLMapper.getChatListByNo(chat_no, channel_no);
	}

	public ArrayList<ChatVO> getChatList(int chat_no) {
		return (ArrayList<ChatVO>) adminSQLMapper.getChatList(chat_no);
	}

	public ChatChannelVO getChannelVO(int channel_no) {
		return adminSQLMapper.getChannelVO(channel_no);
	}

}
