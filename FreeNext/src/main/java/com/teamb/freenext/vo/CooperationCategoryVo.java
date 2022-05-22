package com.teamb.freenext.vo;

public class CooperationCategoryVo {
	private int cooperation_no;
	private String cooperation_name;
	
	public CooperationCategoryVo() {
		super();
	}

	public CooperationCategoryVo(int cooperation_no, String cooperation_name) {
		super();
		this.cooperation_no = cooperation_no;
		this.cooperation_name = cooperation_name;
	}

	public int getCooperation_no() {
		return cooperation_no;
	}

	public void setCooperation_no(int cooperation_no) {
		this.cooperation_no = cooperation_no;
	}

	public String getCooperation_name() {
		return cooperation_name;
	}

	public void setCooperation_name(String cooperation_name) {
		this.cooperation_name = cooperation_name;
	}
}
