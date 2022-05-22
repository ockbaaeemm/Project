package com.teamb.freenext.biz.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.teamb.freenext.vo.AdVo;
import com.teamb.freenext.vo.JobCategoryVo;
import com.teamb.freenext.vo.ProjectBoardVo;
import com.teamb.freenext.vo.ProjectJobVo;
import com.teamb.freenext.vo.ProjectLocalVo;
import com.teamb.freenext.vo.RecruitTypeCategoryVo;
import com.teamb.freenext.vo.WorkTypeCategoryVo;

@Mapper
public interface BizMapper {
	
	public ArrayList<JobCategoryVo> selectJobCategory();
	
	public ArrayList<WorkTypeCategoryVo> selectWorkTypeCategory();
	
	public ArrayList<RecruitTypeCategoryVo> selectRecruitTypeCategory();
	
	public void insertProject(ProjectBoardVo vo);
	
	public void insertProjectJob(ProjectJobVo vo);
	
	public void insertProjectLocal(ProjectLocalVo vo);	
	
	public ArrayList<ProjectBoardVo> selectProjectListByMemberNo(
			@Param("member_no") int member_no, 
			@Param("searchOption") String searchOption, 
			@Param("searchKeyword") String searchKeyword,
			@Param("groupOne") int groupOne,
			@Param("groupTwo") int groupTwo,
			@Param("state_cdT") String state_cdT,
			@Param("startNum") int startNum);
	
	public int selectProjectListCountByMemberNo(
			@Param("member_no") int member_no, 
			@Param("searchOption") String searchOption, 
			@Param("searchKeyword") String searchKeyword,
			@Param("groupOne") int groupOne,
			@Param("groupTwo") int groupTwo,
			@Param("state_cdT") String state_cdT);
	
	public void insertAd(AdVo vo);
	
	public void selectProjectLocal(int project_no);
	
	public void deleteProject(int project_no);
	public void deleteProjectJob(int project_no);
	public void deleteProjectLocal(int project_no);
	public void deleteProjectAd(int project_no);
	public void deleteProjectScrap(int project_no);
	
	public void updateProject(ProjectBoardVo vo);
	public void updateProjectJob(ProjectJobVo vo);	
	public void updateProjectLocal(ProjectLocalVo vo);
	
	public AdVo selectAdByProjectNo(int project_no);  
}
