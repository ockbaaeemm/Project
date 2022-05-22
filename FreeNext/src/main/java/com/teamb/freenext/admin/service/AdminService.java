package com.teamb.freenext.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.freenext.admin.mapper.AdminMapper;
import com.teamb.freenext.vo.AdminVo;
import com.teamb.freenext.vo.MemberCompanyVo;
import com.teamb.freenext.vo.MemberCustomerVo;
import com.teamb.freenext.vo.MemberVo;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	
	public AdminVo adminLogin(AdminVo vo) {
		
		AdminVo result = adminMapper.getAdminByIdAndPw(vo);
		
		return result;
	}
	
	
	public ArrayList<MemberVo> getMemberList(HashMap<String, Object> map){

		return adminMapper.getMemberList(map);
		
	}
	
//	public int getMemberCount (String searchOption, String searchWord, String searchApproval, String searchMemberType) {
//		
//		return adminMapper.getMemberCount(searchOption, searchWord, searchApproval, searchMemberType);
//	}	
	
	public HashMap<String, Object> getMember (int memberNo){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVo memberVo = adminMapper.getCommonMemberByNo(memberNo);
		//memberNo = memberVo.getMember_no();
		map.put("memberVo", memberVo);
		
		if(memberVo.getMember_type().equals("N")) {
			
			MemberCustomerVo memberCustomerVo = adminMapper.getMemberCustomerByNo(memberNo);
			//int memberCustomerNo = memberCustomerVo.getCustomer_no();
			map.put("memberCustomerVo", memberCustomerVo);
			
		} else {
			MemberCompanyVo memberCompanyVo = adminMapper.getMemberCompanyByNo(memberNo);
			//int memberCompanyNo = memberCompanyVo.getCompany_no();
			map.put("memberCompanyVo", memberCompanyVo);
			
		}
		
		return map;
				
	}
	
	public void updateMemberN(MemberVo mvo, MemberCustomerVo cvo) {
		adminMapper.updateCommonMember(mvo);
		adminMapper.updateMemberCustomer(cvo);
		
	}
	
	public void updateMemberB(MemberVo mvo, MemberCompanyVo cvo) {
		adminMapper.updateCommonMember(mvo);
		adminMapper.updateMemberCompany(cvo);
	}

	public int getTotalMemberNumber(HashMap<String, Object> map) {
				
		int result = adminMapper.getTotalNumber(map);
		
		return result;
	}
	
	public int getToalMemberTypeNumber(HashMap<String, Object> map, String member_type) {
		
		map.put("member_type", member_type);
		
		int result = adminMapper.getTotalMemberTypeNumber(map);
		
		return result;
	}
	
	public int getCompanyNumber() {
		
		int result = adminMapper.getTotalCompany();
		
		return result;
	}
}
