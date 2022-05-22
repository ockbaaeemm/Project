package com.teamb.freenext.member.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.teamb.freenext.member.service.MemberService;
import com.teamb.freenext.vo.JobCategoryVo;
import com.teamb.freenext.vo.LocalCategoryVo;
import com.teamb.freenext.vo.MemberCompanyVo;
import com.teamb.freenext.vo.MemberCustomerVo;
import com.teamb.freenext.vo.MemberVo;

@Controller
//@ComponentScan(basePackages = {"com.teamb.freenext.corpMember.controller"})
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("loginPage")
	public String loginPage() {
		
		return "member/loginPage";
	}
	
	@RequestMapping("findIdPage")
	public String findIdPage() {
		
		
		return "member/findIdPage";
	}
	
	@RequestMapping("findPwPage")
	public String findPwPage(MemberVo mvo, Model model) {
		
		model.addAttribute("mvo", mvo);
		
		return "member/findPwPage";
	}
	
	@RequestMapping("findIdResultPage")
	public String findIdResultPage(MemberVo mvo, Model model) {
		
		MemberVo idInfo = memberService.findId(mvo);
		if(idInfo == null || !idInfo.getMember_type().equals("N")) {
			return "member/failFindId";
		}
		
		int countId = memberService.getCountFindId(mvo);
		
		model.addAttribute("countId", countId);
		model.addAttribute("idInfo", idInfo);
		
		if(countId == 0) {
			return "member/failFindId";
		} else {
			return "member/findIdResultPage";
		}
		
		
	}
	
	@RequestMapping("findPwResultPage")
	public String findPwResultPage(MemberVo mvo, Model model) {
		
		MemberVo vo = memberService.findPw(mvo);
		
		
		
		if(vo == null || !vo.getMember_type().equals("N")) {
			
			return "member/failFindPw";
			
		} else {
			
			MemberVo getEmail = memberService.findId(mvo);
			String member_email = getEmail.getMember_email();
			
			//임시Pw 생성
			String temporaryPw = UUID.randomUUID().toString().replaceAll("-", "");
			temporaryPw = temporaryPw.substring(0, 12);
			System.out.println(temporaryPw);
			
			//임시Pw 셋팅
			mvo.setMember_pw(temporaryPw);
			mvo.setMember_email(member_email);
			
			//기존Pw 에서 임시Pw로 변경
			memberService.changeToTemporaryPw(mvo);
			//임시Pw 메일발송
			memberService.temporaryPwSendMail(mvo);
			
			MemberVo memberVo = memberService.getMemberInfo(mvo);
			model.addAttribute("memberVo", memberVo);
			
			return "member/findPwResultPage";
		}
		
		
	}
	
	
	@RequestMapping("memberDuplicationCheckPage")
	public String memberDuplicationCheckPage() {
		
		return "member/memberDuplicationCheckPage";
	}
	
	@RequestMapping("duplicationCheckProcess")
	public String duplicationCheckProcess(MemberVo mvo) {
		
		int duplicationCount = memberService.isExistMember(mvo);
		
		if(duplicationCount == 0) {
			return "redirect:./joinMemberPage";
		} else {
			return "member/memberExist";
		}
		
	}	
	
	@RequestMapping("loginProcess")
	public String loginProcess(MemberVo vo, HttpSession session, Model model, HttpServletRequest request) {
		
		String referer = (request.getHeader("referer")!=null ? request.getHeader("referer").split("/")[4] : request.getRequestURI().split("/")[2]);

		MemberVo memberVo = null;
		if(referer.equals("loginPage")) {
			memberVo = memberService.login(vo, false);
		} else {
			memberVo = memberService.login(vo, true);
		}
		
		if(memberVo != null) {
			if(memberVo.getMember_type().equals("N") && referer.equals("loginPage")) {
				if(memberService.mailAuthCheck(memberVo.getMember_no()) == 0) {
					return "member/mailAuthCheck";
				}
				session.setAttribute("sessionUser", memberVo);
				
				return "redirect:../normal/main";
			} else if(memberVo.getMember_type().equals("B") && !referer.equals("loginPage")){
				session.setAttribute("sessionBizUser", memberVo);
				
				return "redirect:../biz/main";
			}
		}		
		
		if(!referer.equals("loginPage")) {
			model.addAttribute("referer", "biz");
		} else {
			model.addAttribute("referer", "normal");
		}
		return "member/loginFail";
		
	}	
	
	@RequestMapping("mailAuthProcess")
	public String mailAuthProcess(String authKey) {
		
		memberService.authMail(authKey);
		
		return "member/mailAuthComplete";
		
	}	
	
	@RequestMapping("logoutProcess")
	public String logoutProcess(HttpServletRequest request, HttpSession session) {
		String referer = (request.getHeader("referer")!=null ? request.getHeader("referer") : request.getRequestURI());
		
		if(referer.split("/")[3].equals("normal")) {
			session.removeAttribute("sessionUser");
			
			return "redirect:../normal/main";
		} else if(referer.split("/")[3].equals("biz")) {
			session.removeAttribute("sessionBizUser");
			
			return "redirect:../biz/main";
		}
		
		session.invalidate();
		
		return "redirect:../normal/main";
	}
	
	@RequestMapping("joinMemberPage")
	public String joinMemberPage(Model model) {
		
		ArrayList<JobCategoryVo> jobList = memberService.getJobCategoryList();
		ArrayList<LocalCategoryVo> localList = memberService.getLocalCategoryList();
		
		model.addAttribute("jobList", jobList);
		model.addAttribute("localList", localList);
		
		return "member/joinMemberPage";
	}
	
	@RequestMapping("joinMemberProcess")
	public String joinMemberProcess(MemberVo mvo, MemberCustomerVo mcvo, 
									int [] job_no, int [] local_no, MultipartFile uploadFileThumbnail) {
		
		String uploadFolder = "C:/freeNext/profileImage/";
		
		if(uploadFileThumbnail != null) {
			
			//날짜별 폴더 생성 2022/01/19/
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
			String folderPath = sdf.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath);
			
			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}
			
			// 중복되지않게 저장
			String fileName = "";
			UUID uuid = UUID.randomUUID();
			fileName += uuid.toString();
			
			long currentTime = System.currentTimeMillis();
			fileName += "_" + currentTime;
			
			//확장자 추가
			String originalFileName = uploadFileThumbnail.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			fileName += ext;
			
			try {
				uploadFileThumbnail.transferTo(new File(uploadFolder + folderPath + fileName));
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			mvo.setMember_profile(folderPath + fileName);
		}
		
		if(mcvo.getCustomer_agree_email() == null) {
			mcvo.setCustomer_agree_email("N");
		}
		
		if(mcvo.getCustomer_agree_sns() == null) {
			mcvo.setCustomer_agree_sns("N");
		}		
		
		memberService.joinMember(mvo, mcvo, job_no, local_no);
		
		
		return "member/joinMemberComplete";
	}


	
	@RequestMapping("bizLoginPage")
	public String bizLoginPage() {
		
		return "member/bizLoginPage";
	}
	
	@RequestMapping("bizSignUpPage")
	public String bizSignUpPage() {
		
		return "member/bizSignUpPage";
	}
	
	@RequestMapping("bizSignUpProcess")
	public String bizSignUpProcess(MemberVo param1, MemberCompanyVo param2,
			Model model, MultipartFile license_img, MultipartFile profile) {
		
		
		
		String uploadFolder = "C:/freenext/profileImage/"; 

		if(!license_img.isEmpty() && !profile.isEmpty()) {
			
			//날짜별 폴더 생성... 2022/01/19/
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/"); 
			String folderPath = sdf.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath); 
			
			String imgName = "";
			String logoName = "";
			
			if(!todayFolder.exists()) {
				
				todayFolder.mkdirs();
			}
			
			long currentTime = System.currentTimeMillis();
//				파일 원래이름
//			String oriImgName = param2.getCompany_license_img();
//			String oriLogoName = param1.getMember_profile();
			
			String oriImgName = license_img.getOriginalFilename();
			String oriLogoName = profile.getOriginalFilename();
	
			// random uuid + 현재시간 + 확장자
			UUID uuid = UUID.randomUUID();
			imgName += (uuid.toString() + currentTime + oriImgName.substring(oriImgName.lastIndexOf(".")));
			uuid = UUID.randomUUID();
			logoName += (uuid.toString() + currentTime + oriLogoName.substring(oriLogoName.lastIndexOf(".")));
			
			try {
				license_img.transferTo(new File(uploadFolder + folderPath + imgName));
				profile.transferTo(new File(uploadFolder + folderPath + logoName));
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			
			param2.setCompany_license_img(folderPath + imgName);
			param1.setMember_profile(folderPath + logoName);
		}

		memberService.insertMember(param1);
		memberService.insertBizMember(param2);
		model.addAttribute("MemberVo", param1);
		model.addAttribute("MemberCompanyVo", param2);
		return "member/bizSignUpCompletePage";
	}
	
	@RequestMapping("bizSearchIdPage")
	public String bizSearchIdPage() {
		
		return "member/bizSearchIdPage";
	}
	@RequestMapping("bizCheckIdFailPage")
	public String bizCheckIdFailPage() {
		
		return "member/bizCheckIdFailPage";
	}
	
	@RequestMapping("bizSearchIdProcess")
	public String bizSearchIdProcess(MemberVo param, Model model) {
		MemberVo memberVo = memberService.getBizIdCheck(param);
		
		if(memberVo != null) {
			model.addAttribute("MemberVo", memberVo);
			return "member/bizCheckedIdPage";
		}else {
			return "member/bizCheckIdFailPage";
		}
	}
	
	@RequestMapping("bizSearchPwPage")
	public String bizSearchPwPage() {
		
		return "member/bizSearchPwPage";
	}
	
	
	@RequestMapping("bizSearchPwProcess")
	public String bizSearchPwProcess(MemberVo param, Model model) {
		 
		MemberVo memberVo = memberService.getBizPwCheck(param);
		//기존 비밀번호를 newPw 저장
		
		if(memberVo != null) {
		
		//회원정보를 메일센더에 보내서 임시비번으로 바꾸고 메일 전송
		memberService.sendMail(memberVo);
			model.addAttribute("MemberVo", memberVo);
			return "member/bizCheckedPwPage";
		}else {
			return "member/bizCheckPwFailPage";
		}
		
	}
	
	@RequestMapping("bizCheckPwFailPage")
	public String bizCheckPwFailPage() {
		
		return "member/bizCheckPwFailPage";
	}
}
