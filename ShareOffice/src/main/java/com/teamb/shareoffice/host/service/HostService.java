package com.teamb.shareoffice.host.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.host.mapper.HostMapper;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.FacilityCategoryVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.OfficeFacilityVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;

@Service
public class HostService {
	
	@Autowired
	private HostMapper hostMapper;
	
	
	
	public void registerOffice(OfficeInfoVo ovo, ArrayList<ImageDetailVo> imageDetailVoList, int [] facility_no , ArrayList<BusinessDayVo> businessDayVoList) {
		
		
		hostMapper.insertOffice(ovo);

		int officeNo = ovo.getOffice_no();
		
		
		System.out.println("!!!!! 1111 : " + imageDetailVoList.size());
		//System.out.println("!!!!! 2222 : " + facility_no.length);
		
		if(facility_no != null) {
			for(int fcNo : facility_no) {
				OfficeFacilityVo ofcVo = new OfficeFacilityVo();
				ofcVo.setOffice_no(officeNo);
				ofcVo.setFacility_no(fcNo);
				hostMapper.insertOfficeFacility(ofcVo);
			}
		}
		
		
		
		for(ImageDetailVo imageDetailVo : imageDetailVoList) {
			
			imageDetailVo.setOffice_no(officeNo);
			hostMapper.registerImage(imageDetailVo);
		}
		
		
		for(BusinessDayVo bvo : businessDayVoList) {
			bvo.setOffice_no(officeNo);
			hostMapper.registerDayAndTime(bvo);
		}
		
		
	}
	
	public ArrayList<FacilityCategoryVo> getFacilityCategoryList(){
		return hostMapper.getFacilityCategoryList();
	}
	
	
	public ArrayList<OfficeInfoVo> getOfficeList(){
	
		return hostMapper.getOfficeList();
	}
	
	public ArrayList<OfficeInfoVo> getMyOfficeList(int member_no, String office_approve){
		return hostMapper.getMyOfficeList(member_no, office_approve);
	}
	
	public HashMap<String, Object> getOffice(int office_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		OfficeInfoVo officeInfoVo = hostMapper.getOfficeByNo(office_no);
		int officeNo = officeInfoVo.getOffice_no();
		ArrayList<ImageDetailVo> imageDetailVo = hostMapper.getImageList(office_no);
		ArrayList<BusinessDayVo> businessDayVo = hostMapper.getBusinessDayByNo(officeNo);
		
		ArrayList<Integer> facilityNoList = hostMapper.getOfficeFacility(officeNo);
		ArrayList<FacilityCategoryVo> facilityCategoryVoList = new ArrayList<FacilityCategoryVo>();
		
		for(int facilityNo : facilityNoList) {
			FacilityCategoryVo vo = hostMapper.getFacilityCategory(facilityNo);
			facilityCategoryVoList.add(vo);
		}
		
		map.put("officeInfoVo", officeInfoVo);
		map.put("imageDetailVoList", imageDetailVo);
		map.put("businessDayVoList", businessDayVo);
		map.put("facilityCategoryVoList", facilityCategoryVoList);
	
		return map;
	}
	
	public ArrayList<BusinessDayVo> getBusinessDayInfo(int office_no) {
		return hostMapper.getBusinessDayByNo(office_no);
	}
	
	public void deleteOffice(int office_no) {
		hostMapper.deleteOffice(office_no);
	}
	
	public void updateOffice(OfficeInfoVo ovo, ArrayList<ImageDetailVo> imageDetailVoList, int [] facility_no , ArrayList<BusinessDayVo> businessDayVoList) {
		
		System.out.println("!!!!!!!!!!!!!!!!!!!!!" + ovo.getOffice_no());
		
		hostMapper.deleteBusinessDay(ovo.getOffice_no());
		hostMapper.deleteFacility(ovo.getOffice_no());
		
		hostMapper.updateOffice(ovo);
		
		int officeNo = ovo.getOffice_no();
		
		if(facility_no != null) {
			for(int fcNo : facility_no) {
				OfficeFacilityVo ofcVo = new OfficeFacilityVo();
				ofcVo.setOffice_no(officeNo);
				ofcVo.setFacility_no(fcNo);
				hostMapper.insertOfficeFacility(ofcVo);
			}
		}
		
		
		for(ImageDetailVo imageDetailVo : imageDetailVoList) {
			
			imageDetailVo.setOffice_no(officeNo);
			hostMapper.registerImage(imageDetailVo);
		}
		
		
		for(BusinessDayVo bdvo : businessDayVoList) {
			bdvo.setOffice_no(officeNo);
			hostMapper.registerDayAndTime(bdvo);
		}
		

		
		

		
	}

}
