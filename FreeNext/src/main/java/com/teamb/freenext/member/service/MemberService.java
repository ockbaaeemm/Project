package com.teamb.freenext.member.service;

import java.security.MessageDigest;
import java.util.*;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
//import org.thymeleaf.spring5.SpringTemplateEngine;

import com.teamb.freenext.member.mapper.MemberMapper;
import com.teamb.freenext.vo.*;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	/*@Autowired
	private SpringTemplateEngine templateEngine;*/	
	
	//회원중복검사
	public int isExistMember(MemberVo mvo) {
		
		return memberMapper.getCountDuplicationMember(mvo);
	}	
	
	//회원가입
	public void joinMember(MemberVo mvo, MemberCustomerVo mcvo, int [] job_no, int [] local_no) {
		
		memberMapper.insertMember(mvo);
		int memberNo = memberMapper.getLastPK();
		memberMapper.insertMemberCustomerInfo(mcvo);
		int customerNo = memberMapper.getLastPK();
		String member_name = mvo.getMember_name();
		String member_email = mvo.getMember_email();
		
		
		//메일 인증 관련
		UUID uuid = UUID.randomUUID();
		String authKey = uuid.toString();
		
		MailAuthVo mailAuthVo = new MailAuthVo();
		mailAuthVo.setMailauth_key(authKey);
		mailAuthVo.setMember_no(memberNo);
		
		memberMapper.insertMailAuth(mailAuthVo);
		
		//메일 인증 메일 전송
		
		MimeMessage message = javaMailSender.createMimeMessage();
		
		String msgg ="";
		msgg += "<a href='http://localhost:8181/member/mailAuthProcess?authKey="+authKey+"'>메일 인증하기</a>";
		
		try {
			message.addRecipients(MimeMessage.RecipientType.TO, member_email);
			message.setSubject("[FreeNext | 국내 최대 IT아웃소싱 플랫폼] " + member_name + "님 이메일 인증 링크입니다.");
			message.setText(msgg, "utf-8", "html");
			//보내는 사람 이름 설정
	        message.setFrom(new InternetAddress("pubosstest@gmail.com", "FreeNext"));
		} catch (Exception e) {
			System.out.println("메일 발송 익셉션]" + e.getMessage());
		}

		
		javaMailSender.send(message);
		
		if(job_no != null) {
			for(int jcNo : job_no) {
				if(jcNo != 0) {
					CustomerJobVo jVo = new CustomerJobVo();
					jVo.setCustomer_no(customerNo);
					jVo.setJob_no(jcNo);
					memberMapper.insertCustomerJob(jVo);
				}
			}
		}
		
		if(local_no != null) {
			for(int lcNo : local_no) {
				if(lcNo != 0) {
					CustomerLocalVo lcVo = new CustomerLocalVo();
					lcVo.setCustomer_no(customerNo);
					lcVo.setLocal_no(lcNo);
					memberMapper.insertCustomerLocal(lcVo);
				}
			}
		}
		
	}
	
	//메일 인증 완료시 MailAuth 테이블 업데이트
	public void authMail(String key) {
		
		memberMapper.updateMailAuthComplete(key);
	}
	
	//아이디 중복검사
	public boolean isExistId(String member_id) {
		int count = memberMapper.getCountById(member_id);
		
		if(count > 0) {
			return true;
		} else {
			return false;
		}
		
	}
	
	//아이디찾기
	public MemberVo findId(MemberVo vo){
		
		return memberMapper.findIdByNameAndPhone(vo);
	}
	
	//찾은 아이디 갯수
	public int getCountFindId(MemberVo vo) {
		
		return memberMapper.getCountFindId(vo);
	}
	
	//찾은 비밀번호 갯수(예외처리 관련)
		public MemberVo findPw(MemberVo vo) {
			
			return memberMapper.findPwByIdAndNameAndPhone(vo);
		}
	
	//임시Pw 메일 전송
	public void temporaryPwSendMail(MemberVo mvo) {
		
		String member_id = mvo.getMember_id();
		String member_name = mvo.getMember_name();
		String member_email = mvo.getMember_email();
		String member_pw = mvo.getMember_pw();
		
		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
		
		simpleMailMessage.setTo(member_email);
		simpleMailMessage.setSubject("[FreeNext | 국내 최대 IT아웃소싱 플랫폼] " + member_id + " 님 임시 비밀번호가 생성되었습니다.");
		simpleMailMessage.setText(member_name + "(" + member_id + ")고객님의 임시 비밀번호는 다음과 같습니다. \r\n 임시 비밀번호 : " + member_pw);
		
		javaMailSender.send(simpleMailMessage);
		
	}
	
	//기존Pw -> 임시 Pw
	public void changeToTemporaryPw(MemberVo mvo) {
		memberMapper.changeToTemporaryPw(mvo);
	}
	
	public MemberVo getMemberInfo(MemberVo vo) {
		
		return memberMapper.getMemberInfoByIdAndNameAndPhone(vo);
	}
	
	public MemberCustomerVo getCustomerInfo(int member_no) {
		
		return memberMapper.getCustomerInfoByMemberNo(member_no);
	}	
	
	//회원가입
	/*public void joinMember(MemberVo mvo, MemberCustomerVo mcvo, int [] job_no, int [] local_no) {
		memberMapper.insertMember(mvo);
		memberMapper.insertMemberCustomerInfo(mcvo);
		
		
		int customerNo = memberMapper.getLastPK();
		
		if(job_no != null) {
			for(int jcNo : job_no) {
				if(jcNo == 0) continue;
				CustomerJobVo jVo = new CustomerJobVo();
				jVo.setCustomer_no(customerNo);
				jVo.setJob_no(jcNo);
				memberMapper.insertCustomerJob(jVo);
			}
		}
		
		if(local_no != null) {
			for(int lcNo : local_no) {
				if(lcNo == 0) continue;
				CustomerLocalVo lcVo = new CustomerLocalVo();
				lcVo.setCustomer_no(customerNo);
				lcVo.setLocal_no(lcNo);
				memberMapper.insertCustomerLocal(lcVo);
			}
		}
		
	}
	
	// 아이디 중복확인
	public boolean isExistId(String member_id) {
		int count = memberMapper.getCountById(member_id);
		
		if(count > 0) {
			return true;
		} else {
			return false;
		}
		
	}*/	
	
	//직종, 희망지역 카테고리 리스트
	public ArrayList<JobCategoryVo> getJobCategoryList(){
		return memberMapper.getJobCategoryList();
	}
	
	public ArrayList<LocalCategoryVo> getLocalCategoryList(){
		return memberMapper.getLocalCategoryList();
	}
	
	public MemberVo login(MemberVo vo, boolean doHashing) {
		
		
		if(doHashing) {
			String password = vo.getMember_pw();
			password = getPasswordHashCode(password);
			vo.setMember_pw(password);
		}
		
		MemberVo result = memberMapper.loginByIdAndPw(vo);
		
		return result;
	}	
	
	public int mailAuthCheck(int member_no) {
		
		return memberMapper.checkMailAuthByMemberNo(member_no);
	}	
	
	public void insertMember(MemberVo vo) {
		
		String password = vo.getMember_pw();
		password = getPasswordHashCode(password);
		vo.setMember_pw(password);		
		
		memberMapper.insertMember(vo);
	}
	
	// 기업회원 서비스	
	public void insertBizMember(MemberCompanyVo vo) {
		int memberNo = memberMapper.getLastPK();
		vo.setMember_no(memberNo);
		memberMapper.insertBizMember(vo);
	}
	
	public MemberVo getBizIdCheck(MemberVo vo) {
		MemberVo result = memberMapper.getBizIdCheck(vo);
		return result;
	}
	
	public MemberVo getBizPwCheck(MemberVo vo) {
		MemberVo result = memberMapper.getBizPwCheck(vo);
		
		return result;		
	}
	
	//메일전송
	public void sendMail(MemberVo vo) {
		
		UUID uuid = UUID.randomUUID();
		String newPw = uuid.toString();
		newPw = newPw.substring(0, 6);
		
		String newPwDb = getPasswordHashCode(newPw);
		
		vo.setMember_pw(newPwDb);
		
		
		//비번 업데이트
		memberMapper.bizNewPw(vo);
		
		//찾는 회원의 이메일 주소
		String mail = vo.getMember_email();
		
		
		//수신 대상을 담을 arrayList 생성
		ArrayList<String> toUserList = new ArrayList<String>();
		
		//수신 대상 추가
		toUserList.add(mail);
		
		//수신 대상 개수
		int toUserSize = toUserList.size();
		
		//SimpleMailMessage (단순 텍스트 구성 메일 메시지 생성시 이용)
		SimpleMailMessage simpleMessage = new SimpleMailMessage();
		
		//수신자 설정
		simpleMessage.setTo((String[]) toUserList.toArray(new String[toUserSize]));
		
		//메일 제목
		simpleMessage.setSubject("freenext 비밀번호가 변경 되었습니다.");
		
		//메일 내용
		simpleMessage.setText("새로운 비밀번호는" + newPw + "입니다.<br> 로그인후 비밀번호를 변경해주세요" );
		
		//메일 발송
			JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
			javaMailSender.setHost("smtp.gmail.com");
			javaMailSender.setPort(587);
			javaMailSender.setUsername("pubosstest");
			javaMailSender.setPassword("syadtqvmsktofcnu");
			//...
			
			Properties javaMailProperties = new Properties();
			javaMailProperties.put("mail.transport.protocol", "smtp");
			javaMailProperties.put("mail.smtp.auth", true);
			javaMailProperties.put("mail.smtp.starttls.enable", true );
			javaMailProperties.put("mail.debug", false );
			javaMailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com" );
			javaMailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2" );
			//...
			javaMailSender.setJavaMailProperties(javaMailProperties);

			javaMailSender.send(simpleMessage);

	}
	
	public String getPasswordHashCode(String pw) {
		
		pw = pw + "!(-_-)!*(>_<)*";
		
		String hashCode = null;
		
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.reset();
			messageDigest.update(pw.getBytes("utf-8"));
			//hash값 생성
			byte [] chars = messageDigest.digest();
			
			StringBuilder sb = new StringBuilder();
			for(int i=0; i< chars.length; i++) {
				String tmp = Integer.toHexString(chars[i] & 0xff);
				
				if(tmp.length() == 1) {
					sb.append("0");
				}
				
				sb.append(tmp);
				
				hashCode = sb.toString();
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return hashCode;
	}	
		
}
