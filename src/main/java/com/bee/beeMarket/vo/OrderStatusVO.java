package com.bee.beeMarket.vo;

public class OrderStatusVO {
	private int order_status_no;
	private String order_status_name;
	
	public OrderStatusVO() {
		// TODO Auto-generated constructor stub
	}

	public OrderStatusVO(int order_status_no, String order_status_name) {
		super();
		this.order_status_no = order_status_no;
		this.order_status_name = order_status_name;
	}

	public int getOrder_status_no() {
		return order_status_no;
	}

	public void setOrder_status_no(int order_status_no) {
		this.order_status_no = order_status_no;
	}

	public String getOrder_status_name() {
		return order_status_name;
	}

	public void setOrder_status_name(String order_status_name) {
		this.order_status_name = order_status_name;
	}
	
	
}
