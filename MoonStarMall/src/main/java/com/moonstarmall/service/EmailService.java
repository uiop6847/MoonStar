package com.moonstarmall.service;

import com.moonstarmall.dto.EmailDTO;

public interface EmailService {
	
	/* 이메일 인증코드 전송 */
	public void sendMail(EmailDTO dto, String authcode);

}
