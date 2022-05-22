package com.teamb.shareoffice.vo;

import java.util.Date;

public class MessageVo {

	private int message_no;
	private int sender_no;
	private int receive_no;
	private String txt;
	private Date read_date;
	public MessageVo() {
		super();
	}
	public MessageVo(int message_no, int sender_no, int receive_no, String txt, Date read_date) {
		super();
		this.message_no = message_no;
		this.sender_no = sender_no;
		this.receive_no = receive_no;
		this.txt = txt;
		this.read_date = read_date;
	}
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public int getSender_no() {
		return sender_no;
	}
	public void setSender_no(int sender_no) {
		this.sender_no = sender_no;
	}
	public int getReceive_no() {
		return receive_no;
	}
	public void setReceive_no(int receive_no) {
		this.receive_no = receive_no;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}
	public Date getRead_date() {
		return read_date;
	}
	public void setRead_date(Date read_date) {
		this.read_date = read_date;
	}
	
}
