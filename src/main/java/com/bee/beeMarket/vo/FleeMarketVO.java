package com.bee.beeMarket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class FleeMarketVO {
	private int fleemarket_no;
	private int seller_no;
	private int delivery_no;
	private int categorydetail_no;
	private String fleemarket_name;
	private String fleemarket_title;
	private String fleemarket_content;
	private int fleemarket_readcount;
	private int fleemarket_itemqty;
	private int fleemarket_remainqty;
	private int fleemarket_price;
	private int fleemarket_discount;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date fleemarket_startdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date fleemarket_enddate;
	private String fleemarket_statusnm;
	private int fleemarket_statuscd;
	private Date fleemarket_writedate;
	
	public FleeMarketVO() {
		// TODO Auto-generated constructor stub
	}

	public FleeMarketVO(int fleemarket_no, int seller_no, int delivery_no, int categorydetail_no,
			String fleemarket_name, String fleemarket_title, String fleemarket_content, int fleemarket_readcount,
			int fleemarket_itemqty, int fleemarket_remainqty, int fleemarket_price, int fleemarket_discount,
			Date fleemarket_startdate, Date fleemarket_enddate, String fleemarket_statusnm, int fleemarket_statuscd,
			Date fleemarket_writedate) {
		super();
		this.fleemarket_no = fleemarket_no;
		this.seller_no = seller_no;
		this.delivery_no = delivery_no;
		this.categorydetail_no = categorydetail_no;
		this.fleemarket_name = fleemarket_name;
		this.fleemarket_title = fleemarket_title;
		this.fleemarket_content = fleemarket_content;
		this.fleemarket_readcount = fleemarket_readcount;
		this.fleemarket_itemqty = fleemarket_itemqty;
		this.fleemarket_remainqty = fleemarket_remainqty;
		this.fleemarket_price = fleemarket_price;
		this.fleemarket_discount = fleemarket_discount;
		this.fleemarket_startdate = fleemarket_startdate;
		this.fleemarket_enddate = fleemarket_enddate;
		this.fleemarket_statusnm = fleemarket_statusnm;
		this.fleemarket_statuscd = fleemarket_statuscd;
		this.fleemarket_writedate = fleemarket_writedate;
	}

	public int getFleemarket_no() {
		return fleemarket_no;
	}

	public void setFleemarket_no(int fleemarket_no) {
		this.fleemarket_no = fleemarket_no;
	}

	public int getSeller_no() {
		return seller_no;
	}

	public void setSeller_no(int seller_no) {
		this.seller_no = seller_no;
	}

	public int getDelivery_no() {
		return delivery_no;
	}

	public void setDelivery_no(int delivery_no) {
		this.delivery_no = delivery_no;
	}

	public int getCategorydetail_no() {
		return categorydetail_no;
	}

	public void setCategorydetail_no(int categorydetail_no) {
		this.categorydetail_no = categorydetail_no;
	}

	public String getFleemarket_name() {
		return fleemarket_name;
	}

	public void setFleemarket_name(String fleemarket_name) {
		this.fleemarket_name = fleemarket_name;
	}

	public String getFleemarket_title() {
		return fleemarket_title;
	}

	public void setFleemarket_title(String fleemarket_title) {
		this.fleemarket_title = fleemarket_title;
	}

	public String getFleemarket_content() {
		return fleemarket_content;
	}

	public void setFleemarket_content(String fleemarket_content) {
		this.fleemarket_content = fleemarket_content;
	}

	public int getFleemarket_readcount() {
		return fleemarket_readcount;
	}

	public void setFleemarket_readcount(int fleemarket_readcount) {
		this.fleemarket_readcount = fleemarket_readcount;
	}

	public int getFleemarket_itemqty() {
		return fleemarket_itemqty;
	}

	public void setFleemarket_itemqty(int fleemarket_itemqty) {
		this.fleemarket_itemqty = fleemarket_itemqty;
	}

	public int getFleemarket_remainqty() {
		return fleemarket_remainqty;
	}

	public void setFleemarket_remainqty(int fleemarket_remainqty) {
		this.fleemarket_remainqty = fleemarket_remainqty;
	}

	public int getFleemarket_price() {
		return fleemarket_price;
	}

	public void setFleemarket_price(int fleemarket_price) {
		this.fleemarket_price = fleemarket_price;
	}

	public int getFleemarket_discount() {
		return fleemarket_discount;
	}

	public void setFleemarket_discount(int fleemarket_discount) {
		this.fleemarket_discount = fleemarket_discount;
	}

	public Date getFleemarket_startdate() {
		return fleemarket_startdate;
	}

	public void setFleemarket_startdate(Date fleemarket_startdate) {
		this.fleemarket_startdate = fleemarket_startdate;
	}

	public Date getFleemarket_enddate() {
		return fleemarket_enddate;
	}

	public void setFleemarket_enddate(Date fleemarket_enddate) {
		this.fleemarket_enddate = fleemarket_enddate;
	}

	public String getFleemarket_statusnm() {
		return fleemarket_statusnm;
	}

	public void setFleemarket_statusnm(String fleemarket_statusnm) {
		this.fleemarket_statusnm = fleemarket_statusnm;
	}

	public int getFleemarket_statuscd() {
		return fleemarket_statuscd;
	}

	public void setFleemarket_statuscd(int fleemarket_statuscd) {
		this.fleemarket_statuscd = fleemarket_statuscd;
	}

	public Date getFleemarket_writedate() {
		return fleemarket_writedate;
	}

	public void setFleemarket_writedate(Date fleemarket_writedate) {
		this.fleemarket_writedate = fleemarket_writedate;
	}

	
	
	
	
	
}
