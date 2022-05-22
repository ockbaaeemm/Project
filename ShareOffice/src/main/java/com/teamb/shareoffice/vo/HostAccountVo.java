package com.teamb.shareoffice.vo;

public class HostAccountVo {
	
	private int account_no;
	private int bank_category_no;
	private int business_no;
	private String account_number;
	private String account_holder;
	public HostAccountVo() {
		super();
	}
	public HostAccountVo(int account_no, int bank_category_no, int business_no, String account_number,
			String account_holder) {
		super();
		this.account_no = account_no;
		this.bank_category_no = bank_category_no;
		this.business_no = business_no;
		this.account_number = account_number;
		this.account_holder = account_holder;
	}
	public int getAccount_no() {
		return account_no;
	}
	public void setAccount_no(int account_no) {
		this.account_no = account_no;
	}
	public int getBank_category_no() {
		return bank_category_no;
	}
	public void setBank_category_no(int bank_category_no) {
		this.bank_category_no = bank_category_no;
	}
	public int getBusiness_no() {
		return business_no;
	}
	public void setBusiness_no(int business_no) {
		this.business_no = business_no;
	}
	public String getAccount_number() {
		return account_number;
	}
	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}
	public String getAccount_holder() {
		return account_holder;
	}
	public void setAccount_holder(String account_holder) {
		this.account_holder = account_holder;
	}
	
	

}
