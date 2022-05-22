package com.teamb.shareoffice.vo;

import java.util.Date;

public class ReviewVo {
	
	private int review_no;
	private int order_no;
	private String review_title;
	private String review_content;
	private int review_rating;
	private String review_image;
	private Date review_date;
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public int getReview_rating() {
		return review_rating;
	}
	public void setReview_rating(int review_rating) {
		this.review_rating = review_rating;
	}
	public String getReview_image() {
		return review_image;
	}
	public void setReview_image(String review_image) {
		this.review_image = review_image;
	}
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	public ReviewVo() {
		super();
	}
	public ReviewVo(int review_no, int order_no, String review_title, String review_content, int review_rating,
			String review_image, Date review_date) {
		super();
		this.review_no = review_no;
		this.order_no = order_no;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_rating = review_rating;
		this.review_image = review_image;
		this.review_date = review_date;
	}
	
	
	
	
}
