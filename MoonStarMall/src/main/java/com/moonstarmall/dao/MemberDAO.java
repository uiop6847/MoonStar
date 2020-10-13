package com.moonstarmall.dao;

import java.util.Map;

import com.moonstarmall.domain.UserInfoVO;
import com.moonstarmall.dto.LoginDTO;

public interface MemberDAO {
	
	/* 회원가입 */
	public void userInfoAdd(UserInfoVO vo) throws Exception;
	
	/* 아이디 중복체크 */
	public int userIdCheck(String user_id) throws Exception;
	
	/* 이메일 중복체크 */
	public int userEmailCheck(String user_email) throws Exception;
	
	/* 로그인 */
	public LoginDTO loginOK(LoginDTO dto) throws Exception;
	
	/* 로그인 시간 업데이트 */
	public void loginUpdate(String user_id) throws Exception;

//쿠키 정상작동 안함(MemberController.java에서 주석처리
	/* 자동로그인 처리(쿠키저장) */
	public void saveCookie(Map<String, Object> map) throws Exception;
	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	public UserInfoVO checkUserSession(String value) throws Exception;
	
	/* 회원정보 상세조회 */
	public UserInfoVO userInfoSelect(String user_id) throws Exception;
	
	/* 회원정보 수정 */
	public void modifyUserInfo(UserInfoVO vo) throws Exception;
	
	/* 회원 탈퇴 */
	public void deleteUser(String user_id) throws Exception;

}
