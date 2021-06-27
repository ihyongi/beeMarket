package com.bee.beeMarket.vo;

import java.util.Date;

public class ProductCommentVO {
	private int productcomment_no;
	private int product_no;
	private int customer_no;
	private String productcomment_content;
	private int productcomment_star;
	private Date productcomment_writedate;
	public ProductCommentVO() {
		super();
	}
	public ProductCommentVO(int productcomment_no, int product_no, int customer_no, String productcomment_content,
			int productcomment_star, Date productcomment_writedate) {
		super();
		this.productcomment_no = productcomment_no;
		this.product_no = product_no;
		this.customer_no = customer_no;
		this.productcomment_content = productcomment_content;
		this.productcomment_star = productcomment_star;
		this.productcomment_writedate = productcomment_writedate;
	}
	public int getProductcomment_no() {
		return productcomment_no;
	}
	public void setProductcomment_no(int productcomment_no) {
		this.productcomment_no = productcomment_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getCustomer_no() {
		return customer_no;
	}
	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}
	public String getProductcomment_content() {
		return productcomment_content;
	}
	public void setProductcomment_content(String productcomment_content) {
		this.productcomment_content = productcomment_content;
	}
	public int getProductcomment_star() {
		return productcomment_star;
	}
	public void setProductcomment_star(int productcomment_star) {
		this.productcomment_star = productcomment_star;
	}
	public Date getProductcomment_writedate() {
		return productcomment_writedate;
	}
	public void setProductcomment_writedate(Date productcomment_writedate) {
		this.productcomment_writedate = productcomment_writedate;
	}
	
}
