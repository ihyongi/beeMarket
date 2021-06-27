package com.bee.beeMarket.vo;

public class SellerQnACategoryVO {
	
	private int sellerqnacategory_no;
	private String sellerqnacategory_name;
	public int getSellerqnacategory_no() {
		return sellerqnacategory_no;
	}
	public void setSellerqnacategory_no(int sellerqnacategory_no) {
		this.sellerqnacategory_no = sellerqnacategory_no;
	}
	public String getSellerqnacategory_name() {
		return sellerqnacategory_name;
	}
	public void setSellerqnacategory_name(String sellerqnacategory_name) {
		this.sellerqnacategory_name = sellerqnacategory_name;
	}
	public SellerQnACategoryVO(int sellerqnacategory_no, String sellerqnacategory_name) {
		super();
		this.sellerqnacategory_no = sellerqnacategory_no;
		this.sellerqnacategory_name = sellerqnacategory_name;
	}
	public SellerQnACategoryVO() {
		super();
	}
	

}
