package com.teamb.freenext.vo;

import java.util.Date;

public class MyScrapVo {
	
	private int scrap_no;
	private int project_no ;
	private int member_no;
	private Date scrap_date;
	
	public MyScrapVo() {
		super();
	}
	
	public MyScrapVo(int scrap_no, int project_no, int member_no,  Date scrap_date) {
		super();
		this.scrap_no = scrap_no;
		this.project_no = project_no;
		this.member_no = member_no;

		this.scrap_date = scrap_date;
	}	
	
	public int getScrap_no() {
		return scrap_no;
	}
	public void setScrap_no(int scrap_no) {
		this.scrap_no = scrap_no;
	}
	public int getProject_no() {
		return project_no;
	}
	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}


	public Date getScrap_date() {
		return scrap_date;
	}
	public void setScrap_date(Date scrap_date) {
		this.scrap_date = scrap_date;
	}
}
