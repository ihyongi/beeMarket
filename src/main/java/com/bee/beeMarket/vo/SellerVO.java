package com.bee.beeMarket.vo;

import java.util.Date;

public class SellerVO {

	private int seller_no;
	private int	sellergrade_no;
	private String seller_id;
	private String seller_pw;
	private String seller_name;
	private String seller_address;
	private String seller_business_no;
	private int bank_no;
	private String seller_account;
	private String seller_fax_no;
	private String seller_email;
	private String seller_phone;
	private Date seller_signup;
	
	public SellerVO() {
		// TODO Auto-generated constructor stub
	}

	public SellerVO(int seller_no, int sellergrade_no, String seller_id, String seller_pw, String seller_name,
			String seller_address, String seller_business_no, int bank_no, String seller_account, String seller_fax_no,
			String seller_email, String seller_phone, Date seller_signup) {
		super();
		this.seller_no = seller_no;
		this.sellergrade_no = sellergrade_no;
		this.seller_id = seller_id;
		this.seller_pw = seller_pw;
		this.seller_name = seller_name;
		this.seller_address = seller_address;
		this.seller_business_no = seller_business_no;
		this.bank_no = bank_no;
		this.seller_account = seller_account;
		this.seller_fax_no = seller_fax_no;
		this.seller_email = seller_email;
		this.seller_phone = seller_phone;
		this.seller_signup = seller_signup;
	}

	public int getSeller_no() {
		return seller_no;
	}

	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}

	public int getSellergrade_no() {
		return sellergrade_no;
	}

	public void setSellergrade_no(int sellergrade_no) {
		this.sellergrade_no = sellergrade_no;
	}

	public String getSeller_id() {
		return seller_id;
	}

	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}

	public String getSeller_pw() {
		return seller_pw;
	}

	public void setSeller_pw(String seller_pw) {
		this.seller_pw = seller_pw;
	}

	public String getSeller_name() {
		return seller_name;
	}

	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}

	public String getSeller_address() {
		return seller_address;
	}

	public void setSeller_address(String seller_address) {
		this.seller_address = seller_address;
	}

	public String getSeller_business_no() {
		return seller_business_no;
	}

	public void setSeller_business_no(String seller_business_no) {
		this.seller_business_no = seller_business_no;
	}

	public int getBank_no() {
		return bank_no;
	}

	public void setBank_no(int bank_no) {
		this.bank_no = bank_no;
	}

	public String getSeller_account() {
		return seller_account;
	}

	public void setSeller_account(String seller_account) {
		this.seller_account = seller_account;
	}

	public String getSeller_fax_no() {
		return seller_fax_no;
	}

	public void setSeller_fax_no(String seller_fax_no) {
		this.seller_fax_no = seller_fax_no;
	}

	public String getSeller_email() {
		return seller_email;
	}

	public void setSeller_email(String seller_email) {
		this.seller_email = seller_email;
	}

	public String getSeller_phone() {
		return seller_phone;
	}

	public void setSeller_phone(String seller_phone) {
		this.seller_phone = seller_phone;
	}

	public Date getSeller_signup() {
		return seller_signup;
	}

	public void setSeller_signup(Date seller_signup) {
		this.seller_signup = seller_signup;
	}

	
	
	
	
	
}
