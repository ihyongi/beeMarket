package com.bee.beeMarket.vo;

import java.util.Date;

public class ProductWarehouseVO {

	private int productwarehouse_no;
	private int productdetail_no;
	private int productwarehouse_pluscount;
	private Date productwarehouse_writeDate;
	
	public ProductWarehouseVO() {
		super();
	}
	
	public ProductWarehouseVO(int productwarehouse_no, int productdetail_no, int productwarehouse_pluscount,
			Date productwarehouse_writeDate) {
		super();
		this.productwarehouse_no = productwarehouse_no;
		this.productdetail_no = productdetail_no;
		this.productwarehouse_pluscount = productwarehouse_pluscount;
		this.productwarehouse_writeDate = productwarehouse_writeDate;
	}
	
	public int getProductwarehouse_no() {
		return productwarehouse_no;
	}
	public void setProductwarehouse_no(int productwarehouse_no) {
		this.productwarehouse_no = productwarehouse_no;
	}
	public int getProductdetail_no() {
		return productdetail_no;
	}
	public void setProductdetail_no(int productdetail_no) {
		this.productdetail_no = productdetail_no;
	}
	public int getProductwarehouse_pluscount() {
		return productwarehouse_pluscount;
	}
	public void setProductwarehouse_pluscount(int productwarehouse_pluscount) {
		this.productwarehouse_pluscount = productwarehouse_pluscount;
	}
	public Date getProductwarehouse_writeDate() {
		return productwarehouse_writeDate;
	}
	public void setProductwarehouse_writeDate(Date productwarehouse_writeDate) {
		this.productwarehouse_writeDate = productwarehouse_writeDate;
	}

}
