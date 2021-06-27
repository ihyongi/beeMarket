package com.bee.beeMarket.vo;

import java.util.Date;

public class CustomerEmailVO {

	private int customeremail_no;
	private int customer_no;
	private String customeremail_auth_key;
	private String customeremail_auth_complete;
	private Date customeremail_auth_date;
	
	public CustomerEmailVO() {
		// TODO Auto-generated constructor stub
	}

	public CustomerEmailVO(int customeremail_no, int customer_no, String customeremail_auth_key,
			String customeremail_auth_complete, Date customeremail_auth_date) {
		super();
		this.customeremail_no = customeremail_no;
		this.customer_no = customer_no;
		this.customeremail_auth_key = customeremail_auth_key;
		this.customeremail_auth_complete = customeremail_auth_complete;
		this.customeremail_auth_date = customeremail_auth_date;
	}

	
	
	public int getCustomeremail_no() {
		return customeremail_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public String getCustomeremail_auth_key() {
		return customeremail_auth_key;
	}

	public String getCustomeremail_auth_complete() {
		return customeremail_auth_complete;
	}

	public Date getCustomeremail_auth_date() {
		return customeremail_auth_date;
	}

	public void setCustomeremail_no(int customeremail_no) {
		this.customeremail_no = customeremail_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public void setCustomeremail_auth_key(String customeremail_auth_key) {
		this.customeremail_auth_key = customeremail_auth_key;
	}

	public void setCustomeremail_auth_complete(String customeremail_auth_complete) {
		this.customeremail_auth_complete = customeremail_auth_complete;
	}

	public void setCustomeremail_auth_date(Date customeremail_auth_date) {
		this.customeremail_auth_date = customeremail_auth_date;
	}

	
}
