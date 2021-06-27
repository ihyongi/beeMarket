package com.bee.beeMarket.vo;

public class AddressListVO {
	
	private int address_no;
	private int customer_no;
	private String address_number;
	private String address_location;
	
	public AddressListVO() {
		super();
	}

	public AddressListVO(int address_no, int customer_no, String address_number, String address_location) {
		super();
		this.address_no = address_no;
		this.customer_no = customer_no;
		this.address_number = address_number;
		this.address_location = address_location;
	}

	public int getAddress_no() {
		return address_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public String getAddress_number() {
		return address_number;
	}

	public String getAddress_location() {
		return address_location;
	}

	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public void setAddress_number(String address_number) {
		this.address_number = address_number;
	}

	public void setAddress_location(String address_location) {
		this.address_location = address_location;
	}
	
}
