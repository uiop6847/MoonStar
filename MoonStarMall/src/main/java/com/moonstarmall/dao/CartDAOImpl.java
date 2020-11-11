package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {
	
	@Autowired
	SqlSession session;
	
	public final static String NS = "com.moonstarmall.mappers.CartMapper";
	
	/* 동일한 상품이 장바구니에 존재하는지 확인 */
	@Override
	public int cartItemCheck(CartVO vo) throws Exception {
		return session.selectOne(NS + ".itemCheck", vo);
	}
	
	/* 장바구니 등록 및 수량 변경 */
	@Override
	public void cartUpdate(CartVO vo) throws Exception {
		session.update(NS + ".cartUpdate", vo);
	}

	/* 장바구니 list */
	@Override
	public List<Map<String, Object>> cartList(String user_id) throws Exception {
		return session.selectList(NS + ".list", user_id);
	}
	
	
	/* 장바구니에 등록된 상품 수량 변경 */
	@Override
	public void buyCountUpdate(CartVO vo) throws Exception {
		session.update(NS + ".buyUpdate", vo);
	}
	
	/* 장바구니 삭제 */
	@Override
	public void cartDelete(Map<String, Object> map) throws Exception {
		session.delete(NS + ".cartDelete", map);
	}

	/* 사용자의 장바구니 총 개수 */
	@Override
	public int cartCount(String user_id) throws Exception {
		return session.selectOne(NS + ".cartCount", user_id);
	}


}
