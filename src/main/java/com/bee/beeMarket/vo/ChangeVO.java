package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChangeVO {
	private int change_order_no;
	private int order_no;
	private int change_productdetail_no;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date change_applyDate;
	private String change_description;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date change_authDate;
	private int change_addCost;
	
	public ChangeVO() {
		// TODO Auto-generated constructor stub
	}

	public ChangeVO(int change_order_no, int order_no, int change_productdetail_no, Date change_applyDate,
			String change_description, Date change_authDate, int change_addCost) {
		super();
		this.change_order_no = change_order_no;
		this.order_no = order_no;
		this.change_productdetail_no = change_productdetail_no;
		this.change_applyDate = change_applyDate;
		this.change_description = change_description;
		this.change_authDate = change_authDate;
		this.change_addCost = change_addCost;
	}

	public int getChange_order_no() {
		return change_order_no;
	}

	public void setChange_order_no(int change_order_no) {
		this.change_order_no = change_order_no;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public int getChange_productdetail_no() {
		return change_productdetail_no;
	}

	public void setChange_productdetail_no(int change_productdetail_no) {
		this.change_productdetail_no = change_productdetail_no;
	}

	public Date getChange_applyDate() {
		return change_applyDate;
	}

	public void setChange_applyDate(Date change_applyDate) {
		this.change_applyDate = change_applyDate;
	}

	public String getChange_description() {
		return change_description;
	}

	public void setChange_description(String change_description) {
		this.change_description = change_description;
	}

	public Date getChange_authDate() {
		return change_authDate;
	}

	public void setChange_authDate(Date change_authDate) {
		this.change_authDate = change_authDate;
	}

	public int getChange_addCost() {
		return change_addCost;
	}

	public void setChange_addCost(int change_addCost) {
		this.change_addCost = change_addCost;
	}
	
	
}
