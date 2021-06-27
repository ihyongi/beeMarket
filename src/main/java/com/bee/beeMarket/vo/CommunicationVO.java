package com.bee.beeMarket.vo;

import java.util.Date;

public class CommunicationVO {
	private int communication_no;
	private int customer_no;
	private String communication_title;
	private String communication_content;
	private int communication_readcount;
	private Date communication_writedate;
	
	public CommunicationVO() {
		// TODO Auto-generated constructor stub
	}

	public CommunicationVO(int communication_no, int customer_no, String communication_title,
			String communication_content, int communication_readcount, Date communication_writedate) {
		super();
		this.communication_no = communication_no;
		this.customer_no = customer_no;
		this.communication_title = communication_title;
		this.communication_content = communication_content;
		this.communication_readcount = communication_readcount;
		this.communication_writedate = communication_writedate;
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

	public String getCommunication_title() {
		return communication_title;
	}

	public void setCommunication_title(String communication_title) {
		this.communication_title = communication_title;
	}

	public String getCommunication_content() {
		return communication_content;
	}

	public void setCommunication_content(String communication_content) {
		this.communication_content = communication_content;
	}

	public int getCommunication_readcount() {
		return communication_readcount;
	}

	public void setCommunication_readcount(int communication_readcount) {
		this.communication_readcount = communication_readcount;
	}

	public Date getCommunication_writedate() {
		return communication_writedate;
	}

	public void setCommunication_writedate(Date communication_writedate) {
		this.communication_writedate = communication_writedate;
	}
	
	
	
	
	
}
