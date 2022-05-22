package com.teamb.freenext.vo;

import java.util.Date;

public class MailAuthVo {
	private int mailauth_no;
	private int member_no;
	private String mailauth_key;
	private String mailauth_complete;
	private Date mailauth_date;
	
	public MailAuthVo() {
		super();
	}

	public MailAuthVo(int mailauth_no, int member_no, String mailauth_key, String mailauth_complete,
			Date mailauth_date) {
		super();
		this.mailauth_no = mailauth_no;
		this.member_no = member_no;
		this.mailauth_key = mailauth_key;
		this.mailauth_complete = mailauth_complete;
		this.mailauth_date = mailauth_date;
	}

	public int getMailauth_no() {
		return mailauth_no;
	}

	public void setMailauth_no(int mailauth_no) {
		this.mailauth_no = mailauth_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMailauth_key() {
		return mailauth_key;
	}

	public void setMailauth_key(String mailauth_key) {
		this.mailauth_key = mailauth_key;
	}

	public String getMailauth_complete() {
		return mailauth_complete;
	}

	public void setMailauth_complete(String mailauth_complete) {
		this.mailauth_complete = mailauth_complete;
	}

	public Date getMailauth_date() {
		return mailauth_date;
	}

	public void setMailauth_date(Date mailauth_date) {
		this.mailauth_date = mailauth_date;
	}
	
	
	
}
