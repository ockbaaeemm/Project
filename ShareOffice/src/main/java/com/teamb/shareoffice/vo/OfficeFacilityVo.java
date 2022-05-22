package com.teamb.shareoffice.vo;

public class OfficeFacilityVo {
	
	private int officefacility_no;
	private int office_no;
	private int facility_no;
	public OfficeFacilityVo() {
		super();
	}
	public OfficeFacilityVo(int officefacility_no, int office_no, int facility_no) {
		super();
		this.officefacility_no = officefacility_no;
		this.office_no = office_no;
		this.facility_no = facility_no;
	}
	public int getOfficefacility_no() {
		return officefacility_no;
	}
	public void setOfficefacility_no(int officefacility_no) {
		this.officefacility_no = officefacility_no;
	}
	public int getOffice_no() {
		return office_no;
	}
	public void setOffice_no(int office_no) {
		this.office_no = office_no;
	}
	public int getFacility_no() {
		return facility_no;
	}
	public void setFacility_no(int facility_no) {
		this.facility_no = facility_no;
	}
	
	

}
