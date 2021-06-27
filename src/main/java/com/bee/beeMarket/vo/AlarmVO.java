package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class AlarmVO {
	
	private int alarm_no;
	private int customer_no;
	private int product_no;
	private String alarm_comment;
	private String alarm_read;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date alarm_writedate;
	private Date alarm_readdate;
	
	public AlarmVO() {
		super();
	}

	public AlarmVO(int alarm_no, int customer_no, int product_no, String alarm_comment, String alarm_read,
			Date alarm_writedate, Date alarm_readdate) {
		super();
		this.alarm_no = alarm_no;
		this.customer_no = customer_no;
		this.product_no = product_no;
		this.alarm_comment = alarm_comment;
		this.alarm_read = alarm_read;
		this.alarm_writedate = alarm_writedate;
		this.alarm_readdate = alarm_readdate;
	}

	public int getAlarm_no() {
		return alarm_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public String getAlarm_comment() {
		return alarm_comment;
	}

	public String getAlarm_read() {
		return alarm_read;
	}

	public Date getAlarm_writedate() {
		return alarm_writedate;
	}

	public Date getAlarm_readdate() {
		return alarm_readdate;
	}

	public void setAlarm_no(int alarm_no) {
		this.alarm_no = alarm_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public void setAlarm_comment(String alarm_comment) {
		this.alarm_comment = alarm_comment;
	}

	public void setAlarm_read(String alarm_read) {
		this.alarm_read = alarm_read;
	}

	public void setAlarm_writedate(Date alarm_writedate) {
		this.alarm_writedate = alarm_writedate;
	}

	public void setAlarm_readdate(Date alarm_readdate) {
		this.alarm_readdate = alarm_readdate;
	}
	
	
}
