package com.teamb.freenext.normal.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.freenext.commons.StringUtil;
import com.teamb.freenext.normal.mapper.NormalMapper;
import com.teamb.freenext.vo.CooperationCategoryVo;
import com.teamb.freenext.vo.JobCategoryVo;
import com.teamb.freenext.vo.LocalCategoryVo;
import com.teamb.freenext.vo.MemberVo;
import com.teamb.freenext.vo.MyScrapVo;
import com.teamb.freenext.vo.ProjectBoardVo;
import com.teamb.freenext.vo.RecruitTypeCategoryVo;
import com.teamb.freenext.vo.WorkTypeCategoryVo;

@Service
public class NormalService {
	
	@Autowired
	private NormalMapper normalMapper;
		
	public ArrayList<HashMap<String, Object>> getLatestProjectList() {
		
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>(); 
		
		for(ProjectBoardVo projectBoardVo : normalMapper.selectLatestProjectList()) {
			HashMap<String, Object> map = new HashMap<>();
			
			map.put("projectBoardVo", projectBoardVo);

			map.put("jobCategoryVo", normalMapper.selectJobCategoryByProjectNo(projectBoardVo.getProject_no()));
			map.put("cooperationCategoryVo", normalMapper.selectCooperationCategoryByProjectNo(projectBoardVo.getProject_no()));			
			
			resultList.add(map);			
		}
		
		return resultList;
	}
	
	public HashMap<String,Object> getProjectDetailPage(int project_no, boolean isEscape) {
		
		HashMap<String , Object> map = new HashMap<String , Object> ();
		//프리랜서 매칭, IT아웃소싱  공통 상세 페이지 페이지 가져오기
		ProjectBoardVo projectBoardVo = normalMapper.getProjectDetailPageByNo(project_no);
		if(isEscape) {
			projectBoardVo.setProject_content(StringUtil.escapeHTML(projectBoardVo.getProject_content()));
		}
		// 직종 가져오기
		JobCategoryVo jobCategoryVo  = normalMapper.selectJobCategoryByProjectNo(project_no);	
		// 지역 가져오기
		LocalCategoryVo localCategoryVo = normalMapper.getLocalByNo(project_no);
		
		//기업명 가져오기
		int memberNo = projectBoardVo.getMember_no();
		MemberVo memberVo = normalMapper.getMemberByNo(memberNo);
		
		int recruitTypeNo = projectBoardVo.getRecruitType_no();
		RecruitTypeCategoryVo recruitTypeCategoryVo = normalMapper.getRecruitTypeByNo(recruitTypeNo);
		
		int workTypeNo = projectBoardVo.getWorkType_no();
		WorkTypeCategoryVo workTypeCategoryVo = normalMapper.getWorkTypeByNo(workTypeNo);
		
		int cooperationNo = projectBoardVo.getCooperation_no();
		CooperationCategoryVo cooperationCategoryVo = normalMapper.getCooperationByNo(cooperationNo);
		
		map.put("memberVo", memberVo);
		map.put("projectBoardVo",projectBoardVo);
		map.put("jobCategoryVo", jobCategoryVo);
		map.put("localCategoryVo",localCategoryVo);	
		map.put("recruitTypeCategoryVo",recruitTypeCategoryVo);
		map.put("workTypeCategoryVo", workTypeCategoryVo);
		map.put("cooperationCategoryVo",cooperationCategoryVo);
		return map;
	}	
	
	public ArrayList<HashMap<String,Object>>getMyScrapList(int member_no, String orderBy){
		ArrayList<HashMap<String, Object>> scrapList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<MyScrapVo> memberScrapList = null;
		if(orderBy.equals("regist")) {
			memberScrapList = normalMapper.getMyScrapListOrderByRegistDate(member_no);
		} else {			
			memberScrapList = normalMapper.getMyScrapList(member_no);
		}
		
		for(MyScrapVo myScrapVo: memberScrapList ) {
			int projectNo = myScrapVo.getProject_no();
			
			ProjectBoardVo projectBoardVo = normalMapper.getProjectDetailPageByNo(projectNo); 
			
			int memberNo = myScrapVo.getMember_no();
			MemberVo memberVo = normalMapper.getMemberByNo(memberNo);
			
			CooperationCategoryVo cooperationCategoryVo = normalMapper.getCooperationByNo(projectBoardVo.getCooperation_no());
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("projectBoardVo",projectBoardVo);
			map.put("memberVo", memberVo);
			map.put("myScrapVo",myScrapVo);
			map.put("cooperationCategoryVo",cooperationCategoryVo);			
			
			scrapList.add(map);
		}				
	return scrapList;
	}
	
	public void doScrap(MyScrapVo vo) {
		int count = normalMapper.getMyScrapCount(vo);
		
		if(count>0) {
			normalMapper.deleteScrap(vo);
		}else {
			normalMapper.doScrap(vo);
		}	
	}
	
	public void deleteMyScrapByList(int scrap_no) {
		normalMapper.deleteMyScrapByList(scrap_no);
	}	
	
	public int getTotalScrapCount(int project_no) {
		return normalMapper.getTotalScrapCount(project_no);
	}
	public int getMyScrapCount(MyScrapVo vo) {
		return normalMapper.getMyScrapCount(vo);
	}	
	
	public int getProjectBoardCount(int recruitType_no,String project_state,int job_no) {
		
		return normalMapper.getProjectBoardCount(recruitType_no,project_state,job_no);
	}	
	
	public ArrayList<HashMap<String, Object>> getProjectBoardList(int recruitType_no, int pageNum,String project_state,int job_no) {
		
		ArrayList<HashMap<String, Object>> datalist = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<ProjectBoardVo> boardVoList = normalMapper.getProjectBoardList(recruitType_no, pageNum, project_state,job_no);
		
		
		for(ProjectBoardVo boardVo : boardVoList) {
			
			JobCategoryVo jobCategoryVo  = normalMapper.selectJobCategoryByProjectNo(boardVo.getProject_no());
			
			int rtCategoryNo = boardVo.getRecruitType_no();
			RecruitTypeCategoryVo rtCategoryVo = normalMapper.getRecruitTypeByNo(rtCategoryNo);
			
			int cooCategoryNo = boardVo.getCooperation_no();
			CooperationCategoryVo cooCategoryVo = normalMapper.getCooperationByNo(cooCategoryNo);
			
			int workCategoryNo = boardVo.getWorkType_no();
			WorkTypeCategoryVo workCategoryVo = normalMapper.getWorkTypeByNo(workCategoryNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("jobCategoryVo", jobCategoryVo);
			map.put("rtCategoryVo", rtCategoryVo);
			map.put("cooCategoryVo", cooCategoryVo);
			map.put("workCategoryVo", workCategoryVo);
			
			map.put("boardVo", boardVo);
			
			datalist.add(map);
		}
		
		return datalist;
	}
	
	public ArrayList<HashMap<String, Object>> getHotBoardList(int recruitType_no,String project_state,int job_no) {
		
		ArrayList<HashMap<String, Object>> datalist = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<ProjectBoardVo> boardVoList = normalMapper.getHotBoardList(recruitType_no, project_state, job_no);
		
		for(ProjectBoardVo boardVo : boardVoList) {
			
			JobCategoryVo jobCategoryVo  = normalMapper.selectJobCategoryByProjectNo(boardVo.getProject_no());
			
			int rtCategoryNo = boardVo.getRecruitType_no();
			RecruitTypeCategoryVo rtCategoryVo = normalMapper.getRecruitTypeByNo(rtCategoryNo);
			
			int cooCategoryNo = boardVo.getCooperation_no();
			CooperationCategoryVo cooCategoryVo = normalMapper.getCooperationByNo(cooCategoryNo);
			
			int workCategoryNo = boardVo.getWorkType_no();
			WorkTypeCategoryVo workCategoryVo = normalMapper.getWorkTypeByNo(workCategoryNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("jobCategoryVo", jobCategoryVo);
			map.put("rtCategoryVo", rtCategoryVo);
			map.put("cooCategoryVo", cooCategoryVo);
			map.put("workCategoryVo", workCategoryVo);
			
			map.put("boardVo", boardVo);
			
			datalist.add(map);
		}
		
		return datalist;
	}
	
	public ArrayList<HashMap<String, Object>> getMainBoardList(int recruitType_no,String project_state,int job_no){
		
		ArrayList<HashMap<String, Object>> datalist = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<ProjectBoardVo> boardVoList = normalMapper.getMainBoardList(recruitType_no, project_state, job_no);
		
		for(ProjectBoardVo boardVo : boardVoList) {
			
			JobCategoryVo jobCategoryVo  = normalMapper.selectJobCategoryByProjectNo(boardVo.getProject_no());
			
			int rtCategoryNo = boardVo.getRecruitType_no();
			RecruitTypeCategoryVo rtCategoryVo = normalMapper.getRecruitTypeByNo(rtCategoryNo);
			
			int cooCategoryNo = boardVo.getCooperation_no();
			CooperationCategoryVo cooCategoryVo = normalMapper.getCooperationByNo(cooCategoryNo);
			
			int workCategoryNo = boardVo.getWorkType_no();
			WorkTypeCategoryVo workCategoryVo = normalMapper.getWorkTypeByNo(workCategoryNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("jobCategoryVo", jobCategoryVo);
			map.put("rtCategoryVo", rtCategoryVo);
			map.put("cooCategoryVo", cooCategoryVo);
			map.put("workCategoryVo", workCategoryVo);
			
			map.put("boardVo", boardVo);
			
			datalist.add(map);
		}
		
		return datalist;
	}
	
	public ArrayList<HashMap<String, Object>> getSubAdProjectList() {
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();
		
		ArrayList<ProjectBoardVo> subAdProjectVoList = normalMapper.selectSubAdProjectList();
		for(ProjectBoardVo subAdProjectVo : subAdProjectVoList) {
			HashMap<String, Object> map = new HashMap<>();
			
			int project_no = subAdProjectVo.getProject_no();
			
			map.put("subAdProjectVo", subAdProjectVo);
			map.put("jobCategoryVo", normalMapper.selectJobCategoryByProjectNo(project_no));
			map.put("cooperationCategoryVo", normalMapper.selectCooperationCategoryByProjectNo(project_no));
			
			resultList.add(map);
		}
		
		return resultList;
	}	
}
