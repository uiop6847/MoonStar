package com.moonstarmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {
	
	@Autowired
	SqlSession session;
	
	public final static String NS = "com.moonstarmall.mappers.CartMapper";

	/* 장바구니 조회 */
	@Override
	public List<CartVO> cartList(int pro_num, String user_id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
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

	/* 장바구니 삭제 */
	@Override
	public void cartDelete(int cart_cd) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
