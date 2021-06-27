package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class SellerQnAAnswerVO {

	private int sellerqnaanswer_no;
	private int admin_no;
	private int sellerQnA_no;
	private String sellerqnaanswer_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sellerqnaanswer_writedate;
	public int getSellerqnaanswer_no() {
		return sellerqnaanswer_no;
	}
	public void setSellerqnaanswer_no(int sellerqnaanswer_no) {
		this.sellerqnaanswer_no = sellerqnaanswer_no;
	}
	public int getAdmin_no() {
		return admin_no;
	}
	public void setAdmin_no(int admin_no) {
		this.admin_no = admin_no;
	}
	public int getSellerQnA_no() {
		return sellerQnA_no;
	}
	public void setSellerQnA_no(int sellerQnA_no) {
		this.sellerQnA_no = sellerQnA_no;
	}
	public String getSellerqnaanswer_content() {
		return sellerqnaanswer_content;
	}
	public void setSellerqnaanswer_content(String sellerqnaanswer_content) {
		this.sellerqnaanswer_content = sellerqnaanswer_content;
	}
	public Date getSellerqnaanswer_writedate() {
		return sellerqnaanswer_writedate;
	}
	public void setSellerqnaanswer_writedate(Date sellerqnaanswer_writedate) {
		this.sellerqnaanswer_writedate = sellerqnaanswer_writedate;
	}
	public SellerQnAAnswerVO(int sellerqnaanswer_no, int admin_no, int sellerQnA_no, String sellerqnaanswer_content,
			Date sellerqnaanswer_writedate) {
		super();
		this.sellerqnaanswer_no = sellerqnaanswer_no;
		this.admin_no = admin_no;
		this.sellerQnA_no = sellerQnA_no;
		this.sellerqnaanswer_content = sellerqnaanswer_content;
		this.sellerqnaanswer_writedate = sellerqnaanswer_writedate;
	}
	public SellerQnAAnswerVO() {
		super();
	}
	
	
	
}
