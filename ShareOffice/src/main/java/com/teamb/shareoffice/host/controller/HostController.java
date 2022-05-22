package com.teamb.shareoffice.host.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.teamb.shareoffice.host.service.HostService;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.FacilityCategoryVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;

@Controller
@RequestMapping("/host/*")
public class HostController {
	
	@Autowired
	private HostService hostService;
	
	private final String uploadFolder = "/shareOffice/officeImage/";
	//private final String uploadFolder = "C:\shareOffice\licenseImg";
	
	/*@RequestMapping("mainPage")
	public String mainPage() {
		return "host/mainPage";
	}*/
	
	
	@RequestMapping("registerOfficePage")
	public String registerOfficePage(Model model) {
		
		System.out.println("오피스등록 페이지 실행중입니다.");
		
		ArrayList<FacilityCategoryVo> list = hostService.getFacilityCategoryList();
		model.addAttribute("facilityCategoryList", list);
		
		return "host/registerOfficePage";
	}
	
	@RequestMapping("registerOfficeProcess")
	public String registerOfficeProcess(OfficeInfoVo ovo,  MemberVo mvo, HttpSession session, MultipartFile mainFiles, MultipartFile [] subFiles, 
			 int [] facility_no , String [] business_day , int [] business_day_price , int [] business_time_start , int [] business_time_finish) {
		
		ArrayList<BusinessDayVo> businessDayVoList = new ArrayList<BusinessDayVo>();
		
		if(business_day.length == business_day_price.length && business_day.length == business_time_start.length && business_day.length == business_time_finish.length) {
			
			
			for(int i = 0 ; i < business_day.length ; i++) {
				BusinessDayVo businessDayVo = new BusinessDayVo();
				
				businessDayVo.setBusiness_day(business_day[i]);
				businessDayVo.setBusiness_time_start(business_time_start[i]);
				businessDayVo.setBusiness_time_finish(business_time_finish[i]);
				businessDayVo.setBusiness_day_price(business_day_price[i]);
				
				businessDayVoList.add(businessDayVo);
			}
			
		}
		
		System.out.println("오피스등록 프로세스 실행");
		
		ArrayList<ImageDetailVo> imageDetailVoList = new ArrayList<ImageDetailVo>();
				
		
		if(subFiles != null) {
			for(MultipartFile uploadFile : subFiles) {
				if(uploadFile.isEmpty()) {
					continue;
				}
				
				//날짜별 폴더 생성
				Date today = new Date();
				SimpleDateFormat aaa = new SimpleDateFormat("yyyy/MM/dd");
				String folderPath = aaa.format(today);
				
				File todayFolder = new File(uploadFolder + folderPath);
				 
				if(!todayFolder.exists()) {
					todayFolder.mkdirs();
				}
				
				//중복이름 피하기
				String fileName = "";
				UUID uuid = UUID.randomUUID();
				fileName += uuid.toString();
				
				long currentTime = System.currentTimeMillis();
				fileName += "_" + currentTime;
				
				//확장자 추가
				String originalFileName = uploadFile.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				fileName += ext;
				
				try {
					uploadFile.transferTo(new File(uploadFolder + folderPath + "/" + fileName));
				} catch(Exception e) {
					e.printStackTrace();
				}
				
				//Service로 보내기
				ImageDetailVo imageDetailVo = new ImageDetailVo();
				imageDetailVo.setImage_url(folderPath + "/" + fileName);
				imageDetailVoList.add(imageDetailVo);
				
				
			}
		}
		
		if(mainFiles != null && !mainFiles.isEmpty()) {
			
			//날짜별 폴더 생성
			Date today = new Date();
			SimpleDateFormat aaa = new SimpleDateFormat("yyyy/MM/dd");
			String folderPath = aaa.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath);
			
			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}
			
			//중복이름 피하기
			String fileName = "";
			UUID uuid = UUID.randomUUID();
			fileName += uuid.toString();
			
			long currentTime = System.currentTimeMillis();
			fileName += "_" + currentTime;
			
			//확장자 추가
			String originalFileName = mainFiles.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			fileName += ext;
			
			try{
				mainFiles.transferTo(new File(uploadFolder + folderPath + "/" + fileName));
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			ovo.setOffice_thumbnail(folderPath + "/" + fileName);
			
		}
		
		System.out.println("오피스명" + ovo.getOffice_name());

		ovo.setMember_no(((MemberVo) session.getAttribute("sessionUser")).getMember_no());
		
		hostService.registerOffice(ovo, imageDetailVoList, facility_no , businessDayVoList);
		return "redirect:../host/officeListPage";
	}
	
	@RequestMapping("officeListPage")
	public String officeListPage(HttpSession session, Model model, String office_approve) {

		System.out.println("오피스 리스트 페이지가 실행되었습니다.");
		 
		ArrayList<OfficeInfoVo> officeList = hostService.getMyOfficeList(((MemberVo) session.getAttribute("sessionUser")).getMember_no(), office_approve);
		model.addAttribute("officeList", officeList);
		if(office_approve != null) {
			model.addAttribute("office_approve", office_approve);
		} else {
			model.addAttribute("office_approve", "all");
		}

		
		return "host/officeListPage";
	}
	
	@RequestMapping("officeDetailPage")
	public String officeDetailPage(int office_no, Model model) {
		
		System.out.println("오피스 상세보기 페이지가 실행되었습니다.");
		HashMap<String, Object> map = hostService.getOffice(office_no);
		model.addAttribute("data", map);
		
		return "host/officeDetailPage";
	}
	
	@RequestMapping("deleteOfficeProcess")
	public String deleteOfficeProcess(int office_no) {
		
		hostService.deleteOffice(office_no);
		
		return "redirect:./officeListPage";
	}
	
	@RequestMapping("updateOfficePage")
	public String updateOfficePage(int office_no, Model model) {
		
		System.out.println("오피스 수정 페이지가 실행되었습니다.");
		
		ArrayList<FacilityCategoryVo> list = hostService.getFacilityCategoryList();
		model.addAttribute("facilityCategoryList", list);
		
		HashMap<String, Object> map = hostService.getOffice(office_no);
		model.addAttribute("data", map);
		
		return "host/updateOfficePage";
	}
	
	@RequestMapping("updateOfficeProcess")
	public String updateOfficeProcess(OfficeInfoVo ovo, ImageDetailVo ivo, BusinessDayVo bvo, MultipartFile mainFiles, MultipartFile [] subFiles, 
			 int [] facility_no , String [] business_day , int [] business_day_price , int [] business_time_start , int [] business_time_finish) {
		
		System.out.println("오피스 수정 프로세스 실행중");
		System.out.println(business_day);
		System.out.println(business_day_price);
		System.out.println(business_time_start);
		System.out.println(business_time_finish);
		
		
		ArrayList<BusinessDayVo> businessDayVoList = new ArrayList<BusinessDayVo>();
		System.out.println(business_day.length);
		System.out.println(business_day_price.length);
		System.out.println(business_time_start.length);
		System.out.println(business_time_finish.length);
		if(business_day.length == business_day_price.length && business_day.length == business_time_start.length && business_day.length == business_time_finish.length) {
			
			for(int i = 0 ; i < business_day.length ; i++) {
				BusinessDayVo businessDayVo = new BusinessDayVo();
				System.out.println(business_day[i] + ", " + business_time_start[i] + ", " + business_time_finish[i] + ", " + business_day_price[i]);
				businessDayVo.setBusiness_day(business_day[i]);
				businessDayVo.setBusiness_time_start(business_time_start[i]);
				businessDayVo.setBusiness_time_finish(business_time_finish[i]);
				businessDayVo.setBusiness_day_price(business_day_price[i]);
				businessDayVoList.add(businessDayVo);
			}
		}
			
		
		ArrayList<ImageDetailVo> imageDetailVoList = new ArrayList<ImageDetailVo>();
		
		if(subFiles != null) {
			for(MultipartFile uploadFile : subFiles) {
				if(uploadFile.isEmpty()) {
					continue;
				}
				
				//날짜별 폴더 생성
				Date today = new Date();
				SimpleDateFormat aaa = new SimpleDateFormat("yyyy/MM/dd");
				String folderPath = aaa.format(today);
				
				File todayFolder = new File(uploadFolder + folderPath);
				 
				if(!todayFolder.exists()) {
					todayFolder.mkdirs();
				}
				
				//중복이름 피하기
				String fileName = "";
				UUID uuid = UUID.randomUUID();
				fileName += uuid.toString();
				
				long currentTime = System.currentTimeMillis();
				fileName += "_" + currentTime;
				
				//확장자 추가
				String originalFileName = uploadFile.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				fileName += ext;
				
				try {
					uploadFile.transferTo(new File(uploadFolder + folderPath + "/" + fileName));
				} catch(Exception e) {
					e.printStackTrace();
				}
				
				//Service로 보내기
				ImageDetailVo imageDetailVo = new ImageDetailVo();
				imageDetailVo.setImage_url(folderPath + "/" + fileName);
				imageDetailVoList.add(imageDetailVo);
				
				
			}
		}
			
		if(mainFiles != null && !mainFiles.isEmpty()) {
			
			//날짜별 폴더 생성
			Date today = new Date();
			SimpleDateFormat aaa = new SimpleDateFormat("yyyy/MM/dd");
			String folderPath = aaa.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath);
			
			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}
			
			//중복이름 피하기
			String fileName = "";
			UUID uuid = UUID.randomUUID();
			fileName += uuid.toString();
			
			long currentTime = System.currentTimeMillis();
			fileName += "_" + currentTime;
			
			//확장자 추가
			String originalFileName = mainFiles.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			fileName += ext;
			
			try{
				mainFiles.transferTo(new File(uploadFolder + folderPath + "/" + fileName));
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			ovo.setOffice_thumbnail(folderPath + "/" + fileName);
			
		} else {
			ovo.setOffice_thumbnail(((OfficeInfoVo) hostService.getOffice(ovo.getOffice_no()).get("officeInfoVo")).getOffice_thumbnail());
		}
		
		hostService.updateOffice(ovo, imageDetailVoList, facility_no, businessDayVoList);
		
		return "redirect:./officeDetailPage?office_no=" + ovo.getOffice_no();
	}
	

}
