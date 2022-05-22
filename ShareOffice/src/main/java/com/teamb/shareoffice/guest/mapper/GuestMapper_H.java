package com.teamb.shareoffice.guest.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.FacilityCategoryVo;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.ReviewVo;

public interface GuestMapper_H {
    //등록승인된 오피스 최신순 리스트 
	public ArrayList<OfficeInfoVo> getLatestOfficeList ();
	//지도에 오피스 위치 전체 출력
	public ArrayList<OfficeInfoVo> getLocationList(String searchKeyword);
	
	//오피스 상세보기 페이지
	public OfficeInfoVo getOfficeByNo(int office_no);	
	//오피스 최소금액 출력
	public int getOfficeMinPrice(int office_no);
	//운영시간 및 가격 가져오기
	public ArrayList<BusinessDayVo> getBusinessDayPriceByNo(int office_no);
	//이미지 가져오기
	public ArrayList<ImageDetailVo> getImageDetailByNo(int office_no);
	//이미지 총수량 가져오기
	public int getImageCount(int office_no);
	
	//편의시설 가져오기
	public ArrayList<FacilityCategoryVo> getFacilityByNo(int office_no);
	
	//리뷰목록
	public ArrayList<ReviewVo> getReviewListByNo(int office_no);
	//상세페이지에서 리뷰 3개만 출력
	public ArrayList<ReviewVo> getReviewListOnlyThree(int office_no);
	//리뷰 상세보기
	public ReviewVo getReviewByReviewNo(int review_no);
	public MemberVo getMemberNickByOrderNo(int order_no);
	//리뷰 평점 구하기
	public Double getAvgRating(int office_no);
	//리뷰 총갯수 구하기
	public int getReviewCountByNo(int office_no);
	
	//호스트 신청하기
	public void insertApplyHostInfo(HostVo hvo);
	//호스트 승인하기
	public void updateHostApprove(HostVo hvo);
	//호스트 신청현황 
	public ArrayList<HostVo>getHostApproveCheck(int member_no);
	
	}	
	
