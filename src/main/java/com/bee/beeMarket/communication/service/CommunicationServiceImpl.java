package com.bee.beeMarket.communication.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.communication.mapper.CommunicationSQLMapper;
import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.vo.CommentVO;
import com.bee.beeMarket.vo.CommunicationImageVO;
import com.bee.beeMarket.vo.CommunicationVO;
import com.bee.beeMarket.vo.CustomerVO;


@Service
public class CommunicationServiceImpl {

	@Autowired
	private CommunicationSQLMapper communicationSQLMapper; 
	
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	
	public int createCommunicationNo(){
		int communication_no = communicationSQLMapper.createCommunicationNo();
		return communication_no;
	}
	
	public void writeCommunicationContent(CommunicationVO communicationVO , ArrayList<CommunicationImageVO> communicationImageVOList) {
		
		
		communicationSQLMapper.insert(communicationVO);
	
		
		for(CommunicationImageVO communicationImageVO : communicationImageVOList) {
			communicationSQLMapper.insertImage(communicationImageVO);
		}
	}
	
	public ArrayList<HashMap<String, Object>> getCommunicationList(){//메인페이지 제목등등 출력이 되는 부분같다.
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
	
		ArrayList<CommunicationVO> communicationList = communicationSQLMapper.selectAll();
		
		//communicationList.size();//밑의 for 문이 몇번 진행되었는지 보여주는 로그이다.//글목록이 5개면 for문이 5번돌아야 하므로 5가 출력 될거 같다.
		
		for(CommunicationVO communicationVO : communicationList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
		
			int customerNO = communicationVO.getCustomer_no();//수정
			
			CustomerVO customerVO = customerSQLMapper.selectByNo(customerNO);//수정
		
			map.put("customerVO", customerVO);//수정
			map.put("communicationVO", communicationVO);
			result.add(map);//map에 담긴것을 result에 담기 위한 코드이다.
			
		}
			
		return result;
	}
	
	public HashMap<String, Object> getCommunicationContent(int communication_no , boolean isEscapeHtml) {
		
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();//map에 담는 부분이다.
		
		CommunicationVO communicationVO = communicationSQLMapper.selectByNo(communication_no);//DB에 접근하는 단계이다. 
	
		if(isEscapeHtml) {
			String content = communicationVO.getCommunication_content();
			
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replace("\n", "<br>");
			
			communicationVO.setCommunication_content(content);
		}
		
		//----------------------------------------------------------
		int customer_no = communicationVO.getCustomer_no();//멤버에 대한 정보를 가져오는 부분이다.//수정
		
		
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);//멤버 DB에 접근하는 부분이다.//수정
		
		//사진 관련
		ArrayList<CommunicationImageVO> communicationImageVOList = 
				communicationSQLMapper.selectcommunicationImageNO(communication_no);
		
		map.put("customerVO", customerVO);//수정
		map.put("communicationVO", communicationVO);
		map.put("communicationImageVOList", communicationImageVOList);
		return map;
	}
	
	public void deleteCommunicationContent(int communication_no) {
		
		communicationSQLMapper.deleteByNo(communication_no);
		
	}
	
	public void updateCommunicationContent(CommunicationVO communicationVO) {
		
		communicationSQLMapper.updateCommunicationContent(communicationVO);
		
	}
	
	//댓글
	public void writeComment(CommentVO commentVO) {
		
		communicationSQLMapper.insertComment(commentVO);
		
	}
	
	//댓글 목록보기
	public ArrayList<HashMap<String, Object>> getCommentList(int communication_no){
		
		ArrayList<HashMap<String, Object>> commentList = 
				new ArrayList<HashMap<String,Object>>();//담기 시작하는 부분
		
		ArrayList<CommentVO> commentlist = communicationSQLMapper.selectCommentAll(communication_no);//DB부분에 접근하는 단계
		
		for(CommentVO commentVO : commentlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();//map부분에 담기 시작하는 부분
			
			int customerNO = commentVO.getCustomer_no();//멤버엔오를 가져오는 부분//수정
			
			CustomerVO customerVO = customerSQLMapper.selectByNo(customerNO);//멤버에 대한DB부분을 접근하는 과정//수정
		
			map.put("customerVO", customerVO);//정보를 담는 부분//수정
		
			map.put("commentVO", commentVO);//정보를 담는 부분
			
			commentList.add(map);
		}
		
		return commentList;
	}
	//댓글 내용 가져오기 -- 수정하기 위해...
	public HashMap<String, Object> getComment(int comment_no , int communication_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();//담기 시작
		
		CommentVO commentVO = communicationSQLMapper.selectByNoComment(comment_no);//DB에 댓글에 대한 정보를 접근하는 부분
		
		commentVO.setCommunication_no(communication_no);//커뮤니케이션 엔오를 가져오는 부분
		
		int customer_no = commentVO.getCustomer_no();//멤버에 있는 멤버엔오를 가져오는 부분//수정
		
		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);//DB에 가는 부분//수정
	
		map.put("customerVO", customerVO);//담는부분//수정
	
		map.put("commentVO", commentVO);//담는 부분
		
		
		return map;
	}
	
	//댓글 수정
	public void updateComment(CommentVO commentVO) {

		communicationSQLMapper.updateComment(commentVO);//DB에 댓글 수정에 대해서 접근하는 부분
	
	}
	
	//조회수
	public void increaseReadCount(int communication_no) {
		communicationSQLMapper.updateReadCount(communication_no);
		
	}

	//메인페이지에 글 갯수 출력
	public int getContentCount() {
		
		int count = communicationSQLMapper.selectContentCount();
		
		return count;
	}
	//추천수 관련
	public void recommend(int communication_no, int customer_no) {//수정
		// 확인...
		int recommendcount = communicationSQLMapper.selectRecommendCountwho(communication_no, customer_no);//수정
		
	
	 if(recommendcount > 0) {
	  communicationSQLMapper.deleteRecommend(communication_no, customer_no); //수정
	  }else {
	  communicationSQLMapper.insertRecommend(communication_no, customer_no);//수정
	  }
	 
		
		
	}
	//누가 추천하는것인가??
	public int getMyRecommendCount(int communication_no, int customer_no) {//수정
		int recommendcount = communicationSQLMapper.selectRecommendCountwho(communication_no, customer_no);//수정
		return recommendcount;
	}

	public int getRecommendCount(int communication_no) {
		
		int recommendcount = communicationSQLMapper.selectRecommendCountByCommunicationNO(communication_no);
		
		return recommendcount;//여기 0이 적혀 있으면 화면에 숫자 0이 뜬다.
	}

	public void deleteComment(CommentVO commentVO) {
		
		communicationSQLMapper.deleteComment(commentVO);
		
	}

	

}






