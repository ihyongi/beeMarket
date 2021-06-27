package com.bee.beeMarket.vo;

public class LikeProductVO {

	private int likeproduct_no;
	private int customer_no;
	private int product_no;
	
	public LikeProductVO() {
		// TODO Auto-generated constructor stub
	}

	public LikeProductVO(int likeproduct_no, int customer_no, int product_no) {
		super();
		this.likeproduct_no = likeproduct_no;
		this.customer_no = customer_no;
		this.product_no = product_no;
	}

	public int getLikeproduct_no() {
		return likeproduct_no;
	}

	public void setLikeproduct_no(int likeproduct_no) {
		this.likeproduct_no = likeproduct_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	
	
}
