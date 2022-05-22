package com.teamb.freenext;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	//외부 파일 경로 설정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
      // 리퀘스트매핑 uri 설정 정적 리소스 위치 설정(파일위치)
		registry.addResourceHandler("/profileImage/**").addResourceLocations("file:/C:/freeNext/profileImage/");
    }
	
}
