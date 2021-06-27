package com.bee.beeMarket.vo;

import java.util.Date;

public class MyCouponVO {
	
	private int mycoupon_no;
	private int coupon_no;
	private int customer_no;
	private String coupon_used;
	private Date coupon_useddate;
	
	public MyCouponVO() {
		super();
	}

	public MyCouponVO(int mycoupon_no, int coupon_no, int customer_no, String coupon_used, Date coupon_useddate) {
		super();
		this.mycoupon_no = mycoupon_no;
		this.coupon_no = coupon_no;
		this.customer_no = customer_no;
		this.coupon_used = coupon_used;
		this.coupon_useddate = coupon_useddate;
	}

	public int getMycoupon_no() {
		return mycoupon_no;
	}

	public int getCoupon_no() {
		return coupon_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public String getCoupon_used() {
		return coupon_used;
	}

	public Date getCoupon_useddate() {
		return coupon_useddate;
	}

	public void setMycoupon_no(int mycoupon_no) {
		this.mycoupon_no = mycoupon_no;
	}

	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public void setCoupon_used(String coupon_used) {
		this.coupon_used = coupon_used;
	}

	public void setCoupon_useddate(Date coupon_useddate) {
		this.coupon_useddate = coupon_useddate;
	}
	
	

}
