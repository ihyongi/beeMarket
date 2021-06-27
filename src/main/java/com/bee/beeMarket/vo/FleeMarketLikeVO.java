package com.bee.beeMarket.vo;

public class FleeMarketLikeVO {
	private int fleemarketlike_no;
	private int fleemarket_no;
	private int customer_no;
	
	public FleeMarketLikeVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketLikeVO(int fleemarketlike_no, int fleemarket_no, int customer_no) {
		super();
		this.fleemarketlike_no = fleemarketlike_no;
		this.fleemarket_no = fleemarket_no;
		this.customer_no = customer_no;
	}

	public int getFleemarketlike_no() {
		return fleemarketlike_no;
	}

	public void setFleemarketlike_no(int fleemarketlike_no) {
		this.fleemarketlike_no = fleemarketlike_no;
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
	
	
}
