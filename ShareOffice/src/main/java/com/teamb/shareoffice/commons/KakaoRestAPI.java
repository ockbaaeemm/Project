package com.teamb.shareoffice.commons;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamb.shareoffice.vo.KakaopayVo;
import com.teamb.shareoffice.vo.MemberVo;

@Service
public class KakaoRestAPI {

	public enum HttpMethodType { POST, GET, DELETE }
	
	private static final String API_SERVER_HOST  = "https://kapi.kakao.com";
	private static final String API_SERVER_KAUTH_HOST = "https://kauth.kakao.com";
		
	private static final String PAY_READY_PATH = "/v1/payment/ready";
	private static final String PAY_APPROVE_PATH = "/v1/payment/approve";
	private static final String PAY_INFO_PATH = "/v1/payment/order";
	private static final String PAY_CANCEL_PATH = "/v1/payment/cancel";
	
	private static final String LOGIN_GET_TOKEN = "/oauth/token";	


	private final String domain = "http://localhost:8181/";
	//private final String domain = "http://15.164.100.116:8080/";

	private final String loginGetCode = "http://localhost:8181/member/loginGetCode";
	//private final String loginGetCode = "http://15.164.100.116:8080/member/loginGetCode";
	
	private final String cid = "TC0ONETIME";
	
	public Map<String, Object> getLocalInfo(String kakaoKey, String extLoc) {
		
		String requestUrl  = "https://dapi.kakao.com/v2/local/search/keyword.json?";
		
		Map<String, String> params = new HashMap<>();
		params.put("query", extLoc);
		String sendParams = mapToParams(params); 
		
		return Request(HttpMethodType.GET, sendParams, requestUrl, kakaoKey);
	}
	
    // kakao pay   
    public Map<String, Object> payReady(String partner_order_id, String partner_user_id,
    		String item_name, String quantity, String total_amount, String kakaoKey) {
    	
    	String approval_url = this.domain + "guest/kakaoPayApproval";
    	String cancel_url = this.domain + "guest/kakaoPayCancel";
    	String fail_url = this.domain + "guest/kakaoPayFail";
    	
    	Map<String, String> params = new HashMap<>();
    	
    	params.put("cid", this.cid);
    	params.put("partner_order_id", partner_order_id);
    	params.put("partner_user_id", partner_user_id);
    	params.put("item_name", item_name);
    	params.put("quantity", quantity);
    	params.put("total_amount", total_amount);
    	params.put("tax_free_amount", "0");
    	params.put("approval_url", approval_url);
    	params.put("cancel_url", cancel_url);
    	params.put("fail_url", fail_url);
    	
    	String sendParams = mapToParams(params);    			
    	
    	String requestUrl = API_SERVER_HOST + PAY_READY_PATH;

    	return Request(HttpMethodType.POST, sendParams, requestUrl, kakaoKey);
    }	
	
    public Map<String, Object> payApprove(String pg_token, KakaopayVo vo, HttpSession session, String kakaoKey) {
    	
    	String requestUrl = API_SERVER_HOST + PAY_APPROVE_PATH;
    	
    	Map<String, String> params = new HashMap<>();
    	
    	params.put("cid", this.cid);
    	params.put("tid", vo.getTid());
    	params.put("partner_order_id", vo.getPartner_order_id());
    	params.put("partner_user_id", ((MemberVo) session.getAttribute("sessionUser")).getMember_id());
    	params.put("pg_token", pg_token);
    	
    	String sendParams = mapToParams(params);
    	
    	return Request(HttpMethodType.POST, sendParams, requestUrl, kakaoKey);
    }
    
    public Map<String, Object> payInfo(String tid, String kakaoKey) {
    	
    	String requestUrl = API_SERVER_HOST + PAY_INFO_PATH;
    	
    	Map<String, String> params = new HashMap<>();
    	
    	params.put("cid", this.cid);
    	params.put("tid", tid);
    	
    	String sendParams = mapToParams(params);
    	
    	return Request(HttpMethodType.POST, sendParams, requestUrl, kakaoKey);
    }
    
    public Map<String, Object> payCancel(String tid, String cancel_amount, String kakaoKey) {
    	
    	String requestUrl = API_SERVER_HOST + PAY_CANCEL_PATH;
    	
    	Map<String, String> params = new HashMap<>();
    	
    	params.put("cid", this.cid);
    	params.put("tid", tid);
    	params.put("cancel_amount", cancel_amount);
    	params.put("cancel_tax_free_amount", "0");
    	
    	String sendParams = mapToParams(params);
    	
    	return Request(HttpMethodType.POST, sendParams,requestUrl, kakaoKey);
    	
    }
    
    public Map<String, Object> loginGetToken(String code, String kakaoKey) {
    	String requestUrl = API_SERVER_KAUTH_HOST + LOGIN_GET_TOKEN;
    	
    	Map<String, String> params = new HashMap<>();
    	
    	params.put("grant_type", "authorization_code");
    	params.put("client_id", kakaoKey);

    	params.put("redirect_uri", loginGetCode);
    	params.put("code", code);
    	
    	String sendParams = mapToParams(params);
    	
    	return Request(HttpMethodType.POST, sendParams, requestUrl, kakaoKey);
    }    
    
    public Map<String, Object> Request(HttpMethodType httpMethod, String sendParams, String requestUrl, String kakaoKey) {

        Map<String, Object> result = new HashMap<>();;
    	
    	
    	if(sendParams != null && sendParams.length() > 0 &&	httpMethod == HttpMethodType.GET) {
    		requestUrl += sendParams;
    	}    	
    	
    	HttpsURLConnection conn;
    	OutputStreamWriter writer = null;
        BufferedReader reader = null;
        InputStreamReader isr = null;
        
        try {
        	final URL url = new URL(requestUrl);
        	conn = (HttpsURLConnection) url.openConnection();
        	conn.setRequestMethod(httpMethod.toString());
        	
        	conn.setRequestProperty("Authorization", "KakaoAK " + kakaoKey);
        	conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        	conn.setRequestProperty("charset", "utf-8");
        	
        	if(sendParams != null && sendParams.length() > 0 &&
        			httpMethod == HttpMethodType.POST) {
	        	conn.setDoOutput(true);
	        	writer = new OutputStreamWriter(conn.getOutputStream());
	        	writer.write(sendParams);
	        	writer.flush();
        	}
        	
        	final int responseCode = conn.getResponseCode();
        	//System.out.println(String.format("\nSending '%s' request to URL : %s", httpMethod, requestUrl));
        	//System.out.println("Response Code : " + responseCode);
        	
        	if(responseCode == 200) {
        		isr = new InputStreamReader(conn.getInputStream());
        	} else {
        		isr = new InputStreamReader(conn.getErrorStream());
        	}
        	
        	reader = new BufferedReader(isr);
        	final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            //System.out.println(buffer.toString());
            
            
            if(httpMethod == HttpMethodType.GET) {

            	result.put("result", buffer.toString());
            	return result;
            }
            
            result = stringToMap(buffer.toString());
            result.put("response_code", String.valueOf(responseCode));
        	            
            return result;
        	
        } catch(Exception e) {
        	//e.printStackTrace();
        	System.out.println("카카오 변환 API 익셉션]" + e.getMessage());
        	
        	result.put("result", "fail");
        	
        } finally {
            if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }	
	
    public String urlEncodeUTF8(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new UnsupportedOperationException(e);
        }
    }   
	
    public String mapToParams(Map<String, String > map) {
        StringBuilder paramBuilder = new StringBuilder();
        for (String key : map.keySet()) {
            paramBuilder.append(paramBuilder.length() > 0 ? "&" : "");
            paramBuilder.append(String.format("%s=%s", urlEncodeUTF8(key),
                    urlEncodeUTF8(map.get(key).toString())));
        }
        return paramBuilder.toString();
    }    
    
    public Map<String, Object> stringToMap(String s) {
    	Map<String, Object> map = new HashMap<>();
    	
		ObjectMapper mapper = new ObjectMapper();

	    try{
	        map = mapper.readValue(s, Map.class);

	    } catch (IOException e){
	        e.printStackTrace();
	    }
	    
	    return map;
    }    
}
