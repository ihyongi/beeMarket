package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class SellerQnAVO {
	
	private int sellerQnA_no;
	private int seller_no;
	private int sellerqnacategory_no;
	private String sellerQnA_title ;
	private String sellerQnA_content;
	private String sellerQnA_statue;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sellerQnA_writedate;
	public int getSellerQnA_no() {
		return sellerQnA_no;
	}
	public void setSellerQnA_no(int sellerQnA_no) {
		this.sellerQnA_no = sellerQnA_no;
	}
	public int getSeller_no() {
		return seller_no;
	}
	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}
	public int getSellerqnacategory_no() {
		return sellerqnacategory_no;
	}
	public void setSellerqnacategory_no(int sellerqnacategory_no) {
		this.sellerqnacategory_no = sellerqnacategory_no;
	}
	public String getSellerQnA_title() {
		return sellerQnA_title;
	}
	public void setSellerQnA_title(String sellerQnA_title) {
		this.sellerQnA_title = sellerQnA_title;
	}
	public String getSellerQnA_content() {
		return sellerQnA_content;
	}
	public void setSellerQnA_content(String sellerQnA_content) {
		this.sellerQnA_content = sellerQnA_content;
	}
	public String getSellerQnA_statue() {
		return sellerQnA_statue;
	}
	public void setSellerQnA_statue(String sellerQnA_statue) {
		this.sellerQnA_statue = sellerQnA_statue;
	}
	public Date getSellerQnA_writedate() {
		return sellerQnA_writedate;
	}
	public void setSellerQnA_writedate(Date sellerQnA_writedate) {
		this.sellerQnA_writedate = sellerQnA_writedate;
	}
	public SellerQnAVO(int sellerQnA_no, int seller_no, int sellerqnacategory_no, String sellerQnA_title,
			String sellerQnA_content, String sellerQnA_statue, Date sellerQnA_writedate) {
		super();
		this.sellerQnA_no = sellerQnA_no;
		this.seller_no = seller_no;
		this.sellerqnacategory_no = sellerqnacategory_no;
		this.sellerQnA_title = sellerQnA_title;
		this.sellerQnA_content = sellerQnA_content;
		this.sellerQnA_statue = sellerQnA_statue;
		this.sellerQnA_writedate = sellerQnA_writedate;
	}
	public SellerQnAVO() {
		super();
	}
	

}
