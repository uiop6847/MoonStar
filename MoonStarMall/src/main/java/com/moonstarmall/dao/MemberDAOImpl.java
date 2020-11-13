package com.moonstarmall.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.UserInfoVO;
import com.moonstarmall.dto.LoginDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSession session;
	
	public final static String NS = "com.moonstarmall.mappers.UserInfoMapper";

	/* 회원가입 */
	@Override
	public void userInfoAdd(UserInfoVO vo) throws Exception {
		session.insert(NS + ".userInfoAdd", vo);
	}

	/* 아이디 중복체크 */
	@Override
	public int userIdCheck(String user_id) throws Exception {
		return session.selectOne(NS + ".userIdCheck", user_id);
	}

	/* 이메일 중복체크 */
	@Override
	public int userEmailCheck(String user_email) throws Exception {
		return session.selectOne(NS + ".userEmailCheck", user_email);
	}

	/* 로그인 */
	@Override
	public LoginDTO loginOK(LoginDTO dto) throws Exception {
		return session.selectOne(NS + ".loginOK", dto);
	}

	/* 로그인 시간 업데이트 */
	@Override
	public void loginUpdate(String user_id) throws Exception {
		session.update(NS + ".loginUpdate", user_id);
	}

	/* 자동로그인 처리(쿠키저장) */
	@Override
	public void saveCookie(Map<String, Object> map) throws Exception {
		session.update(NS + ".saveCookie", map);
	}

	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	@Override
	public UserInfoVO checkUserSession(String value) throws Exception {
		return session.selectOne(NS + ".checkUserSession", value);
	}

	/* 회원정보 상세조회 */
	@Override
	public UserInfoVO userInfoSelect(String user_id) throws Exception {
		return session.selectOne(NS + ".userInfoSelect", user_id);
	}
	
	/* 회원정보 수정 */
	@Override
	public void modifyUserInfo(UserInfoVO vo) throws Exception {
		session.update(NS + ".modifyUserInfo", vo);
	}

	/* 회원 탈퇴 */
	@Override
	public void deleteUser(String user_id) throws Exception {
		session.delete(NS + ".deleteUser", user_id);
	}
	
	/* 사용자 적립금 조회 */
	@Override
	public int userPoint(String user_id) throws Exception {
		return session.selectOne(NS + ".userPoint", user_id);
	}

	/* 사용한 적립금 차감 */
	@Override
	public void usePoint(String user_id, int user_point) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("user_id", user_id);
		map.put("user_point", user_point);
		
		session.update(NS + ".usePoint", map);
	}
	

}
