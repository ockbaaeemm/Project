package com.teamb.shareoffice.vo;

import java.util.Date;

public class AllotCouponVo {

	private int allot_no;
	private int member_no;
	private int coupon_no;
	private Date allot_date;
	private String allot_useOrUnuse;
	
	public AllotCouponVo() {
		super();
	}

	public AllotCouponVo(int allot_no, int member_no, int coupon_no, Date allot_date, String allot_useOrUnuse) {
		super();
		this.allot_no = allot_no;
		this.member_no = member_no;
		this.coupon_no = coupon_no;
		this.allot_date = allot_date;
		this.allot_useOrUnuse = allot_useOrUnuse;
	}

	public int getAllot_no() {
		return allot_no;
	}

	public void setAllot_no(int allot_no) {
		this.allot_no = allot_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getCoupon_no() {
		return coupon_no;
	}

	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}

	public Date getAllot_date() {
		return allot_date;
	}

	public void setAllot_date(Date allot_date) {
		this.allot_date = allot_date;
	}

	public String getAllot_useOrUnuse() {
		return allot_useOrUnuse;
	}

	public void setAllot_useOrUnuse(String allot_useOrUnuse) {
		this.allot_useOrUnuse = allot_useOrUnuse;
	}
	
	
}
