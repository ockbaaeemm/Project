package com.teamb.shareoffice.vo;

import java.util.Date;

public class OfficeInfoVo {
	
	private int office_no;
	private int member_no;
	private String office_name;
	private String office_simpleContent;
	private String office_detailContent;
	private int office_personnel;
	private String office_tags;
	private String office_address;
	private String office_address_detail;
	private String office_managerPhone;
	private String office_changedPhone;
	private String office_thumbnail;
	private int office_min_booking_day;
	private String office_approve;
	private String office_approve_comment;
	private Date office_approve_date;
	
	public OfficeInfoVo() {
		super();
	}
	public OfficeInfoVo(int office_no, int member_no, String office_name, String office_simpleContent, String office_detailContent,
			int office_personnel, String office_tags, String office_address, String office_address_detail,
			String office_managerPhone, String office_changedPhone, String office_thumbnail, int office_min_booking_day,
			String office_approve, String office_approve_comment, Date office_approve_date) {
		super();
		this.office_no = office_no;
		this.member_no = member_no;
		this.office_name = office_name;
		this.office_simpleContent = office_simpleContent;
		this.office_detailContent = office_detailContent;
		this.office_personnel = office_personnel;
		this.office_tags = office_tags;
		this.office_address = office_address;
		this.office_address_detail = office_address_detail;
		this.office_managerPhone = office_managerPhone;
		this.office_changedPhone = office_changedPhone;
		this.office_thumbnail = office_thumbnail;
		this.office_min_booking_day = office_min_booking_day;
		this.office_approve = office_approve;
		this.office_approve_comment = office_approve_comment;
		this.office_approve_date = office_approve_date;
	}
	
	
	public int getOffice_no() {
		return office_no;
	}
	public void setOffice_no(int office_no) {
		this.office_no = office_no;
	}
	
	public int getMember_no() {
		return member_no;
	}
	
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getOffice_name() {
		return office_name;
	}
	public void setOffice_name(String office_name) {
		this.office_name = office_name;
	}
	public String getOffice_simpleContent() {
		return office_simpleContent;
	}
	public void setOffice_simpleContent(String office_simpleContent) {
		this.office_simpleContent = office_simpleContent;
	}
	public String getOffice_detailContent() {
		return office_detailContent;
	}
	public void setOffice_detailContent(String office_detailContent) {
		this.office_detailContent = office_detailContent;
	}
	public int getOffice_personnel() {
		return office_personnel;
	}
	public void setOffice_personnel(int office_personnel) {
		this.office_personnel = office_personnel;
	}
	public String getOffice_tags() {
		return office_tags;
	}
	public void setOffice_tags(String office_tags) {
		this.office_tags = office_tags;
	}
	public String getOffice_address() {
		return office_address;
	}
	public void setOffice_address(String office_address) {
		this.office_address = office_address;
	}
	public String getOffice_address_detail() {
		return office_address_detail;
	}
	public void setOffice_address_detail(String office_address_detail) {
		this.office_address_detail = office_address_detail;
	}
	public String getOffice_managerPhone() {
		return office_managerPhone;
	}
	public void setOffice_managerPhone(String office_managerPhone) {
		this.office_managerPhone = office_managerPhone;
	}
	public String getOffice_changedPhone() {
		return office_changedPhone;
	}
	public void setOffice_changedPhone(String office_changedPhone) {
		this.office_changedPhone = office_changedPhone;
	}
	public String getOffice_thumbnail() {
		return office_thumbnail;
	}
	public void setOffice_thumbnail(String office_thumbnail) {
		this.office_thumbnail = office_thumbnail;
	}
	public int getOffice_min_booking_day() {
		return office_min_booking_day;
	}
	public void setOffice_min_booking_day(int office_min_booking_day) {
		this.office_min_booking_day = office_min_booking_day;
	}
	public String getOffice_approve() {
		return office_approve;
	}
	public void setOffice_approve(String office_approve) {
		this.office_approve = office_approve;
	}
	public String getOffice_approve_comment() {
		return office_approve_comment;
	}
	public void setOffice_approve_comment(String office_approve_comment) {
		this.office_approve_comment = office_approve_comment;
	}
	public Date getOffice_approve_date() {
		return office_approve_date;
	}
	public void setOffice_approve_date(Date office_approve_date) {
		this.office_approve_date = office_approve_date;
	}
	



}