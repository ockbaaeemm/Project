package com.teamb.freenext.admin.controller;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.teamb.freenext.admin.service.AdminService;
import com.teamb.freenext.member.service.MemberService;
import com.teamb.freenext.vo.AdminVo;
import com.teamb.freenext.vo.MemberCompanyVo;
import com.teamb.freenext.vo.MemberCustomerVo;
import com.teamb.freenext.vo.MemberVo;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;

	@RequestMapping("main")
	public String main() {
		
		System.out.println("관리자 메인페이지가 실행되었습니다.");
		
		return "admin/main";
	}
	
	
	// 관리자 회원가입 페이지는 따로 만들지 않고, INSERT로 관리자 한명 생성하기
	@RequestMapping("joinAdminPage")
	public String joinAdminPage() {
		
		System.out.println("관리자 회원가입페이지가 실행되었습니다.");
		
		return "admin/joinAdminPage";
	}
	
	
	@RequestMapping("loginPage")
	public String adminLoginPage() {
		
		System.out.println("관리자 로그인 페이지가 실행되었습니다.");
		
		return "admin/loginPage";
	}
	
	
	@RequestMapping("adminLoginProcess")
	public String adminLoginProcess(AdminVo param, HttpSession session) {
		
		System.out.println("관리자 로그인 프로세스가 실행되었습니다.");
		System.out.println(param.getAdmin_id());
		System.out.println(param.getAdmin_pw());
		AdminVo adminSessionUser = adminService.adminLogin(param);
		
		if(adminSessionUser != null) {
			
			session.setAttribute("sessionAdmin", adminSessionUser);
			
			System.out.println("관리자로 로그인");
			return "redirect:./main";
			
		}else {
			
			System.out.println("관리자로 로그인 실패");
			return "admin/loginFail";
		}
		
	}
	
	@RequestMapping("logoutProcess")
	public String logoutProcess(HttpSession session) {
		
		session.removeAttribute("sessionAdmin");
		
		return "redirect:./main";
	}
	
	
	@RequestMapping("manageMemberPage")
	public String manageMemberPage(Model model, String searchOption, String searchWord, String searchApproval, 
									String searchMemberType, @RequestParam(value = "pageNum" , defaultValue = "1") int pageNum) {

		System.out.println("회원관리 페이지 실행");
		
		int startNum = (pageNum-1)*10 ;
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchOption", searchOption);
		map.put("searchWord", searchWord);
		map.put("searchApproval", searchApproval);
		map.put("searchMemberType", searchMemberType);
		
		for(String key : map.keySet()) {
			String value = (String) map.get(key);
			if(value != null && value.isEmpty()) {
				map.put(key, null);
			}
		}
		
		map.put("startNum", startNum);
		
		ArrayList<MemberVo> memberList = adminService.getMemberList(map);
		model.addAttribute("memberList", memberList);
		
		int countT = adminService.getTotalMemberNumber(map);
		
		int countN = 0;
		int countC = 0;
		
		if(map.get("searchMemberType") == null) {

			countN = adminService.getToalMemberTypeNumber(map, "N");
			countC = adminService.getToalMemberTypeNumber(map, "B");			
		}
		else if(searchMemberType.equals("N")) {

			countN = countT;
			countC = 0;
		} else if(searchMemberType.equals("B")) {

			countN = 0;
			countC = countT;
		}				

		//int count = adminService.getMemberCount(searchOption, searchWord, searchApproval, searchMemberType);
		int totalPageCount = (int)Math.ceil(countT/10.0);
		
		//페이징 관련
		int startPage = ((pageNum-1)/5)*5 + 1;
		int endPage = ((pageNum-1)/5 + 1)*(5);
		if(endPage > totalPageCount){
			endPage = totalPageCount;
		}
		
		//검색 관련
		String additionalParam = "";
		
		if(map.get("searchOption") != null) {
			additionalParam += "&searchOption=" + searchOption;
		}
		
		if(map.get("searchWord") != null) {
			try {
				searchWord = URLEncoder.encode(searchWord, "utf-8");
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			additionalParam += "&searchWord=" + searchWord;
		}
		
		if(map.get("searchApproval") != null) {
			additionalParam += "&searchApproval=" + searchApproval;
		}

		if(map.get("searchMemberType") != null) {
			additionalParam += "&searchMemberType=" + searchMemberType;
		}	
		
		model.addAttribute("countT", countT);
		model.addAttribute("countN", countN);
		model.addAttribute("countC", countC);
		model.addAttribute("additionalParam", additionalParam);
		//model.addAttribute("count", count);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("searchData", map);
		
		return "admin/manageMemberPage";
	}
	
	
	@RequestMapping("updateMemberPage")
	public String updateMemberPage(int member_no, String searchOption, String searchWord, String searchApproval, 
			String searchMemberType, Model model) {
		
		HashMap<String, Object> map = adminService.getMember(member_no);
		
		String additionalParam = "";
		
		if(searchOption != null) {
			additionalParam += "&searchOption=" + searchOption;
		}
		if(searchWord != null) {
			additionalParam += "&searchWord=" + searchWord;
		}
		if(searchApproval != null) {
			additionalParam += "&searchApproval=" + searchApproval;
		}
		if(searchMemberType != null) {
			additionalParam += "&searchMemberType=" + searchMemberType;
		}		
		
		model.addAttribute("data", map);
		model.addAttribute("additionalParam", additionalParam);
		
		System.out.println("관리자 회원정보 수정페이지 실행");
		
		return "admin/updateMemberPage";
	}
	
	@RequestMapping("updateMemberProcessN")
	public String updateMemberProcessN(int memberNo, MemberVo mvo, MemberCustomerVo cvo, MultipartFile memberProfileImg, Model model,
										HttpServletRequest request) {
		
		String uploadFolder = "C:/freeNext/profileImage/";
		
		if(memberProfileImg != null) {
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
			String folderPath = sdf.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath);
			
			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}
			
			String fileName = "";
			UUID uuid = UUID.randomUUID();
			fileName += uuid.toString();
			
			long currentTime = System.currentTimeMillis();
			fileName += "_" + currentTime;
			
			String originalFileName = memberProfileImg.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			fileName += ext;
			
			System.out.println("original +" + originalFileName);
			
			
			try {
				memberProfileImg.transferTo(new File(uploadFolder + folderPath + fileName));
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			mvo.setMember_profile(folderPath + fileName);
		}
		
		System.out.println("체크1");
		
		if(cvo.getCustomer_agree_email() == null) {
			cvo.setCustomer_agree_email("N");
		}
		
		if(cvo.getCustomer_agree_sns() == null) {
			cvo.setCustomer_agree_sns("N");
		}
		
		
		mvo.setMember_no(memberNo);
		cvo.setMember_no(memberNo);
		//cvo.setCustomer_agree_email(agreeEmail);
		//cvo.setCustomer_agree_sns(agreeSNS);
			
			
		adminService.updateMemberN(mvo, cvo);
		
		
		String[] splitReferer = request.getHeader("referer").split("\\?")[1].split("\\&");
		String additionalParam = "";
		
		for(int i=1;i<splitReferer.length;i++) {
			additionalParam += "&" + splitReferer[i];
		}
		
		return "redirect:./updateMemberPage?" + additionalParam;
	}
	
	@RequestMapping("updateMemberProcessB")
	public String updateMemberProcessB(int memberNo, MemberVo mvo, MemberCompanyVo cvo, MultipartFile licenseImg, Model model,
										HttpServletRequest request) {
		
			String uploadFolder = "C:/freeNext/profileImage/";
		
			if(licenseImg != null){
					
					Date today = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/"); 
					String folderPath = sdf.format(today);
					
					File todayFolder = new File(uploadFolder + folderPath); 
					
					if(!todayFolder.exists()) {
						todayFolder.mkdirs();
					}	
					
					String fileName = "";
					UUID uuid = UUID.randomUUID();
					fileName += uuid.toString();
					
					long currentTime = System.currentTimeMillis();
					fileName += "_" + currentTime;
					
					String originalFileName = licenseImg.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
					fileName += ext;

					try {
						licenseImg.transferTo(new File(uploadFolder + folderPath + fileName));
					}catch(Exception e) {
						e.printStackTrace();
					}

					cvo.setCompany_license_img(folderPath + fileName); 
			}
		
		mvo.setMember_no(memberNo);
		cvo.setMember_no(memberNo);
					
		mvo.setMember_pw(memberService.getPasswordHashCode(mvo.getMember_pw()));
		mvo.setMember_profile(((MemberVo) adminService.getMember(memberNo).get("memberVo")).getMember_profile());		
		
		adminService.updateMemberB(mvo, cvo);
		
		String[] splitReferer = request.getHeader("referer").split("\\?")[1].split("\\&");
		String additionalParam = "";
		
		for(int i=1;i<splitReferer.length;i++) {
			additionalParam += "&" + splitReferer[i];
		}
		
		return "redirect:./updateMemberPage?" + additionalParam;		
	}

}



