package com.moonstarmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.StatusVO;

@Repository
public class StatusDAOImpl implements StatusDAO {
	
	@Autowired
	private SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.StatusMapper";

	/* 상태테이블 리스트 조회 */
	@Override
	public List<StatusVO> statusList(String div_nm) throws Exception {
		return session.selectList(NS + ".statusList", div_nm);
	}

}
