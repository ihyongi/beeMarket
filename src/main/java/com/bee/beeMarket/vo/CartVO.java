package com.bee.beeMarket.vo;

public class CartVO {

	private int cart_no;
	private int customer_no;
	private int productdetail_no;
	private int productdetail_count;

	public CartVO() {
		// TODO Auto-generated constructor stub
	}

	public CartVO(int cart_no, int customer_no, int productdetail_no, int productdetail_count) {
		super();
		this.cart_no = cart_no;
		this.customer_no = customer_no;
		this.productdetail_no = productdetail_no;
		this.productdetail_count = productdetail_count;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getProductdetail_no() {
		return productdetail_no;
	}

	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}

	public int getProductdetail_count() {
		return productdetail_count;
	}

	public void setProductdetail_count(int productdetail_count) {
		this.productdetail_count = productdetail_count;
	}
	
	
	
}
