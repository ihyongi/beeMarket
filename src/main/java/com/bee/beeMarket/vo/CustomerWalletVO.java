package com.bee.beeMarket.vo;

public class CustomerWalletVO {

	private int wallet_no;
	private int customer_no;
	private int jelly_no;
	private int point_no;
	
	public CustomerWalletVO() {
		// TODO Auto-generated constructor stub
	}

	public CustomerWalletVO(int wallet_no, int customer_no, int jelly_no, int point_no) {
		super();
		this.wallet_no = wallet_no;
		this.customer_no = customer_no;
		this.jelly_no = jelly_no;
		this.point_no = point_no;
	}

	public int getWallet_no() {
		return wallet_no;
	}

	public void setWallet_no(int wallet_no) {
		this.wallet_no = wallet_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getJelly_no() {
		return jelly_no;
	}

	public void setJelly_no(int jelly_no) {
		this.jelly_no = jelly_no;
	}

	public int getPoint_no() {
		return point_no;
	}

	public void setPoint_no(int point_no) {
		this.point_no = point_no;
	}
	
	
}
