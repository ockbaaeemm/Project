package com.teamb.shareoffice.vo;

import java.util.Date;

public class KakaopayVo {
	private int kakaopay_no;
	private int ad_no;
	private String tid;
	private String partner_order_id;
	private int total_amount;	
	private Date kakaopay_date;
	
	public KakaopayVo() {
		super();
	}

	public KakaopayVo(int kakaopay_no, int ad_no, String tid, String partner_order_id,
			int total_amount, Date kakaopay_date) {
		super();
		this.kakaopay_no = kakaopay_no;
		this.ad_no = ad_no;
		this.tid = tid;
		this.partner_order_id = partner_order_id;
		this.total_amount = total_amount;
		this.kakaopay_date = kakaopay_date;
	}

	public int getKakaopay_no() {
		return kakaopay_no;
	}

	public void setKakaopay_no(int kakaopay_no) {
		this.kakaopay_no = kakaopay_no;
	}

	public int getAd_no() {
		return ad_no;
	}

	public void setAd_no(int ad_no) {
		this.ad_no = ad_no;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getPartner_order_id() {
		return partner_order_id;
	}

	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}

	public int getTotal_amount() {
		return total_amount;
	}

	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}

	public Date getKakaopay_date() {
		return kakaopay_date;
	}

	public void setKakaopay_date(Date kakaopay_date) {
		this.kakaopay_date = kakaopay_date;
	}
}
