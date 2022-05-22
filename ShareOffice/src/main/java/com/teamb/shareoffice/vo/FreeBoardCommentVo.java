package com.teamb.shareoffice.vo;

import java.util.Date;

public class FreeBoardCommentVo {
	
	private int comment_no;
	private int freeboard_no;
	private int member_no;
	private String comment_content;
	private Date comment_writeDate;
	
	public FreeBoardCommentVo() {
		super();
	}

	public FreeBoardCommentVo(int comment_no, int freeboard_no, int member_no, String comment_content,
			Date comment_writeDate) {
		super();
		this.comment_no = comment_no;
		this.freeboard_no = freeboard_no;
		this.member_no = member_no;
		this.comment_content = comment_content;
		this.comment_writeDate = comment_writeDate;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
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

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Date getComment_writeDate() {
		return comment_writeDate;
	}

	public void setComment_writeDate(Date comment_writeDate) {
		this.comment_writeDate = comment_writeDate;
	}
	 
	
	 
}
