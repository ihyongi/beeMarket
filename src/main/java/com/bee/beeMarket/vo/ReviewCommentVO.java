package com.bee.beeMarket.vo;

import java.util.Date;

public class ReviewCommentVO {
	private int reviewcomment_no;
	private int review_no;
	private int customer_no;
	private String reviewcomment_content;
	private Date reviewcomment_writedate;
	
	public ReviewCommentVO() {
		// TODO Auto-generated constructor stub
	}

	
	public ReviewCommentVO(int reviewcomment_no, int review_no, int customer_no, String reviewcomment_content,
			Date reviewcomment_writedate) {
		super();
		this.reviewcomment_no = reviewcomment_no;
		this.review_no = review_no;
		this.customer_no = customer_no;
		this.reviewcomment_content = reviewcomment_content;
		this.reviewcomment_writedate = reviewcomment_writedate;
	}



	public int getReviewcomment_no() {
		return reviewcomment_no;
	}

	public void setReviewcomment_no(int reviewcomment_no) {
		this.reviewcomment_no = reviewcomment_no;
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public String getReviewcomment_content() {
		return reviewcomment_content;
	}

	public void setReviewcomment_content(String reviewcomment_content) {
		this.reviewcomment_content = reviewcomment_content;
	}

	public Date getReviewcomment_writedate() {
		return reviewcomment_writedate;
	}

	public void setReviewcomment_writedate(Date reviewcomment_writedate) {
		this.reviewcomment_writedate = reviewcomment_writedate;
	}
	
	
	
	
}
