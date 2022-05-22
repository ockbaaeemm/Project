package com.teamb.shareoffice.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

public class GuestInterceptor extends WebContentInterceptor {
	// 오버라이딩
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler) throws ModelAndViewDefiningException {

		if(request.getSession().getAttribute("sessionUser") == null) {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/loginRequired");	// forwarding할 곳 지정
			
			// exception을 발생시켜 forwarding함
			throw new ModelAndViewDefiningException(mv);
		}
		return true;	// 원래 목적지로 감
	}
}
