package com.teamb.freenext.vo;

public class ProjectLocalVo {
	private int project_local_no;
	private int local_no;
	private int project_no;
	
	public ProjectLocalVo() {
		super();
	}

	public ProjectLocalVo(int project_local_no, int local_no, int project_no) {
		super();
		this.project_local_no = project_local_no;
		this.local_no = local_no;
		this.project_no = project_no;
	}

	public int getProject_local_no() {
		return project_local_no;
	}

	public void setProject_local_no(int project_local_no) {
		this.project_local_no = project_local_no;
	}

	public int getLocal_no() {
		return local_no;
	}

	public void setLocal_no(int local_no) {
		this.local_no = local_no;
	}

	public int getProject_no() {
		return project_no;
	}

	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}
}
