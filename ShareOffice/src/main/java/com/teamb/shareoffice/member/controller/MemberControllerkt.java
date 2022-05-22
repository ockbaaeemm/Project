package com.teamb.shareoffice.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class MemberControllerkt {
	
	@RequestMapping("test")
	public String test(String name) {
		
		
		return "../board/test";
	}
	
}
