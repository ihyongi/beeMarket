package com.bee.beeMarket.vo;

public class FleeMarketImageVO {
	private int fleemarketimage_no;
	private int fleemarket_no;
	private String fleemarketimage_location;
	private String fleemarketimage_orifilename;
	
	public FleeMarketImageVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketImageVO(int fleemarketimage_no, int fleemarket_no, String fleemarketimage_location,
			String fleemarketimage_orifilename) {
		super();
		this.fleemarketimage_no = fleemarketimage_no;
		this.fleemarket_no = fleemarket_no;
		this.fleemarketimage_location = fleemarketimage_location;
		this.fleemarketimage_orifilename = fleemarketimage_orifilename;
	}

	public int getFleemarketimage_no() {
		return fleemarketimage_no;
	}

	public void setFleemarketimage_no(int fleemarketimage_no) {
		this.fleemarketimage_no = fleemarketimage_no;
	}

	public int getFleemarket_no() {
		return fleemarket_no;
	}

	public void setFleemarket_no(int fleemarket_no) {
		this.fleemarket_no = fleemarket_no;
	}

	public String getFleemarketimage_location() {
		return fleemarketimage_location;
	}

	public void setFleemarketimage_location(String fleemarketimage_location) {
		this.fleemarketimage_location = fleemarketimage_location;
	}

	public String getFleemarketimage_orifilename() {
		return fleemarketimage_orifilename;
	}

	public void setFleemarketimage_orifilename(String fleemarketimage_orifilename) {
		this.fleemarketimage_orifilename = fleemarketimage_orifilename;
	}
	
	
	
}
