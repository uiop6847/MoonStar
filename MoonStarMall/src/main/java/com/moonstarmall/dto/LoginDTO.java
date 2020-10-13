package com.moonstarmall.dto;

import java.util.Date;

// 로그인하는 아이디, 비밀번호 입력정보를 저장하는 용도
public class LoginDTO {

	private String	user_id;
	private String	user_pw;
	private String	user_nm;
	private int		user_point;
	private Date	last_date;
	private boolean	userCookie;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
	public Date getLast_date() {
		return last_date;
	}
	public void setLast_date(Date last_date) {
		this.last_date = last_date;
	}
	public boolean isUserCookie() {
		return userCookie;
	}
	public void setUserCookie(boolean userCookie) {
		this.userCookie = userCookie;
	}
	
	@Override
	public String toString() {
		return "LoginDTO [user_id=" + user_id + ", user_pw=" + user_pw + ", user_nm=" + user_nm + ", user_point="
				+ user_point + ", last_date=" + last_date + ", userCookie=" + userCookie + "]";
	}
}
