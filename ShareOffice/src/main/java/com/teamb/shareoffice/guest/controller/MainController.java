package com.teamb.shareoffice.guest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@Autowired
	private GuestController_H guestController_H;

	@RequestMapping("/")
	public String main() {
		return guestController_H.mainPage();
	}
}
