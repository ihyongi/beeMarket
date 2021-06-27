package com.bee.beeMarket.vo;

public class ProductDetailVO {
	private int productdetail_no;
	private int product_no;
	private String productdetail_option;
	private int productdetail_price;
	private String discount_status;
	
	public ProductDetailVO() {
		super();
	}

	public ProductDetailVO(int productdetail_no, int product_no, String productdetail_option, int productdetail_price,
			String discount_status) {
		super();
		this.productdetail_no = productdetail_no;
		this.product_no = product_no;
		this.productdetail_option = productdetail_option;
		this.productdetail_price = productdetail_price;
		this.discount_status = discount_status;
	}

	public int getProductdetail_no() {
		return productdetail_no;
	}

	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public String getProductdetail_option() {
		return productdetail_option;
	}

	public void setProductdetail_option(String productdetail_option) {
		this.productdetail_option = productdetail_option;
	}

	public int getProductdetail_price() {
		return productdetail_price;
	}

	public void setProductdetail_price(int productdetail_price) {
		this.productdetail_price = productdetail_price;
	}

	public String getDiscount_status() {
		return discount_status;
	}

	public void setDiscount_status(String discount_status) {
		this.discount_status = discount_status;
	}

	
	
	
}
