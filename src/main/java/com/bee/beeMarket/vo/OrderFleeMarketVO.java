package com.bee.beeMarket.vo;

import java.sql.Date;

public class OrderFleeMarketVO {
	private int orderflee_no;
	private int customer_no;
	private int fleemarketdetail_no;
	private int order_status_no;
	private int address_no;
	private int orderpayment_no;
	private int orderflee_count;
	private int orderflee_price;
	private Date orderflee_orderdate;

	
	public OrderFleeMarketVO() {
		// TODO Auto-generated constructor stub
	}


	public OrderFleeMarketVO(int orderflee_no, int customer_no, int fleemarketdetail_no, int order_status_no,
			int address_no, int orderpayment_no, int orderflee_count, int orderflee_price, Date orderflee_orderdate) {
		super();
		this.orderflee_no = orderflee_no;
		this.customer_no = customer_no;
		this.fleemarketdetail_no = fleemarketdetail_no;
		this.order_status_no = order_status_no;
		this.address_no = address_no;
		this.orderpayment_no = orderpayment_no;
		this.orderflee_count = orderflee_count;
		this.orderflee_price = orderflee_price;
		this.orderflee_orderdate = orderflee_orderdate;
	}


	public int getOrderflee_no() {
		return orderflee_no;
	}


	public void setOrderflee_no(int orderflee_no) {
		this.orderflee_no = orderflee_no;
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


	public int getOrder_status_no() {
		return order_status_no;
	}


	public void setOrder_status_no(int order_status_no) {
		this.order_status_no = order_status_no;
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


	public int getOrderflee_count() {
		return orderflee_count;
	}


	public void setOrderflee_count(int orderflee_count) {
		this.orderflee_count = orderflee_count;
	}


	public int getOrderflee_price() {
		return orderflee_price;
	}


	public void setOrderflee_price(int orderflee_price) {
		this.orderflee_price = orderflee_price;
	}


	public Date getOrderflee_orderdate() {
		return orderflee_orderdate;
	}


	public void setOrderflee_orderdate(Date orderflee_orderdate) {
		this.orderflee_orderdate = orderflee_orderdate;
	}

	
	
	
}

