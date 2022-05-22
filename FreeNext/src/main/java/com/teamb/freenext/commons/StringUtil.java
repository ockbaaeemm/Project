package com.teamb.freenext.commons;

import java.net.URLEncoder;


import org.apache.commons.text.StringEscapeUtils;

public class StringUtil {
	public static String escapeHTML(String text) {
		
		return StringEscapeUtils.escapeHtml4(text)
			.replaceAll("(\r\n|\r|\n|\n\r)", "<br>").replaceAll(" ", "&nbsp;");
	}
	
	public static String tailParam(String searchOption, String searchWord) {
		String tailParam = "";
		
		if(searchOption != null) {
			try {
				tailParam += "&searchOption=" + URLEncoder.encode(searchOption, "UTF-8");
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(searchWord != null) {
			try {
				tailParam += "&searchWord=" + URLEncoder.encode(searchWord, "UTF-8");
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return tailParam;
	}
}
