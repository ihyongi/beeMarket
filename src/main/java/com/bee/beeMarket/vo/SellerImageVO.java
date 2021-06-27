package com.bee.beeMarket.vo;

public class SellerImageVO {
	
	private int sellerimage_no;
	private int seller_no;
	private String sellerimage_location; 
	private String sellerimage_orifilename;
	
	public SellerImageVO() {
		// TODO Auto-generated constructor stub
	}
	
	public SellerImageVO(int sellerimage_no, int seller_no, String sellerimage_location,
			String sellerimage_orifilename) {
		super();
		this.sellerimage_no = sellerimage_no;
		this.seller_no = seller_no;
		this.sellerimage_location = sellerimage_location;
		this.sellerimage_orifilename = sellerimage_orifilename;
	}
	
	
	
	public int getSellerimage_no() {
		return sellerimage_no;
	}
	public void setSellerimage_no(int sellerimage_no) {
		this.sellerimage_no = sellerimage_no;
	}
	public int getSeller_no() {
		return seller_no;
	}
	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}
	public String getSellerimage_location() {
		return sellerimage_location;
	}
	public void setSellerimage_location(String sellerimage_location) {
		this.sellerimage_location = sellerimage_location;
	}
	public String getSellerimage_orifilename() {
		return sellerimage_orifilename;
	}
	public void setSellerimage_orifilename(String sellerimage_orifilename) {
		this.sellerimage_orifilename = sellerimage_orifilename;
	}
	
	
}

