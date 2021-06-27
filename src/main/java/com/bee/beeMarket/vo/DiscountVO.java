package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

public class DiscountVO {

	private int discount_no;
	private int productdetail_no;
	private int discount_rate;
	private int discount_price;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date discount_begindate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date discount_enddate;
	
	
	public DiscountVO() {
		// TODO Auto-generated constructor stub
	}


	public DiscountVO(int discount_no, int productdetail_no, int discount_rate, int discount_price,
			Date discount_begindate, Date discount_enddate) {
		super();
		this.discount_no = discount_no;
		this.productdetail_no = productdetail_no;
		this.discount_rate = discount_rate;
		this.discount_price = discount_price;
		this.discount_begindate = discount_begindate;
		this.discount_enddate = discount_enddate;
	}


	public int getDiscount_no() {
		return discount_no;
	}


	public void setDiscount_no(int discount_no) {
		this.discount_no = discount_no;
	}


	public int getProductdetail_no() {
		return productdetail_no;
	}


	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}


	public int getDiscount_rate() {
		return discount_rate;
	}


	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}


	public int getDiscount_price() {
		return discount_price;
	}


	public void setDiscount_price(int discount_price) {
		this.discount_price = discount_price;
	}


	public Date getDiscount_begindate() {
		return discount_begindate;
	}


	public void setDiscount_begindate(Date discount_begindate) {
		this.discount_begindate = discount_begindate;
	}


	public Date getDiscount_enddate() {
		return discount_enddate;
	}


	public void setDiscount_enddate(Date discount_enddate) {
		this.discount_enddate = discount_enddate;
	}

	
	
	
	
}
