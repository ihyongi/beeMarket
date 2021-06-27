package com.bee.beeMarket.vo;

import java.util.Date;

public class ProductVO {
	private int product_no;
	private int seller_no;
	private String product_title;
	private String product_name;
	private int categorydetail_no;
	private int delivery_no;
	private String product_content;
	private int product_readcount;
	private Date product_writedate;
	
	public ProductVO() {
		super();
	}

	public ProductVO(int product_no, int seller_no, String product_title, String product_name, int categorydetail_no,
			int delivery_no, String product_content, int product_readcount, Date product_writedate) {
		super();
		this.product_no = product_no;
		this.seller_no = seller_no;
		this.product_title = product_title;
		this.product_name = product_name;
		this.categorydetail_no = categorydetail_no;
		this.delivery_no = delivery_no;
		this.product_content = product_content;
		this.product_readcount = product_readcount;
		this.product_writedate = product_writedate;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public int getSeller_no() {
		return seller_no;
	}

	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getCategorydetail_no() {
		return categorydetail_no;
	}

	public void setCategorydetail_no(int categorydetail_no) {
		this.categorydetail_no = categorydetail_no;
	}

	public int getDelivery_no() {
		return delivery_no;
	}

	public void setDelivery_no(int delivery_no) {
		this.delivery_no = delivery_no;
	}

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public int getProduct_readcount() {
		return product_readcount;
	}

	public void setProduct_readcount(int product_readcount) {
		this.product_readcount = product_readcount;
	}

	public Date getProduct_writedate() {
		return product_writedate;
	}

	public void setProduct_writedate(Date product_writedate) {
		this.product_writedate = product_writedate;
	}
	
	
	
	
}
