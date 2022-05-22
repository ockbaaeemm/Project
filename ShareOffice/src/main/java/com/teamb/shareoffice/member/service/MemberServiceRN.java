package com.teamb.shareoffice.member.service;

import java.util.*;
import java.util.Base64.Decoder;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamb.shareoffice.guest.mapper.GuestMapper_H;
import com.teamb.shareoffice.member.mapper.MemberMapperRN;
import com.teamb.shareoffice.vo.HostVo;
import com.teamb.shareoffice.vo.MemberVo;

@Service
public class MemberServiceRN {
	
	@Autowired
	private MemberMapperRN memberMapper;
	
	@Autowired
	private GuestMapper_H guestMapperH;

	public String getJSKey() {
		try {
            byte[] jsTarget = "iC4Lr6MNcH6U4SV8u6KrLD6GjxG601FHAiZBm1MZXgyOZM6HPxdNuyQj/NgUWA4V".getBytes();
            byte[] jsKey = "abcdefghijklmnop".getBytes();
            
            SecretKeySpec keySpec = null;
        	
            keySpec = new SecretKeySpec(jsKey, "AES");
        	Cipher cipher = null;

        	cipher = Cipher.getInstance("AES");

        	cipher.init(Cipher.DECRYPT_MODE, keySpec);

    		Decoder encoder = Base64.getDecoder(); 
    		
    		return(new String(cipher.doFinal(encoder.decode(jsTarget))));
    		
    	} catch (Exception e) {
    		System.out.println("exception]" + e.getMessage());
        }
		
		return null;
	}
	
	public String getKakaoKey() {
		try {
            
            byte[] kakaoTarget = "est2MXw786x2LIfT6FJEoo75nS5CG34FiIF70nyQY6TJxuNk1WYSWOwxOFewvfZp".getBytes();
            byte[] kakaoKey = "axmthlthijklmqlt".getBytes();
            
            SecretKeySpec keySpec = null;
        	
        	keySpec = new SecretKeySpec(kakaoKey, "AES");
        	Cipher cipher = null;

    		cipher = Cipher.getInstance("AES");

    		cipher.init(Cipher.DECRYPT_MODE, keySpec);

    		Decoder encoder = Base64.getDecoder(); 
    		
    		return(new String(cipher.doFinal(encoder.decode(kakaoTarget))));
    		
    	} catch (Exception e) {
    		System.out.println("exception]" + e.getMessage());
        }
		
		return null;
	}
	
	//회원가입
	public void joinMember(MemberVo memberVo) {
		
		memberMapper.insertMember(memberVo);

	}
	
	public MemberVo isExist(String member_id) {
		
		return memberMapper.selectMemberById(member_id);
	}
	
	public ArrayList<HostVo> getHostVoList(int member_no) {
		return guestMapperH.getHostApproveCheck(member_no);
	}
	
	public MemberVo getMemberByNo(int member_no) {
		return memberMapper.selectMemberByNo(member_no);
	}
}
