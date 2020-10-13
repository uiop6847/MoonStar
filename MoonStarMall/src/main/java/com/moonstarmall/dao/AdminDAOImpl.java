package com.moonstarmall.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.AdminVO;
import com.moonstarmall.dto.AdminDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Autowired
	SqlSession session;
	
	public final static String NS="com.moonstarmall.mappers.AdminMapper";
	
	/* 관리자 로그인 */
	@Override
	public AdminVO login(AdminDTO dto) throws Exception {
		return session.selectOne(NS + ".login", dto);
	}

}
