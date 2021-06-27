package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CustomerQnAVO {

	
	
	private int customerQnA_no;
	private int customer_no;
	private int customerqnacategory_no;
	private String customerQnA_title;
	private String customerQnA_content;
	private String customerQnA_statue;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customerQnA_writedate;
	public CustomerQnAVO(int customerQnA_no, int customer_no, int customerqnacategory_no, String customerQnA_title,
			String customerQnA_content, String customerQnA_statue, Date customerQnA_writedate) {
		super();
		this.customerQnA_no = customerQnA_no;
		this.customer_no = customer_no;
		this.customerqnacategory_no = customerqnacategory_no;
		this.customerQnA_title = customerQnA_title;
		this.customerQnA_content = customerQnA_content;
		this.customerQnA_statue = customerQnA_statue;
		this.customerQnA_writedate = customerQnA_writedate;
	}
	public CustomerQnAVO() {
		super();
	}
	public int getCustomerQnA_no() {
		return customerQnA_no;
	}
	public void setCustomerQnA_no(int customerQnA_no) {
		this.customerQnA_no = customerQnA_no;
	}
	public int getCustomer_no() {
		return customer_no;
	}
	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}
	public int getCustomerqnacategory_no() {
		return customerqnacategory_no;
	}
	public void setCustomerqnacategory_no(int customerqnacategory_no) {
		this.customerqnacategory_no = customerqnacategory_no;
	}
	public String getCustomerQnA_title() {
		return customerQnA_title;
	}
	public void setCustomerQnA_title(String customerQnA_title) {
		this.customerQnA_title = customerQnA_title;
	}
	public String getCustomerQnA_content() {
		return customerQnA_content;
	}
	public void setCustomerQnA_content(String customerQnA_content) {
		this.customerQnA_content = customerQnA_content;
	}
	public String getCustomerQnA_statue() {
		return customerQnA_statue;
	}
	public void setCustomerQnA_statue(String customerQnA_statue) {
		this.customerQnA_statue = customerQnA_statue;
	}
	public Date getCustomerQnA_writedate() {
		return customerQnA_writedate;
	}
	public void setCustomerQnA_writedate(Date customerQnA_writedate) {
		this.customerQnA_writedate = customerQnA_writedate;
	}
	
	
	
	
}
