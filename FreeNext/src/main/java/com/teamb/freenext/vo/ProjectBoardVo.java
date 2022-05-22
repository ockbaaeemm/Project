package com.teamb.freenext.vo;

import java.util.Date;

public class ProjectBoardVo {
	private int project_no;
	private int member_no;
	private int workType_no;
	private int recruitType_no;
	private int cooperation_no;
	private String project_name;
	private String project_period;
	private String project_price;
	private String project_state;
	private String project_content;
	private String project_url;
	private Date project_date;
	private String project_key;
	
	public ProjectBoardVo() {
		super();
	}

	public ProjectBoardVo(int project_no, int member_no, int workType_no, int recruitType_no, int cooperation_no,
			String project_name, String project_period, String project_price, String project_state,
			String project_content, String project_url, Date project_date, String project_key) {
		super();
		this.project_no = project_no;
		this.member_no = member_no;
		this.workType_no = workType_no;
		this.recruitType_no = recruitType_no;
		this.cooperation_no = cooperation_no;
		this.project_name = project_name;
		this.project_period = project_period;
		this.project_price = project_price;
		this.project_state = project_state;
		this.project_content = project_content;
		this.project_url = project_url;
		this.project_date = project_date;
		this.project_key = project_key;
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

	public int getWorkType_no() {
		return workType_no;
	}

	public void setWorkType_no(int workType_no) {
		this.workType_no = workType_no;
	}

	public int getRecruitType_no() {
		return recruitType_no;
	}

	public void setRecruitType_no(int recruitType_no) {
		this.recruitType_no = recruitType_no;
	}

	public int getCooperation_no() {
		return cooperation_no;
	}

	public void setCooperation_no(int cooperation_no) {
		this.cooperation_no = cooperation_no;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getProject_period() {
		return project_period;
	}

	public void setProject_period(String project_period) {
		this.project_period = project_period;
	}

	public String getProject_price() {
		return project_price;
	}

	public void setProject_price(String project_price) {
		this.project_price = project_price;
	}

	public String getProject_state() {
		return project_state;
	}

	public void setProject_state(String project_state) {
		this.project_state = project_state;
	}

	public String getProject_content() {
		return project_content;
	}

	public void setProject_content(String project_content) {
		this.project_content = project_content;
	}

	public String getProject_url() {
		return project_url;
	}

	public void setProject_url(String project_url) {
		this.project_url = project_url;
	}

	public Date getProject_date() {
		return project_date;
	}

	public void setProject_date(Date project_date) {
		this.project_date = project_date;
	}

	public String getProject_key() {
		return project_key;
	}

	public void setProject_key(String project_key) {
		this.project_key = project_key;
	}
}
