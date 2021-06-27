package com.bee.beeMarket.vo;

import java.util.Date;

public class CommentVO {
	private int comment_no;
	private int communication_no;
	private int customer_no;
	private String comment_content;
	private Date comment_writedate;
	
	public CommentVO() {
		// TODO Auto-generated constructor stub
	}

	public CommentVO(int comment_no, int communication_no, int customer_no, String comment_content,
			Date comment_writedate) {
		super();
		this.comment_no = comment_no;
		this.communication_no = communication_no;
		this.customer_no = customer_no;
		this.comment_content = comment_content;
		this.comment_writedate = comment_writedate;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getCommunication_no() {
		return communication_no;
	}

	public void setCommunication_no(int communication_no) {
		this.communication_no = communication_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Date getComment_writedate() {
		return comment_writedate;
	}

	public void setComment_writedate(Date comment_writedate) {
		this.comment_writedate = comment_writedate;
	}
	
	
	
}
