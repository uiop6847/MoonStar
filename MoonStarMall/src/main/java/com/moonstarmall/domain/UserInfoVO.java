package com.moonstarmall.domain;

import java.util.Date;

public class UserInfoVO {

	private String 	user_id;
	private String 	user_nm;
	private String 	user_pw;
	private String 	user_email;
	private String 	zip_num;
	private String 	addr;
	private String 	addr_dtl;
	private String 	tel_phone;
	private String 	cell_phone;
	private String 	email_rev_yn;
	private int 	user_point;
	private Date 	sta_date;
	private Date 	last_date;
	private String 	authcode;
	private String  session_key;
	private Date	session_limit;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getZip_num() {
		return zip_num;
	}
	public void setZip_num(String zip_num) {
		this.zip_num = zip_num;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_dtl() {
		return addr_dtl;
	}
	public void setAddr_dtl(String addr_dtl) {
		this.addr_dtl = addr_dtl;
	}
	public String getTel_phone() {
		return tel_phone;
	}
	public void setTel_phone(String tel_phone) {
		this.tel_phone = tel_phone;
	}
	public String getCell_phone() {
		return cell_phone;
	}
	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}
	public String getEmail_rev_yn() {
		return email_rev_yn;
	}
	public void setEmail_rev_yn(String email_rev_yn) {
		this.email_rev_yn = email_rev_yn;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
	public Date getSta_date() {
		return sta_date;
	}
	public void setSta_date(Date sta_date) {
		this.sta_date = sta_date;
	}
	public Date getLast_date() {
		return last_date;
	}
	public void setLast_date(Date last_date) {
		this.last_date = last_date;
	}
	public String getAuthcode() {
		return authcode;
	}
	public void setAuthcode(String authcode) {
		this.authcode = authcode;
	}
	public String getSession_key() {
		return session_key;
	}
	public void setSession_key(String session_key) {
		this.session_key = session_key;
	}
	public Date getSession_limit() {
		return session_limit;
	}
	public void setSession_limit(Date session_limit) {
		this.session_limit = session_limit;
	}
	
	@Override
	public String toString() {
		return "UserInfoVO [user_id=" + user_id + ", user_nm=" + user_nm + ", user_pw=" + user_pw + ", user_email="
				+ user_email + ", zip_num=" + zip_num + ", addr=" + addr + ", addr_dtl=" + addr_dtl + ", tel_phone="
				+ tel_phone + ", cell_phone=" + cell_phone + ", email_rev_yn=" + email_rev_yn + ", user_point=" + user_point
				+ ", sta_date=" + sta_date + ", last_date=" + last_date + ", authcode="
				+ authcode + ", session_key=" + session_key + ", session_limit=" + session_limit + "]";
	}
}
