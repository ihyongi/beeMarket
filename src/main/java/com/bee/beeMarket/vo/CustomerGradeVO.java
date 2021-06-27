package com.bee.beeMarket.vo;

public class CustomerGradeVO {

	private int customergrade_no;
	private int customergrade_rate;
	
	
	public CustomerGradeVO() {
		// TODO Auto-generated constructor stub
	}

	
	public CustomerGradeVO(int customergrade_no, int customergrade_rate) {
		super();
		this.customergrade_no = customergrade_no;
		this.customergrade_rate = customergrade_rate;
	}


	public int getCustomergrade_no() {
		return customergrade_no;
	}

	public void setCustomergrade_no(int customergrade_no) {
		this.customergrade_no = customergrade_no;
	}

	public int getCustomergrade_rate() {
		return customergrade_rate;
	}

	public void setCustomergrade_rate(int customergrade_rate) {
		this.customergrade_rate = customergrade_rate;
	}
	
}
