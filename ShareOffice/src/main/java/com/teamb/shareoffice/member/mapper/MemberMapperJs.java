package com.teamb.shareoffice.member.mapper;

import java.util.ArrayList;

import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.MessageVo;

public interface MemberMapperJs {

	public ArrayList<MessageVo> getMessageList(int no); // 받은 쪽지함
	
	public ArrayList<MessageVo> getSendMessageList(int no); // 보낸 쪽지함
	
	public MemberVo getMemberByNo(int no); 
	
	public void insertMessage(MessageVo vo);
	
	public MessageVo getSenderNo(int no);
	
	public MemberVo getMemberByNick(String nick);
	
	public void updateDate(int no);
	
	public int newMessageCount(int no);
	
	public void deleteReceiveMessage(MessageVo vo);
	
	public void deleteSendMessage(MessageVo vo);
}
