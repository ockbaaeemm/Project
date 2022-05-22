package com.teamb.freenext.biz.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.freenext.biz.mapper.BizMapper;
import com.teamb.freenext.member.mapper.MemberMapper;
import com.teamb.freenext.normal.mapper.NormalMapper;
import com.teamb.freenext.scraping.mapper.ScrapingMapper;
import com.teamb.freenext.vo.AdVo;
import com.teamb.freenext.vo.JobCategoryVo;
import com.teamb.freenext.vo.ProjectBoardVo;
import com.teamb.freenext.vo.ProjectJobVo;
import com.teamb.freenext.vo.ProjectLocalVo;
import com.teamb.freenext.vo.RecruitTypeCategoryVo;
import com.teamb.freenext.vo.WorkTypeCategoryVo;

@Service
public class BizService {
	
	@Autowired
	private BizMapper bizMapper;
	
	@Autowired
	private NormalMapper normalMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private ScrapingMapper scrapinMapper;
	
	public int registProjectProcess(ProjectBoardVo vo, int[] job_no_list, int[] local_no_list, String subAd) {
		bizMapper.insertProject(vo);
		int project_no = memberMapper.getLastPK();
		
		if(job_no_list != null) {

			for(int job_no : job_no_list) {
				if(job_no == 0) continue;
				ProjectJobVo projectJobVo = new ProjectJobVo();
				projectJobVo.setProject_no(project_no);
				projectJobVo.setJob_no(job_no);
				
				bizMapper.insertProjectJob(projectJobVo);
			}			
		}
		
		if(local_no_list != null) {
			
			for(int local_no : local_no_list) {
				if(local_no == 0) continue;
				ProjectLocalVo projectLocalVo = new ProjectLocalVo();
				projectLocalVo.setProject_no(project_no);
				projectLocalVo.setLocal_no(local_no);
				
				bizMapper.insertProjectLocal(projectLocalVo);
			}
		}
		
		if(subAd != null) {
			AdVo adVo = new AdVo();
			adVo.setProject_no(project_no);
			Calendar date = Calendar.getInstance();
			date.add(Calendar.DATE, 7);			
			adVo.setAd_endDate(date.getTime());
			
			bizMapper.insertAd(adVo);
		}
		
		return project_no;
	}
	
	public ArrayList<JobCategoryVo> getJobCategoryList() {
		return bizMapper.selectJobCategory();
	}
	
	public ArrayList<WorkTypeCategoryVo> getWorkTypeCateogoryList() {
		return bizMapper.selectWorkTypeCategory();
	}
	
	public ArrayList<RecruitTypeCategoryVo> getRecruitTypeCategoryList() {
		return bizMapper.selectRecruitTypeCategory();
	}
	
	public int getProjectListCountByMemberNo(int member_no, String searchOption, String searchKeyword,
											int groupOne, int groupTwo, String state_cdT) {
		return bizMapper.selectProjectListCountByMemberNo(
				member_no, searchOption, searchKeyword, groupOne, groupTwo, state_cdT);
	}
 
	public ArrayList<HashMap<String, Object>> getProjectListByMemberNo(int member_no, String searchOption, String searchKeyword,
											int groupOne, int groupTwo, String state_cdT, int startNum)
	{

		ArrayList<ProjectBoardVo> projectBoardVoList = bizMapper.selectProjectListByMemberNo(
				member_no, searchOption, searchKeyword, groupOne, groupTwo, state_cdT, startNum);

		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		for(ProjectBoardVo projectBoardVo : projectBoardVoList) {
			HashMap<String, Object> map = new HashMap<>();
			
			map.put("projectBoardVo", projectBoardVo);				
			map.put("recruitTypeCategoryVo", normalMapper.getRecruitTypeByNo(projectBoardVo.getRecruitType_no()));
			map.put("jobCategoryVo", normalMapper.selectJobCategoryByProjectNo(projectBoardVo.getProject_no()));
			
			resultList.add(map);
		}
		return resultList;
	}
	
	public void modifyProjectProcess(ProjectBoardVo vo, int[] job_no_list, int[] local_no_list, String subAd, String doJob)
	{
		bizMapper.updateProject(vo);
		int project_no = vo.getProject_no();
		
		
		if(doJob.equals("D")) {
			bizMapper.deleteProjectJob(project_no);	
		} else {
			if(job_no_list != null) {
				for(int job_no : job_no_list) {
					if(job_no == 0) continue;
					ProjectJobVo projectJobVo = new ProjectJobVo();
					projectJobVo.setProject_no(project_no);
					projectJobVo.setJob_no(job_no);
					
					if(doJob.equals("I")) {
						bizMapper.insertProjectJob(projectJobVo);
					} else if(doJob.equals("U")) {
						bizMapper.updateProjectJob(projectJobVo);				
					}
				}			
			}
		}

		
		if(local_no_list != null) {
			
			for(int local_no : local_no_list) {
				if(local_no == 0) continue;
				ProjectLocalVo projectLocalVo = new ProjectLocalVo();
				projectLocalVo.setProject_no(project_no);
				projectLocalVo.setLocal_no(local_no);
				
				bizMapper.updateProjectLocal(projectLocalVo);
			}
		}
		
		if(subAd != null) {
			AdVo adVo = new AdVo();
			adVo.setProject_no(project_no);
			Calendar date = Calendar.getInstance();
			date.add(Calendar.DATE, 7);			
			adVo.setAd_endDate(date.getTime());
			
			bizMapper.insertAd(adVo);
		}		
	}
	
	public AdVo getProjectAd(int project_no) {
		return bizMapper.selectAdByProjectNo(project_no);
	}
	
	
	public void deleteBoard(int project_no)
	{
		bizMapper.deleteProject(project_no);
		bizMapper.deleteProjectJob(project_no);
		bizMapper.deleteProjectLocal(project_no);
		bizMapper.deleteProjectAd(project_no);
		bizMapper.deleteProjectScrap(project_no);
	}
	
	public String getKakaoKey() {
		return scrapinMapper.selectKakaoKey();
	}
	
}
