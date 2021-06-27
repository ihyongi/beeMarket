package com.bee.beeMarket.vo;

public class CommunicationImageVO {
	private int image_no;
	private int communication_no;
	private String image_location;
	private String image_original_filename;
	
	public CommunicationImageVO() {
		// TODO Auto-generated constructor stub
	}

	public CommunicationImageVO(int image_no, int communication_no, String image_location,
			String image_original_filename) {
		super();
		this.image_no = image_no;
		this.communication_no = communication_no;
		this.image_location = image_location;
		this.image_original_filename = image_original_filename;
	}

	public int getImage_no() {
		return image_no;
	}

	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}

	public int getCommunication_no() {
		return communication_no;
	}

	public void setCommunication_no(int communication_no) {
		this.communication_no = communication_no;
	}

	public String getImage_location() {
		return image_location;
	}

	public void setImage_location(String image_location) {
		this.image_location = image_location;
	}

	public String getImage_original_filename() {
		return image_original_filename;
	}

	public void setImage_original_filename(String image_original_filename) {
		this.image_original_filename = image_original_filename;
	}
	
	
}
