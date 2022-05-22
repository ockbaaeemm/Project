package com.teamb.shareoffice.vo;

public class BusinessDayVo {
	
	private int day_no;
	private int office_no;
	private String business_day;
	private int business_day_price;
	private int business_time_start;
	private int business_time_finish;
	
	public BusinessDayVo() {
		super();
	}
	public BusinessDayVo(int day_no, int office_no, String business_day, int business_day_price, int business_time_start,
			int business_time_finish) {
		super();
		this.day_no = day_no;
		this.office_no = office_no;
		this.business_day = business_day;
		this.business_day_price = business_day_price;
		this.business_time_start = business_time_start;
		this.business_time_finish = business_time_finish;
	}
	
	public int getDay_no() {
		return day_no;
	}
	public void setDay_no(int day_no) {
		this.day_no = day_no;
	}
	
	public int getOffice_no() {
		return office_no;
	}
	
	public void setOffice_no(int office_no) {
		this.office_no = office_no;
	}
	
	public String getBusiness_day() {
		return business_day;
	}
	
	public void setBusiness_day(String business_day) {
		this.business_day = business_day;
	}
	public int getBusiness_day_price() {
		return business_day_price;
	}
	public void setBusiness_day_price(int business_day_price) {
		this.business_day_price = business_day_price;
	}
	public int getBusiness_time_start() {
		return business_time_start;
	}
	public void setBusiness_time_start(int business_time_start) {
		this.business_time_start = business_time_start;
	}
	public int getBusiness_time_finish() {
		return business_time_finish;
	}
	public void setBusiness_time_finish(int business_time_finish) {
		this.business_time_finish = business_time_finish;
	}
	
	
	
}
