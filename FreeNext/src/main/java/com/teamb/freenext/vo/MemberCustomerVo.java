package com.teamb.freenext.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberCustomerVo {
	private int customer_no;
	private int member_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date customer_birth;
	private String customer_number;
	private String customer_agree_email;
	private String customer_agree_sns;
	
	public MemberCustomerVo() {
		super();
	}

	public MemberCustomerVo(int customer_no, int member_no, Date customer_birth, String customer_number,
			String customer_agree_email, String customer_agree_sns) {
		super();
		this.customer_no = customer_no;
		this.member_no = member_no;
		this.customer_birth = customer_birth;
		this.customer_number = customer_number;
		this.customer_agree_email = customer_agree_email;
		this.customer_agree_sns = customer_agree_sns;
	}

	public int getCustomer_no() {
		return customer_no;
	}

	public void setCustomer_no(int customer_no) {
		this.customer_no = customer_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public Date getCustomer_birth() {
		return customer_birth;
	}

	public void setCustomer_birth(Date customer_birth) {
		this.customer_birth = customer_birth;
	}

	public String getCustomer_number() {
		return customer_number;
	}

	public void setCustomer_number(String customer_number) {
		this.customer_number = customer_number;
	}

	public String getCustomer_agree_email() {
		return customer_agree_email;
	}

	public void setCustomer_agree_email(String customer_agree_email) {
		this.customer_agree_email = customer_agree_email;
	}

	public String getCustomer_agree_sns() {
		return customer_agree_sns;
	}

	public void setCustomer_agree_sns(String customer_agree_sns) {
		this.customer_agree_sns = customer_agree_sns;
	}
}
