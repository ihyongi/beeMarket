package com.bee.beeMarket.vo;

public class CustomerQnACategoryVO {
	private int customerqnacategory_no ;
	private String customerqnacategory_name;
	public CustomerQnACategoryVO(int customerqnacategory_no, String customerqnacategory_name) {
		super();
		this.customerqnacategory_no = customerqnacategory_no;
		this.customerqnacategory_name = customerqnacategory_name;
	}
	public CustomerQnACategoryVO() {
		super();
	}
	public int getCustomerqnacategory_no() {
		return customerqnacategory_no;
	}
	public void setCustomerqnacategory_no(int customerqnacategory_no) {
		this.customerqnacategory_no = customerqnacategory_no;
	}
	public String getCustomerqnacategory_name() {
		return customerqnacategory_name;
	}
	public void setCustomerqnacategory_name(String customerqnacategory_name) {
		this.customerqnacategory_name = customerqnacategory_name;
	}
	
	

}
