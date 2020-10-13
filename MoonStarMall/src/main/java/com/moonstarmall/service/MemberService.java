package com.moonstarmall.service;

import java.util.Date;

import com.moonstarmall.domain.UserInfoVO;
import com.moonstarmall.dto.LoginDTO;

public interface MemberService {
	
	/* 회원가입 */
	public void userInfoAdd(UserInfoVO vo) throws Exception;
	
	/* 아이디 중복체크 */
	public int userIdCheck(String user_id) throws Exception;
	
	/* 이메일 중복체크 */
	public int userEmailCheck(String user_email) throws Exception;
	
	/* 로그인 */
	public LoginDTO loginOK(LoginDTO dto) throws Exception;
	
	/* 자동로그인 처리(쿠키저장) */
	public void saveCookie(String sessionKey, Date sessionLimit, String user_id) throws Exception;
	
	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	public UserInfoVO checkUserSession(String value) throws Exception;
	
	/* 회원정보 상세조회 */
	public UserInfoVO userInfoSelect(String user_id) throws Exception;
	
	/* 회원정보 수정 */
	public void modifyUserInfo(UserInfoVO vo) throws Exception;
	
	/* 회원 탈퇴 */
	public void deleteUser(String user_id) throws Exception;

}
