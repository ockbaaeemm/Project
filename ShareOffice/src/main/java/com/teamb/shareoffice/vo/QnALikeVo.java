package com.teamb.shareoffice.vo;

import java.util.Date;

public class QnALikeVo {
	private int like_no;
	private int member_no;
	private int qna_no;
	private Date like_date;
	
	public QnALikeVo() {
		super();
	}

	public QnALikeVo(int like_no, int member_no, int qna_no, Date like_date) {
		super();
		this.like_no = like_no;
		this.member_no = member_no;
		this.qna_no = qna_no;
		this.like_date = like_date;
	}

	public int getLike_no() {
		return like_no;
	}

	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public Date getLike_date() {
		return like_date;
	}

	public void setLike_date(Date like_date) {
		this.like_date = like_date;
	}
	
	
	
}
