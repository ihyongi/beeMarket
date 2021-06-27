package com.bee.beeMarket.vo;

public class DeliveryVO {
	
	private int delivery_no;
	private String delivery_name;
	private String delivery_phone;
	private String delivery_url;
	private int delivery_price;
	
	
	public DeliveryVO() {
		// TODO Auto-generated constructor stub
	}
	
	public DeliveryVO(int delivery_no, String delivery_name, String delivery_phone, String delivery_url,
			int delivery_price) {
		super();
		this.delivery_no = delivery_no;
		this.delivery_name = delivery_name;
		this.delivery_phone = delivery_phone;
		this.delivery_url = delivery_url;
		this.delivery_price = delivery_price;
	}
	
	
	public int getDelivery_no() {
		return delivery_no;
	}
	public void setDelivery_no(int delivery_no) {
		this.delivery_no = delivery_no;
	}
	public String getDelivery_name() {
		return delivery_name;
	}
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	public String getDelivery_phone() {
		return delivery_phone;
	}
	public void setDelivery_phone(String delivery_phone) {
		this.delivery_phone = delivery_phone;
	}
	public String getDelivery_url() {
		return delivery_url;
	}
	public void setDelivery_url(String delivery_url) {
		this.delivery_url = delivery_url;
	}
	public int getDelivery_price() {
		return delivery_price;
	}
	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}
}
