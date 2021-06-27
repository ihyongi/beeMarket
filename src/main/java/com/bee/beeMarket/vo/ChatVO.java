package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChatVO {

	private int chat_no;
	private int channel_no;
	private String message;
	private String receiver;
	private String sender;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:MM:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:MM:ss")
	private Date chat_time;
	private String read_status;
	
	public ChatVO() {
		// TODO Auto-generated constructor stub
	}

	public ChatVO(int chat_no, int channel_no, String message, String receiver, String sender, Date chat_time,
			String read_status) {
		super();
		this.chat_no = chat_no;
		this.channel_no = channel_no;
		this.message = message;
		this.receiver = receiver;
		this.sender = sender;
		this.chat_time = chat_time;
		this.read_status = read_status;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public int getChannel_no() {
		return channel_no;
	}

	public void setChannel_no(int channel_no) {
		this.channel_no = channel_no;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public Date getChat_time() {
		return chat_time;
	}

	public void setChat_time(Date chat_time) {
		this.chat_time = chat_time;
	}

	public String getRead_status() {
		return read_status;
	}

	public void setRead_status(String read_status) {
		this.read_status = read_status;
	}

	

	

	
	
	
}
