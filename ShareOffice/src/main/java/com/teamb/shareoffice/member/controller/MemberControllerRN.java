package com.teamb.shareoffice.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamb.shareoffice.commons.KakaoRestAPI;
import com.teamb.shareoffice.guest.service.GuestService_H;
import com.teamb.shareoffice.member.service.MemberServiceRN;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.MemberVo;

@Controller
@RequestMapping("/member/*")
public class MemberControllerRN {
	
	@Autowired
	private MemberServiceRN memberService;
	
	@RequestMapping("loginPage")
	public String loginPage() {
		
		return "member/loginPage";
	}
	
	@RequestMapping("loginGetCode")
	public String loginGetCode(String code, Model model) {		

		KakaoRestAPI kakao = new KakaoRestAPI();		
					
		Map<String, Object> result = kakao.loginGetToken(code, memberService.getKakaoKey());
		
		model.addAttribute("access_token", result.get("access_token"));
		model.addAttribute("expires_in", result.get("expires_in"));
		model.addAttribute("refresh_token", result.get("refresh_token"));
		model.addAttribute("jsKey", memberService.getJSKey());

		return "member/getKakaoUserInfo";
	}
	
	@RequestMapping("checkJoin")
	public String checkJoin(String member_id, String member_email, String member_nick,
			HttpSession session, Model model) {
		MemberVo vo = memberService.isExist(member_id);
		
		if(vo != null) {
			session.setAttribute("sessionUser", vo);
			if(vo.getMember_type().equals("G")) {
				for(HostVo hostVo : memberService.getHostVoList(vo.getMember_no())) {
					if(hostVo.getHost_approve().equals("P")) {
						session.setAttribute("applyHost", "Y");
					}
				}
				
			}
			return "redirect:/";		
			
		} else {
			model.addAttribute("member_id", member_id);
			model.addAttribute("member_email", member_email);
			model.addAttribute("member_nick", member_nick);
			
			return "member/joinMemberPage";

		}
	}
	
	@RequestMapping("joinMemberProcess")
	public String joinMemberProcess(MemberVo memberVo) {				

		memberService.joinMember(memberVo);
				
		return "member/joinMemberComplete";
	}
	
	@RequestMapping("unlinkKakao")
	public String unlinkKakao(Model model) {
		
		model.addAttribute("jsKey", memberService.getJSKey());
		
		return "member/unlinkKakao";
	}	

}