package com.teamb.shareoffice.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.admin.mapper.AdminMapper;
import com.teamb.shareoffice.guest.mapper.GuestMapper_H;
import com.teamb.shareoffice.host.mapper.HostMapper;
import com.teamb.shareoffice.member.mapper.MemberMapperJs;
import com.teamb.shareoffice.member.mapper.MemberMapperRN;
import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.MessageVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;

@Service
public class AdminService 
{
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private MemberMapperRN memberMapper;
	
	@Autowired
	private MemberMapperJs memberMapperJs;
	
	@Autowired
	private HostMapper hostMapper;
	
	public AdminVo loginAdmin(AdminVo vo)
	{
		AdminVo result = adminMapper.getAdminPw(vo);
		
		return result;
	}
	
	public ArrayList<HashMap<String, Object>> guestManagement(String searchOption, String searchStr, int pageNum)
	{
		ArrayList<HashMap<String, Object>> guestList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<MemberVo> memberVoList = adminMapper.getGuestInformation(searchOption, searchStr, pageNum);
			
		for(MemberVo memberVo : memberVoList)
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			
			guestList.add(map);
		}
		
		return guestList;
	}
	
	public void deleteGuest(int member_no)
	{
		adminMapper.deleteGuest(member_no);
	}
	
	public ArrayList<HashMap<String, Object>> hostManagement(String searchOption, String searchStr, int pageNum)
	{
		ArrayList<HashMap<String, Object>> hostList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<HostVo> hostVoList = adminMapper.getHostInformation(searchOption, searchStr, pageNum);
		
		for(HostVo hostVo : hostVoList)
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("hostVo", hostVo);
			
			hostList.add(map);
		}
		
		return hostList;
	}
	
	public MemberVo hostApplyGuest(int member_no, int host_no)
	{
		adminMapper.hostApplyGuest(host_no);
		adminMapper.updateMemberType(String.valueOf(member_no), "H");
		
		return adminMapper.hostSessionRenewal(member_no);
	}
	
	public MemberVo hostRefuseGuest(String host_no, String refuseReason, String member_no)
	{
		adminMapper.hostRefuseGuest(host_no, refuseReason, member_no);
		if(member_no != null) {
			adminMapper.updateMemberType(member_no, "G");
			adminMapper.updateOfficeApprove(Integer.parseInt(member_no));
			
		}
		
		return adminMapper.hostSessionRenewal(Integer.parseInt(member_no));
	}

	public ArrayList<HashMap<String, Object>> getOfficeInformation(String searchOption, String searchStr, int pageNum)
	{
		ArrayList<HashMap<String, Object>> getOfficeList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<OfficeInfoVo> getVoList = adminMapper.getOfficeInformation(searchOption, searchStr, pageNum);
		
		for(OfficeInfoVo officeInfoVo : getVoList)
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("getOffice", officeInfoVo);
			
			int officeNo = officeInfoVo.getOffice_no();
			
			map.put("imageDetailList", adminMapper.getImageDetail(officeNo));
			
			
			getOfficeList.add(map);
		}
		
		return getOfficeList;
	}
	
	
	
	public void officeApply(int office_no, int member_no)
	{
		adminMapper.officeApply(office_no, member_no);
	}
	
	public void officeRefuse(String office_no, String refuseReason, int member_no)
	{
		adminMapper.officeRefuse(office_no, refuseReason, member_no);
	}
	
	public void deleteOfficeByHostRefuse(int member_no)
	{
		adminMapper.deleteOfficeByHostRefuse(member_no);
	}

	public void noticeMessage(String msg, int member_no) 
	{
		MessageVo ttt = new MessageVo();
		ttt.setSender_no(0);
		ttt.setReceive_no(member_no); //�ш릿 �명��...
		ttt.setTxt(msg);
		
		memberMapperJs.insertMessage(ttt);

	}
}
	
