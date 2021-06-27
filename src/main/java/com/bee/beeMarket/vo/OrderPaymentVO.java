
package com.bee.beeMarket.vo;

public class OrderPaymentVO {
	private int orderpayment_no;
	private String orderpayment_name;
	
	public OrderPaymentVO() {
		// TODO Auto-generated constructor stub
	}

	public OrderPaymentVO(int orderpayment_no, String orderpayment_name) {
		super();
		this.orderpayment_no = orderpayment_no;
		this.orderpayment_name = orderpayment_name;
	}

	public int getOrderpayment_no() {
		return orderpayment_no;
	}

	public void setOrderpayment_no(int orderpayment_no) {
		this.orderpayment_no = orderpayment_no;
	}

	public String getOrderpayment_name() {
		return orderpayment_name;
	}

	public void setOrderpayment_name(String orderpayment_name) {
		this.orderpayment_name = orderpayment_name;
	}
	
	
	
}
