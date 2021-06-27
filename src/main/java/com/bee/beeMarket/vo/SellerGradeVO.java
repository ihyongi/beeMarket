package com.bee.beeMarket.vo;

public class SellerGradeVO {
	
	private int sellergrade_no;
	private int sellergrade_rate;
	
	public SellerGradeVO() {
		// TODO Auto-generated constructor stub
	}

	public SellerGradeVO(int sellergrade_no, int sellergrade_rate) {
		super();
		this.sellergrade_no = sellergrade_no;
		this.sellergrade_rate = sellergrade_rate;
	}

	public int getSellergrade_no() {
		return sellergrade_no;
	}

	public void setSellergrade_no(int sellergrade_no) {
		this.sellergrade_no = sellergrade_no;
	}

	public int getSellergrade_rate() {
		return sellergrade_rate;
	}

	public void setSellergrade_rate(int sellergrade_rate) {
		this.sellergrade_rate = sellergrade_rate;
	}

	
	
}
