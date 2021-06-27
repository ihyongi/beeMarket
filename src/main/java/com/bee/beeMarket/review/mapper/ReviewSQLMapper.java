package com.bee.beeMarket.review.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.ProductCategoryVO;
import com.bee.beeMarket.vo.ReviewCommentVO;
import com.bee.beeMarket.vo.ReviewImageVO;
import com.bee.beeMarket.vo.ReviewProductVO;
import com.bee.beeMarket.vo.ReviewVO;

public interface ReviewSQLMapper {
	
	//사진 
	public int createReviewNo();

	public void insert(ReviewVO reviewVO);

	public ArrayList<ReviewVO> selectAll(
			@Param("searchWord") String searchWord,
			@Param("searchType") String searchType,
			@Param("pageNum") int pageNum);

	public ReviewVO selectByNo(int no);

	public void updateReviewContent(ReviewVO reviewVO);

	public void deleteByNo(int no);
	//사진 관련...

	public void insertImage(ReviewImageVO reviewImageVO);

	public ArrayList<ReviewImageVO> selectReviewImageNO(int review_no);
	//댓글..
	public void insertReviewComment(ReviewCommentVO reviewCommentVO);

	public ArrayList<ReviewCommentVO> selectreviewCommentList(int review_no);

	public void updateReviewComment(ReviewCommentVO reviewCommentVO);

	public ReviewCommentVO selectByNoReviewComment(int reviewcomment_no);

	public void deleteReviewComment(ReviewCommentVO reviewCommentVO);

	public void insertRecommend(@Param("review_no")int review_no, @Param("customer_no")int customer_no);

	public int selectRecommend(@Param("review_no")int review_no, @Param("customer_no")int customer_no);

	public void deleteRecommend(@Param("review_no")int review_no, @Param("customer_no")int customer_no);

	public int selectRecommendReviewNO(int review_no);

	public void insertReviewProduct(ReviewProductVO productVO);

	public ArrayList<ProductCategoryVO> selectProductCategoryList();

	public int selectReviewContentCount();

	public void updateReviewReadCount(int review_no);

	

	

	

	

	



}
