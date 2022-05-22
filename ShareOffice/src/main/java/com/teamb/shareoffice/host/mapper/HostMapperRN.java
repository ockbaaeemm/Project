package com.teamb.shareoffice.host.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.teamb.shareoffice.vo.OfficeInfoVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;

public interface HostMapperRN {

	public ArrayList<HashMap<String, Object>> selectOfficeOrderRental(@Param("host_member_no") int host_member_no, @Param("rental_date") String rental_date);
	public HashMap<String, Object> selectOfficeOrder(int order_no);
	public ArrayList<RentalVo> selectRentalList(int order_no);
	public OrderVo selectOrderByRentalNo(int rental_no);
	
	public void updateRentalStatus(@Param("rental_no") int rental_no, @Param("rental_status") String rental_status);
	
	public RentalVo selectRental(int rental_no);
	
	public ArrayList<Integer> selectMyOfficeNo(int member_no);
	public ArrayList<HashMap<String, Object>> selectOrderMember(@Param("office_no_list") ArrayList<Integer> office_no_list, @Param("category") String category, @Param("searchKeyword") String searchKeyword);
	public OfficeInfoVo selectOfficeByOrderNo(int order_no);
	public ArrayList<RentalVo> selectRentalByOrderNo(@Param("order_no") int order_no, @Param("onlyCancel") boolean onlyCancel);
	
	public ArrayList<RentalVo> selectMonthRental(@Param("member_no") int member_no, @Param("startDay") String startDay, @Param("endDay") String endDay);
	
	// 통계/대시보드
	// 내 오피스 예약비율
	public ArrayList<HashMap<String, Object>> selectRentalProportion(@Param("member_no") int member_no, @Param("endDateDate") Date endDateDate);
	// 최근 부정적(3점 미만)인 리뷰 5건
	public ArrayList<HashMap<String, Object>> selectLatest5NegativeReview(int member_no);
	// 내 오피스 리뷰 평균
	public Double selectMyOfficeReviewAvg(int member_no);
	// 특정 오피스 특정 기간 예약비율
	public HashMap<String, Object> selectOneOfficeRentalProportion(@Param("office_no") int office_no, @Param("startDate") String startDate, @Param("endDate") String endDate);
} 
