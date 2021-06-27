package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CancelVO {
	private int cancel_order_no;
	private int order_no;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cancel_applyDate;
	private String cancel_description;
	
	public CancelVO() {
		// TODO Auto-generated constructor stub
	}

	public CancelVO(int cancel_order_no, int order_no, Date cancel_applyDate, String cancel_description) {
		super();
		this.cancel_order_no = cancel_order_no;
		this.order_no = order_no;
		this.cancel_applyDate = cancel_applyDate;
		this.cancel_description = cancel_description;
	}

	public int getCancel_order_no() {
		return cancel_order_no;
	}

	public void setCancel_order_no(int cancel_order_no) {
		this.cancel_order_no = cancel_order_no;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public Date getCancel_applyDate() {
		return cancel_applyDate;
	}

	public void setCancel_applyDate(Date cancel_applyDate) {
		this.cancel_applyDate = cancel_applyDate;
	}

	public String getCancel_description() {
		return cancel_description;
	}

	public void setCancel_description(String cancel_description) {
		this.cancel_description = cancel_description;
	}
	
	

}
