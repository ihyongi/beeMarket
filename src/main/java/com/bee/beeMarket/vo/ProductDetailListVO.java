package com.bee.beeMarket.vo;

import java.util.Date;

public class ProductDetailListVO {

	private int productdetail_no;
	private String productdetail_option;
	private int productwarehouse_pluscount;
	private int productdetail_price;
	private Date productwarehouse_writedate;
	
	public ProductDetailListVO() {
		// TODO Auto-generated constructor stub
	}
	
	

	public ProductDetailListVO(int productdetail_no, String productdetail_option, int productwarehouse_pluscount,
			int productdetail_price, Date productwarehouse_writedate) {
		super();
		this.productdetail_no = productdetail_no;
		this.productdetail_option = productdetail_option;
		this.productwarehouse_pluscount = productwarehouse_pluscount;
		this.productdetail_price = productdetail_price;
		this.productwarehouse_writedate = productwarehouse_writedate;
	}



	public int getProductdetail_no() {
		return productdetail_no;
	}

	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}

	public String getProductdetail_option() {
		return productdetail_option;
	}

	public void setProductdetail_option(String productdetail_option) {
		this.productdetail_option = productdetail_option;
	}

	public int getProductwarehouse_pluscount() {
		return productwarehouse_pluscount;
	}

	public void setProductwarehouse_pluscount(int productwarehouse_pluscount) {
		this.productwarehouse_pluscount = productwarehouse_pluscount;
	}

	public int getProductdetail_price() {
		return productdetail_price;
	}

	public void setProductdetail_price(int productdetail_price) {
		this.productdetail_price = productdetail_price;
	}

	public Date getProductwarehouse_writedate() {
		return productwarehouse_writedate;
	}

	public void setProductwarehouse_writedate(Date productwarehouse_writedate) {
		this.productwarehouse_writedate = productwarehouse_writedate;
	}
	
	
}
