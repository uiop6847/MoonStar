package com.moonstarmall.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.moonstarmall.dto.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private JavaMailSender mailSender;

	/* 이메일 인증코드 전송 */
	@Override
	public void sendMail(EmailDTO dto, String authcode) {
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			// 받는 사람 설정(이메일)
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			// 보내는 사람 설정(이메일, 이름)
			msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			// 이메일 제목
			msg.setSubject(dto.getSubject(), "utf-8");
			// 이메일 본문(인증코드 추가)
			msg.setText(dto.getMessage() + authcode , "utf-8");
			
			// 메일 보내기
			mailSender.send(msg); // gamil 보안설정을 낮게 설정해야함
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

}
