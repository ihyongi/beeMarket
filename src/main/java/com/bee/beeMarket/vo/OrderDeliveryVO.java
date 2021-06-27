package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class OrderDeliveryVO {
	private int orderdelivery_no;
	private int order_no;
	private int order_status_no;
	private String orderdelivery_invoiceNumber;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderdelivery_sendDate;
	
	public OrderDeliveryVO() {
		super();
	}

	public OrderDeliveryVO(int orderdelivery_no, int order_no, int order_status_no, String orderdelivery_invoiceNumber,
			Date orderdelivery_sendDate) {
		super();
		this.orderdelivery_no = orderdelivery_no;
		this.order_no = order_no;
		this.order_status_no = order_status_no;
		this.orderdelivery_invoiceNumber = orderdelivery_invoiceNumber;
		this.orderdelivery_sendDate = orderdelivery_sendDate;
	}

	public int getOrderdelivery_no() {
		return orderdelivery_no;
	}

	public void setOrderdelivery_no(int orderdelivery_no) {
		this.orderdelivery_no = orderdelivery_no;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public int getOrder_status_no() {
		return order_status_no;
	}

	public void setOrder_status_no(int order_status_no) {
		this.order_status_no = order_status_no;
	}

	public String getOrderdelivery_invoiceNumber() {
		return orderdelivery_invoiceNumber;
	}

	public void setOrderdelivery_invoiceNumber(String orderdelivery_invoiceNumber) {
		this.orderdelivery_invoiceNumber = orderdelivery_invoiceNumber;
	}

	public Date getOrderdelivery_sendDate() {
		return orderdelivery_sendDate;
	}

	public void setOrderdelivery_sendDate(Date orderdelivery_sendDate) {
		this.orderdelivery_sendDate = orderdelivery_sendDate;
	}
	
}
