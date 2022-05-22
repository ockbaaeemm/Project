package com.teamb.shareoffice.vo;

import java.util.Date;

public class HostVo {
	
	private int host_no;
	private int member_no;
	private String host_owner;
	private String host_name;
	private String host_license_number;
	private String host_license_img;
	private Date host_apply_date;
	private String host_approve;
	private String host_approve_comment;
	private Date host_approve_date;
	private int host_refuse_count;
	
	
	public HostVo(int host_no, int member_no, String host_owner, String host_name, String host_license_number, String host_license_img,
			Date host_apply_date, String host_approve, String host_approve_comment, Date host_approve_date, int host_refuse_count) {
		super();
		this.host_no = host_no;
		this.member_no = member_no;
		this.host_owner = host_owner;
		this.host_name = host_name;
		this.host_license_number = host_license_number;
		this.host_license_img = host_license_img;
		this.host_apply_date = host_apply_date;
		this.host_approve = host_approve;
		this.host_approve_comment = host_approve_comment;
		this.host_approve_date = host_approve_date;
		this.host_refuse_count = host_refuse_count;
	}
	public HostVo() {
		super();
	}
	public int getHost_no() {
		return host_no;
	}
	public void setHost_no(int host_no) {
		this.host_no = host_no;
	}
	
	public int getMember_no() {
		return member_no;
	}
	
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getHost_owner() {
		return host_owner;
	}
	public void setHost_owner(String host_owner) {
		this.host_owner = host_owner;
	}
	public String getHost_name() {
		return host_name;
	}
	public void setHost_name(String host_name) {
		this.host_name = host_name;
	}
	public String getHost_license_number() {
		return host_license_number;
	}
	public void setHost_license_number(String host_license_number) {
		this.host_license_number = host_license_number;
	}
	public String getHost_license_img() {
		return host_license_img;
	}
	public void setHost_license_img(String host_license_img) {
		this.host_license_img = host_license_img;
	}
	public Date getHost_apply_date() {
		return host_apply_date;
	}
	public void setHost_apply_date(Date host_apply_date) {
		this.host_apply_date = host_apply_date;
	}
	public String getHost_approve() {
		return host_approve;
	}
	public void setHost_approve(String host_approve) {
		this.host_approve = host_approve;
	}
	public String getHost_approve_comment() {
		return host_approve_comment;
	}
	public void setHost_approve_comment(String host_approve_comment) {
		this.host_approve_comment = host_approve_comment;
	}
	public Date getHost_approve_date() {
		return host_approve_date;
	}
	public void setHost_approve_date(Date host_approve_date) {
		this.host_approve_date = host_approve_date;
	}
	public int getHost_refuse_count() {
		return host_refuse_count;
	}
	public void setHost_refuse_count(int host_refuse_count) {
		this.host_refuse_count = host_refuse_count;
	}
}
