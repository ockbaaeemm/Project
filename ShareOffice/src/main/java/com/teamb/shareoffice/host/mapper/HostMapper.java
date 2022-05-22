package com.teamb.shareoffice.host.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.FacilityCategoryVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.OfficeFacilityVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;

public interface HostMapper {
	
	// 오피스 등록관련
	public void insertOffice(OfficeInfoVo vo);
	
	public int getLastOfficeInfoPK();
	
	// 오피스 시설 카테고리 관련
	public void insertOfficeFacility(OfficeFacilityVo vo);
	
	public ArrayList<FacilityCategoryVo> getFacilityCategoryList();

	// 오피스 이미지 업로드 관련
	public void registerImage(ImageDetailVo vo);
	
	// 오피스 운영시간 및 요금 관련
	public void registerDayAndTime(BusinessDayVo vo);
	
	
	// 오피스 목록 조회
	public ArrayList<OfficeInfoVo> getOfficeList();
	public ArrayList<OfficeInfoVo> getMyOfficeList(@Param("member_no") int member_no, @Param("office_approve") String office_approve);
	public OfficeInfoVo getOfficeByNo(int no);
	
	public ArrayList<ImageDetailVo> getImageList(int no);
	public ArrayList<BusinessDayVo> getBusinessDayByNo(int no);
	
	public ArrayList<Integer> getOfficeFacility(int no);
	public FacilityCategoryVo getFacilityCategory(int no);

	// 오피스 삭제
	public void deleteOffice(int no);
	
	////// 오피스 수정
	public void updateOffice(OfficeInfoVo vo);
	
	// 오피스 상세이미지 수정
	public void updateOfficeDetailImage(ImageDetailVo vo);
	
	// 오피스 운영요일 수정
	public void deleteBusinessDay(int no);
	
	// 오피스 편의시설 수정
	public void deleteFacility(int no);
	
}
