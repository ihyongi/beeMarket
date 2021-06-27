package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class SellerWithdrawVO {
	private int withdraw_no;
	private int wallet_no;
	private int bank_no;
	private String seller_account;
	private int withdraw_commission;
	private int withdraw_amount;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date withdraw_updatedate;
	
	public SellerWithdrawVO() {
		// TODO Auto-generated constructor stub
	}

	public SellerWithdrawVO(int withdraw_no, int wallet_no, int bank_no, String seller_account, int withdraw_commission,
			int withdraw_amount, Date withdraw_updatedate) {
		super();
		this.withdraw_no = withdraw_no;
		this.wallet_no = wallet_no;
		this.bank_no = bank_no;
		this.seller_account = seller_account;
		this.withdraw_commission = withdraw_commission;
		this.withdraw_amount = withdraw_amount;
		this.withdraw_updatedate = withdraw_updatedate;
	}

	public int getWithdraw_no() {
		return withdraw_no;
	}

	public void setWithdraw_no(int withdraw_no) {
		this.withdraw_no = withdraw_no;
	}

	public int getWallet_no() {
		return wallet_no;
	}

	public void setWallet_no(int wallet_no) {
		this.wallet_no = wallet_no;
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

	public int getWithdraw_commission() {
		return withdraw_commission;
	}

	public void setWithdraw_commission(int withdraw_commission) {
		this.withdraw_commission = withdraw_commission;
	}

	public int getWithdraw_amount() {
		return withdraw_amount;
	}

	public void setWithdraw_amount(int withdraw_amount) {
		this.withdraw_amount = withdraw_amount;
	}

	public Date getWithdraw_updatedate() {
		return withdraw_updatedate;
	}

	public void setWithdraw_updatedate(Date withdraw_updatedate) {
		this.withdraw_updatedate = withdraw_updatedate;
	}

	
	
}
