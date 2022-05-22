package com.teamb.shareoffice.board.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.teamb.shareoffice.board.service.BoardServicekt;
import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.AllotCouponVo;
import com.teamb.shareoffice.vo.CouponVo;
import com.teamb.shareoffice.vo.FreeBoardCommentVo;
import com.teamb.shareoffice.vo.FreeBoardVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.QnAAnswerVo;
import com.teamb.shareoffice.vo.QnALikeVo;
import com.teamb.shareoffice.vo.QnAVo;

@Controller
@RequestMapping("/board/*")
public class BoardControllerkt {

	@Autowired
	private BoardServicekt boardServicekt;
	
	@RequestMapping("test")
	public String test() {
		
		return "board/test";
	}
	
	@RequestMapping("freeBoardPage")
	public String freeBoardPage(Model model,
			@RequestParam(value = "pageNum" , defaultValue = "1") int pageNum) {
		
		ArrayList<HashMap<String, Object>> freeBoardList = boardServicekt.getFreeBoardList(pageNum);
		
		int count = boardServicekt.getFreeBoardCount();
		
		int totalPageCount = (int)Math.ceil(count/10.0);
		
		int startPage = ((pageNum-1)/5)*5 + 1;
		int endPage = ((pageNum-1)/5 + 1)*(5);
		if(endPage > totalPageCount){
			endPage = totalPageCount;
		}
		
		
		model.addAttribute("count", count);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("freeBoardList", freeBoardList);
		
		return "board/freeBoardPage"; 
	}
	
	@RequestMapping("freeBoardWritePage")
	public String freeBoardWritePage() {
		
		return "board/freeBoardWritePage";
	}
	
	@RequestMapping("freeBoardWriteProcess")
	public String freeBoardWriteProcess(FreeBoardVo param, HttpSession session, MemberVo param2) {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("sessionUser");
		param.setMember_no(memberVo.getMember_no());
		
		boardServicekt.insertFreeBoard(param);
		
		return "redirect:./freeBoardPage";
	}
	@RequestMapping("freeBoardReadPage")
	public String freeBoardReadPage(int freeboard_no, Model model) {
		boardServicekt.increaseFreeBoardReadCount(freeboard_no);
		
		HashMap<String, Object> map = boardServicekt.readFreeBoardRow(freeboard_no);
		//코멘트 값 가져오기
		ArrayList<HashMap<String, Object>> freeBoardCommentList = boardServicekt.getFreeBoardCommentList(freeboard_no);

		model.addAttribute("data", map);	
		model.addAttribute("freeBoardCommentList", freeBoardCommentList);
		
		return "board/freeBoardReadPage";
	}
	
	@RequestMapping("deleteContentProcess")
	public String deleteContentProcess(int freeboard_no) {
		
		boardServicekt.deleteFreeBoardRow(freeboard_no);
		
		return "redirect:./freeBoardPage";
	}
	
	@RequestMapping("updateFreeBoardPage")
	public String updateFreeBoard(int freeboard_no, Model model) {
		HashMap<String, Object> map = boardServicekt.readFreeBoardRow(freeboard_no);
		model.addAttribute("data" , map);
		
		
		return "board/updateFreeBoardPage";
	}
	
	@RequestMapping("updateFreeBoardProcess")
	public String updateFreeBoardProcess(FreeBoardVo param) {
		
		boardServicekt.fixFreeBoardRow(param);
		
		return "redirect:./freeBoardReadPage?freeboard_no=" + param.getFreeboard_no();
	}
	
	@RequestMapping("freeBoardCommentWriteProcess")
	public String freeBoardCommentWriteProcess(FreeBoardCommentVo param,HttpSession session, Model model) {
	
		MemberVo memberVo = (MemberVo)session.getAttribute("sessionUser");
		param.setMember_no(memberVo.getMember_no());
		
		//코멘트 등록
		boardServicekt.insertFreeBoardComment(param);

		
		return "redirect:./freeBoardReadPage?freeboard_no=" + param.getFreeboard_no();
	
	}
	

	
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
		 
		
		return "board/QnAPage";
	}
	
	@RequestMapping("QnAWritePage")
	public String QnAWritePage() {
		
		return "board/QnAWritePage";
	}
	
	@RequestMapping("QnAWriteProcess")
	public String QnAWriteProcess (QnAVo param, HttpSession session) {
		
		MemberVo memberSession = (MemberVo)session.getAttribute("sessionUser");
		param.setMember_no(memberSession.getMember_no());
		
		boardServicekt.insertQnAWrite(param);
		
		return "redirect:./QnAPage";
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
		return "board/QnAReadPage";
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
		
		return "redirect:./QnAReadPage?qna_no=" + param.getQna_no();
	}
	
	
	@RequestMapping("deleteQnAContentProcess")
	public String deleteQnAContentProcess(int qna_no) {
		
		boardServicekt.deleteQnABoardRow(qna_no);
		
		return "redirect:./QnAPage";
	}
	
	@RequestMapping("updateQnAPage")
	public String updateQnAPage(int qna_no, Model model) {
		HashMap<String, Object> map = boardServicekt.readQnABoardRow(qna_no);

		model.addAttribute("data", map);
	
		return "board/updateQnAPage";
	}
	@RequestMapping("fixQnAProcess")
	public String fixQnAProcess(QnAVo param) {
		boardServicekt.fixQnABoardRow(param);
		return "redirect:./QnAReadPage?qna_no=" + param.getQna_no();
	}
	@RequestMapping("likeProcess")
	public String likeProcess(QnALikeVo param, HttpSession session) {
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int memberNo = sessionUser.getMember_no();
		param.setMember_no(memberNo);
		
		boardServicekt.likeOrCancle(param);
		
		return "redirect:./QnAReadPage?qna_no=" + param.getQna_no();
	}
	// 생성된 쿠폰 
	@RequestMapping("createdCouponListPage")
	public String createdCouponListPage(Model model) {
		
		
		model.addAttribute("CouponVo", boardServicekt.getCouponList(0)); 
		
		
		return "board/createdCouponListPage";
		
	}
	// 관리자 쿠폰 생성 페이지
	@RequestMapping("createCouponPage")
	public String createCouponPage() {
	
		return "board/createCouponPage";
		
	}
	
	
	@RequestMapping("createCouponProcess") 
	public String createCouponProcess(CouponVo param, MultipartFile image, HttpSession session) {
		String uploadFolder = "C:/shareOffice/couponImage/"; 
			System.out.println("이미지이름" + image.getOriginalFilename());
			if(!image.isEmpty()) {
			
			//날짜별 폴더 생성...
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/"); 
			String folderPath = sdf.format(today);
			
			File todayFolder = new File(uploadFolder + folderPath); 
			
			String imgName = "";
			
			
			if(!todayFolder.exists()) {
				
				todayFolder.mkdirs();
			}
			
			String oriImgName = image.getOriginalFilename();
	
			// random uuid + 현재시간 + 확장자
			UUID uuid = UUID.randomUUID();
			uuid = UUID.randomUUID();
			imgName += (uuid.toString() + oriImgName.substring(oriImgName.lastIndexOf(".")));
			
			try {
				image.transferTo(new File(uploadFolder + folderPath + imgName));
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			param.setCoupon_image(folderPath + imgName);
		
		}
		AdminVo adminVo = (AdminVo)session.getAttribute("AdminUser");
		if(adminVo != null) {
			param.setAdmin_no(adminVo.getAdmin_no());
		}
		boardServicekt.insertCoupon(param);	
		
		return "redirect:./createdCouponListPage";
	}
	// 사용자 쿠폰 발급 하는 페이지
	@RequestMapping("couponListPage")
	public String couponListPage(Model model, HttpSession session) {
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		if(sessionUser != null) {
//			ArrayList<HashMap<String, Object>> reserveCoupon = boardServicekt.getCouponList(sessionUser.getMember_no());
			//생성된 유저 쿠폰 정보 
//			model.addAttribute("reserveCouponList", reserveCoupon);
			//생성된 쿠폰 리스트
			model.addAttribute("CouponVo", boardServicekt.getCouponList(sessionUser.getMember_no())); 
		}
		
		return "board/couponListPage";
		
	}
	@RequestMapping("getCouponProcess")
	public String getCouponProcess(AllotCouponVo param) {
		boardServicekt.insertAllotCoupon(param);
		
		return "redirect:./couponListPage";
	}
	
	@RequestMapping("myCouponPage")
	public String myCouponPage(Model model, HttpSession session) {
		
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			int memberNo = sessionUser.getMember_no();
			model.addAttribute("myCouponList", boardServicekt.getMyCoupon(memberNo));
		}
		
		
		return "board/myCouponPage";
	}
	
	
	
}


