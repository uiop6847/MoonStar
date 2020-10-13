package com.moonstarmall.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moonstarmall.dao.MemberDAO;
import com.moonstarmall.domain.UserInfoVO;
import com.moonstarmall.dto.LoginDTO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired  // 주입 이노테이션.  이 클래스의 bean객체 생성 : spring-security.xml
	private BCryptPasswordEncoder crptPassEnc;

	/* 회원가입 */
	@Override
	public void userInfoAdd(UserInfoVO vo) throws Exception{
		dao.userInfoAdd(vo);
	}

	/* 아이디 중복체크 */
	@Override
	public int userIdCheck(String user_id) throws Exception{
		return dao.userIdCheck(user_id);
	}

	/* 이메일 중복체크 */
	@Override
	public int userEmailCheck(String user_email) throws Exception{
		return dao.userEmailCheck(user_email);
	}

	/* 로그인 */
	@Transactional
	@Override
	public LoginDTO loginOK(LoginDTO dto) throws Exception {
		
		LoginDTO loginDTO = dao.loginOK(dto);
		
		// 입력된 비밀번호와 암호화된 비밀번호가 맞는지 확인
		if(loginDTO != null) {
			if(crptPassEnc.matches(dto.getUser_pw(), loginDTO.getUser_pw())) {
				dao.loginUpdate(loginDTO.getUser_id());
			}else {
				// 비밀번호가 일치하지 않으면
				loginDTO = null;
			}
		}
		
		return loginDTO;
	}

	/* 자동로그인 처리(쿠키저장) */
	@Override
	public void saveCookie(String sessionKey, Date sessionLimit, String user_id) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("session_key", sessionKey);
		map.put("session_limit", sessionLimit);
		map.put("user_id", user_id);
		
		dao.saveCookie(map);
	}

	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	@Override
	public UserInfoVO checkUserSession(String value) throws Exception {
		return dao.checkUserSession(value);
	}

	/* 회원정보 상세조회 */
	@Override
	public UserInfoVO userInfoSelect(String user_id) throws Exception {
		return dao.userInfoSelect(user_id);
	}

	/* 회원정보 수정 */
	@Override
	public void modifyUserInfo(UserInfoVO vo) throws Exception {
		dao.modifyUserInfo(vo);
	}

	/* 회원 탈퇴 */
	@Override
	public void deleteUser(String user_id) throws Exception {
		dao.deleteUser(user_id);
	}
}
