package com.teamb.shareoffice.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.admin.mapper.AdminMapper;
import com.teamb.shareoffice.board.mapper.BoardMapperkt;
import com.teamb.shareoffice.member.mapper.MemberMapperkt;
import com.teamb.shareoffice.vo.AdminVo;
import com.teamb.shareoffice.vo.AllotCouponVo;
import com.teamb.shareoffice.vo.CouponVo;
import com.teamb.shareoffice.vo.FreeBoardCommentVo;
import com.teamb.shareoffice.vo.FreeBoardVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.QnAAnswerVo;
import com.teamb.shareoffice.vo.QnALikeVo;
import com.teamb.shareoffice.vo.QnAVo;

@Service
public class BoardServicekt {
	
	private static final int HashMap = 0;
	@Autowired
	private BoardMapperkt boardMapperkt;
	@Autowired
	private MemberMapperkt memberMapperkt;
	@Autowired
	private AdminMapper adminMapper;
	
	public ArrayList<HashMap<String, Object>> getFreeBoardList(int pageNum){
		
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String, Object>>(); 
		pageNum = ((pageNum - 1) * 10);
		
		ArrayList<FreeBoardVo> freeBoardList = boardMapperkt.getFreeBoardList(pageNum);
		
		for(FreeBoardVo freeBoardVo : freeBoardList) {
			
			int memberNo = freeBoardVo.getMember_no();
			MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);

			HashMap<String, Object> addList = new HashMap<String, Object>();
			addList.put("freeBoardVo", freeBoardVo);
			addList.put("memberVo", memberVo);
			
			dataList.add(addList);
			
		}
		
		return dataList;
	}

	public void insertFreeBoard(FreeBoardVo vo) {
		boardMapperkt.insertFreeBoard(vo);
	}
	
	public HashMap<String, Object> readFreeBoardRow(int freeboard_no) {
		HashMap<String, Object> result = new HashMap<String, Object>(); 
		
		FreeBoardVo freeBoardRow = boardMapperkt.readFreeBoardRow(freeboard_no);
		int member_no = freeBoardRow.getMember_no();
		MemberVo memberVo = memberMapperkt.getMemberByNo(member_no);
		
		result.put("freeBoardVo", freeBoardRow);
		result.put("memberVo", memberVo);
	
		return result;
	}
	
	public void increaseFreeBoardReadCount(int freeboard_no) {
		boardMapperkt.increaseFreeBoardReadCount(freeboard_no);
	}
	
	public void deleteFreeBoardRow(int freeboard_no) {
		boardMapperkt.deleteFreeBoardRow(freeboard_no);
	}
	
	public void fixFreeBoardRow(FreeBoardVo vo) {
		boardMapperkt.fixFreeBoardRow(vo);
	}
	
	public void insertFreeBoardComment(FreeBoardCommentVo vo) {
		boardMapperkt.insertFreeBoardComment(vo);
	}
	
	public ArrayList<HashMap<String, Object>> getFreeBoardCommentList(int freeboard_no){
		
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String, Object>>(); 
		
		ArrayList<FreeBoardCommentVo> freeBoardCommentList = boardMapperkt.getFreeBoardCommentList(freeboard_no);
		
		for(FreeBoardCommentVo freeBoardCommentVo : freeBoardCommentList) {
			
			int memberNo = freeBoardCommentVo.getMember_no();
			MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);
			
			HashMap<String, Object> addList = new HashMap<String, Object>();
			addList.put("freeBoardCommentVo", freeBoardCommentVo);
			addList.put("memberVo", memberVo);
			
			dataList.add(addList);
			
		}
		
		return dataList;
	}
	
	public int getFreeBoardCount() {

		return boardMapperkt.getFreeBoardCount();
	}
	
	
	public ArrayList<HashMap<String, Object>> getQnAList(int pageNum){
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String, Object>>(); 

		pageNum = ((pageNum - 1) * 10);
		ArrayList<QnAVo> QnAList = boardMapperkt.getQnAList(pageNum);
		for(QnAVo QnABoardVo : QnAList) {
			
			int memberNo = QnABoardVo.getMember_no();
			MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);
			
			HashMap<String, Object> addList = new HashMap<String, Object>();
			
			int chkNum = boardMapperkt.getCheckedQnAComment(QnABoardVo.getQna_no());
			
			addList.put("CheckedQnAComment", chkNum);
			addList.put("QnABoardVo", QnABoardVo);
			addList.put("memberVo", memberVo);
			
			dataList.add(addList);
		}

		return dataList;
	}

	public ArrayList<HashMap<String, Object>> getHotQnAList(){
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		int [] hotQnAList = boardMapperkt.getQnALimitNo();
		for(int hotQnANumber : hotQnAList) {
			HashMap<String, Object> hotQnAVo = new HashMap<String, Object>();
			
			hotQnAVo.put("QnAVo", boardMapperkt.getHotQnA(hotQnANumber));
			hotQnAVo.put("getCheckedQnAComment", boardMapperkt.getCheckedQnAComment(hotQnANumber));
			
			list.add(hotQnAVo);
		}
		return list;
	}
	
	
	public int getQnACount() {

		return boardMapperkt.getQnACount();
	}
	
	public void insertQnAWrite(QnAVo vo) {
		
		boardMapperkt.insertQnAWrite(vo);
		
	}
	
	public void insertQnAAnswer(QnAAnswerVo vo) {

		boardMapperkt.insertQnAAnswer(vo);
		
	}
	
	public ArrayList<HashMap<String, Object>> getQnAAnswerList(int qna_no){
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<QnAAnswerVo> QnAAnswerVo = boardMapperkt.getQnAAnswerList(qna_no);		
		
		for(QnAAnswerVo qnAAnswerVo : QnAAnswerVo) {
			HashMap<String, Object> data = new HashMap<String, Object>();
			//관리자만 댓글 쓸수있음 수정
			int adminNo = qnAAnswerVo.getAdmin_no();

			int memberNo = qnAAnswerVo.getMember_no();
			if(memberNo != 0) {
			
				MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);
				String member_nick = memberVo.getMember_nick();
				data.put("author", member_nick);
			}else {
				AdminVo adminVo = adminMapper.getAdminByNo(adminNo);
				String admin_name = adminVo.getAdmin_name();
				data.put("author", admin_name);
			}
			data.put("QnAAnswerVo", qnAAnswerVo);

			dataList.add(data);
		}
		
		
		
		return dataList;
			
	}
	public HashMap<String, Object> readQnABoardRow(int qna_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		QnAVo readQnABoardRow = boardMapperkt.readQnABoardRow(qna_no);
		int memberNo = readQnABoardRow.getMember_no();
		MemberVo memberVo = memberMapperkt.getMemberByNo(memberNo);
		
		map.put("QnAVo", readQnABoardRow);
		map.put("MemberVo", memberVo);
		
		return map;
	}
	
	public void deleteQnABoardRow(int qna_no) {
		boardMapperkt.deleteQnABoardRow(qna_no);
	}
	
	public void fixQnABoardRow(QnAVo vo) {
		boardMapperkt.fixQnABoardRow(vo);
	}
	
	public void likeOrCancle(QnALikeVo vo) {
		
		int count = boardMapperkt.getMyCountLike(vo);
		
		if(count > 0) {
			boardMapperkt.deleteQnALike(vo);
		}else {
			boardMapperkt.insertQnALike(vo);
		}
	}
	
	public int getTotalCountLike(int qna_no) {
		
		return boardMapperkt.getTotalCountLike(qna_no);
	}
	
	public int getMyCountLike(QnALikeVo vo) {
		
		return boardMapperkt.getMyCountLike(vo);
	}
	
	public void insertCoupon(CouponVo vo) {
		boardMapperkt.insertCoupon(vo);
	}
	public ArrayList<HashMap<String, Object>> getCouponList(int member_no) {
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<CouponVo> CouponVoList = boardMapperkt.getCouponList();
		for(CouponVo couponVo : CouponVoList) {
			
			
			int count = boardMapperkt.consumptionCoupon(couponVo.getCoupon_no());
			
			HashMap<String, Object> data = new HashMap<String, Object>();
			
			
			
			AllotCouponVo allotCouponVo = new AllotCouponVo();
			allotCouponVo.setMember_no(member_no);
			allotCouponVo.setCoupon_no(couponVo.getCoupon_no());
			int myReserveCouponCount = boardMapperkt.memberReserveCoupon2(allotCouponVo);
			
			
			data.put("myReserveCouponCount", myReserveCouponCount);
			data.put("CouponVoList", couponVo);
			data.put("waste",count);
			dataList.add(data);
		}
		return dataList;
	}
	
	public void insertAllotCoupon(AllotCouponVo vo) {
		boardMapperkt.insertAllotCoupon(vo);
		
	}
	
	public ArrayList<HashMap<String, Object>> getMemberReserveCoupon(int member_no){
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<AllotCouponVo> allotCouponVoList = boardMapperkt.memberReserveCoupon(member_no); 
		for(AllotCouponVo allotCouponVo : allotCouponVoList) {
			
			HashMap<String, Object> data = new HashMap<String, Object>();
			
			data.put("AllotCouponVo", allotCouponVo);
			dataList.add(data);
		}
		
		
		return dataList;
	}
	
	public ArrayList<HashMap<String, Object>> getMyCoupon(int member_no){
		 ArrayList<HashMap<String, Object>> dataList = new  ArrayList<HashMap<String, Object>>();
		 
		 ArrayList<HashMap<String, Object>> myCouponVoList = boardMapperkt.getMyCoupon(member_no);
		 
		 	for(HashMap<String, Object> myCoupon : myCouponVoList) {
		 		HashMap<String, Object> data = new HashMap<String, Object>();
		 		
		 		data.put("myCouponVo", myCoupon);
		 		
		 		dataList.add(data);
		 	}
		 
		 return dataList;
		
	}

	
}
