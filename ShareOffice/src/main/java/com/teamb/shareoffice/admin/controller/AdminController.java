package com.teamb.shareoffice.admin.controller;

import java.awt.Component;
import java.io.File;
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

import com.teamb.shareoffice.admin.service.AdminService;
import com.teamb.shareoffice.board.service.BoardServicekt;
import com.teamb.shareoffice.member.service.MemberServiceJs;
import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.CouponVo;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.MessageVo;

@Controller
@RequestMapping("/admin/*")
public class AdminController 
{
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BoardServicekt boardServicekt;
	
	@RequestMapping("loginAdmin")
	public String loginAdmin()
	{
		
		return "admin/loginAdmin";
	}
	
	@RequestMapping("logoutAdmin")
	public String logoutProcess(HttpSession session) {
		
		session.removeAttribute("adminUser");
		
		return "redirect:../admin/loginAdmin";
	}	
	
	
	@RequestMapping("adminLoginProcess")
	public String adminLoginProcess(AdminVo param, HttpSession session)
	{	
		AdminVo adminUser = adminService.loginAdmin(param);
		
		if(adminUser != null)
		{
			session.setAttribute("adminUser", adminUser);
			
			return "redirect:../admin/guestManagement";
		}
		else
		{
			return "redirect:../admin/loginAdmin";
		}
			
	}
	
	@RequestMapping("adminPage")
	public String adminPage(HttpSession session)
	{	
		AdminVo adminUser = (AdminVo) session.getAttribute("adminUser");

		if(adminUser != null)
		{
			session.setAttribute("adminUser", adminUser);

			return "redirect:../admin/guestManagement";
		}					

		return "redirect:../admin/loginAdmin";
	}
	
	@RequestMapping("guestManagement")
	public String guestManagement(Model model, String searchOption, String searchStr, @RequestParam(value="pageNum", defaultValue="1") int pageNum)
	{		
		ArrayList<HashMap<String, Object>> guestList = adminService.guestManagement(searchOption, searchStr, pageNum);
		
		model.addAttribute("guestList", guestList);
		
		return "admin/guestManagement";
	}
	
	@RequestMapping("deleteGuest")
	public String deleteGuest(int member_no)
	{
		adminService.deleteGuest(member_no);
		
		return "redirect:../admin/guestManagement";
	}
	
	@RequestMapping("hostManagement")
	public String hostManagement(Model model, String searchOption, String searchStr, @RequestParam(value="pageNum", defaultValue="1") int pageNum)
	{	
		ArrayList<HashMap<String, Object>> hostList = adminService.hostManagement(searchOption, searchStr, pageNum);
		
		model.addAttribute("hostList", hostList);
		
		return "admin/hostManagement";
	}
	
	@RequestMapping("hostApplyGuest")
	public String hostApplyGuest(int member_no, int host_no, HttpSession session)
	{
		MemberVo memberVo = adminService.hostApplyGuest(member_no, host_no);
		String msg = "호스트 신청이 승인되었습니다.";
		adminService.noticeMessage(msg, member_no);
		session.setAttribute("sessionUser", memberVo);
		
		return "redirect:../admin/hostManagement";
	}
	
	@RequestMapping("hostRefuseGuest")
	public String hostRefuseGuest(String host_no, String refuseReason, String member_no, HttpSession session)
	{	
		MemberVo memberVo = adminService.hostRefuseGuest(host_no, refuseReason, member_no);
	
		String msg = "호스트 권한이 거절/해제 되었습니다. \n사유 : " + refuseReason;
		
		adminService.noticeMessage(msg, Integer.parseInt(member_no));
		
		session.setAttribute("sessionUser", memberVo);
	
		return "redirect:../admin/deleteOfficeByHostRefuse?member_no=" + member_no;
	}
	
	@RequestMapping("deleteOfficeByHostRefuse")
	public String deleteOfficeByHostRefuse(int member_no, String msg)
	{
		adminService.deleteOfficeByHostRefuse(member_no);
		
		return "redirect:../admin/hostManagement";
	}
	
	@RequestMapping("officeManagement")
	public String officeManagement(Model model, String searchOption, String searchStr, @RequestParam(value="pageNum", defaultValue="1") int pageNum)
	{		
		ArrayList<HashMap<String, Object>> officeList = adminService.getOfficeInformation(searchOption, searchStr, pageNum);
		
		model.addAttribute("officeList", officeList);
		
		return "admin/officeManagement";
	}

	@RequestMapping("officeApply")
	public String officeApply(int office_no, int member_no)
	{
		adminService.officeApply(office_no, member_no);
		
		String msg = "오피스 신청이 승인되었습니다.";
		adminService.noticeMessage(msg, member_no);
		
		return "redirect:../admin/officeManagement";
	}
	
	@RequestMapping("officeRefuse")
	public String officeRefuse(String office_no, String refuseReason, int member_no)
	{	
		adminService.officeRefuse(office_no, refuseReason, member_no);
		
		String msg = "오피스 신청이 거절되었습니다. \n사유 : " + refuseReason;
		adminService.noticeMessage(msg, member_no);
		
		return "redirect:../admin/officeManagement";
	}
	
	@RequestMapping("createCouponPage")
	public String createCouponPage() {
	
		return "admin/createCouponPage";
	}
	
	@RequestMapping("createdCouponListPage")
	public String createdCouponListPage(Model model) {
		
		
		model.addAttribute("CouponVo", boardServicekt.getCouponList(0)); 
		
		
		return "admin/createdCouponListPage";
	}
		
	@RequestMapping("createCouponProcess") 
	public String createCouponProcess(CouponVo param, MultipartFile image, HttpSession session) {
		//String uploadFolder = "C:/shareOffice/couponImage/";
		String uploadFolder = "/shareOffice/couponImage/";
			if(!image.isEmpty()) {
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/"); 
			String folderPath = sdf.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath); 
			
			String imgName = "";
			
			
			if(!todayFolder.exists()) {
				
				todayFolder.mkdirs();
			}
			
			String oriImgName = image.getOriginalFilename();
	
			UUID uuid = UUID.randomUUID();
			uuid = UUID.randomUUID();
			imgName += (uuid.toString() + oriImgName.substring(oriImgName.lastIndexOf(".")));
			
			try {
				image.transferTo(new File(uploadFolder + folderPath + imgName));
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			param.setCoupon_image(folderPath + imgName);
		
		}
		AdminVo adminVo = (AdminVo)session.getAttribute("AdminUser");
		if(adminVo != null) {
			param.setAdmin_no(adminVo.getAdmin_no());
		}
		boardServicekt.insertCoupon(param);	
		
		return "redirect:./createdCouponListPage";
	}
	
}
