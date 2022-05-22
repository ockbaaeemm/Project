package com.teamb.shareoffice.guest.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamb.shareoffice.guest.service.GuestServiceB;
import com.teamb.shareoffice.guest.service.GuestService_H;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;


@RestController
@RequestMapping("/guest/*")
public class RestGuestController {
	
	@Autowired
	private GuestServiceB guestServiceB;
	
	
	@RequestMapping("getOfficeReservedDateAndBusinessDay")
	public HashMap<String, Object> getOfficeReservedDateAndBusinessDay(int office_no){
		HashMap<String, Object> responseData = new HashMap<String, Object>();
		
		responseData.put("officeBusinessDayInfo", guestServiceB.getBusinessDayInfo(office_no));
		responseData.put("officeRentalList", guestServiceB.getOfficeRentalList(office_no));
		
		return responseData;
	}
	
	
	@Autowired 
	private GuestService_H guestService_H;
	
	@RequestMapping("getLocationList")
	public HashMap<String, Object> getLocationList(String searchKeyword){
		HashMap<String, Object> locationData = new HashMap<String, Object>();
		
		ArrayList<OfficeInfoVo> locationList = guestService_H.getLocationList(searchKeyword);

		locationData.put("result","success");
		locationData.put("locationList",locationList);
		
		return locationData;
		
	}
	
	
	@RequestMapping("rentalWhetherCheck")
	public HashMap<String, Object> rentalWhetherCheck(int office_no, String [] rental_date) throws Exception{
		
		HashMap<String, Object> responseData = new HashMap<String, Object>();
		/*
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US);
		Calendar cal = Calendar.getInstance();

		Date [] parseDateArr = new Date[rental_date.length];
		int [] rentalWhetherArr = new int[rental_date.length];
		Date parseDate = null;
		 
		// 제이슨 형태로 받아온 배열 앞뒤 [] 자르기
		rental_date[0] = rental_date[0].substring(1);
		rental_date[rental_date.length-1] = rental_date[rental_date.length-1].substring(0, rental_date[rental_date.length-1].length()-1);
		
		for(int i=0; i<rental_date.length; i++) {
			
			// 제이슨 형태로 받아온 배열의 값 앞뒤 "" 자르기
			rental_date[i] = rental_date[i].substring(1, rental_date[i].length()-1);
			
			parseDate = sdf.parse(rental_date[i]);
			
			//GMT기준 맞춰서  9시간 더하기
			cal.setTime(parseDate);
			cal.add(Calendar.HOUR, +9);
			parseDateArr[i] = cal.getTime();
			
		}
		
		if(rental_date != null) {
			for(int i=0; i<rental_date.length; i++) {
				int rentalWhether = guestServiceB.officeRentalWhetherCheck(office_no, parseDateArr[i]);
				rentalWhetherArr[i] = rentalWhether;
			}
		}
		
		responseData.put("rentalWhether", rentalWhetherArr);
		
		
		*/
		//System.out.println("여기여기 : " + rentalWhetherArr);
	
		
		List<Integer> rentalWhetherArr = new ArrayList<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(rental_date != null) {
			for(String ttt  : rental_date) {
				int rentalWhether = guestServiceB.officeRentalWhetherCheck(office_no, sdf.parse(ttt));
				rentalWhetherArr.add(rentalWhether);
			}
		}		
		
		responseData.put("rentalWhether", rentalWhetherArr);
		return responseData;
	}
	
	
	

}
