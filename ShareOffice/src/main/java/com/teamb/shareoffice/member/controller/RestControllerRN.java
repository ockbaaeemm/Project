package com.teamb.shareoffice.member.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamb.shareoffice.member.service.MemberServiceRN;
import com.teamb.shareoffice.vo.MemberVo;

@RestController
@RequestMapping("/member/*")
public class RestControllerRN {
	
	@Autowired
	private MemberServiceRN memberService; 
	
	@Autowired
	
	
	@RequestMapping("getJSKey")
	public HashMap<String, Object> getJSKey() {
		HashMap<String, Object> data = new HashMap<>();

		data.put("jsKey", memberService.getJSKey());
		
		return data;
	}
	
	
	@RequestMapping("updateSession")
	public HashMap<String, Object> updateSession(HttpSession session) {
		HashMap<String, Object> data = new HashMap<>();
		
		session.setAttribute("sessionUser", memberService.getMemberByNo(((MemberVo) session.getAttribute("sessionUser")).getMember_no()));
		
		data.put("result", "success");
		
		return data;
	}	
}
