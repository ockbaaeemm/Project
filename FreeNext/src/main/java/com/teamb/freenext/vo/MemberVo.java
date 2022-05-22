package com.teamb.freenext.vo;

import java.util.Date;

public class MemberVo {
	private int member_no;
	private String member_type;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_approval;
	private String member_phone;	
	private String member_email;
	private String member_address;
	private String member_profile;
	private Date member_joindate;
	
	public MemberVo() {
		super();
	}

	public MemberVo(int member_no, String member_type, String member_id, String member_pw, String member_name,
			String member_approval, String member_phone, String member_email, String member_address, String member_profile,
			Date member_joindate) {
		super();
		this.member_no = member_no;
		this.member_type = member_type;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_approval = member_approval;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_address = member_address;
		this.member_profile = member_profile;
		this.member_joindate = member_joindate;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMember_type() {
		return member_type;
	}

	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_approval() {
		return member_approval;
	}

	public void setMember_approval(String member_approval) {
		this.member_approval = member_approval;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	
	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	public String getMember_profile() {
		return member_profile;
	}

	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}

	public Date getMember_joindate() {
		return member_joindate;
	}

	public void setMember_joindate(Date member_joindate) {
		this.member_joindate = member_joindate;
	}	
}
