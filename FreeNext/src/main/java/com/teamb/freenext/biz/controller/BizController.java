package com.teamb.freenext.biz.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamb.freenext.biz.service.BizService;
import com.teamb.freenext.commons.KakaoRestAPI;
import com.teamb.freenext.member.service.MemberService;
import com.teamb.freenext.normal.service.NormalService;
import com.teamb.freenext.vo.KakaopayVo;
import com.teamb.freenext.vo.MemberVo;
import com.teamb.freenext.vo.ProjectBoardVo;

@Controller
@RequestMapping("/biz/*")
public class BizController {
	
	@Autowired
	private BizService bizService;
	
	@Autowired
	private NormalService normalService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("main")
	public String main() {

		return "biz/main";
	}
	
	@RequestMapping("registProjectPage")
	public String  registProjectPage(Model model) {
		
		model.addAttribute("jobCategoryList", bizService.getJobCategoryList());
		model.addAttribute("workTypeCategoryList", bizService.getWorkTypeCateogoryList());
		model.addAttribute("recruitTypeCategoryList", bizService.getRecruitTypeCategoryList());
		model.addAttribute("localCategoryList", memberService.getLocalCategoryList());
		
		return "biz/registProjectPage";
	}
	
	@RequestMapping("registProjectProcess")
	public String registProjectProcess(ProjectBoardVo vo, int[] job_no_list, int[] local_no_list, String subAd, HttpSession session) {
		vo.setMember_no(((MemberVo) session.getAttribute("sessionBizUser")).getMember_no());
		
		int project_no = bizService.registProjectProcess(vo, job_no_list, local_no_list, subAd);		
		
		return "redirect:../biz/projectDetailPage?project_no=" + project_no;
	}
	
	@RequestMapping("projectListPage")
	public String projectListPage(Model model, HttpSession session, String searchOption, String searchKeyword, 
			@RequestParam(value="groupOne", defaultValue = "0") int groupOne, 
			@RequestParam(value="groupTwo", defaultValue = "0") int groupTwo,
			@RequestParam(value="state_cdT", defaultValue = "all") String state_cdT,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum)	
	{		
		
		int member_no = ((MemberVo) session.getAttribute("sessionBizUser")).getMember_no();

		int totalCount = bizService.getProjectListCountByMemberNo(member_no, searchOption, searchKeyword, groupOne, groupTwo, state_cdT);
		int totalPage = (int) Math.ceil(totalCount / 10.0);
				
		int startNum = (pageNum-1) * 10;
		
		int startPage = ((pageNum-1)/10)*10 + 1;
		int endPage = ((pageNum-1)/10 + 1) * (10);
		
		if(totalCount == 0) {
			endPage = startPage;
		} else if(endPage > totalPage) {
			endPage = totalPage;
		}			
		
		String additionalParam = "";
		
		if(searchOption != null) {
			additionalParam += "&searchOption=" + searchOption;
		}		
		if(searchKeyword != null) {
			additionalParam += "&searchKeyword=" + searchKeyword;
		}
		if(groupOne != 0) {
			additionalParam += "&groupOne=" + groupOne;
		}
		if(groupTwo != 0) {
			additionalParam += "&groupTwo=" + groupTwo;
		}
		if(state_cdT != null) {
			additionalParam += "&state_cdT=" + state_cdT;
		}
		
		model.addAttribute("projectList", bizService.getProjectListByMemberNo(
				member_no, searchOption, searchKeyword, groupOne, groupTwo, state_cdT, startNum));
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("additionalParam", additionalParam);
		
		model.addAttribute("jobCategoryList", bizService.getJobCategoryList());
		
		HashMap<String, Object> searchData = new HashMap<>();
		searchData.put("searchOption", searchOption);
		searchData.put("searchKeyword", searchKeyword);
		searchData.put("groupOne", groupOne);
		searchData.put("groupTwo", groupTwo);
		searchData.put("state_cdT", state_cdT);		
		
		model.addAttribute("searchData", searchData);
		
		return "biz/projectListPage";
	}
	
	@RequestMapping("projectDetailPage")
	public String projectDetailPage(int project_no, Model model) 
	{		
		model.addAttribute("data", normalService.getProjectDetailPage(project_no, true));
		model.addAttribute("adVo", bizService.getProjectAd(project_no));

		return "biz/projectDetailPage";
	}
	
	@RequestMapping("modifyProjectPage")
	public String modifyProjectPage(int project_no, Model model)
	{
		model.addAttribute("data", normalService.getProjectDetailPage(project_no, false));
		model.addAttribute("jobCategoryList", bizService.getJobCategoryList());
		model.addAttribute("workTypeCategoryList", bizService.getWorkTypeCateogoryList());
		model.addAttribute("recruitTypeCategoryList", bizService.getRecruitTypeCategoryList());
		model.addAttribute("localCategoryList", memberService.getLocalCategoryList());
		model.addAttribute("adVo", bizService.getProjectAd(project_no));
		
		return "biz/modifyProjectPage";
	}
	
	@RequestMapping("modifyProjectProcess")
	public String modifyProjectProcess(ProjectBoardVo vo, int[] job_no_list, int[] local_no_list, String subAd, String doJob) {
		
		bizService.modifyProjectProcess(vo, job_no_list, local_no_list, subAd, doJob);
		
		return "redirect:../biz/projectDetailPage?project_no=" + vo.getProject_no();
	}
	
	@RequestMapping("deleteProject")
	public String deleteProject(int project_no)
	{
		bizService.deleteBoard(project_no);
		
		return "redirect:../biz/projectListPage";
	}
	
	@RequestMapping("kakaoPayApproval")
	public String kakaoPayApproval(String pg_token, HttpSession session, Model model) {
		String kakaoKey = bizService.getKakaoKey();
		
//		session.removeAttribute("response_code");
//		session.removeAttribute("tid");
	
		KakaopayVo vo = (KakaopayVo) session.getAttribute("kakaopayVo");
		
		KakaoRestAPI kakao = new KakaoRestAPI();
		Map<String, Object> result = kakao.payApprove(pg_token, vo, session, kakaoKey);	
		
		model.addAttribute("response_code", result.get("response_code"));
		session.removeAttribute("kakaopayVo");
		return "biz/payDone";
	}
	
	@RequestMapping("kakaoPayCancel")
	public String kakaoPayCancel(HttpSession session) {
		session.removeAttribute("kakaopayVo");
		
		return "biz/payCancel";
	}
	
	@RequestMapping("kakaoPayFail")
	public String kakaoPayFail(HttpSession session) {
		session.removeAttribute("kakaopayVo");
		
		return "biz/payFail";
	}
}
