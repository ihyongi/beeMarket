package com.bee.beeMarket.vo;

import java.util.Date;

public class ReviewVO {
	private int review_no;
	private int customer_no;
	private String review_title;
	private String review_content;
	private int review_readcount;
	private int review_score;
	private Date review_writedate;
	private String product_category_name;
	
	public ReviewVO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewVO(int review_no, int customer_no, String review_title, String review_content, int review_readcount,
			int review_score, Date review_writedate, String product_category_name) {
		super();
		this.review_no = review_no;
		this.customer_no = customer_no;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_readcount = review_readcount;
		this.review_score = review_score;
		this.review_writedate = review_writedate;
		this.product_category_name = product_category_name;
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

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public int getReview_readcount() {
		return review_readcount;
	}

	public void setReview_readcount(int review_readcount) {
		this.review_readcount = review_readcount;
	}

	public int getReview_score() {
		return review_score;
	}

	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}

	public Date getReview_writedate() {
		return review_writedate;
	}

	public void setReview_writedate(Date review_writedate) {
		this.review_writedate = review_writedate;
	}

	public String getProduct_category_name() {
		return product_category_name;
	}

	public void setProduct_category_name(String product_category_name) {
		this.product_category_name = product_category_name;
	}
	
	
	
	
	
}
