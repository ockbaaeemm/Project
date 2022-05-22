package com.teamb.shareoffice.vo;

import java.util.Date;

public class QnAVo {
	private int qna_no;
	private int member_no;
	private String qna_title;
	private String qna_content;
	private String qna_screct;
	private Date qna_writeDate;
	
	public QnAVo() {
		super();
	}

	public QnAVo(int qna_no, int member_no, String qna_title, String qna_content, String qna_screct,
			Date qna_writeDate) {
		super();
		this.qna_no = qna_no;
		this.member_no = member_no;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
		this.qna_screct = qna_screct;
		this.qna_writeDate = qna_writeDate;
	}

	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getqna_screct() {
		return qna_screct;
	}

	public void setqna_screct(String qna_screct) {
		this.qna_screct = qna_screct;
	}

	public Date getQna_writeDate() {
		return qna_writeDate;
	}

	public void setQna_writeDate(Date qna_writeDate) {
		this.qna_writeDate = qna_writeDate;
	}
	
	
	
}
