package com.bee.beeMarket.communication.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.CommentVO;
import com.bee.beeMarket.vo.CommunicationImageVO;
import com.bee.beeMarket.vo.CommunicationVO;

public interface CommunicationSQLMapper {
	
	// 커뮤니케이션 no 가져오기
	public int createCommunicationNo();
	
	//커뮤니케이션 글 쓰기
	public void insert(CommunicationVO communicationVO);
	//커뮤니케이션 목록 불러오기
	public ArrayList<CommunicationVO> selectAll();
	//커뮤니케이션 내용불러오기
	public CommunicationVO selectByNo(int no);
	//커뮤니케이션 삭제
	public void deleteByNo(int no);
	//커뮤니케이션 수정
	public void updateCommunicationContent(CommunicationVO communicationVO);
	//댓글 입력
	public void insertComment(CommentVO commentVO);
	//댓글 목록
	public ArrayList<CommentVO> selectCommentAll(int communication_no);
	//댓글 목록 선택한 것 불러오기
	public CommentVO selectByNoComment(int comment_no);
	
	//댓글 수정
	public void updateComment(CommentVO commentVO);
	
	
	//사진 삽입 관련
	public void insertImage(CommunicationImageVO communicationImageVO);
	//사진 삽입 관련
	public ArrayList<CommunicationImageVO> selectcommunicationImageNO(int communication_no);
	
	//조회수
	public void updateReadCount(int no);
	
	//메인페이지에 글 갯수 출력
	
	
	public int selectContentCount();
	
	//추천 관련
	public void insertRecommend(@Param("communication_no") int communication_no, 
								@Param("customer_no") int customer_no);//수정
	
	public void deleteRecommend(@Param("communication_no") int communication_no, 
								@Param("customer_no") int customer_no);//수정
	public int selectRecommendCountwho(@Param("communication_no") int communication_no, 
										@Param("customer_no") int customer_no);//수정
	//글 추천 횟수

	public int selectRecommendCountByCommunicationNO(int communication_no);
	
	//댓글 삭제
	public void deleteComment(CommentVO commentVO);

	

	
	
	
}





