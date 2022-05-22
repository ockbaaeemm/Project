package com.teamb.shareoffice.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamb.shareoffice.board.service.BoardServicekt;
import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.QnAAnswerVo;
import com.teamb.shareoffice.vo.QnALikeVo;

@Controller
@RequestMapping("/admin/*")
public class AdminControllerRN {

	@Autowired
	private BoardServicekt boardServicekt;
	
	//QnA 
	@RequestMapping("QnAPage")
	public String QnAPage(Model model, HttpSession session,
			@RequestParam(value = "pageNum" , defaultValue = "1") int pageNum) {
		
		ArrayList<HashMap<String, Object>> QnABoardList = boardServicekt.getQnAList(pageNum);
		
		ArrayList<HashMap<String, Object>> hotQnAVoList = boardServicekt.getHotQnAList();
		
		int count = boardServicekt.getQnACount();
			
	    int totalPageCount = (int)Math.ceil(count/10.0);
		
		// 1 2 3 4 5 , 6 7 8 9 10
	    int startPage = ((pageNum-1)/5)*5 + 1;
		int endPage = ((pageNum-1)/5 + 1)*(5);
		if(endPage > totalPageCount){
			endPage = totalPageCount;
		}

		model.addAttribute("hotQnAVoList", hotQnAVoList);
		model.addAttribute("count", count);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("QnABoardList", QnABoardList);
		 
		
		return "admin/QnAPage";
	}
	
	@RequestMapping("QnAReadPage")
	public String QnAReadPage(int qna_no, Model model, HttpSession session) {
		 
		HashMap<String, Object> readQnABoardRow = boardServicekt.readQnABoardRow(qna_no);
		ArrayList<HashMap<String, Object>> authorList = boardServicekt.getQnAAnswerList(qna_no);
		//좋아요 ;;
		int totalLikeCount = boardServicekt.getTotalCountLike(qna_no);
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			
			int memberNo = sessionUser.getMember_no();
			QnALikeVo qnALikeVo = new QnALikeVo();
			qnALikeVo.setMember_no(memberNo);
			qnALikeVo.setQna_no(qna_no);
			
			int myLikeCount = boardServicekt.getMyCountLike(qnALikeVo);
			model.addAttribute("myLikeCount", myLikeCount);
		}
		
		model.addAttribute("totalLikeCount", totalLikeCount);
		model.addAttribute("readQnABoardRow", readQnABoardRow);
		model.addAttribute("answerList", authorList);
		return "admin/QnAReadPage";
	}
	
	@RequestMapping("QnAAnswerWriteProcess")
	public String QnAAnswerWriteProcess(QnAAnswerVo param, HttpSession session) {
		AdminVo adminSession = (AdminVo) session.getAttribute("adminUser");		
		
		if(adminSession != null) {
			param.setAdmin_no(adminSession.getAdmin_no());
		} 
		/*MemberVo memberSession = (MemberVo) session.getAttribute("sessionUser");
		if(memberSession != null) {
			param.setMember_no(memberSession.getMember_no());	
		}*/				
		
		boardServicekt.insertQnAAnswer(param);
		
		return "redirect:../admin/QnAReadPage?qna_no=" + param.getQna_no();
	}
	
	
	@RequestMapping("deleteQnAContentProcess")
	public String deleteQnAContentProcess(int qna_no) {
		
		boardServicekt.deleteQnABoardRow(qna_no);
		
		return "redirect:../admin/QnAPage";
	}	
}
