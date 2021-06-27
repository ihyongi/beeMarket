package com.bee.beeMarket.vo;

import java.util.Date;

public class FleeMarketCommentVO {
	
	private int comment_no;
	private int fleemarket_no;
	private int customer_no;
	private int fleemarket_score;
	private String comment_content;
	private Date comment_date;
	
	public FleeMarketCommentVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketCommentVO(int comment_no, int fleemarket_no, int customer_no, int fleemarket_score,
			String comment_content, Date comment_date) {
		super();
		this.comment_no = comment_no;
		this.fleemarket_no = fleemarket_no;
		this.customer_no = customer_no;
		this.fleemarket_score = fleemarket_score;
		this.comment_content = comment_content;
		this.comment_date = comment_date;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getFleemarket_no() {
		return fleemarket_no;
	}

	public void setFleemarket_no(int fleemarket_no) {
		this.fleemarket_no = fleemarket_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getFleemarket_score() {
		return fleemarket_score;
	}

	public void setFleemarket_score(int fleemarket_score) {
		this.fleemarket_score = fleemarket_score;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Date getComment_date() {
		return comment_date;
	}

	public void setComment_date(Date comment_date) {
		this.comment_date = comment_date;
	}
	
	
}
