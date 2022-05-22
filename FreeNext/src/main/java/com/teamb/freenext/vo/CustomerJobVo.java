package com.teamb.freenext.vo;

public class CustomerJobVo {
	private int customer_job_no;
	private int customer_no;
	private int job_no;
	
	public CustomerJobVo() {
		super();
	}

	public CustomerJobVo(int customer_job_no, int customer_no, int job_no) {
		super();
		this.customer_job_no = customer_job_no;
		this.customer_no = customer_no;
		this.job_no = job_no;
	}

	public int getCustomer_job_no() {
		return customer_job_no;
	}

	public void setCustomer_job_no(int customer_job_no) {
		this.customer_job_no = customer_job_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getJob_no() {
		return job_no;
	}

	public void setJob_no(int job_no) {
		this.job_no = job_no;
	}
}
