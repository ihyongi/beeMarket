package com.bee.beeMarket.admin.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.AdminVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CustomerQnAAnswerVO;
import com.bee.beeMarket.vo.SellerQnAAnswerVO;

public interface AdminSQLMapper {

	public int createAdminKey();

	public void insert(AdminVO adminVO);

	public AdminVO selectByIdAndPw(@Param("id") String id, @Param("pw") String pw);

	public AdminVO selectByNo(int no);

	public void writeCustomerQnAAnswer(CustomerQnAAnswerVO customerQnAAnswerVO);

	public void writeSellerQnAAnswer(SellerQnAAnswerVO sellerQnAAnswerVO);

	public void deleteCustomerQnAAnswer(int no);

	public void deleteSellerQnAAnswer(int no);

	public ArrayList<CustomerQnAAnswerVO> selectCustomerQnAAnswerByCustomerQnANo(int customerQnA_no);

	public ArrayList<SellerQnAAnswerVO> selectSellerQnAAnswerBySellerQnANo(int sellerQnA_no);

	
	
	/* 관리자 채팅 */
	
	public ArrayList<ChatChannelVO> getChannelList();

	public void insertChatLogProcessToCustomer(@Param("message") String message, @Param("receiver") String receiver,
			@Param("channel_no") int channel_no);

	public void updateReadStatus(int channel_no);

	public ArrayList<ChatVO> getChatForList(int channel_no);

	public int getUnreadCount(int channel_no);

	public ArrayList<ChatVO> getChatListByNo(@Param("chat_no") int chat_no, @Param("channel_no") int channel_no);

	public ArrayList<ChatVO> getChatList(int chat_no);

	public ChatChannelVO getChannelVO(int channel_no);

}
