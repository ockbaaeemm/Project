package com.teamb.shareoffice.host.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.guest.mapper.GuestMapperB;
import com.teamb.shareoffice.host.mapper.HostMapperRN;
import com.teamb.shareoffice.member.mapper.MemberMapperJs;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;

@Service
public class HostServiceRN {

	@Autowired
	private HostMapperRN hostMapper;
	
	@Autowired
	private MemberMapperJs memberMapper;
	
	@Autowired
	private GuestMapperB guestMapperB;
	
	public ArrayList<HashMap<String, Object>> getCalendarRentalList(int host_member_no, String rental_date) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		for(HashMap<String, Object> orderInfo : hostMapper.selectOfficeOrderRental(host_member_no, rental_date)) {
			HashMap<String, Object> map = new HashMap<>();
			
			map.put("orderInfo", orderInfo);
			map.put("guestVo", memberMapper.getMemberByNo(Integer.valueOf(String.valueOf(orderInfo.get("member_no")))));
			
			resultList.add(map);
		}
		
		return resultList;
	}
	
	public HashMap<String, Object> getOrderDetailInfo(int order_no) {
		HashMap<String, Object> resultMap = new HashMap<>();
		
		HashMap<String, Object> orderInfo = hostMapper.selectOfficeOrder(order_no);
		resultMap.put("orderInfo", orderInfo);
		ArrayList<RentalVo> rentalList = hostMapper.selectRentalList(order_no);
		long totalPrice = 0; 
		for(RentalVo rentalVo : rentalList) {
			totalPrice += rentalVo.getRental_price();
		}
		resultMap.put("rentalList", rentalList);
		resultMap.put("totalPrice", totalPrice);
		resultMap.put("guestVo", memberMapper.getMemberByNo(Integer.valueOf(String.valueOf(orderInfo.get("member_no")))));
		
		return resultMap;
	}
	
	public void modifyRentalStatus(int rental_no, String rental_status) {
		hostMapper.updateRentalStatus(rental_no, rental_status);
	}
	
	public OrderVo getOrderByRentalNo(int rental_no) {
		return hostMapper.selectOrderByRentalNo(rental_no);
	}
	
	public RentalVo getRental(int rental_no) {
		return hostMapper.selectRental(rental_no);
	}
	
	public ArrayList<HashMap<String, Object>> getOrderList(int member_no, String category, String searchKeyword, boolean onlyCancel) {
		
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();

		for(HashMap<String, Object>  map : hostMapper.selectOrderMember(hostMapper.selectMyOfficeNo(member_no), category, searchKeyword)) {
			HashMap<String, Object> resultMap = new HashMap<>();
			
			int order_no = Integer.valueOf(String.valueOf(map.get("order_no")));
			
			ArrayList<RentalVo> rentalList = hostMapper.selectRentalByOrderNo(order_no, onlyCancel);

			if(onlyCancel && rentalList.size() == 0) {
				continue;
			} else {
				resultMap.put("orderInfo", map);
				resultMap.put("officeVo", hostMapper.selectOfficeByOrderNo(order_no));
				resultMap.put("rentalList", rentalList);
				resultMap.put("totalPrice", rentalList.stream().mapToInt(RentalVo::getRental_price).sum());
			}
			
			resultList.add(resultMap);
		}
		
		return resultList;
	}
	
	public ArrayList<RentalVo> getMonthRental(int member_no, String rental_date) {
		
		String[] splitRentalDate = rental_date.split("-");
		
		String year = splitRentalDate[0];
		String month = splitRentalDate[1];
		
		String startDay = year + "-" + month + "-01";
		String endDay = year + "-" + month + "-31";
		
		return hostMapper.selectMonthRental(member_no, startDay, endDay);
	}
	
	// 통계/대시보드
	// 오피스별 예약비율(이번 달 까지)
	public HashMap<String, Object> getRentalProportion(int member_no) {
		HashMap<String, Object> resultMap = new HashMap<>();
		
		try {
			Calendar today = Calendar.getInstance();
			today.setTime(new Date());
			int year = today.get(Calendar.YEAR);
			int month = today.get(Calendar.MONTH);
			Calendar endDateTemp = Calendar.getInstance();
			endDateTemp.set(year,month,1);
			endDateTemp.getActualMaximum(Calendar.DAY_OF_MONTH);
			String endDateStr = year  + "-"+ (month+1) + "-" + Integer.toString(endDateTemp.getActualMaximum(Calendar.DAY_OF_MONTH));
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date endDateDate = sdFormat.parse(endDateStr);				    
			Calendar endDate = Calendar.getInstance();
			endDate.setTime(endDateDate); 
			
			ArrayList<HashMap<String, Object>> rentalProportionList = hostMapper.selectRentalProportion(member_no, endDateDate);				
			int totalCnt = rentalProportionList.stream().mapToInt(a -> Integer.valueOf(String.valueOf(a.get("cnt")))).sum();
			long totalPrice = rentalProportionList.stream().mapToInt(a -> Integer.valueOf(String.valueOf(a.get("totalPrice")))).sum();
			
			resultMap.put("totalCnt", totalCnt);
			resultMap.put("totalPrice", totalPrice);
			
			int totalDayCnt = 0;
			ArrayList<HashMap<String, Object>> mapList = new ArrayList<>();
			for(HashMap<String, Object> rentalProportion : rentalProportionList) {
				HashMap<String, Object> map = new HashMap<>();
				
				int office_no = Integer.valueOf(String.valueOf(rentalProportion.get("office_no")));
				map.put("office_no", rentalProportion.get("office_no"));
				map.put("cnt", rentalProportion.get("cnt"));
				map.put("office_name", rentalProportion.get("office_name"));
	
				String office_approve_date_str = String.valueOf(rentalProportion.get("office_approve_date"));
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	
				ArrayList<BusinessDayVo> businessDayList = guestMapperB.getBusinessDayInfoByOfficeNo(office_no);
				List<String> dayList = businessDayList.stream().map(a -> a.getBusiness_day()).collect(Collectors.toList());
				
					Date office_approve_date = formatter.parse(office_approve_date_str);
					
					Calendar registDate = Calendar.getInstance();
					registDate.setTime(office_approve_date);
					
					String[] weekList = {"일", "월", "화", "수", "목", "금", "토"};

					for (Date date = registDate.getTime(); registDate.before(endDate); registDate.add(Calendar.DATE, 1), date = registDate.getTime()) {
						
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(date);
	
						String dayOfWeek = weekList[calendar.get(Calendar.DAY_OF_WEEK)-1];

						if(dayList.contains(dayOfWeek)) {
							totalDayCnt++;
						}
	
					}
					
					mapList.add(map);
				
			}
			
			double totalProportion = (totalCnt / (totalDayCnt*1.0)) * 100.0;
			resultMap.put("totalProportion", String.format("%.2f", totalProportion));
			resultMap.put("officeProportionList", mapList);
		
		} catch (ParseException e) {
			System.out.println("date parse 익셉션]" + e.getMessage());
		}

		return resultMap;
	}
	
	// 최근 부정적인 리뷰 5건
	public ArrayList<HashMap<String, Object>> getLatest5NegativeReview(int member_no) {
		return hostMapper.selectLatest5NegativeReview(member_no);
	}
	
	// 내 오피스 리뷰 평균
	public Double getMyOfficeReviewAvg(int member_no) {
		Double avg = hostMapper.selectMyOfficeReviewAvg(member_no);
		return (avg != null) ? avg : 0;
	}
	
	// 최근 5개월 오피스별 예약비율
	public ArrayList<HashMap<String, Object>> getRentalProportionLast5Month(int member_no) {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		Calendar today = Calendar.getInstance();
		today.setTime(new Date());
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH) + 1;
		
		if(month < 5) {
			month += 8;
			year--;
		} else {
			month -= 4;			
		}
		
		for(int office_no : hostMapper.selectMyOfficeNo(member_no)) {
			
			int lastMonth = month + 4;
			HashMap<String, Object> map = new HashMap<>();
			ArrayList<HashMap<String, Object>> oneOfficeRentalProportionList = new ArrayList<>();
			for(int tmpMonth=month;tmpMonth<=lastMonth;tmpMonth++) {
				String yearMonth = "";
				if(tmpMonth > 12) {
					yearMonth += (year+1) + "-" + (tmpMonth-12);
				} else {
					yearMonth += year + "-" + tmpMonth;
				}				
				HashMap<String, Object> resultMap = hostMapper.selectOneOfficeRentalProportion(office_no, yearMonth + "-01", yearMonth + "-31");
				if(resultMap.get("totalPrice") == null) {
					resultMap.put("totalPrice", 0);
				}
				resultMap.put("period", yearMonth);
				oneOfficeRentalProportionList.add(resultMap);
			}
			
			map.put("rentalProportion", oneOfficeRentalProportionList);
			resultList.add(map);
		}
		
		return resultList;
	}
	
}
