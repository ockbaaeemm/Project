package com.teamb.freenext.member.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamb.freenext.member.service.MemberService;

@RestController
@RequestMapping("/member/*")
public class RestMemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("isExistId")
	public HashMap<String, Object> isExistId(String member_id) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		boolean result = memberService.isExistId(member_id);
		
		data.put("result", result);
		
		return data;
		
	}

}
