package com.teamb.shareoffice.admin.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.ImageDetailVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OfficeInfoVo;

public interface AdminMapper 
{
	public AdminVo getAdminPw(AdminVo vo);
	public MemberVo hostSessionRenewal(MemberVo vo);
	public ArrayList<MemberVo> getGuestInformation(@Param("searchOption") String searchOption, @Param("searchStr") String searchStr, @Param("pageNum") int pageNum);
	
	public ArrayList<HostVo> getHostInformation(@Param("searchOption") String searchOption, @Param("searchStr") String searchStr, @Param("pageNum") int pageNum);
	public ArrayList<HostVo> getCheckApplyHostList();

	public ArrayList<OfficeInfoVo> getOfficeInformation(@Param("searchOption") String searchOption, @Param("searchStr") String searchStr, @Param("pageNum") int pageNum);
	public ArrayList<ImageDetailVo> getImageDetail(int office_no);
	
	public void updateMemberType(@Param("member_no") String member_no, @Param("member_type") String member_type);
	public void hostApplyGuest(int host_no);
	public MemberVo hostSessionRenewal(int member_no);
	public void hostRefuseGuest(@Param("host_no") String host_no, @Param("refuseReason") String refuseReason, @Param("member_no") String member_no);
	public void updateOfficeApprove(int member_no);
	public void deleteGuest(int member_no);
	
	public void officeApply(@Param("office_no") int office_no, @Param("member_no") int member_no);
	public void officeRefuse(@Param("office_no") String office_no, @Param("refuseReason") String refuseReason, @Param("member_no") int member_no);
	public void deleteOfficeByHostRefuse(int member_no);

	public AdminVo getAdminByNo(int admin_no);
}
