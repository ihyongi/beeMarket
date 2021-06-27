package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class OrderVO {
	
	private int order_no;
	private int customer_no;
	private int productdetail_no;
	private int mycoupon_no;
	private int address_no;
	private int orderpayment_no;
	private int order_count;
	private int order_price;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date order_orderdate; //주문날짜
	private int order_status_no;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date order_confrimdate; //구매확정날짜
	
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	}


	public OrderVO(int order_no, int customer_no, int productdetail_no, int mycoupon_no, int address_no,
			int orderpayment_no, int order_count, int order_price, Date order_orderdate, int order_status_no,
			Date order_confrimdate) {
		super();
		this.order_no = order_no;
		this.customer_no = customer_no;
		this.productdetail_no = productdetail_no;
		this.mycoupon_no = mycoupon_no;
		this.address_no = address_no;
		this.orderpayment_no = orderpayment_no;
		this.order_count = order_count;
		this.order_price = order_price;
		this.order_orderdate = order_orderdate;
		this.order_status_no = order_status_no;
		this.order_confrimdate = order_confrimdate;
	}


	public int getOrder_no() {
		return order_no;
	}


	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}


	public int getCustomer_no() {
		return customer_no;
	}


	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}


	public int getProductdetail_no() {
		return productdetail_no;
	}


	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}


	public int getMycoupon_no() {
		return mycoupon_no;
	}


	public void setMycoupon_no(int mycoupon_no) {
		this.mycoupon_no = mycoupon_no;
	}


	public int getAddress_no() {
		return address_no;
	}


	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}


	public int getOrderpayment_no() {
		return orderpayment_no;
	}


	public void setOrderpayment_no(int orderpayment_no) {
		this.orderpayment_no = orderpayment_no;
	}


	public int getOrder_count() {
		return order_count;
	}


	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}


	public int getOrder_price() {
		return order_price;
	}


	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}


	public Date getOrder_orderdate() {
		return order_orderdate;
	}


	public void setOrder_orderdate(Date order_orderdate) {
		this.order_orderdate = order_orderdate;
	}


	public int getOrder_status_no() {
		return order_status_no;
	}


	public void setOrder_status_no(int order_status_no) {
		this.order_status_no = order_status_no;
	}


	public Date getOrder_confrimdate() {
		return order_confrimdate;
	}


	public void setOrder_confrimdate(Date order_confrimdate) {
		this.order_confrimdate = order_confrimdate;
	}

	
	
	
}
