package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class SellerWalletVO {

	private int wallet_no;
	private int seller_no;
	private int cash_amount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date wallet_updatedate;
	
	public SellerWalletVO() {
		// TODO Auto-generated constructor stub
	}

	public SellerWalletVO(int wallet_no, int seller_no, int order_no, int cash_amount, Date wallet_updatedate) {
		super();
		this.wallet_no = wallet_no;
		this.seller_no = seller_no;
		this.cash_amount = cash_amount;
		this.wallet_updatedate = wallet_updatedate;
	}

	public int getWallet_no() {
		return wallet_no;
	}

	public void setWallet_no(int wallet_no) {
		this.wallet_no = wallet_no;
	}

	public int getSeller_no() {
		return seller_no;
	}

	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}

	public int getCash_amount() {
		return cash_amount;
	}

	public void setCash_amount(int cash_amount) {
		this.cash_amount = cash_amount;
	}

	public Date getWallet_updatedate() {
		return wallet_updatedate;
	}

	public void setWallet_updatedate(Date wallet_updatedate) {
		this.wallet_updatedate = wallet_updatedate;
	}

	
	
}
