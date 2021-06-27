package com.bee.beeMarket.vo;

import java.util.Date;

public class SellerEmailVO {
	
	private int selleremail_no;
	private int seller_no;
	private String selleremail_auth_key;
	private String selleremail_auth_complete;
	private Date selleremail_auth_date;
	
	
	
	public SellerEmailVO() {
		// TODO Auto-generated constructor stub
	}

	public SellerEmailVO(int selleremail_no, int seller_no, String selleremail_auth_key,
			String selleremail_auth_complete, Date selleremail_auth_date) {
		super();
		this.selleremail_no = selleremail_no;
		this.seller_no = seller_no;
		this.selleremail_auth_key = selleremail_auth_key;
		this.selleremail_auth_complete = selleremail_auth_complete;
		this.selleremail_auth_date = selleremail_auth_date;
	}

	
	
	public int getSelleremail_no() {
		return selleremail_no;
	}

	public int getSeller_no() {
		return seller_no;
	}

	public String getSelleremail_auth_key() {
		return selleremail_auth_key;
	}

	public String getSelleremail_auth_complete() {
		return selleremail_auth_complete;
	}

	public Date getSelleremail_auth_date() {
		return selleremail_auth_date;
	}

	public void setSelleremail_no(int selleremail_no) {
		this.selleremail_no = selleremail_no;
	}

	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}

	public void setSelleremail_auth_key(String selleremail_auth_key) {
		this.selleremail_auth_key = selleremail_auth_key;
	}

	public void setSelleremail_auth_complete(String selleremail_auth_complete) {
		this.selleremail_auth_complete = selleremail_auth_complete;
	}

	public void setSelleremail_auth_date(Date selleremail_auth_date) {
		this.selleremail_auth_date = selleremail_auth_date;
	}
	
	
}
