package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.util.SearchCriteria;

@Repository
public class AdMemberDAOImpl implements AdMemberDAO {
	
	@Autowired
	SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.AdUserInfoMapper";

	/* 회원 리스트 */
	@Override
	public List<Map<String, Object>> userList(SearchCriteria cri) throws Exception {
		return session.selectList(NS + ".userList", cri);
	}

	/* 회원 총 건수 */
	@Override
	public int userCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NS + ".userCount", cri);
	}

}
