package com.teamb.freenext;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class FreeNextApplication {

	public static void main(String[] args) {
		SpringApplication.run(FreeNextApplication.class, args);
	}

}
