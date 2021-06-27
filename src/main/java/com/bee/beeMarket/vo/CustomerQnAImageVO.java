package com.bee.beeMarket.vo;

public class CustomerQnAImageVO {

	
	
	private int customerqnaimage_no;
	private int customerQnA_no;
	private String customerqnaimage_location;
	private String customerqnaimage_orifilename;
	public int getCustomerqnaimage_no() {
		return customerqnaimage_no;
	}
	public void setCustomerqnaimage_no(int customerqnaimage_no) {
		this.customerqnaimage_no = customerqnaimage_no;
	}
	public int getCustomerQnA_no() {
		return customerQnA_no;
	}
	public void setCustomerQnA_no(int customerQnA_no) {
		this.customerQnA_no = customerQnA_no;
	}
	public String getCustomerqnaimage_location() {
		return customerqnaimage_location;
	}
	public void setCustomerqnaimage_location(String customerqnaimage_location) {
		this.customerqnaimage_location = customerqnaimage_location;
	}
	public String getCustomerqnaimage_orifilename() {
		return customerqnaimage_orifilename;
	}
	public void setCustomerqnaimage_orifilename(String customerqnaimage_orifilename) {
		this.customerqnaimage_orifilename = customerqnaimage_orifilename;
	}
	public CustomerQnAImageVO(int customerqnaimage_no, int customerQnA_no, String customerqnaimage_location,
			String customerqnaimage_orifilename) {
		super();
		this.customerqnaimage_no = customerqnaimage_no;
		this.customerQnA_no = customerQnA_no;
		this.customerqnaimage_location = customerqnaimage_location;
		this.customerqnaimage_orifilename = customerqnaimage_orifilename;
	}
	public CustomerQnAImageVO() {
		super();
	}
	
	
	
	
}