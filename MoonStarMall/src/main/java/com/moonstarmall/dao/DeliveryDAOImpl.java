package com.moonstarmall.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.DeliveryVO;

@Repository
public class DeliveryDAOImpl implements DeliveryDAO {
	
	@Autowired
	private SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.DeliveryMapper";

	/* 기본배송지 조회 */
	@Override
	public DeliveryVO defaultAddr(String user_id) throws Exception {
		return session.selectOne(NS + ".defaultAddr", user_id);
	}

}
