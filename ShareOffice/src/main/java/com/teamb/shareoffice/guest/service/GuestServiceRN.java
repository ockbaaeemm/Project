package com.teamb.shareoffice.guest.service;

import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.guest.mapper.GuestMapperB;
import com.teamb.shareoffice.guest.mapper.GuestMapperRN;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;

@Service
public class GuestServiceRN {

	@Autowired
	private GuestMapperB guestMapperB;
	
	@Autowired
	private GuestMapperRN guestMapperRN;
	
	public int order(OrderVo orderVo, ArrayList<RentalVo> rentalVoList) {
		
		guestMapperB.guestOrder(orderVo);
		
		int order_no = orderVo.getOrder_no();
		
		for(RentalVo rentalVo : rentalVoList) {
			rentalVo.setOrder_no(order_no);
			
			guestMapperB.officeRental(rentalVo);
		}
		
		return order_no;
	}
	
	public ArrayList<HashMap<String, Object>> getMemberCoupon(int member_no) {
		return guestMapperRN.selectMemberCoupon(member_no);
	}
	
	public void useCoupon(int allot_no) {
		guestMapperRN.useCoupon(allot_no);
	}

	public HashMap<String, Object> getOrderDetailInfo(int member_no, int order_no) {

		HashMap<String, Object> map = new HashMap<>();

		System.out.println("member_no : " + member_no + ", order_no" + order_no);
		OrderVo orderVo = guestMapperRN.selectOrderByOrderNo(order_no);
		ArrayList<RentalVo> rentalVoList = guestMapperB.getRentalListByOrderNo(order_no);
		
		//rental_date 오름차순으로 정렬
		List<RentalVo> sortRentalVoList = rentalVoList.stream().sorted(Comparator.comparing(RentalVo::getRental_date)).collect(Collectors.toList());

		Calendar calendar = Calendar.getInstance();
		String[] weekList = {"일", "월", "화", "수", "목", "금", "토"};
		long totalPrice = 0;
		long originPrice = 0;
		long cancelPrice = 0;
		for(RentalVo rentalVo : rentalVoList) {
			if(rentalVo.getRental_status().equals("C")) {
				cancelPrice += rentalVo.getRental_price();
			} else {
				totalPrice += rentalVo.getRental_price();	
			}
			
			calendar.setTime(rentalVo.getRental_date());
			
			originPrice += guestMapperRN.selectBusinessDayPrice(orderVo.getOffice_no(), weekList[calendar.get(Calendar.DAY_OF_WEEK)-1]);
		}
		
		map.put("orderVo", orderVo);
		map.put("rentalVoList", sortRentalVoList);
		map.put("totalPrice", totalPrice);
		map.put("originPrice", originPrice);
		map.put("couponPrice", originPrice - totalPrice - cancelPrice);
		map.put("cancelPrice", cancelPrice);
		map.put("officeVo", guestMapperB.getOfficeInfoByOfficeNo(orderVo.getOffice_no()));

		return map;
	}
	
}
