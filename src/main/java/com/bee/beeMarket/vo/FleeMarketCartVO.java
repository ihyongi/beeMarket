package com.bee.beeMarket.vo;

public class FleeMarketCartVO {

	private int fleemarketcart_no;
	private int customer_no;
	private int fleemarketdetail_no;
	private int fleemarketdetail_count;
	
	public FleeMarketCartVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketCartVO(int fleemarketcart_no, int customer_no, int fleemarketdetail_no, int fleemarketdetail_count) {
		super();
		this.fleemarketcart_no = fleemarketcart_no;
		this.customer_no = customer_no;
		this.fleemarketdetail_no = fleemarketdetail_no;
		this.fleemarketdetail_count = fleemarketdetail_count;
	}

	public int getFleemarketcart_no() {
		return fleemarketcart_no;
	}

	public void setFleemarketcart_no(int fleemarketcart_no) {
		this.fleemarketcart_no = fleemarketcart_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getFleemarketdetail_no() {
		return fleemarketdetail_no;
	}

	public void setFleemarketdetail_no(int fleemarketdetail_no) {
		this.fleemarketdetail_no = fleemarketdetail_no;
	}

	public int getFleemarketdetail_count() {
		return fleemarketdetail_count;
	}

	public void setFleemarketdetail_count(int fleemarketdetail_count) {
		this.fleemarketdetail_count = fleemarketdetail_count;
	}


	
}
