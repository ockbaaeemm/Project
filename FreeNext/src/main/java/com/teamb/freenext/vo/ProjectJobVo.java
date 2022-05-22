package com.teamb.freenext.vo;

public class ProjectJobVo {
	private int project_job_no;
	private int job_no;
	private int project_no;
	
	public ProjectJobVo() {
		super();
	}

	public ProjectJobVo(int project_job_no, int job_no, int project_no) {
		super();
		this.project_job_no = project_job_no;
		this.job_no = job_no;
		this.project_no = project_no;
	}

	public int getProject_job_no() {
		return project_job_no;
	}

	public void setProject_job_no(int project_job_no) {
		this.project_job_no = project_job_no;
	}

	public int getJob_no() {
		return job_no;
	}

	public void setJob_no(int job_no) {
		this.job_no = job_no;
	}

	public int getProject_no() {
		return project_no;
	}

	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}
}
