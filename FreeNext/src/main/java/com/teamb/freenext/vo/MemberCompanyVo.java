package com.teamb.freenext.vo;

public class MemberCompanyVo {
	private int company_no;
	private int member_no;
	private String company_manager;
	private String company_license_number;
	private String company_license_img;
	private String company_fax;
	
	public MemberCompanyVo() {
		super();
	}

	public MemberCompanyVo(int company_no, int member_no, String company_manager, String company_license_number,
			String company_license_img, String company_fax) {
		super();
		this.company_no = company_no;
		this.member_no = member_no;
		this.company_manager = company_manager;
		this.company_license_number = company_license_number;
		this.company_license_img = company_license_img;
		this.company_fax = company_fax;
	}

	public int getCompany_no() {
		return company_no;
	}

	public void setCompany_no(int company_no) {
		this.company_no = company_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getCompany_manager() {
		return company_manager;
	}

	public void setCompany_manager(String company_manager) {
		this.company_manager = company_manager;
	}

	public String getCompany_license_number() {
		return company_license_number;
	}

	public void setCompany_license_number(String company_license_number) {
		this.company_license_number = company_license_number;
	}

	public String getCompany_license_img() {
		return company_license_img;
	}

	public void setCompany_license_img(String company_license_img) {
		this.company_license_img = company_license_img;
	}

	public String getCompany_fax() {
		return company_fax;
	}

	public void setCompany_fax(String company_fax) {
		this.company_fax = company_fax;
	}
}
