package com.teamb.freenext.vo;

public class CustomerLocalVo {
	private int customer_local_no;
	private int customer_no;
	private int local_no;
	
	public CustomerLocalVo() {
		super();
	}

	public CustomerLocalVo(int customer_local_no, int customer_no, int local_no) {
		super();
		this.customer_local_no = customer_local_no;
		this.customer_no = customer_no;
		this.local_no = local_no;
	}

	public int getCustomer_local_no() {
		return customer_local_no;
	}

	public void setCustomer_local_no(int customer_local_no) {
		this.customer_local_no = customer_local_no;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getLocal_no() {
		return local_no;
	}

	public void setLocal_no(int local_no) {
		this.local_no = local_no;
	}
}
