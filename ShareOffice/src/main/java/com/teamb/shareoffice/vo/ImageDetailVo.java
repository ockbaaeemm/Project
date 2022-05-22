package com.teamb.shareoffice.vo;

public class ImageDetailVo {
	
	private int image_no;
	private int office_no;
	private String image_url;
	public ImageDetailVo() {
		super();
	}
	public ImageDetailVo(int image_no, int office_no, String image_url) {
		super();
		this.image_no = image_no;
		this.office_no = office_no;
		this.image_url = image_url;
	}
	public int getImage_no() {
		return image_no;
	}
	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}
	public int getOffice_no() {
		return office_no;
	}
	public void setOffice_no(int office_no) {
		this.office_no = office_no;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	

}
