package com.bee.beeMarket.vo;

public class ProductImageVO {
	private int productimage_no;
	private int product_no;
	private String productimage_location;
	private String productimage_orifilename;
	
	public ProductImageVO() {
		super();
	}

	public ProductImageVO(int productimage_no, int product_no, String productimage_location,
			String productimage_orifilename) {
		super();
		this.productimage_no = productimage_no;
		this.product_no = product_no;
		this.productimage_location = productimage_location;
		this.productimage_orifilename = productimage_orifilename;
	}

	public int getProductimage_no() {
		return productimage_no;
	}

	public void setProductimage_no(int productimage_no) {
		this.productimage_no = productimage_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public String getProductimage_location() {
		return productimage_location;
	}

	public void setProductimage_location(String productimage_location) {
		this.productimage_location = productimage_location;
	}

	public String getProductimage_orifilename() {
		return productimage_orifilename;
	}

	public void setProductimage_orifilename(String productimage_orifilename) {
		this.productimage_orifilename = productimage_orifilename;
	}
	
	
	
}
