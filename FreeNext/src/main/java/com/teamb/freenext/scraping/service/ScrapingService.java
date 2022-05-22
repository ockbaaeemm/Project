package com.teamb.freenext.scraping.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.safety.Whitelist;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.net.*;

import com.teamb.freenext.commons.KakaoRestAPI;
import com.teamb.freenext.scraping.mapper.ScrapingMapper;
import com.teamb.freenext.vo.ProjectBoardVo;

@Service
public class ScrapingService {

	@Autowired
	private ScrapingMapper scrapingMapper;
	
	@Autowired
	private KakaoRestAPI kakao;	
	
	@Scheduled(fixedDelay = 600000)		// 10분 : 600000
	public void getDesignGroupNine() {
		String kakaoKey = scrapingMapper.selectKakaoKey();

		if(kakaoKey != null) {
				
			String board_no = scrapingMapper.selectStartKey(3);

			Connection conn = null;			
			Document document = null;
			
			if(board_no == null) {
				String URL = "http://designnine.co.kr/project/project_list1.html?PHPSESSID=7cb3863d8bc2b28eb99a337710148688";
				conn = Jsoup.connect(URL);
				try {
					document = conn.get();
				} catch(Exception e) {
					System.out.println("최신 글 번호 connect 익셉션]" + e.getMessage());
				}
				
				Element parsingTable = document.getElementsByTag("table").get(16);
				
				Element parsingTr = parsingTable.getElementsByTag("tr").get(12);

				Element parsingTd = parsingTr.getElementsByTag("td").get(0);

				Element parsingDiv = parsingTd.getElementsByTag("div").get(0);

				board_no = parsingDiv.text();

				System.out.println("최신글번호: " + board_no);	            
			}
			
			String[] locations = {"근무장소", "근무위치", "근무 위치", "위치", "장소", "위 치", "장 소", "근무지역", "근무지"};
			
			int cnt = 0;
			while(cnt <= 10) {
				
				try {
					String scrapURL = "http://designnine.co.kr/project/project_view2.html?num=" + board_no + "&start=0";
					conn = Jsoup.connect(scrapURL);
					
					document = conn.get();
									
		            Elements text00s = document.select(".text00");
		            
		            if(text00s.get(0).text().equals("")) {
		            	cnt++;
		            	
		            	board_no = String.valueOf((Integer.parseInt(board_no) + 1));
		            	continue;
		            }
		            
		            cnt = 0;
		            
		            ProjectBoardVo projectBoardVo = new ProjectBoardVo();
		            projectBoardVo.setMember_no(0);
		            projectBoardVo.setRecruitType_no(1);
		            projectBoardVo.setCooperation_no(3);
		            projectBoardVo.setProject_url(scrapURL);
		            projectBoardVo.setProject_key(board_no);
		            projectBoardVo.setProject_name(text00s.get(0).text());
		            int job_no = getJobNo(text00s.get(2).text());
		            int local_no = 0;
		            projectBoardVo.setProject_state((text00s.get(4).text().equals("접수중")) ? "Y" : "N");
		            projectBoardVo.setProject_period(text00s.get(6).text());
		            projectBoardVo.setProject_price(text00s.get(8).text());
		            projectBoardVo.setWorkType_no(getWorkTypeNo(text00s.get(10).text()));           
		
		        	Element text00 = text00s.get(12);            	
		        		  
		        	String text = text00.text();
					
					for(Element p : text00.getElementsByTag("p")) {
						if(p.hasText()) {
							p.prepend("pTag");
						}
					}
					
					for(Element br : text00.getElementsByTag("br")) {
						br.append("brTag");
					}
					
					String converseStr = text00.html().replaceAll("&nbsp;", "").replaceAll("\n ", "").replaceAll("\n  ",  "").replaceAll("brTag", "\n").replaceAll("pTag", "\n");
					String cleanStr = Jsoup.clean(converseStr, "", Whitelist.none(), new Document.OutputSettings().prettyPrint(false)).replaceAll("&gt;", ">");
	
					projectBoardVo.setProject_content(cleanStr);
					
					boolean isExist = false;
					for(String location : locations) {
						int index = text.indexOf(location);
						
						if(index != -1) {            					
							String extLoc = text.substring(index+location.length(), text.length()).split(" : | :|: | |\\(|,")[1];
							
							Map<String, Object> result = kakao.getLocalInfo(kakaoKey, extLoc);
							        					
							String locCategory = ((String) result.get("result")).split("\"")[5].split(" ")[0];
							
							if(locCategory.equals("경기")) {
								locCategory = clsGyeonggi(((String) result.get("result")).split("\"")[5].split(" ")[1]);
							}
							System.out.println(extLoc + " > " + locCategory);
							local_no = getLocalNo(locCategory);
							isExist = true;
							break;
						}			
					}
					
					if(!isExist) {
						local_no = 11;
					}
					
					
					HashMap<String, Object> data = new HashMap<>();
					data.put("in_project_no", projectBoardVo.getProject_no());
					data.put("in_member_no", projectBoardVo.getMember_no());
					data.put("in_workType_no", projectBoardVo.getWorkType_no());
					data.put("in_recruitType_no", projectBoardVo.getRecruitType_no());
					data.put("in_cooperation_no", projectBoardVo.getCooperation_no());
					data.put("in_project_name", projectBoardVo.getProject_name());
					data.put("in_project_period", projectBoardVo.getProject_period());
					data.put("in_project_price", projectBoardVo.getProject_price());
					data.put("in_project_state", projectBoardVo.getProject_state());
					data.put("in_project_content", projectBoardVo.getProject_content());
					data.put("in_project_url", projectBoardVo.getProject_url());
					data.put("in_project_date", projectBoardVo.getProject_date());
					data.put("in_project_key", projectBoardVo.getProject_key());
					data.put("in_job_no", job_no);
					data.put("in_local_no", local_no);
					
					
					scrapingMapper.insertOrUpdate(data);
					
					board_no = String.valueOf((Integer.parseInt(board_no) + 1));
				
				}catch (Exception e) {
					System.out.println("크롤링 익셉션!!!!!!]" + e.getMessage());					
					cnt++;
					continue;
				}
			}
			System.out.println("디자인그룹나인 탐색종료");
		}			
	}
	
	@Scheduled(fixedDelay = 600000, initialDelay = 150000)		// 2분30초 딜레이 후 시작, 10분 간격
	public void getElancer() {

		HashMap<String, ArrayList<String>> paramMap = new HashMap<>();
		paramMap.put("oc=0", new ArrayList<String>(Arrays.asList("2", "E030001")));
		paramMap.put("oc=1", new ArrayList<String>(Arrays.asList("5", "E030002")));
		paramMap.put("oc=2", new ArrayList<String>(Arrays.asList("1", "E030003")));
		paramMap.put("oc=3", new ArrayList<String>(Arrays.asList("3", "E030004")));
		paramMap.put("oc=4", new ArrayList<String>(Arrays.asList("7", "E030005")));
		
		for(String key : paramMap.keySet()) {
			String URL = "https://www.elancer.co.kr/list-partner?" + key;
			Connection conn = Jsoup.connect(URL);
			String token = null;
			
			try {
				Document document = conn.get();
				
				Elements metas = document.getElementsByTag("meta");
				token = metas.get(2).attr("content");
				
			} catch(Exception e) {
				System.out.println("conn 익셉션]" + e.getMessage());
			}
			int job_no = Integer.parseInt(paramMap.get(key).get(0));
			ArrayList<String> endKeyList = scrapingMapper.selectEndKeyElancer(job_no);			
			
			int pageNum = 1;
			int cnt = (!endKeyList.isEmpty()) ? 5 - endKeyList.size() : 0;
			boolean hasEndKey = false;
			String board_no = "";
			
			while(cnt < 5) {							
				
				Map<String, String> params = new HashMap<>();
				params.put("se_work_type", paramMap.get(key).get(1));
				params.put("page", String.valueOf(pageNum));
				
				String urlParameters = kakao.mapToParams(params);
				
				String targetURL = "https://www.elancer.co.kr/ajax-partner";				

				try {
					URL url = new URL(targetURL);
					
					HttpURLConnection httpConn = (HttpURLConnection)url.openConnection();
					httpConn.setRequestMethod("POST");
					httpConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
					httpConn.setRequestProperty("X-CSRF-TOKEN", token);
					httpConn.setDoOutput(true);
					DataOutputStream output = new DataOutputStream(httpConn.getOutputStream());
					output.writeBytes(urlParameters);
					output.flush();
					
					BufferedReader input = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
					String line;
					StringBuffer buffer = new StringBuffer();
					while((line = input.readLine()) != null) {
						buffer.append(line);
					}
					
					Map<String, Object> resultMap = kakao.stringToMap(buffer.toString());
					ArrayList<String> resultList = (ArrayList<String>) resultMap.get("datas");
					
					for(String result : resultList) {
						
						if(cnt >= 5) break;
						ProjectBoardVo projectBoardVo = new ProjectBoardVo();	
						Element div = Jsoup.parse(result);
						Element a = div.getElementsByTag("a").get(1);
						
						board_no = a.attr("href").split("project\\?fm_str\\=")[1];
						
						if(endKeyList.contains(board_no) || endKeyList.isEmpty()) {
							hasEndKey = true;
						}
						
						projectBoardVo.setProject_key(board_no);
						
						projectBoardVo.setWorkType_no(getWorkTypeNo(a.text().split("\\[|\\]")[1]));
						projectBoardVo.setCooperation_no(2);
						projectBoardVo.setRecruitType_no(1);
						
						String detailURL = "https://www.elancer.co.kr/project?fm_str=" + board_no;
						projectBoardVo.setProject_url(detailURL);
						
						conn = Jsoup.connect(detailURL);
						
						Document document = conn.get();
						
						if(document.getElementsByTag("title").get(0).text().equals("Server Error")) {
							cnt++;
							continue;
						}
						
						projectBoardVo.setProject_name(document.getElementsByClass("mb-2 md:mb-2.5 text-fs-20 md:text-fs-40").get(0).text());
						projectBoardVo.setProject_state((document.getElementsByClass("float-right ebtn-basic ebtn-cl-dred").get(0).text().equals("모집완료")) ? "N" : "Y");

						String project_period = document.getElementsByClass("ebtn-medium ebtn-cf-white").get(1).text();
						if(project_period.indexOf("개월") == -1) {
							project_period = "";
						}
						projectBoardVo.setProject_period(project_period);
						
						projectBoardVo.setProject_price(document.getElementsByClass("project-money").get(0).text());
						projectBoardVo.setProject_content(Jsoup.clean(
								document.getElementsByClass("etext-p leading-relaxed text-gray-c_b7").get(0).html(),
								"", Whitelist.none(), new Document.OutputSettings().prettyPrint(false)).replaceAll("&nbsp;", " ").replaceAll("&amp;", "&").replaceAll("&gt;", ">").replaceAll("&lt;", "<"));

						String locCategory = document.getElementsByClass("ebtn-medium ebtn-cf-white").get(2).text();

						int local_no = 11;
						if(locCategory.indexOf("경기") != -1) {

							locCategory = clsGyeonggi(locCategory.split("\\|")[1]);
							local_no = getLocalNo(locCategory);
						} else {
							local_no = getLocalNo(locCategory.substring(0,2));
						}
						
						System.out.println(locCategory + " > " + local_no);	
						
						HashMap<String, Object> data = new HashMap<>();
						data.put("in_project_no", projectBoardVo.getProject_no());
						data.put("in_member_no", projectBoardVo.getMember_no());
						data.put("in_workType_no", projectBoardVo.getWorkType_no());
						data.put("in_recruitType_no", projectBoardVo.getRecruitType_no());
						data.put("in_cooperation_no", projectBoardVo.getCooperation_no());
						data.put("in_project_name", projectBoardVo.getProject_name());
						data.put("in_project_period", projectBoardVo.getProject_period());
						data.put("in_project_price", projectBoardVo.getProject_price());
						data.put("in_project_state", projectBoardVo.getProject_state());
						data.put("in_project_content", projectBoardVo.getProject_content());
						data.put("in_project_url", projectBoardVo.getProject_url());
						data.put("in_project_date", projectBoardVo.getProject_date());
						data.put("in_project_key", projectBoardVo.getProject_key());
						data.put("in_job_no", job_no);
						data.put("in_local_no", local_no);
						
						
						scrapingMapper.insertOrUpdate(data);
						
						if(hasEndKey) cnt++;
					}
				
					pageNum++;
					
				} catch (Exception e) {
					System.out.println("httpConn 익셉션]" + e.getMessage());
					cnt++;
					continue;
				}

			}
			
		}
		System.out.println("이랜서 탐색종료");
	}
	
	//@Scheduled(fixedDelay = 50000)
	@Scheduled(fixedDelay = 600000, initialDelay = 300000)		// 5분 딜레이 후 시작, 10분 간격
	public void getWebCruit() {
		String kakaoKey = scrapingMapper.selectKakaoKey();

		if(kakaoKey != null) {		
		
			String board_no = scrapingMapper.selectStartKey(5);
			
			Connection conn = null;			
			Document document = null;		
			
			if(board_no == null) {
				String URL = "http://www.webcruit.co.kr/projects";
				conn = Jsoup.connect(URL);
				try {
					document = conn.get();
				} catch(Exception e) {
					System.out.println("최신 글 번호 connect 익셉션]" + e.getMessage());
				}
				
				board_no = document.getElementsByClass("project_name_box").get(0).selectFirst("a").attr("href").split("projects/")[1];
	
				System.out.println("최신글번호: " + board_no);	            			
			}
			
			String[] prefixes = {"PLA", "DES", "PRO", "PUB"};
			
			int cnt = 0;
			
			boolean isFirst = true;
			while(cnt < 10) {
				
				try {
					
					for(String prefix : prefixes) {
						
						if(cnt>=10) break;
						
						if(!isFirst) {
							board_no = prefix + board_no;
						} else {
							isFirst = false;
						}
						
						String scrapURL = "http://www.webcruit.co.kr/projects/" + board_no;
						conn = Jsoup.connect(scrapURL);
						
						document = conn.get();
						
						Element infoTable = document.selectFirst(".project_info_view_table");
						
						Element nameTd = infoTable.selectFirst("tr").selectFirst("td");
						String nameTdText = nameTd.text();
						
						if(nameTdText.equals("[ ]")) {							
							
							int no = Integer.parseInt(board_no.substring(3));
							
							if(!prefix.equals("PUB")) {
								board_no = String.valueOf((no));
							} else {
								board_no = String.valueOf(no+1);
							}							
							
							cnt++;
							
							continue;
						}
						
						cnt = 0;												
						
						ProjectBoardVo projectBoardVo = new ProjectBoardVo();
						
						String[] project_nameArr = nameTdText.split(" ");
						String project_name = "";
						for(int i=3;i<project_nameArr.length;i++) {
							project_name += project_nameArr[i] + " ";
						}
						projectBoardVo.setProject_name(project_name);						
						
						String project_state = nameTd.select("span").text();
			            projectBoardVo.setProject_state((project_state.equals("진행중") || project_state.equals("접수마감")) ? "N" : "Y");			            
						
						projectBoardVo.setMember_no(0);
						projectBoardVo.setRecruitType_no(1);
						projectBoardVo.setCooperation_no(5);
						projectBoardVo.setProject_url(scrapURL);
						projectBoardVo.setProject_key(board_no);						
						
						for(Element tr : infoTable.select("tr")) {
							if(tr.text().indexOf("근무형태") != -1) {
								projectBoardVo.setWorkType_no(getWorkTypeNo(tr.selectFirst("td").text()));
								break;
							}
						}						
						
						for(Element tr : infoTable.select("tr")) {
							if(tr.text().indexOf("근무급여") != -1) {
								projectBoardVo.setProject_price(tr.selectFirst("td").text());
								break;
							}
						}							
						
						for(Element tr : infoTable.select("tr")) {
							if(tr.text().indexOf("근무기간") != -1) {
								projectBoardVo.setProject_period(tr.selectFirst("td").text());
								break;
							}
						}						
						
						int local_no = 11;
						for(Element tr : infoTable.select("tr")) {
							if(tr.text().indexOf("근무위치") != -1) {
								
								String extLoc = tr.selectFirst("td").text().split(" ")[0];
								Map<String, Object> result = kakao.getLocalInfo(kakaoKey, extLoc);
								
								String locCategory = ((String) result.get("result")).split("\"")[5].split(" ")[0];
																
								if(locCategory.equals("경기")) {
								locCategory = clsGyeonggi(((String) result.get("result")).split("\"")[5].split(" ")[1]);
								}
								
								System.out.println(extLoc + " > " + locCategory);
								
								local_no = getLocalNo(locCategory);										
								break;
							}
						}							

						
						Element contentBox = document.select(".project_info_text").get(0);

						for(Element p : contentBox.getElementsByTag("p")) {
							if(p.hasText()) {
								p.prepend("pTag");
							}
						}
					
						contentBox.select("br").append("brTag");
					
						String converseStr = contentBox.html().replaceAll("&nbsp;", "").replaceAll("brTag", "\n").replaceAll("pTag", "\n");
						String project_content = Jsoup.clean(converseStr, "", Whitelist.none(), new Document.OutputSettings().prettyPrint(false));
						
						projectBoardVo.setProject_content(project_content);						
						
						int job_no = 7;
						switch(prefix) {
							case "PLA" :
								if(project_content.indexOf("PM") != -1) {
									job_no = getJobNo("PM");
								} else {
									job_no = getJobNo("기획");
								}
								break;
							case "DES" :
								job_no = getJobNo("디자인");
								break;
							case "PRO" :
								job_no = getJobNo("개발");
								break;
							case "PUB" :
								job_no = getJobNo("퍼블리싱");
								break;
						}
						
						HashMap<String, Object> data = new HashMap<>();
						data.put("in_project_no", projectBoardVo.getProject_no());
						data.put("in_member_no", projectBoardVo.getMember_no());
						data.put("in_workType_no", projectBoardVo.getWorkType_no());
						data.put("in_recruitType_no", projectBoardVo.getRecruitType_no());
						data.put("in_cooperation_no", projectBoardVo.getCooperation_no());
						data.put("in_project_name", projectBoardVo.getProject_name());
						data.put("in_project_period", projectBoardVo.getProject_period());
						data.put("in_project_price", projectBoardVo.getProject_price());
						data.put("in_project_state", projectBoardVo.getProject_state());
						data.put("in_project_content", projectBoardVo.getProject_content());
						data.put("in_project_url", projectBoardVo.getProject_url());
						data.put("in_project_date", projectBoardVo.getProject_date());
						data.put("in_project_key", projectBoardVo.getProject_key());
						data.put("in_job_no", job_no);
						data.put("in_local_no", local_no);
						
						
						scrapingMapper.insertOrUpdate(data);
						
						board_no = String.valueOf((Integer.parseInt(board_no.substring(3)) + 1));						

						break;
					}

				}catch (Exception e) {
					System.out.println("크롤링 익셉션!!!!!!]" + e.getMessage());					
					cnt++;
					continue;
				}
			}
			System.out.println("웹크루트 탐색종료");
		}				
	}
	
	@Scheduled(fixedDelay = 600000, initialDelay = 450000)		// 7분 30초 딜레이 후 시작, 10분 간격		
	public void getWishket() {
		
		// 로그인 페이지 접속
		Connection.Response loginPageResponse;
		try {
			String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36";
			
			loginPageResponse = Jsoup.connect("https://www.wishket.com/accounts/login/")
			                                                .timeout(3000)
			                                                .userAgent(userAgent)
			                                                .header("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9")
			                                                .header("content-type", "application/x-www-form-urlencoded")
			                                                .header("accept-encoding", "gzip, deflate, br")
			                                                .header("accept-language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
			                                                .method(Connection.Method.GET)
			                                                .execute();
			
			// 로그인 페이지에서 얻은 쿠키
			Map<String, String> loginTryCookie = loginPageResponse.cookies();
			
			// 로그인 페이지에서 로그인에 함께 전송하는 토큰 얻어내기
			Document loginPageDocument = loginPageResponse.parse();			
			String csrfToken = loginPageDocument.select("input[name=csrfmiddlewaretoken]").val();					 
			
			// 전송할 폼 데이터
			Map<String, String> loginData = new HashMap<>();
			loginData.put("csrfmiddlewaretoken", csrfToken); // 로그인 페이지에서 얻은 토큰
			loginData.put("identification", "test_teamb");
			loginData.put("password", "fnsl1004");
			loginData.put("remember_me", "1");
			

			// 로그인(POST) referer 없으면 403뜸
			Connection.Response loginResponse = Jsoup.connect("https://www.wishket.com/accounts/login/")
												.userAgent(userAgent)
			                                    .timeout(3000)
			                                    .header("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9")
                                                .header("content-type", "application/x-www-form-urlencoded")
                                                .header("accept-encoding", "gzip, deflate, br")                                                
                                                .header("accept-language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
                                                .header("cache-control", "max-age=0")
                                                .header("content-length", "96")
                                                .header("sec-fetch-dest", "document")
                                                .header("sec-fetch-mode", "navigate")
                                                .header("sec-fetch-user", "?1")
                                                .header("upgrade-insecure-requests", "1")
                                                .header("origin", "https://www.wishket.com")
                                                .header("referer", "https://www.wishket.com/accounts/login")
                                                .cookies(loginTryCookie)
			                                    .data(loginData)
			                                    .method(Connection.Method.POST)
			                                    .execute();
			
			// 로그인 성공 후 얻은 쿠키.
			Map<String, String> loginCookie = loginResponse.cookies();	
			
			
			ArrayList<String> endKeyList = scrapingMapper.selectEndKeyWishket();
			
			int cnt = (!endKeyList.isEmpty()) ? 5 - endKeyList.size() : 0;
			boolean hasEndKey = false;
			int pageNum = 1;
			while(cnt < 5) {
				
				Map<String, String> listData = new HashMap<>();
				listData.put("text_search_type", "all");
				listData.put("order_by", "submit");
				listData.put("page", String.valueOf(pageNum));

				Document projectListPage = Jsoup.connect("https://www.wishket.com/project/search/?page=" + String.valueOf(pageNum))
							                    .header("Content-Type", "application/x-www-form-urlencoded")
							                    .header("x-requested-with", "XMLHttpRequest")
							                    .data(listData)
							                    .post();
				
				Elements infoBoxes = projectListPage.select(".project-info-box");
				
				for(Element infoBox : infoBoxes) {
					
					if(cnt >= 5) break;
					
					String board_no = infoBox.selectFirst(".project-unit-heading").selectFirst(".project-link").attr("href").split("/")[2];
					System.out.println(board_no);
					
					if(endKeyList.contains(board_no) || endKeyList.isEmpty()) {
						hasEndKey = true;
					}
					
					String project_url = "https://www.wishket.com/project/" + board_no + "/";
					try {
						Document document = Jsoup.connect(project_url)
								.userAgent(userAgent)
								.header("cache-control", "max-age=0")
								.header("upgrade-insecure-requests", "1")
								.header("sec-fetch-user", "?1")
								.header("sec-fetch-dest", "document")
								.header("sec-fetch-mode", "navigate")
								.cookies(loginCookie)
								.get();
				
						
						if(document.getElementsByClass("message warning partners").size() > 0 && 
								document.getElementsByClass("message-body body-2 text700").get(0).text().equals("존재하지 않는 프로젝트입니다.")) {
							cnt++;
							continue;
						}					
						
						ProjectBoardVo projectBoardVo = new ProjectBoardVo();
						
						projectBoardVo.setMember_no(0);
						projectBoardVo.setRecruitType_no(2);
																
						projectBoardVo.setWorkType_no(document.getElementsByClass("simple-chip outsourcing-chip caption-1-medium").get(0).text().equals("외주(도급)") ? 4 : 2);
						projectBoardVo.setCooperation_no(4);
						projectBoardVo.setProject_name(document.getElementsByClass("subtitle-1-medium mb8 text900").get(0).text());
						
						Elements conditionBox = document.getElementsByClass("project-condition-data body-1-medium text900");
						
						Elements flex_budgetBox = document.getElementsByClass("flex-box project-condition-data body-1-medium text900");
						
						if(flex_budgetBox.isEmpty()) {
							projectBoardVo.setProject_price(conditionBox.get(0).text());
							projectBoardVo.setProject_period(conditionBox.get(1).text());
						} else {
							projectBoardVo.setProject_price(flex_budgetBox.get(0).text());
							projectBoardVo.setProject_period(conditionBox.get(0).text());
						}
						
						projectBoardVo.setProject_state(document.getElementsByClass("project-status-label recruiting-status").get(0).text().indexOf("모집 중") != -1 ? "Y" : "N");
						
						Element contentBox = document.getElementsByClass("project-description-box body-2 mb40 text900").get(0);					
						
						contentBox.select("br").append("brTag");
						contentBox.select("p").prepend("pTag");
						
						String converseStr = contentBox.html().replaceAll("&nbsp;", "").replaceAll("brTag", "").replaceAll("pTag", "\n");
						String project_content = Jsoup.clean(converseStr, "", Whitelist.none(), new Document.OutputSettings().prettyPrint(false)).replaceAll("&gt;", ">").replaceAll("&lt;", "<").replaceAll("&amp;", "&");
						
						projectBoardVo.setProject_content(project_content);
						projectBoardVo.setProject_url(project_url);
						projectBoardVo.setProject_key(board_no);
						
						HashMap<String, Object> data = new HashMap<>();
						data.put("in_project_no", projectBoardVo.getProject_no());
						data.put("in_member_no", projectBoardVo.getMember_no());
						data.put("in_workType_no", projectBoardVo.getWorkType_no());
						data.put("in_recruitType_no", projectBoardVo.getRecruitType_no());
						data.put("in_cooperation_no", projectBoardVo.getCooperation_no());
						data.put("in_project_name", projectBoardVo.getProject_name());
						data.put("in_project_period", projectBoardVo.getProject_period());
						data.put("in_project_price", projectBoardVo.getProject_price());
						data.put("in_project_state", projectBoardVo.getProject_state());
						data.put("in_project_content", projectBoardVo.getProject_content());
						data.put("in_project_url", projectBoardVo.getProject_url());
						data.put("in_project_date", projectBoardVo.getProject_date());
						data.put("in_project_key", projectBoardVo.getProject_key());
						data.put("in_job_no", 0);
						data.put("in_local_no", 0);
											
						scrapingMapper.insertOrUpdate(data);					
						
						if(hasEndKey) cnt++;
					} catch(Exception e) {
						System.out.println("detailPage conn 익셉션]" + e.getMessage());
						//cnt++;
						continue;
					}
				}
				pageNum++;
			}

		} catch (IOException e) {
			System.out.println("conn 익셉션]" + e.getMessage());	
			
			e.printStackTrace();
		}
		System.out.println("위시켓 탐색종료");

	}
	
	public int getJobNo(String jobName) {
		
		if(jobName.indexOf("디자인") != -1 || jobName.indexOf("디자이너") != -1) {
			return 1;
		} else if(jobName.indexOf("퍼블리셔") != -1 || jobName.indexOf("액션스크립터") != -1 || jobName.indexOf("퍼블리싱") != -1) { 
			return 5;
		} else if(jobName.indexOf("프로그래머") != -1 || jobName.indexOf("개발") != -1) {
			return 2;
		} else if(jobName.indexOf("PM") != -1) {
			return 4;
		} else if(jobName.indexOf("마케팅") != -1) {
			return 6;
		} else if(jobName.indexOf("기획") != -1) {
			return 3;
		} else return 7;		
	}
	
	public int getWorkTypeNo(String workTypeName) {
		if(workTypeName.indexOf("재택") != -1) {
			return 1;
		} else if(workTypeName.indexOf("파견") != -1 || workTypeName.indexOf("상주") != -1) {
			return 2;
		} else if(workTypeName.indexOf("정규직") != -1) {
			return 3;
		} else return 4;
	}
	
	public int getLocalNo(String localName) {
		
		switch(localName) {
			case "서울" :
				return 1;
			case "인천" :
				return 2;
			case "경기남부" :
				return 3;
			case "경기북부" :
				return 4;
			case "대전" :
				return 5;
			case "대구" :
				return 6;
			case "경북" :
				return 6;
			case "부산" :
				return 7;
			case "경남" :
				return 7;
			case "광주" :
				return 8;
			case "강원" :
				return 9;
			case "제주" :
				return 10;
			default :
				return 11;
		}
	}
	
	public String clsGyeonggi(String localName) {
		String[] southArr = {"과천시", "여주시", "용인시", "광명시", "시흥시",
				"의왕시", "광주시", "안산시", "이천시", "군포시", "안성시", "평택시",
				"김포시", "안양시", "하남시", "부천시", "여주시", "화성시", "성남시",
				"오산시", "양평군"};
		
		String[] northArr = {"고양시", "동두천시", "파주시", "구리시", "양주시",
				"포천시", "남양주시", "의정부시", "가평군", "연천군"};
		
		ArrayList<String> southList = new ArrayList<>(Arrays.asList(southArr));
		ArrayList<String> northList = new ArrayList<>(Arrays.asList(northArr));
		
		if(southList.contains(localName)) {
			return "경기남부";
		} else if(northList.contains(localName)) {
			return "경기북부";
		}
		
		return "기타";
	}	
}
