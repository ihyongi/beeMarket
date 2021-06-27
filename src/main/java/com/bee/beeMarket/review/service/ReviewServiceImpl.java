package com.bee.beeMarket.review.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.review.mapper.ReviewSQLMapper;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.ProductCategoryVO;
import com.bee.beeMarket.vo.ReviewCommentVO;
import com.bee.beeMarket.vo.ReviewImageVO;
import com.bee.beeMarket.vo.ReviewProductVO;
import com.bee.beeMarket.vo.ReviewVO;

@Service
public class ReviewServiceImpl {

	@Autowired
	private ReviewSQLMapper reviewSQLMapper;

	@Autowired
	private CustomerSQLMapper customerSQLMapper;

	//////////////////////////////////////////////////////////////
	public CustomerSQLMapper getCustomerSQLMapper() {
		return customerSQLMapper;
	}

	public void setCustomerSQLMapper(CustomerSQLMapper customerSQLMapper) {
		this.customerSQLMapper = customerSQLMapper;
	}
	//////////////////////////////////////////////////////////////

	public int createReviewNo() {
		int review_no = reviewSQLMapper.createReviewNo();
		return review_no;
	}

	public void writeReviewContent(ReviewVO reviewVO, ArrayList<ReviewImageVO> reviewImageVOList) {

		reviewSQLMapper.insert(reviewVO);

		for (ReviewImageVO reviewImageVO : reviewImageVOList) {
			System.out.println(reviewImageVO.getImage_original_filename());
			reviewSQLMapper.insertImage(reviewImageVO);
			System.out.println(reviewImageVO.getImage_original_filename());
		}

	}

	public ArrayList<HashMap<String, Object>> getReviewList(String search_word, String search_type, int pageNum) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<ReviewVO> reviewList = reviewSQLMapper.selectAll(search_word, search_type, pageNum);

		for (ReviewVO reviewVO : reviewList) {

			HashMap<String, Object> map = new HashMap<String, Object>();

			int customerNO = reviewVO.getCustomer_no();

			CustomerVO customerVO = customerSQLMapper.selectByNo(customerNO);

			map.put("customerVO", customerVO);
			map.put("reviewVO", reviewVO);
			result.add(map);
			System.out.println("review_title=" + reviewVO.getReview_title());
		}

		return result;
	}

	public HashMap<String, Object> getReviewContent(int review_no, boolean isEscapeHtml) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		ReviewVO reviewVO = reviewSQLMapper.selectByNo(review_no);

		if (isEscapeHtml) {
			String content = reviewVO.getReview_content();

			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");

			reviewVO.setReview_content(content);

		}

		int customer_no = reviewVO.getCustomer_no();

		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);

		ArrayList<ReviewImageVO> reviewImageVOList = reviewSQLMapper.selectReviewImageNO(review_no);

		map.put("reviewVO", reviewVO);
		map.put("customerVO", customerVO);
		map.put("reviewImageVOList", reviewImageVOList);

		return map;

	}

	public void updateReviewContent(ReviewVO reviewVO) {

		reviewSQLMapper.updateReviewContent(reviewVO);

	}

	public void deleteReviewContent(int review_no) {

		reviewSQLMapper.deleteByNo(review_no);

	}

	// 댓글 쓰기
	public void writeReviewComment(ReviewCommentVO reviewCommentVO) {

		reviewSQLMapper.insertReviewComment(reviewCommentVO);
	}

	// 댓글 목록보기
	public ArrayList<HashMap<String, Object>> getReviewCommentList(int review_no) {

		ArrayList<HashMap<String, Object>> reviewCommentList = new ArrayList<HashMap<String, Object>>();

		ArrayList<ReviewCommentVO> reviewCommentlist = reviewSQLMapper.selectreviewCommentList(review_no);

		for (ReviewCommentVO reviewCommentVO : reviewCommentlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();

			int customerNO = reviewCommentVO.getCustomer_no();

			CustomerVO customerVO = customerSQLMapper.selectByNo(customerNO);

			map.put("reviewCommentVO", reviewCommentVO);
			map.put("customerVO", customerVO);

			reviewCommentList.add(map);// ArrayList<HashMap<String, Object>> reviewCommentList = new
										// ArrayList<HashMap<String,Object>>();여기에 있는 변수명인 reviewCommentList를 넣어주어야 한다.
		}

		return reviewCommentList;
	}

	public void updatewriteReviewComment(ReviewCommentVO reviewCommentVO) {

		reviewSQLMapper.updateReviewComment(reviewCommentVO);

	}

	public HashMap<String, Object> getReviewComment(int reviewcomment_no, int review_no) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		ReviewCommentVO reviewCommentVO = reviewSQLMapper.selectByNoReviewComment(reviewcomment_no);

		reviewCommentVO.setReview_no(review_no);

		int customer_no = reviewCommentVO.getCustomer_no();

		CustomerVO customerVO = customerSQLMapper.selectByNo(customer_no);

		map.put("customerVO", customerVO);

		map.put("reviewCommentVO", reviewCommentVO);

		return map;
	}

	public void deleteReviewComment(ReviewCommentVO reviewCommentVO) {

		reviewSQLMapper.deleteReviewComment(reviewCommentVO);
	}

	public void recommend(int review_no, int customer_no) {
		// 여기 값이 밑에 주는 값하고 동일 해야 한다.
		int recommendCount = reviewSQLMapper.selectRecommend(review_no, customer_no);

		if (recommendCount > 0) {
			reviewSQLMapper.deleteRecommend(review_no, customer_no);
		} else {
			reviewSQLMapper.insertRecommend(review_no, customer_no);
		}

	}

	public int getMyRecommendCount(int review_no, int customer_no) {
		int recommendCount = reviewSQLMapper.selectRecommend(review_no, customer_no);
		return recommendCount;
	}

	public int Recommendcount(int review_no) {
		int recommendCount = reviewSQLMapper.selectRecommendReviewNO(review_no);

		return recommendCount;
	}

	public void writeReviewProduct(ReviewProductVO productVO) {
		System.out.println("test02");
		reviewSQLMapper.insertReviewProduct(productVO);
		System.out.println("test03");

	}

	public ArrayList<ProductCategoryVO> getProductCategoryList() {
		ArrayList<ProductCategoryVO> list = reviewSQLMapper.selectProductCategoryList();
		return list;
	}

	public int getReviewContentCount() {

		int count = reviewSQLMapper.selectReviewContentCount();

		return count;
	}

	public void increaseReviewCount(int review_no) {
		reviewSQLMapper.updateReviewReadCount(review_no);

	}

}
