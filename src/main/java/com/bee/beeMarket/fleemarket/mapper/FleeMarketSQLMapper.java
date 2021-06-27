package com.bee.beeMarket.fleemarket.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.CategoryDetailVO;
import com.bee.beeMarket.vo.CategoryVO;
import com.bee.beeMarket.vo.DeliveryVO;
import com.bee.beeMarket.vo.FleeMarketCommentVO;
import com.bee.beeMarket.vo.FleeMarketDetailVO;
import com.bee.beeMarket.vo.FleeMarketImageVO;
import com.bee.beeMarket.vo.FleeMarketVO;

public interface FleeMarketSQLMapper {
	
	//createKey - fleemarket_no
	public int createFleeMarketKey();
	public int createFleeMarketDetailKey();
	public int createFleeMarketImageKey();
	
	
	//공동구매 옵션 등록
	public void insertFleeMarketDetail(FleeMarketDetailVO fleeMarketDetailVO);
	
	
	//공동구매 세부클래스 정보보기
	public ArrayList<FleeMarketDetailVO> selectFleeMarketDetailByFleeMarketNo(int fleemarket_no);
	

	//상품별 세부페이지
	public FleeMarketVO readFleeMarket(int fleemarket_no);
	
	
	//상품 상세정보 (productdetail_no로 받아오기) 
	public FleeMarketDetailVO getFleeMarketDetailByNo(int fleemarketdetail_no);
	
	//메인이미지by FleeMarketNo
	public FleeMarketImageVO getMainImageByFleeMarketNo(int no);
	
	// 주문에서 댓글가져오기
	public ArrayList<FleeMarketCommentVO> selectCommentByFleeMarketNo(int fleemarket_no);
	
	
	
	
	

	
	//공동구매VO 인서트 글쓰기
	public void insertFleeMarket(FleeMarketVO fleeMarketVO);
	
	//공동구매 내용불러오기
	public FleeMarketVO selectByFleeNo(int fleemarket_no);
	
	//공동구매목록 불러오기
	public ArrayList<FleeMarketVO> getFleeMarketList();
		
	//판매자 공동구매 목록 불러오기 - 검색
	public ArrayList<FleeMarketVO> selectFleeMarketListBySellerNo(@Param("seller_no") int seller_no,
			@Param("searchWord") String serchWord,
			@Param("searchType") String searchType,
			//페이지넘버 int 추가
			@Param("pageNum") int pageNum
			);
	
	//고객용 공동구매 목록 불러오기 - 검색 
	public ArrayList<FleeMarketVO> selectFleeMarketListByCustomerNo(
			@Param("searchWord") String serchWord,
			@Param("searchType") String searchType,
			//페이지넘버 int 추가
			@Param("pageNum") int pageNum
			);
	
	
	
	//게시물 총개
	public int selectFleeMarketCount();
	
	//수정
	public void updateFleeMarket(FleeMarketVO fleeMarketVO);
	public void updateFleeMarketImage(FleeMarketImageVO fleeMarketImageVO);
	public void updateFleeMarketDetail(FleeMarketDetailVO fleeMarketDetailVO);
	
	
	//글삭제
	public void deleteByFleeMarketNo(int fleemarket_no);
	//조회수
	public void increaseReadCount(int fleemarket_no);
	
	
	
	//.....
	public ArrayList<FleeMarketVO> getFleeMarketListByCategoryNo(int no);
		
	// seller_no로 상품 목록 가져오기
	public ArrayList<FleeMarketVO> getFleeMarketBySellerNo(int seller_no);
	
	//fleemarket_no로 디테일 VO 조회
	public ArrayList<FleeMarketDetailVO> selectDetailByFleeMarketNO(int fleemarket_no);
	
	
	
	
	
	
	//댓글
	
	//댓글 쓰기
	public void insertComment(FleeMarketCommentVO fleeMarketCommentVO);
	
	//댓글목록보기(여러줄)  --쓰면 목록에 출력
	public ArrayList<FleeMarketCommentVO> selectCommentList(int fleemarket_no);
	
	//댓글내용가져오기(한줄)
	public FleeMarketCommentVO getCommentContent(int comment_no);
	
	//댓글 수정하기
	public void updateComment(FleeMarketCommentVO fleeMarketCommentVO);
	
	//댓글 삭제
	public void deleteComment(int comment_no);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 신청하기
	public void insertApplicant(@Param("fleemarket_no")int fleemarket_no,
			@Param("customer_no") int customer_no);
	
	// 신청취소
	public void deleteApplicant(@Param("fleemarket_no")int fleemarket_no,
			@Param("customer_no") int customer_no);
	
	// 내가 이글을 신청했는가 유무판단
	public int selectApplicantCountByFleeMarketNoAndCustomerNo(@Param("fleemarket_no")int fleemarket_no,
			@Param("customer_no") int customer_no);
	
	// 해당 공동상품의 총 신청수
	public int selectApplicantCountByFleeMarketNo(int fleemarket_no);
	
	
	
	//대분류, 중분류 카테고리 조인(뷰로 해부렀음 효은님이)
	public ArrayList<CategoryVO> getAllCategory();
	
	// category_no 값으로 상품 게시글 항목 select
	public ArrayList<CategoryDetailVO> getAllCategoryDetail();
	
	//이상품의 카테고리번호를 가져오자
	public int getFleeMarketCategory(int fleemarket_no);
	//공구 카트
	
	public FleeMarketDetailVO selectFleeMarketDetailByNo(int fleemarketdetail_no);
	//택배회사 목록
	public ArrayList<DeliveryVO> getDeliveryCompany();
	
	//주문 배달
	public DeliveryVO getDeliveryCompanyName(int fleemarket_no);
	
	
	
	public int selectByFleeItemCount(int fleemarket_no);
	//상품별 구매수 가져오기
	public int getOrderCount(int fleemarket_no);
	public ArrayList<FleeMarketVO> selectBestFleeMarket();
	
	
	//판매자에게 보이는 고객구매현황
	public ArrayList<HashMap<String,Object>> selectOrderListByCustomerToSeller(int fleemarket_no);
		
		
	

	
	
	
	
	
}
