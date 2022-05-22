package com.teamb.shareoffice.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamb.shareoffice.member.mapper.MemberMapperkt;

@Controller
@RequestMapping("/test/*")
public class TestController {

	@Autowired
	private MemberMapperkt mapper;
	
		@RequestMapping("test")
		public String test(Model model) {
			
			model.addAttribute("tt", mapper.test().get("test_name"));
			System.out.println("test page중입니다");
			
			return "test/test";
		}
}
