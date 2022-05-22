package com.teamb.freenext.normal.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamb.freenext.normal.service.NormalService;
import com.teamb.freenext.vo.MemberVo;
import com.teamb.freenext.vo.MyScrapVo;

@RestController
@RequestMapping("/normal/*")
public class RestNormalController {

	@Autowired
	private NormalService normalService;
	
	@RequestMapping("doScrap")
	public HashMap<String,Object>doScrap(MyScrapVo vo, HttpSession session){
						
		HashMap<String,Object> data = new HashMap<String,Object>();
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			  data.put("result","error");
			  data.put("reason", "로그인이 필요합니다");
			  return data;
		}
		
		int memberNo= sessionUser.getMember_no();
		vo.setMember_no(memberNo);
		
		normalService.doScrap(vo);
		data.put("result","success");
		
		return data;
	}
	@RequestMapping("getMyScrapState")
	public HashMap<String,Object>getMyScrapState(MyScrapVo vo, HttpSession session){
		HashMap<String,Object> data = new HashMap<String,Object>();
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			  data.put("result","error");
			  data.put("reason", "로그인이 필요합니다");
			  return data;
		}
		
		vo.setMember_no(sessionUser.getMember_no());
		
		int myScrapCount = normalService.getMyScrapCount(vo);
		
		data.put("result", "success");
		if(myScrapCount>0) {
			data.put("state","scrap");
		}else {
			data.put("state","unscrap");
		}
		return data;
	
	}
	
	@RequestMapping("getTotalScrapState")
	public HashMap<String,Object>getTotalScrapState(int project_no){
		HashMap<String,Object> data = new HashMap<String,Object>();
		
		int totalScrapCount = normalService.getTotalScrapCount(project_no);
		data.put("totalScrapCount",totalScrapCount);
	return data;	
	
	}
}