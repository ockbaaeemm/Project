package com.teamb.shareoffice.vo;

public class BankCategoryVo {
	
	private int bank_category_no;
	private String bank_name;
	public BankCategoryVo() {
		super();
	}
	public BankCategoryVo(int bank_category_no, String bank_name) {
		super();
		this.bank_category_no = bank_category_no;
		this.bank_name = bank_name;
	}
	public int getBank_category_no() {
		return bank_category_no;
	}
	public void setBank_category_no(int bank_category_no) {
		this.bank_category_no = bank_category_no;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}

	
}
