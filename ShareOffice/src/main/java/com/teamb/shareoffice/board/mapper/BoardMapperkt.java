package com.teamb.shareoffice.board.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.teamb.shareoffice.vo.AllotCouponVo;
import com.teamb.shareoffice.vo.CouponVo;
import com.teamb.shareoffice.vo.FreeBoardCommentVo;
import com.teamb.shareoffice.vo.FreeBoardVo;
import com.teamb.shareoffice.vo.QnAAnswerVo;
import com.teamb.shareoffice.vo.QnALikeVo;
import com.teamb.shareoffice.vo.QnAVo;

@Mapper
public interface BoardMapperkt {
	//게시글 등록
	public void insertFreeBoard(FreeBoardVo vo);
	//게시판 읽어오기 쿼리
	public ArrayList<FreeBoardVo> getFreeBoardList(int pageNum);
	//게시글 읽기
	public FreeBoardVo readFreeBoardRow(int freeboard_no);
	//조회수 증가
	public void increaseFreeBoardReadCount(int freeboard_no);
	//게시글 삭제
	public void deleteFreeBoardRow(int freeboard_no);
	//게시글 수정
	public void fixFreeBoardRow(FreeBoardVo vo);
	//코멘트 등록
	public void insertFreeBoardComment(FreeBoardCommentVo vo);
	//코멘트 쿼리
	public ArrayList<FreeBoardCommentVo> getFreeBoardCommentList(int freeboard_no);
	//게시판 글 갯수 쿼리
	public int getFreeBoardCount();
	//QnA 게시판 읽어오기 쿼리
	public ArrayList<QnAVo> getQnAList(int PageNum);
	//QnA 추천수 많은 순 3개 no 불러오기
	public int [] getQnALimitNo();
	//위에서 뽑은 3개 no로 3개의 행 저장하는쿼리
//	public ArrayList<QnAVo> getHotQnA(int qna_no);
	public QnAVo getHotQnA(int qna_no);
	//QnA 게시판 글 갯수 쿼리
	public int getQnACount();
	//QnA 게시판 글쓰기
	public void insertQnAWrite(QnAVo vo);
	//QnA 게시판 상세글보기
	public QnAVo readQnABoardRow(int qna_no);
	//QnA 게시판 삭제
	public void deleteQnABoardRow(int qna_no);
	//QnA 게시판 수정
	public void fixQnABoardRow(QnAVo vo);
	//QnA 답글 쓰기 
	public void insertQnAAnswer(QnAAnswerVo vo);
	//QnA 답글 읽어오기 쿼리
	public ArrayList<QnAAnswerVo> getQnAAnswerList(int qna_no);
	//답글이 있냐 없냐 확인 하는 쿼리 
	public int getCheckedQnAComment(int qna_no);
	//QnA 좋아요 인서트 
	public void insertQnALike(QnALikeVo vo);
	//QnA 좋아요 취소 인서트
	public void deleteQnALike(QnALikeVo vo);
	//QnA 좋아요 총 숫자
	public int getTotalCountLike(int qna_no);
	//특정 멤버가 좋아요를 햇는가?
	public int getMyCountLike(QnALikeVo vo);
	//쿠폰 생성 
	public void insertCoupon(CouponVo vo);
	//쿠폰리스트
	public ArrayList<CouponVo> getCouponList();
	//발급된 쿠폰수
	public int consumptionCoupon(int coupon_no);
	//쿠폰 발급
	public void insertAllotCoupon(AllotCouponVo vo);
	//보유한 쿠폰정보
	public ArrayList<AllotCouponVo> memberReserveCoupon(int member_no);
	//회원이 발급한 쿠폰정보
	public int memberReserveCoupon2(AllotCouponVo vo);
	//내 쿠폰 정보
	public ArrayList<HashMap<String, Object>> getMyCoupon(int member_no);
	
	
}
