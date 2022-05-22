package com.teamb.shareoffice.vo;

import java.util.Date;

public class OrderVo {
	
	private int order_no;
	private int office_no;
	private int member_no;
	private int order_personnel;
	private String order_refuse_check;
	private String order_refuse_comment;
	private String order_tid;
	private Date order_date;
	public OrderVo() {
		super();
	}
	public OrderVo(int order_no, int office_no, int member_no, int order_personnel, String order_refuse_check, String order_refuse_comment,
			String order_tid, Date order_date) {
		super();
		this.order_no = order_no;
		this.office_no = office_no;
		this.member_no = member_no;
		this.order_personnel = order_personnel;
		this.order_refuse_check = order_refuse_check;
		this.order_refuse_comment = order_refuse_comment;
		this.order_tid = order_tid;
		this.order_date = order_date;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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
	
	public int getOrder_personnel() {
		return order_personnel;
	}
	
	public void setOrder_personnel(int order_personnel) {
		this.order_personnel = order_personnel;
	}
	
	public String getOrder_refuse_check() {
		return order_refuse_check;
	}
	
	public void setOrder_refuse_check(String order_refuse_check) {
		this.order_refuse_check = order_refuse_check;
	}
	
	public String getOrder_refuse_comment() {
		return order_refuse_comment;
	}
	
	public void setOrder_refuse_comment(String order_refuse_comment) {
		this.order_refuse_comment = order_refuse_comment;
	}
	
	public Date getOrder_date() {
		return order_date;
	}
	
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	
	public String getOrder_tid() {
		return order_tid;
	}
	public void setOrder_tid(String order_tid) {
		this.order_tid = order_tid;
	}
	
}
