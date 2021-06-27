package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CustomerVO {

	private int customer_no;
	private int customergrade_no;
	private String customer_id;
	private String customer_pw;
	private String customer_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customer_birth;
	private String customer_gender;
	private String customer_phone;
	private String customer_email;
	private Date customer_signup;
	
	public CustomerVO() {
		super();
	}

	public CustomerVO(int customer_no, int customergrade_no, String customer_id, String customer_pw,
			String customer_name, Date customer_birth, String customer_gender, String customer_phone,
			String customer_email, Date customer_signup) {
		super();
		this.customer_no = customer_no;
		this.customergrade_no = customergrade_no;
		this.customer_id = customer_id;
		this.customer_pw = customer_pw;
		this.customer_name = customer_name;
		this.customer_birth = customer_birth;
		this.customer_gender = customer_gender;
		this.customer_phone = customer_phone;
		this.customer_email = customer_email;
		this.customer_signup = customer_signup;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public int getCustomergrade_no() {
		return customergrade_no;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public String getCustomer_pw() {
		return customer_pw;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public Date getCustomer_birth() {
		return customer_birth;
	}

	public String getCustomer_gender() {
		return customer_gender;
	}

	public String getCustomer_phone() {
		return customer_phone;
	}

	public String getCustomer_email() {
		return customer_email;
	}

	public Date getCustomer_signup() {
		return customer_signup;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public void setCustomergrade_no(int customergrade_no) {
		this.customergrade_no = customergrade_no;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	public void setCustomer_pw(String customer_pw) {
		this.customer_pw = customer_pw;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public void setCustomer_birth(Date customer_birth) {
		this.customer_birth = customer_birth;
	}

	public void setCustomer_gender(String customer_gender) {
		this.customer_gender = customer_gender;
	}

	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
	}

	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}

	public void setCustomer_signup(Date customer_signup) {
		this.customer_signup = customer_signup;
	}

	
}
