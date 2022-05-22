package com.teamb.freenext.vo;

public class WorkTypeCategoryVo {
	private int workType_no;
	private String workType_name;
	
	public WorkTypeCategoryVo() {
		super();
	}

	public WorkTypeCategoryVo(int workType_no, String workType_name) {
		super();
		this.workType_no = workType_no;
		this.workType_name = workType_name;
	}

	public int getWorkType_no() {
		return workType_no;
	}

	public void setWorkType_no(int workType_no) {
		this.workType_no = workType_no;
	}

	public String getWorkType_name() {
		return workType_name;
	}

	public void setWorkType_name(String workType_name) {
		this.workType_name = workType_name;
	}
}
