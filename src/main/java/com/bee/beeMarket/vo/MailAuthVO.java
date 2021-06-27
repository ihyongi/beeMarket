package com.bee.beeMarket.vo;

import java.util.Date;

public class MailAuthVO {

	
	
	private int mail_no;
	private int customer_no;
	private String mail_auth_key;
	private String mail_auth_complete;
	private Date mail_auth_date;
	
	public MailAuthVO(int mail_no, int customer_no, String mail_auth_key, String mail_auth_complete,
			Date mail_auth_date) {
		super();
		this.mail_no = mail_no;
		this.customer_no = customer_no;
		this.mail_auth_key = mail_auth_key;
		this.mail_auth_complete = mail_auth_complete;
		this.mail_auth_date = mail_auth_date;
	}
	public MailAuthVO() {
		super();
	}
	public int getMail_no() {
		return mail_no;
	}
	public void setMail_no(int mail_no) {
		this.mail_no = mail_no;
	}
	public int getCustomer_no() {
		return customer_no;
	}
	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}
	public String getMail_auth_key() {
		return mail_auth_key;
	}
	public void setMail_auth_key(String mail_auth_key) {
		this.mail_auth_key = mail_auth_key;
	}
	public String getMail_auth_complete() {
		return mail_auth_complete;
	}
	public void setMail_auth_complete(String mail_auth_complete) {
		this.mail_auth_complete = mail_auth_complete;
	}
	public Date getMail_auth_date() {
		return mail_auth_date;
	}
	public void setMail_auth_date(Date mail_auth_date) {
		this.mail_auth_date = mail_auth_date;
	}
	
	
}
