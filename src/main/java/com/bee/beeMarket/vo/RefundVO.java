package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class RefundVO {
	private int refund_order_no;
	private int order_no;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date refund_applyDate;
	private String refund_description;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date refund_authDate;
	private int refund_addCost;
	
	public RefundVO() {
		// TODO Auto-generated constructor stub
	}

	public RefundVO(int refund_order_no, int order_no, Date refund_applyDate, String refund_description,
			Date refund_authDate, int refund_addCost) {
		super();
		this.refund_order_no = refund_order_no;
		this.order_no = order_no;
		this.refund_applyDate = refund_applyDate;
		this.refund_description = refund_description;
		this.refund_authDate = refund_authDate;
		this.refund_addCost = refund_addCost;
	}

	public int getRefund_order_no() {
		return refund_order_no;
	}

	public void setRefund_order_no(int refund_order_no) {
		this.refund_order_no = refund_order_no;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public Date getRefund_applyDate() {
		return refund_applyDate;
	}

	public void setRefund_applyDate(Date refund_applyDate) {
		this.refund_applyDate = refund_applyDate;
	}

	public String getRefund_description() {
		return refund_description;
	}

	public void setRefund_description(String refund_description) {
		this.refund_description = refund_description;
	}

	public Date getRefund_authDate() {
		return refund_authDate;
	}

	public void setRefund_authDate(Date refund_authDate) {
		this.refund_authDate = refund_authDate;
	}

	public int getRefund_addCost() {
		return refund_addCost;
	}

	public void setRefund_addCost(int refund_addCost) {
		this.refund_addCost = refund_addCost;
	}
	
}
