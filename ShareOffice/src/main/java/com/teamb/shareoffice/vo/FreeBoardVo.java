package com.teamb.shareoffice.vo;

import java.util.Date;

public class FreeBoardVo {
	
	private int freeboard_no;
	private int member_no;
	private String freeboard_title;
	private String freeboard_content;
	private int freeboard_readCount;
	private Date freeboard_writeDate;
	
	public FreeBoardVo() {
		super();
	}

	public FreeBoardVo(int freeboard_no, int member_no, String freeboard_title, String freeboard_content, int freeboard_readCount,
			Date freeboard_writeDate) {
		super();
		this.freeboard_no = freeboard_no;
		this.freeboard_title = freeboard_title;
		this.freeboard_content = freeboard_content;
		this.freeboard_readCount = freeboard_readCount;
		this.freeboard_writeDate = freeboard_writeDate;
	}

	public int getFreeboard_no() {
		return freeboard_no;
	}

	public void setFreeboard_no(int freeboard_no) {
		this.freeboard_no = freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getFreeboard_title() {
		return freeboard_title;
	}

	public void setFreeboard_title(String freeboard_title) {
		this.freeboard_title = freeboard_title;
	}

	public String getFreeboard_content() {
		return freeboard_content;
	}

	public void setFreeboard_content(String freeboard_content) {
		this.freeboard_content = freeboard_content;
	}

	public int getFreeboard_readCount() {
		return freeboard_readCount;
	}

	public void setFreeboard_readCount(int freeboard_readCount) {
		this.freeboard_readCount = freeboard_readCount;
	}

	public Date getFreeboard_writeDate() {
		return freeboard_writeDate;
	}

	public void setFreeboard_writeDate(Date freeboard_writeDate) {
		this.freeboard_writeDate = freeboard_writeDate;
	}
	
	
	
	
}	
