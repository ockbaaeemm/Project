package com.teamb.freenext.vo;

public class LocalCategoryVo {
	private int local_no;
	private String local_name;
	
	public LocalCategoryVo() {
		super();
	}

	public LocalCategoryVo(int local_no, String local_name) {
		super();
		this.local_no = local_no;
		this.local_name = local_name;
	}

	public int getLocal_no() {
		return local_no;
	}

	public void setLocal_no(int local_no) {
		this.local_no = local_no;
	}

	public String getLocal_name() {
		return local_name;
	}

	public void setLocal_name(String local_name) {
		this.local_name = local_name;
	}
}
