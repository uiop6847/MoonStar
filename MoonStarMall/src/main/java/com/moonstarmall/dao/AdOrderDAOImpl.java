package com.moonstarmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.OrderVO;
import com.moonstarmall.util.OrderSearchCriteria;

@Repository
public class AdOrderDAOImpl implements AdOrderDAO {
	
	@Autowired
	private SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.AdOrderMapper";

	/* 주문목록 조회 */
	@Override
	public List<OrderVO> orderList(OrderSearchCriteria cri) throws Exception {
		return session.selectList(NS + ".orderList", cri);
	}

	/* 주문 총 건수 */
	@Override
	public int orderCount(OrderSearchCriteria cri) throws Exception {
		return session.selectOne(NS + ".orderCount", cri);
	}

	/* 주문처리상태 update*/
	@Override
	public void ordStatusUpdate(List<OrderVO> list) throws Exception {
		session.update(NS + ".ordStatusUpdate", list);
	}

}
