package com.teamb.shareoffice.guest.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.guest.mapper.GuestMapperB;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;
import com.teamb.shareoffice.vo.ReviewVo;

@Service
public class GuestServiceB {
	
	@Autowired
	private GuestMapperB guestMapperB;
	
	
	public HashMap<String, Object> getOfficeInfo(int office_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		OfficeInfoVo officeInfoVo = guestMapperB.getOfficeInfoByOfficeNo(office_no);
		
		map.put("officeInfoVo", officeInfoVo);
		
		return map;
	}
	
	public ArrayList<HashMap<String, Object>> getBusinessDayInfo(int office_no) {
		
		ArrayList<HashMap<String, Object>> businessDayVoList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<BusinessDayVo> businessDayInfoList = guestMapperB.getBusinessDayInfoByOfficeNo(office_no);

		for(BusinessDayVo businessDayVo : businessDayInfoList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("businessDayVo", businessDayVo);
			
			businessDayVoList.add(map);
		}
		
		return businessDayVoList;
		
	}
	
	public BusinessDayVo getPriceAndBusiunessTime(BusinessDayVo bdvo) {
		
		return guestMapperB.getPriceAndBusinessTimeByDay(bdvo);
		
	}
	

	public void guestOrderAndOfficeRental (OrderVo ovo, String [] rental_date, int [] rental_price) {
		
		//예약날짜 타입 변경(Parse : String -> Date)
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.US);
		
		guestMapperB.guestOrder(ovo);
		
		int order_no = ovo.getOrder_no();
		
		if(rental_date != null && rental_price != null) {
			for(int i=0; i<rental_date.length; i++) {
				
				RentalVo rvo = new RentalVo();
				rvo.setOrder_no(order_no);
				try {
					rvo.setRental_date(sdf.parse(rental_date[i]));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				rvo.setRental_price(rental_price[i]);
				guestMapperB.officeRental(rvo);
			}
			
		}
		
	}
	
	//예약페이지 캘린더관련
	public ArrayList<RentalVo> getOfficeRentalList(int office_no) {
		
		return guestMapperB.getRentalListByOfficeNo(office_no);
		
	}
	
	
	//예약현황페이지관련
	public ArrayList<HashMap<String, Object>> getGuestRentalList(int member_no) {
		
		ArrayList<HashMap<String, Object>> rentalList = new ArrayList<HashMap<String, Object>>();
		ArrayList<OrderVo> guestOrderList = guestMapperB.getOrderListByMemberNo(member_no);
		
		
		for(OrderVo orderVo : guestOrderList)  {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int order_no = orderVo.getOrder_no();
			int office_no = orderVo.getOffice_no();
			
			int totalPayment = 0;
			
			int rentalCount = guestMapperB.getRentalCount(order_no);
			int rentalUseCount = guestMapperB.getRentalUseCount(order_no);
			int rentalUseAndCancelCount = guestMapperB.getRentalUseAndCancelCount(order_no);
			
			boolean officeUseWhether = false;
			
			if (rentalCount <= rentalUseAndCancelCount) {
				officeUseWhether = true;
			}
			
			OfficeInfoVo officeInfoVo = guestMapperB.getOfficeInfoByOfficeNo(office_no);
			ArrayList<RentalVo> rentalVoList = guestMapperB.getRentalListByOrderNo(order_no);
			int reviewExist = guestMapperB.reviewExistCheck(order_no);			
			
			for(RentalVo rentalVo : rentalVoList) {
				
				totalPayment += rentalVo.getRental_price();
			}
			
			map.put("orderVo", orderVo);
			map.put("officeInfoVo", officeInfoVo);
			map.put("rentalVoList", rentalVoList);
			map.put("totalPayment", totalPayment);
			map.put("reviewExist", reviewExist); //리뷰존재여부 체크후 작성버튼 출력여부용
			map.put("officeUseWhether", officeUseWhether); // 예약한 오피스 사용여부 체크후 작성버튼 출력여부용
			map.put("rentalUseCount", rentalUseCount);
			
			rentalList.add(map);
		}
		
		return rentalList;
	}
	
	public void writeReview(ReviewVo rvo) {
		guestMapperB.writeReview(rvo);
	}
	
	public int reviewExistCheck(int order_no) {
		return guestMapperB.reviewExistCheck(order_no);
	}
	
	public int officeRentalWhetherCheck(int office_no, Date rental_date) {
		
		return guestMapperB.officeRentalWhetherCheck(office_no, rental_date);
	}
	
	
}
