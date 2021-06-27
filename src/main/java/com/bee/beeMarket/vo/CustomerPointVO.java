package com.bee.beeMarket.vo;

import java.util.Date;

public class CustomerPointVO {
	
	private int point_no;
	private int customer_no;
	private int pointdetail_no;
	private int point_plus;
	private int point_minus;
	private Date point_updatedate;
	
	public CustomerPointVO() {
		// TODO Auto-generated constructor stub
	}

	public CustomerPointVO(int point_no, int customer_no, int pointdetail_no, int point_plus, int point_minus,
			Date point_updatedate) {
		super();
		this.point_no = point_no;
		this.customer_no = customer_no;
		this.pointdetail_no = pointdetail_no;
		this.point_plus = point_plus;
		this.point_minus = point_minus;
		this.point_updatedate = point_updatedate;
	}

	public int getPoint_no() {
		return point_no;
	}

	public void setPoint_no(int point_no) {
		this.point_no = point_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getPointdetail_no() {
		return pointdetail_no;
	}

	public void setPointdetail_no(int pointdetail_no) {
		this.pointdetail_no = pointdetail_no;
	}

	public int getPoint_plus() {
		return point_plus;
	}

	public void setPoint_plus(int point_plus) {
		this.point_plus = point_plus;
	}

	public int getPoint_minus() {
		return point_minus;
	}

	public void setPoint_minus(int point_minus) {
		this.point_minus = point_minus;
	}

	public Date getPoint_updatedate() {
		return point_updatedate;
	}

	public void setPoint_updatedate(Date point_updatedate) {
		this.point_updatedate = point_updatedate;
	}
	
	
}
