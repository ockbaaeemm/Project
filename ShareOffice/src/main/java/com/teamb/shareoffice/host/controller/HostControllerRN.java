package com.teamb.shareoffice.host.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamb.shareoffice.host.service.HostServiceRN;
import com.teamb.shareoffice.vo.MemberVo;

@Controller
@RequestMapping("/host/*")
public class HostControllerRN {
	
	@Autowired
	private HostServiceRN hostService;
	
	@RequestMapping("rentalStatusPage")
	public String rentalStatusPage() {
		
		return "host/rentalStatusPage";
	}
	
	@RequestMapping("orderDetailPage")
	public String orderDetailPage(int order_no, Model model) {
		model.addAttribute("resultMap", hostService.getOrderDetailInfo(order_no));
		
		return "host/orderDetailPage";
	}
	
	@RequestMapping("mainPage")
	public String mainPage(Model model, HttpSession session) {
		
		int member_no = ((MemberVo) session.getAttribute("sessionUser")).getMember_no();
		
		model.addAttribute("negativeReview", hostService.getLatest5NegativeReview(member_no));
		model.addAttribute("reviewAvg", hostService.getMyOfficeReviewAvg(member_no));

		return "host/mainPage";
	}
}
