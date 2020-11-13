package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.domain.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	private SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.OrderMapper";
	
	/* 상품상세정보에 대한 주문요청내역 조회 */
	@Override
	public List<Map<String, Object>> orderInfoSelect(CartVO vo) throws Exception {
		return session.selectList(NS + ".proDtlorderInfo", vo);
	}
	
	/* 주문요청내역 조회 : 단건 */
	@Override
	public List<Map<String, Object>> orderInfoSelect(int cart_cd) throws Exception {
		return session.selectList(NS + ".orderInfoOne", cart_cd);
	}
	/* 주문요청내역 조회 : 여러건 */
	@Override
	public List<Map<String, Object>> orderInfoSelect(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".orderInfoAll", map);
	}
	
	/* 주문번호 시퀀스 조회 */
	@Override
	public int orderSeq() throws Exception {
		return session.selectOne(NS + ".orderSeq");
	}
	
	/* 주문정보 저장 */
	@Override
	public void orderInsert(OrderVO vo) throws Exception {
		session.insert(NS + ".orderInsert", vo);
	}
	
	/* 주문정보상세 저장 */
	@Override
	public void orderDtlInsert(Map<String, Object> map) throws Exception {
		session.insert(NS + ".orderDtlInsert", map);
	}

	/* 주문내역 조회 */
	@Override
	public List<OrderVO> orderList(String user_id) throws Exception {
		return session.selectList(NS + ".list", user_id);
	}

}
