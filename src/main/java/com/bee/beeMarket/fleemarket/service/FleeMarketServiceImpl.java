package com.bee.beeMarket.fleemarket.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.fleemarket.mapper.FleeMarketImageSQLMapper;
import com.bee.beeMarket.fleemarket.mapper.FleeMarketSQLMapper;
import com.bee.beeMarket.fleeorder.mapper.FleeOrderSQLMapper;
import com.bee.beeMarket.seller.mapper.SellerSQLMapper;
import com.bee.beeMarket.vo.CategoryDetailVO;
import com.bee.beeMarket.vo.CategoryVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketCartVO;
import com.bee.beeMarket.vo.FleeMarketCommentVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketImageVO;
import com.bee.beeMarket.vo.FleeMarketVO;
import com.bee.beeMarket.vo.SellerVO;

@Service
public class FleeMarketServiceImpl {

	@Autowired
	private FleeMarketSQLMapper fleeMarketSQLMapper;
	@Autowired
	private SellerSQLMapper sellerSQLMapper;
	@Autowired
	private FleeMarketImageSQLMapper fleeMarketImageSQLMapper;
	@Autowired
	private CustomerSQLMapper customerSQLMapper;
	@Autowired
	private FleeOrderSQLMapper fleeOrderSQLMapper;
	
	
	
	
	//게시물
	public void writeFleeContent(FleeMarketVO fleemarketVO, ArrayList<FleeMarketImageVO> fleeMarketImageList, ArrayList<FleeMarketDetailVO> fleeMarketDetailList) {
		int fleemarket_no = fleeMarketSQLMapper.createFleeMarketKey();
		fleemarketVO.setFleemarket_no(fleemarket_no);
		//서비스 주입
		fleeMarketSQLMapper.insertFleeMarket(fleemarketVO);
		//fleeMarketSQLMapper.insertFleeMarketWarehouse(fleeMarketWarehouseVO);
		
		
		//이미지 들어오면 반복문돌면서 list에 넣기
		for(FleeMarketImageVO fleeMarketImageVO : fleeMarketImageList) {
			fleeMarketImageVO.setFleemarket_no(fleemarket_no);
			fleeMarketImageSQLMapper.insertImage(fleeMarketImageVO);
		} 
		//공동상품 디테일 요소(옵션(색상, 사이즈))
		for (int i = 0; i< fleeMarketDetailList.size(); i++) {
			FleeMarketDetailVO fleeMarketDetailVO = fleeMarketDetailList.get(i);
			int fleemarketdetail_no = fleeMarketSQLMapper.createFleeMarketDetailKey();
			fleeMarketDetailVO.setFleemarketdetail_no(fleemarketdetail_no);
			fleeMarketDetailVO.setFleemarket_no(fleemarket_no);
			System.out.println("상상"+fleeMarketDetailVO.getFleemarketdetail_option());
			fleeMarketSQLMapper.insertFleeMarketDetail(fleeMarketDetailVO);
			
		}
		
		
		
	}
	// 카테고리 리스트( 대분류 ) 
	public ArrayList<HashMap<String,Object>> getCategoryList(){
			
			ArrayList<HashMap<String,Object>> result = new ArrayList<HashMap<String, Object>>();
			ArrayList<CategoryVO> CategoryList = fleeMarketSQLMapper.getAllCategory();
			
			for (CategoryVO categoryVO : CategoryList) {
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("categoryVO", categoryVO);
				
				result.add(map);
			}
			return result;
			
		}
		
	// 카테고리 디테일 리스트 (중분류)
	public ArrayList<HashMap<String, Object>> getCategoryDetailList(){
		
		ArrayList<HashMap<String,Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<CategoryDetailVO> CategoryDetailList = fleeMarketSQLMapper.getAllCategoryDetail();
		
		for (CategoryDetailVO categoryDetailVO : CategoryDetailList) {
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("categoryDetailVO", categoryDetailVO);
			
			
			result.add(map);
		}
		return result;
	}
		
		
		
		
		
		
		
		
		
		
		
		
	// 구매자 게시물 목록보기  //페이지넘버 int pageNum추가
	public ArrayList<HashMap<String, Object>> getCustomerFleeMarketList(String search_word, String search_type, int pageNum){
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		//페이지넘버 pageNum추가
		ArrayList<FleeMarketVO> fleeMarketList = fleeMarketSQLMapper.selectFleeMarketListByCustomerNo(search_word, search_type,pageNum);
		for(FleeMarketVO fleeMarketVO : fleeMarketList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int seller_no=fleeMarketVO.getSeller_no();
			SellerVO sellerVO=sellerSQLMapper.selectBySellerNo(seller_no);
			
			
			int fleemarket_no = fleeMarketVO.getFleemarket_no();
			
			
			
			
			ArrayList<FleeMarketImageVO> fleeMarketImageVO = fleeMarketImageSQLMapper.selectByFleeMarketNo(fleemarket_no);
			int applicantCount = fleeMarketSQLMapper.selectApplicantCountByFleeMarketNo(fleemarket_no);
			int orderCount = fleeMarketSQLMapper.getOrderCount(fleemarket_no);
			
			map.put("orderCount", orderCount);
			map.put("sellerVO", sellerVO);
			map.put("fleeMarketVO", fleeMarketVO);
			map.put("fleeMarketImageVO", fleeMarketImageVO);
			map.put("applicantCount", applicantCount);
			
			result.add(map);
		}
		
		return result;
	}	
	
	public ArrayList<HashMap<String, Object>> bestFleeMarketList() {
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<FleeMarketVO> bestFleeMarket = fleeMarketSQLMapper.selectBestFleeMarket();
		
		for(FleeMarketVO fleeMarketVO1 : bestFleeMarket) {
			HashMap<String, Object> map1 = new HashMap<String, Object>();
			int fleemarket_no = fleeMarketVO1.getFleemarket_no();
			ArrayList<FleeMarketImageVO> fleeMarketImageVO1 = fleeMarketImageSQLMapper.selectByFleeMarketNo(fleemarket_no);
			int orderCount = fleeMarketSQLMapper.getOrderCount(fleemarket_no);
			int seller_no = fleeMarketVO1.getSeller_no();
			SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);
			
			map1.put("sellerVO", sellerVO);
			map1.put("orderCount", orderCount);
			map1.put("fleeMarketVO1", fleeMarketVO1);
			map1.put("fleeMarketImageVO1", fleeMarketImageVO1);
			
			result.add(map1);
			
		}
		return result;
		
	}
		
	
		
	// 판매자 게시물 목록보기  //페이지넘버 int pageNum추가
	public ArrayList<HashMap<String, Object>> getSellerFleeMarketList(int seller_no, String search_word, String search_type, int pageNum){
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		//페이지넘버 pageNum추가
		ArrayList<FleeMarketVO> fleeMarketList = fleeMarketSQLMapper.selectFleeMarketListBySellerNo(seller_no, search_word, search_type,pageNum);
		for(FleeMarketVO fleeMarketVO : fleeMarketList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int fleemarket_no = fleeMarketVO.getFleemarket_no();
			int applicantCount = fleeMarketSQLMapper.selectApplicantCountByFleeMarketNo(fleemarket_no);
			Integer orderCount = fleeMarketSQLMapper.getOrderCount(fleemarket_no);
			
			map.put("orderCount", orderCount);
			map.put("applicantCount", applicantCount);
			map.put("fleeMarketVO" , fleeMarketVO);
			
			result.add(map);
		}
		return result;
	}
	
	//판매자에게 보이는 고객구매현황
	public ArrayList<HashMap<String,Object>>  selectOrderListByCustomerToSeller(int fleemarket_no){
		
		ArrayList<HashMap<String, Object>> result = fleeMarketSQLMapper.selectOrderListByCustomerToSeller(fleemarket_no);
		
		
		return result;
	}
	
	
	//게시글 갯수
	public int getFleeMarketCount() {
		int count = fleeMarketSQLMapper.selectFleeMarketCount();
		return count;
	}
	
	//글내용보기
	public HashMap<String, Object> getFleeMarketContent(int fleemarket_no, boolean isEscapeHtml){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		FleeMarketVO fleeMarketVO = fleeMarketSQLMapper.selectByFleeNo(fleemarket_no);
		int seller_no=fleeMarketVO.getSeller_no();
		SellerVO sellerVO = sellerSQLMapper.selectBySellerNo(seller_no);
		ArrayList<FleeMarketImageVO> fleeMarketImageList = fleeMarketImageSQLMapper.selectByFleeMarketNo(fleemarket_no);
		ArrayList<FleeMarketDetailVO> fleeMarketDetailVO = fleeMarketSQLMapper.selectFleeMarketDetailByFleeMarketNo(fleemarket_no);
		Integer orderCount = fleeMarketSQLMapper.getOrderCount(fleemarket_no);
		
		map.put("orderCount", orderCount);
		map.put("fleeMarketDetailVO", fleeMarketDetailVO);
		map.put("fleeMarketVO", fleeMarketVO);
		map.put("sellerVO", sellerVO);
		map.put("fleeMarketImageList", fleeMarketImageList);
		
		
		//escape처리 -- 특정문자열을 출력하기 위해서 일부 바꿔주는 역할..
		if(isEscapeHtml) {
			String content = fleeMarketVO.getFleemarket_content();
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			fleeMarketVO.setFleemarket_content(content);
		}
		return map;
		
	}
	
	//	**댓글**
	//  댓글 작성
	public void insertComment(int fleemarket_no, FleeMarketCommentVO fleeMarketCommentVO) {
		fleeMarketSQLMapper.insertComment(fleeMarketCommentVO);
	}
	
	//댓글 목록보기
	public ArrayList<HashMap<String, Object>> getCommentList(int fleemarket_no){
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<FleeMarketCommentVO> list = fleeMarketSQLMapper.selectCommentList(fleemarket_no); 
		
		for(FleeMarketCommentVO fleeMarketCommentVO : list) {
			CustomerVO customerVO = customerSQLMapper.selectByNo(fleeMarketCommentVO.getCustomer_no());
			
			HashMap<String, Object> map= new HashMap<String, Object>();
			map.put("customerVO", customerVO);
			map.put("fleeMarketCommentVO", fleeMarketCommentVO);
			commentList.add(map);
			
		}
		return commentList;
		
	}
	
//	// 댓글 내용가져오기
//	public HashMap<String, Object> getRepliyContent(int comment_no, int fleemarket_no){
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		FleeMarketCommentVO fleeMarketCommentVO = fleeMarketSQLMapper.getCommentContent(comment_no);
//		fleeMarketCommentVO.setFleemarket_no(fleemarket_no);
//		int customer_no= fleeMarketCommentVO.getCustomer_no();
//		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);
//		
//		map.put("customerVO", customerVO);
//		map.put("fleeMarketCommentVO", fleeMarketCommentVO);
//		return map;
//	}
	
	//(수강평) 댓글 수정하기
	public void updateComment(FleeMarketCommentVO fleeMarketCommentVO) {
		fleeMarketSQLMapper.updateComment(fleeMarketCommentVO);
	}
	
	//댓글 삭제하기
	public void deleteComment(int comment_no) {
		fleeMarketSQLMapper.deleteComment(comment_no);
	}
	
	// ******신청********
	// 신청 유무확인작업
	public void applicant(int fleemarket_no, int customer_no) {
		int count = fleeMarketSQLMapper.selectApplicantCountByFleeMarketNoAndCustomerNo(fleemarket_no, customer_no);
		if(count>0) {
			fleeMarketSQLMapper.deleteApplicant(fleemarket_no, customer_no);
		}else {
			fleeMarketSQLMapper.insertApplicant(fleemarket_no, customer_no);
		}
	}
	
	//내가 이글을 신청했는가 개수출력
	public int getMyApplicantCount(int fleemarket_no, int customer_no) {
		int count=fleeMarketSQLMapper.selectApplicantCountByFleeMarketNoAndCustomerNo(fleemarket_no, customer_no);
		return count;
	}
	
	public int getApplicantCount(int fleemarket_no) {
		int count = fleeMarketSQLMapper.selectApplicantCountByFleeMarketNo(fleemarket_no);
		
		return count;
	}
	
	// 공동상품당 신청 총개수
	public int getFleeMarketApplicantCount(int fleemarket_no) {
		int applicantCount=fleeMarketSQLMapper.selectApplicantCountByFleeMarketNo(fleemarket_no);
		return applicantCount;
	}
	
	
	
	
	
	
	
	
	//글수정
	public void updateFleeMarket(FleeMarketVO fleeMarketVO) {
		fleeMarketSQLMapper.updateFleeMarket(fleeMarketVO);
	}
	//글삭제
	public void deleteFleeMarket(int fleemarket_no) {
		fleeMarketSQLMapper.deleteByFleeMarketNo(fleemarket_no);
	}
	
	//조회수
	public void increaseReadCount(int fleemarket_no) {
		fleeMarketSQLMapper.increaseReadCount(fleemarket_no);
	}
	//고객 페이지 공동구매 리스트
	public ArrayList<HashMap<String, Object>> getFleeMarketList(int seller_no, HttpSession session) {

		
		
		
		return null;
	}
	
	
	
	
	
	
	
	

	
	
	
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}














