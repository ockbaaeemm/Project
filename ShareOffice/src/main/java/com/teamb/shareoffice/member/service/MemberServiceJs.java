package com.teamb.shareoffice.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.member.mapper.MemberMapperJs;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.MessageVo;

@Service
public class MemberServiceJs {
	
	@Autowired
	private MemberMapperJs memberMapperJs;
	
	//보낸쪽지함
	public ArrayList<HashMap<String, Object>> getMessageList(int no) { 
		
		ArrayList<HashMap<String, Object>> datalist = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MessageVo> messageVoList = memberMapperJs.getMessageList(no);
		
		for(MessageVo messageVo : messageVoList) {
			
			int memberNo = messageVo.getSender_no();
			
			MemberVo memberVo = null; 
					
			if(memberNo == 0) {
				memberVo = new MemberVo();
				memberVo.setMember_nick("Share Office");
			}else {
				memberVo = memberMapperJs.getMemberByNo(memberNo);
			}
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("memberVo", memberVo);
			map.put("messageVo", messageVo);
			
			datalist.add(map);
		}
		
		memberMapperJs.updateDate(no);
		
		
		return datalist;
	}
	
	//받은쪽지함
	public ArrayList<HashMap<String, Object>> getSendMessageList(int no) {
		
		ArrayList<HashMap<String, Object>> datalist = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MessageVo> messageVoList = memberMapperJs.getSendMessageList(no);
		
		for(MessageVo messageVo : messageVoList) {
			
			int memberNo = messageVo.getReceive_no();
			
			MemberVo memberVo = memberMapperJs.getMemberByNo(memberNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("memberVo", memberVo);
			map.put("messageVo", messageVo);
			
			datalist.add(map);
		}
		
		return datalist;
	}
	
	// 공용 코드
	public void writeMessage(MessageVo vo) {
		
/*		
		@Autowired
		private MemberMapperJs memberMapperJs;

		MessageVo ttt = new MessageVo();
		ttt.setSender_no(0);
		ttt.setReceive_no(6); //여긴 세팅...
		ttt.setTxt("신청하신 오피스가 승인/거절 되었습니다.");
		
		memberMapperJs.insertMessage(vo);
*/		
		
		memberMapperJs.insertMessage(vo);
	}
	
	public HashMap<String, Object> getSender(int sender_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MessageVo messageVo = memberMapperJs.getSenderNo(sender_no);
		int memberNo = messageVo.getSender_no();
		MemberVo memberVo = memberMapperJs.getMemberByNo(memberNo);
		
		map.put("memberVo", memberVo);
		map.put("messageVo", messageVo);
		
		return map;
		
	}
	
	public MemberVo getMemberNick(String nick) {
		
		MemberVo result = memberMapperJs.getMemberByNick(nick);
		
		return result;
	}
	// 새로 온 쪽지 확인
	public void updateDate(int no) {
		
		memberMapperJs.updateDate(no);
	}
	// 새로 온 쪽지 갯수
	public int newMessageCount(int no) {
		
		memberMapperJs.newMessageCount(no);
		
		return memberMapperJs.newMessageCount(no);
	}
	
	public void deleteReceiveMessage(MessageVo vo) {
		
		memberMapperJs.deleteReceiveMessage(vo);
	}
	
	public void deleteSendMessage(MessageVo vo) {
		
		memberMapperJs.deleteSendMessage(vo);
	}
}
