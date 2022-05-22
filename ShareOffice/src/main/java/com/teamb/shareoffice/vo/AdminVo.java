package com.teamb.shareoffice.vo;

import java.util.Date;

public class AdminVo {
	
	private int admin_no;
	private String admin_id;
	private String admin_pw;
	private String admin_authority;
	private String admin_name;
	private String admin_phone;
	private String admin_email;
	private Date admin_joindate;
	private String admin_account;
	
	public AdminVo() {
		super();
	}
	public AdminVo(int admin_no, String admin_id, String admin_pw, String admin_authority, String admin_name,
			String admin_phone, String admin_email, Date admin_joindate, String admin_account) {
		super();
		this.admin_no = admin_no;
		this.admin_id = admin_id;
		this.admin_pw = admin_pw;
		this.admin_authority = admin_authority;
		this.admin_name = admin_name;
		this.admin_phone = admin_phone;
		this.admin_email = admin_email;
		this.admin_joindate = admin_joindate;
		this.admin_account = admin_account;
	}
	public int getAdmin_no() {
		return admin_no;
	}
	public void setAdmin_no(int admin_no) {
		this.admin_no = admin_no;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_pw() {
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
	public String getAdmin_authority() {
		return admin_authority;
	}
	public void setAdmin_authority(String admin_authority) {
		this.admin_authority = admin_authority;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getAdmin_phone() {
		return admin_phone;
	}
	public void setAdmin_phone(String admin_phone) {
		this.admin_phone = admin_phone;
	}
	public String getAdmin_email() {
		return admin_email;
	}
	public void setAdmin_email(String admin_email) {
		this.admin_email = admin_email;
	}
	public Date getAdmin_joindate() {
		return admin_joindate;
	}
	public void setAdmin_joindate(Date admin_joindate) {
		this.admin_joindate = admin_joindate;
	}
	public String getAdmin_account() {
		return admin_account;
	}
	public void setAdmin_account(String admin_account) {
		this.admin_account = admin_account;
	}
	
}
