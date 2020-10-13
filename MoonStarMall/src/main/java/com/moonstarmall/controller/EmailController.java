package com.moonstarmall.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moonstarmall.dto.EmailDTO;
import com.moonstarmall.service.EmailService;

@Controller
@RequestMapping("/email/*")
public class EmailController {
	
	@Autowired
	private EmailService emailService;
	
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	
	@ResponseBody
	@RequestMapping("send")
	public ResponseEntity<String> send(@ModelAttribute EmailDTO dto, Model model, HttpSession session) {
		logger.info("email send() called");
		logger.info("EmailDTO: " + dto.toString());
		
		ResponseEntity<String> entity = null;
		
		// 6자리 인증 코드 생성
		String authcode = "";
		for(int i=0; i<6; i++) {
			authcode += String.valueOf((int)(Math.random()*10));
		}
		// 인증코드를 세션에 저장 : 사용자가 인증코드 입력해서 요청이 발생이되면 비교시 목적으로 세션에 저장을 해둠.
		session.setAttribute("authcode", authcode);

		logger.info("=====authcode: " + authcode);
		try {
			// dto : 회원가입시 입력한 메일주소 , authcode : 인증코드
			emailService.sendMail(dto, authcode);
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

}
