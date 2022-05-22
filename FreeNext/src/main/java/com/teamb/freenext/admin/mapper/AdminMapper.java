package com.teamb.freenext.admin.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.teamb.freenext.vo.AdminVo;
import com.teamb.freenext.vo.MemberCompanyVo;
import com.teamb.freenext.vo.MemberCustomerVo;
import com.teamb.freenext.vo.MemberVo;

@Mapper
public interface AdminMapper {
	
	public AdminVo getAdminByIdAndPw(AdminVo abc);
	
	public ArrayList<MemberVo> getMemberList(HashMap<String, Object> map);	

	public MemberVo getCommonMemberByNo(int no);
	
	public MemberCustomerVo getMemberCustomerByNo(int no);
	
	public MemberCompanyVo getMemberCompanyByNo(int no);

	public void updateCommonMember(MemberVo vo);
	
	public void updateMemberCustomer(MemberCustomerVo vo);
	
	public void updateMemberCompany(MemberCompanyVo vo);
	
	public int getTotalNumber(HashMap<String, Object> map);
	
	public int getTotalMemberTypeNumber(HashMap<String, Object> map);
	
	public int getTotalCompany();
		
}
