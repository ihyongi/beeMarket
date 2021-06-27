package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CouponVO {
	
	private int coupon_no;
	private String coupon_name;
	private int coupon_discountprice;
	private int coupon_discountrate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date coupon_begindate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date coupon_enddate;
	public CouponVO() {
		super();
	}
	public CouponVO(int coupon_no, String coupon_name, int coupon_discountprice, int coupon_discountrate,
			Date coupon_begindate, Date coupon_enddate) {
		super();
		this.coupon_no = coupon_no;
		this.coupon_name = coupon_name;
		this.coupon_discountprice = coupon_discountprice;
		this.coupon_discountrate = coupon_discountrate;
		this.coupon_begindate = coupon_begindate;
		this.coupon_enddate = coupon_enddate;
	}
	public int getCoupon_no() {
		return coupon_no;
	}
	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public int getCoupon_discountprice() {
		return coupon_discountprice;
	}
	public void setCoupon_discountprice(int coupon_discountprice) {
		this.coupon_discountprice = coupon_discountprice;
	}
	public int getCoupon_discountrate() {
		return coupon_discountrate;
	}
	public void setCoupon_discountrate(int coupon_discountrate) {
		this.coupon_discountrate = coupon_discountrate;
	}
	public Date getCoupon_begindate() {
		return coupon_begindate;
	}
	public void setCoupon_begindate(Date coupon_begindate) {
		this.coupon_begindate = coupon_begindate;
	}
	public Date getCoupon_enddate() {
		return coupon_enddate;
	}
	public void setCoupon_enddate(Date coupon_enddate) {
		this.coupon_enddate = coupon_enddate;
	}
	
	

}
