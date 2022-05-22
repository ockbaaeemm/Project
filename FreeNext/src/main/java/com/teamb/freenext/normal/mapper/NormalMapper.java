package com.teamb.freenext.normal.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.teamb.freenext.vo.CooperationCategoryVo;
import com.teamb.freenext.vo.JobCategoryVo;
import com.teamb.freenext.vo.LocalCategoryVo;
import com.teamb.freenext.vo.MemberVo;
import com.teamb.freenext.vo.MyScrapVo;
import com.teamb.freenext.vo.ProjectBoardVo;
import com.teamb.freenext.vo.RecruitTypeCategoryVo;
import com.teamb.freenext.vo.WorkTypeCategoryVo;

@Mapper
public interface NormalMapper {
	// 메인페이지에 출력되는 데이터 가져오기
	public ArrayList<ProjectBoardVo> selectLatestProjectList();
	public JobCategoryVo selectJobCategoryByProjectNo(int project_no);
	public CooperationCategoryVo selectCooperationCategoryByProjectNo(int project_no);
	
    //프리랜서 매칭, IT아웃소싱 상세 페이지 페이지 가져오기
	public ProjectBoardVo getProjectDetailPageByNo(int project_no) ;
	
	// 스크랩 리스트(스크랩순, 최신등록순)
	public ArrayList<MyScrapVo>getMyScrapList(int member_no);
	public ArrayList<MyScrapVo> getMyScrapListOrderByRegistDate(int member_no);
	
	//스크랩 하기
	public void doScrap(MyScrapVo vo);
	public void deleteScrap(MyScrapVo vo);
	public int getTotalScrapCount(int project_no);
	public int getMyScrapCount(MyScrapVo vo);	
	// 프로젝트 리스트에서 스크랩 삭제
	public void deleteMyScrapByList(int scrap_no);
	//지역 가져오기
	public LocalCategoryVo getLocalByNo(int project_no);
	
	//회원정보 가져오기
	public MemberVo getMemberByNo(int member_no);
	//모집형태 가져오기
	public RecruitTypeCategoryVo getRecruitTypeByNo(int recruitType_no);
	//근무형태 가져오기
	public WorkTypeCategoryVo getWorkTypeByNo(int workType_no);
	//협력사 가져오기
	public CooperationCategoryVo getCooperationByNo(int cooperation_no);
	
	// 프로젝트 리스트 가져오기
	/*public ArrayList<ProjectBoardVo> getProjectBoardList(
			@Param("recruitType_no") int recruitType_no, 
			@Param("pageNum") int pageNum, 
			@Param("project_state") String project_state);*/
	
	// 프로젝트 리스트 가져오기
	public ArrayList<ProjectBoardVo> getProjectBoardList(
			int recruitType_no, 
			@Param("pageNum") int pageNum, 
			String project_state,
			int job_no);	
	
	public ArrayList<ProjectBoardVo> selectSubAdProjectList();
	
	/*public int getProjectBoardCount(@Param("recruitType_no") int recruitType_no,
									@Param("project_state") String project_state);*/
	
	public int getProjectBoardCount(int recruitType_no,String project_state,int job_no);
	
	public ArrayList<ProjectBoardVo> getHotBoardList(
			int recruitType_no,
			String project_state,
			int job_no);
	
	public ArrayList<ProjectBoardVo> getMainBoardList(
			int recruitType_no,
			String project_state,
			int job_no);	
}
