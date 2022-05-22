package com.teamb.shareoffice.guest.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.teamb.shareoffice.guest.mapper.GuestMapper_H;
import com.teamb.shareoffice.member.mapper.MemberMapperkt;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.FacilityCategoryVo;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.ReviewVo;

@Service
public class GuestService_H {

	
	
	@Autowired 
	private GuestMapper_H guestMapper_H;
	@Autowired
	private MemberMapperkt memberMapperkt;
	//오피스 기본 리스트
	public ArrayList<HashMap<String, Object>> getLatestOfficeList(){
		
		ArrayList<HashMap<String, Object>> officelist =  new ArrayList<HashMap<String, Object>>();
		ArrayList<OfficeInfoVo> officeVoList = guestMapper_H.getLatestOfficeList();
		
		
		for(OfficeInfoVo officeVo:officeVoList ) {
			
			ArrayList<BusinessDayVo> businessDayList = guestMapper_H.getBusinessDayPriceByNo(officeVo.getOffice_no()); 
			ArrayList<FacilityCategoryVo> facilityCategoryList = guestMapper_H.getFacilityByNo(officeVo.getOffice_no());
			
			int officeMinPrice = guestMapper_H.getOfficeMinPrice(officeVo.getOffice_no());
			Double officeAvgRating = guestMapper_H.getAvgRating(officeVo.getOffice_no());
			
			HashMap<String, Object> map = new HashMap<String, Object>();	
			//운영시간 및 가격 가져오기(수정 필요)
		
			
		    map.put("officeVo", officeVo);
		    map.put("businessDayList",businessDayList);
		    map.put("officeMinPrice",officeMinPrice);
		    map.put("officeAvgRating",officeAvgRating);
		    map.put("facilityCategoryList",facilityCategoryList);
		
		  
		
		    officelist.add(map);
		}
		
		
		return officelist;
	}	

	
	//오피스 위치 전체 출력
    public ArrayList<OfficeInfoVo> getLocationList(String searchKeyword){
    	
    	//System.out.println("@@@@$@#$@#$ :" + searchKeyword + "qqqqqqqqqqqqq");
    	
    	ArrayList<OfficeInfoVo> list = guestMapper_H.getLocationList(searchKeyword);

    	return list;
    }
    //오피스 상세페이지
	public HashMap<String, Object> getOfficeDetail(int office_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		OfficeInfoVo officeVo = guestMapper_H.getOfficeByNo(office_no);
		ArrayList<BusinessDayVo> businessDayList = guestMapper_H.getBusinessDayPriceByNo(office_no); 
		
		ArrayList<ImageDetailVo> officeImageList = guestMapper_H.getImageDetailByNo(office_no);
		ArrayList<FacilityCategoryVo> facilityCategoryList = guestMapper_H.getFacilityByNo(office_no);
		ArrayList<ReviewVo> reviewListThree = guestMapper_H.getReviewListOnlyThree(office_no);
		
		
		map.put("officeVo",officeVo);
		map.put("facilityCategoryList",facilityCategoryList);
		map.put("officeImageList",officeImageList);
		map.put("businessDayList",businessDayList);
		map.put("reviewListThree", reviewListThree);

		
		return map;
	}
	//오피스 최소수량 출력
	public int getOfficeMinPrice(int office_no) {
		return guestMapper_H.getOfficeMinPrice(office_no);
	}

	//이미지 총수량
	public int getImageCount(int office_no) {
		return guestMapper_H.getImageCount(office_no);
	}
	//이용후기 평점 평균
	public Double getOfficeAvgRating(int office_no) {
		return guestMapper_H.getAvgRating(office_no);
	}
	//오피스별 이용후기 총 갯수
	public int getReviewCount(int office_no) {
		return guestMapper_H.getReviewCountByNo(office_no);
	}


	
	// 오피스 이용후기리스트 페이지
	public ArrayList<HashMap<String, Object>> reviewList(int office_no) {

		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		ArrayList<ReviewVo> reviewVoList = guestMapper_H.getReviewListByNo(office_no);

		
		for (ReviewVo reviewVo : reviewVoList) {
					
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("reviewVo",reviewVo);
			
			
			reviewList.add(map);

		}		
		return reviewList;
	}
	public HashMap<String, Object> getReviewDetail (int review_no){
		
		HashMap<String, Object>map = new HashMap<String, Object>();
				
		ReviewVo reviewVo = guestMapper_H.getReviewByReviewNo(review_no);
		MemberVo memberVo = guestMapper_H.getMemberNickByOrderNo(reviewVo.getOrder_no());		
		
		map.put("reviewVo", reviewVo);
		map.put("memberVo",memberVo);
		return map;
	}
	
	
	public void applyHost(HostVo hvo) {
		
		guestMapper_H.insertApplyHostInfo(hvo);
		
	}
	//게스트가 호스트 신청한 목록 출력
	public ArrayList<HashMap<String, Object>> getHostApprove(int member_no ){
		
		ArrayList<HashMap<String, Object>> applyList =  new ArrayList<HashMap<String, Object>>();
		ArrayList<HostVo> hostVoList =  guestMapper_H.getHostApproveCheck(member_no);		
		
		for(HostVo hostVo:hostVoList) {
			int memberNo = hostVo.getMember_no();
			MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("hostVo",hostVo);
			map.put("memberVo", memberVo);
			
			applyList.add(map);
		}
		
			
		return applyList;
	}

}
