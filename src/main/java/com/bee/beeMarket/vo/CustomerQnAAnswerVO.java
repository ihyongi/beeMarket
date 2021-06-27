package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CustomerQnAAnswerVO {
	
	private int customerqnaanswer_no;
	private int admin_no;
	private int customerQnA_no;
	private String customerqnaanswer_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customerqnaanswer_writedate;
	public CustomerQnAAnswerVO(int customerqnaanswer_no, int admin_no, int customerQnA_no,
			String customerqnaanswer_content, Date customerqnaanswer_writedate) {
		super();
		this.customerqnaanswer_no = customerqnaanswer_no;
		this.admin_no = admin_no;
		this.customerQnA_no = customerQnA_no;
		this.customerqnaanswer_content = customerqnaanswer_content;
		this.customerqnaanswer_writedate = customerqnaanswer_writedate;
	}
	public CustomerQnAAnswerVO() {
		super();
	}
	public int getCustomerqnaanswer_no() {
		return customerqnaanswer_no;
	}
	public void setCustomerqnaanswer_no(int customerqnaanswer_no) {
		this.customerqnaanswer_no = customerqnaanswer_no;
	}
	public int getAdmin_no() {
		return admin_no;
	}
	public void setAdmin_no(int admin_no) {
		this.admin_no = admin_no;
	}
	public int getCustomerQnA_no() {
		return customerQnA_no;
	}
	public void setCustomerQnA_no(int customerQnA_no) {
		this.customerQnA_no = customerQnA_no;
	}
	public String getCustomerqnaanswer_content() {
		return customerqnaanswer_content;
	}
	public void setCustomerqnaanswer_content(String customerqnaanswer_content) {
		this.customerqnaanswer_content = customerqnaanswer_content;
	}
	public Date getCustomerqnaanswer_writedate() {
		return customerqnaanswer_writedate;
	}
	public void setCustomerqnaanswer_writedate(Date customerqnaanswer_writedate) {
		this.customerqnaanswer_writedate = customerqnaanswer_writedate;
	}
	
	

	
}
