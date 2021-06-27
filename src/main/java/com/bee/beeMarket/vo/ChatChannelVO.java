package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChatChannelVO {

	private int channel_no;
	private String customer_id;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:MM:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:MM:ss")
	private Date created_at;
	
	public ChatChannelVO() {
		super();
	}
	
	public ChatChannelVO(int channel_no, String customer_id, Date created_at) {
		super();
		this.channel_no = channel_no;
		this.customer_id = customer_id;
		this.created_at = created_at;
	}
	
	public int getChannel_no() {
		return channel_no;
	}
	public void setChannel_no(int channel_no) {
		this.channel_no = channel_no;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	
	
	
}
