package com.bee.beeMarket.vo;

public class BankVO {

	private int bank_no;
	private String bank_name;
	
	public BankVO() {
		super();
	}
	
	public BankVO(int bank_no, String bank_name) {
		super();
		this.bank_no = bank_no;
		this.bank_name = bank_name;
	}
	
	public int getBank_no() {
		return bank_no;
	}
	public void setBank_no(int bank_no) {
		this.bank_no = bank_no;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	
	
	
}
