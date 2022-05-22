package com.teamb.shareoffice.vo;

import java.util.Date;

public class QnAAnswerVo {
	
	private int answer_no;
	private int admin_no;
	private int qna_no;
	private int member_no;
	private String answer_content;
	private Date answer_writeDate;
	
	public QnAAnswerVo() {
		super();
	}

	public QnAAnswerVo(int answer_no, int admin_no, int qna_no, int member_no, String answer_content,
			Date answer_writeDate) {
		super();
		this.answer_no = answer_no;
		this.admin_no = admin_no;
		this.qna_no = qna_no;
		this.member_no = member_no;
		this.answer_content = answer_content;
		this.answer_writeDate = answer_writeDate;
	}

	public int getAnswer_no() {
		return answer_no;
	}

	public void setAnswer_no(int answer_no) {
		this.answer_no = answer_no;
	}

	public int getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(int admin_no) {
		this.admin_no = admin_no;
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

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public Date getAnswer_writeDate() {
		return answer_writeDate;
	}

	public void setAnswer_writeDate(Date answer_writeDate) {
		this.answer_writeDate = answer_writeDate;
	}
	
	
	
}
