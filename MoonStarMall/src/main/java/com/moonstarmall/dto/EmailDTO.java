package com.moonstarmall.dto;

public class EmailDTO {

	private String senderName;	// 발신자 이름
	private String senderMail;	// 발신자 이메일 주소
	private String receiveMail; // 수신자 이메일 주소
	private String subject;		// 제목
	private String message;		// 본문
	
	/* 
	 * Constructor 
	 * 수신자 이메일 주소를 제외하고
	 * 인증 코드 전송을 위한 작업을 해둠
	 * 
	 */
	public EmailDTO() {
		this.senderName = "MoonStarMall";
		this.senderMail = "MoonStarMall";
		this.subject = "MoonStarMall 인증코드입니다.";
		this.message = "이메일 인증을 위해,\n아래 인증코드를 이메일 인증코드 란에 입력하세요.\n\n인증코드: ";
	}
	
	
	/* Getter and Setter */
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSenderMail() {
		return senderMail;
	}
	public void setSenderMail(String senderMail) {
		this.senderMail = senderMail;
	}
	public String getReceiveMail() {
		return receiveMail;
	}
	public void setReceiveMail(String receiveMail) {
		this.receiveMail = receiveMail;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "EmailDTO [senderName=" + senderName + ", senderMail=" + senderMail + ", receiveMail=" + receiveMail
				+ ", subject=" + subject + ", message=" + message + "]";
	}
}
