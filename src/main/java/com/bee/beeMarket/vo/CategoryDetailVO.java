package com.bee.beeMarket.vo;

public class CategoryDetailVO {
	
	private int categorydetail_no;
	private int category_no;
	private String categorydetail_name;
	
	public CategoryDetailVO() {
		// TODO Auto-generated constructor stub
	}

	public CategoryDetailVO(int categorydetail_no, int category_no, String categorydetail_name) {
		super();
		this.categorydetail_no = categorydetail_no;
		this.category_no = category_no;
		this.categorydetail_name = categorydetail_name;
	}

	public int getCategorydetail_no() {
		return categorydetail_no;
	}

	public void setCategorydetail_no(int categorydetail_no) {
		this.categorydetail_no = categorydetail_no;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	public String getCategorydetail_name() {
		return categorydetail_name;
	}

	public void setCategorydetail_name(String categorydetail_name) {
		this.categorydetail_name = categorydetail_name;
	}
	
}
