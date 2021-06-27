package com.bee.beeMarket.vo;

public class FleeMarketDetailVO {
	private int fleemarketdetail_no;
	private int fleemarket_no;
	private String fleemarketdetail_option;
	
	
	public FleeMarketDetailVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketDetailVO(int fleemarketdetail_no, int fleemarket_no, String fleemarketdetail_option,
			int fleemarketdetail_count) {
		super();
		this.fleemarketdetail_no = fleemarketdetail_no;
		this.fleemarket_no = fleemarket_no;
		this.fleemarketdetail_option = fleemarketdetail_option;
		
	}

	public int getFleemarketdetail_no() {
		return fleemarketdetail_no;
	}

	public void setFleemarketdetail_no(int fleemarketdetail_no) {
		this.fleemarketdetail_no = fleemarketdetail_no;
	}

	public int getFleemarket_no() {
		return fleemarket_no;
	}

	public void setFleemarket_no(int fleemarket_no) {
		this.fleemarket_no = fleemarket_no;
	}

	public String getFleemarketdetail_option() {
		return fleemarketdetail_option;
	}

	public void setFleemarketdetail_option(String fleemarketdetail_option) {
		this.fleemarketdetail_option = fleemarketdetail_option;
	}

	
	
	
}
