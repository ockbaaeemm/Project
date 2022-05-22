package com.teamb.freenext.vo;

import java.util.Date;

public class AdVo {
	private int ad_no;
	private int project_no;
	private Date ad_endDate;
	
	public AdVo() {
		super();
	}

	public AdVo(int ad_no, int project_no, Date ad_endDate) {
		super();
		this.ad_no = ad_no;
		this.project_no = project_no;
		this.ad_endDate = ad_endDate;
	}

	public int getAd_no() {
		return ad_no;
	}

	public void setAd_no(int ad_no) {
		this.ad_no = ad_no;
	}

	public int getProject_no() {
		return project_no;
	}

	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}

	public Date getAd_endDate() {
		return ad_endDate;
	}

	public void setAd_endDate(Date ad_endDate) {
		this.ad_endDate = ad_endDate;
	}
}
