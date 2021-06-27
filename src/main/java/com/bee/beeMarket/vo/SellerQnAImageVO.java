package com.bee.beeMarket.vo;

public class SellerQnAImageVO {
	
	private int sellerqnaimage_no;
	private int sellerQnA_no;
	private String sellerqnaimage_location;
	private String sellerqnaimage_orifilename;
	public SellerQnAImageVO() {
		super();
	}
	public SellerQnAImageVO(int sellerqnaimage_no, int sellerQnA_no, String sellerqnaimage_location,
			String sellerqnaimage_orifilename) {
		super();
		this.sellerqnaimage_no = sellerqnaimage_no;
		this.sellerQnA_no = sellerQnA_no;
		this.sellerqnaimage_location = sellerqnaimage_location;
		this.sellerqnaimage_orifilename = sellerqnaimage_orifilename;
	}
	public int getSellerqnaimage_no() {
		return sellerqnaimage_no;
	}
	public void setSellerqnaimage_no(int sellerqnaimage_no) {
		this.sellerqnaimage_no = sellerqnaimage_no;
	}
	public int getSellerQnA_no() {
		return sellerQnA_no;
	}
	public void setSellerQnA_no(int sellerQnA_no) {
		this.sellerQnA_no = sellerQnA_no;
	}
	public String getSellerqnaimage_location() {
		return sellerqnaimage_location;
	}
	public void setSellerqnaimage_location(String sellerqnaimage_location) {
		this.sellerqnaimage_location = sellerqnaimage_location;
	}
	public String getSellerqnaimage_orifilename() {
		return sellerqnaimage_orifilename;
	}
	public void setSellerqnaimage_orifilename(String sellerqnaimage_orifilename) {
		this.sellerqnaimage_orifilename = sellerqnaimage_orifilename;
	}
	

}
