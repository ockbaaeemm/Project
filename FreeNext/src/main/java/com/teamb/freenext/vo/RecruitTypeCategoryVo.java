package com.teamb.freenext.vo;

public class RecruitTypeCategoryVo {
	private int recruitType_no;
	private String recruitType_name;
	
	public RecruitTypeCategoryVo() {
		super();
	}

	public RecruitTypeCategoryVo(int recruitType_no, String recruitType_name) {
		super();
		this.recruitType_no = recruitType_no;
		this.recruitType_name = recruitType_name;
	}

	public int getRecruitType_no() {
		return recruitType_no;
	}

	public void setRecruitType_no(int recruitType_no) {
		this.recruitType_no = recruitType_no;
	}

	public String getRecruitType_name() {
		return recruitType_name;
	}

	public void setRecruitType_name(String recruitType_name) {
		this.recruitType_name = recruitType_name;
	}
}
