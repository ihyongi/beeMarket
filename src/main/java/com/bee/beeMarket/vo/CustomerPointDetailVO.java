package com.bee.beeMarket.vo;

public class CustomerPointDetailVO {

	private int pointdetail_no;
	private String pointdetail_name;
	
	public CustomerPointDetailVO() {
		// TODO Auto-generated constructor stub
	}

	public CustomerPointDetailVO(int pointdetail_no, String pointdetail_name) {
		super();
		this.pointdetail_no = pointdetail_no;
		this.pointdetail_name = pointdetail_name;
	}

	public int getPointdetail_no() {
		return pointdetail_no;
	}

	public void setPointdetail_no(int pointdetail_no) {
		this.pointdetail_no = pointdetail_no;
	}

	public String getPointdetail_name() {
		return pointdetail_name;
	}

	public void setPointdetail_name(String pointdetail_name) {
		this.pointdetail_name = pointdetail_name;
	}
	
	
}
