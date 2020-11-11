package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.CartDAO;
import com.moonstarmall.domain.CartVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartDAO dao;
	
	/* 동일한 상품이 장바구니에 존재하는지 확인 */
	@Override
	public int cartItemCheck(CartVO vo) throws Exception {
		return dao.cartItemCheck(vo);
	}

	/* 장바구니 수량 변경 */
	@Override
	public void cartUpdate(CartVO vo) throws Exception {
		dao.cartUpdate(vo);
	}

	/* 장바구니 list */
	@Override
	public List<Map<String, Object>> cartList(String user_id) throws Exception {
		return dao.cartList(user_id);
	}

	/* 장바구니에 등록된 상품 수량 변경 */
	@Override
	public void buyCountUpdate(CartVO vo) throws Exception {
		dao.buyCountUpdate(vo);
	}
	
	/* 장바구니 삭제 */
	@Override
	public void cartDelete(Map<String, Object> map) throws Exception {
		dao.cartDelete(map);
	}

	/* 사용자의 장바구니 총 개수 */
	@Override
	public int cartCount(String user_id) throws Exception {
		return dao.cartCount(user_id);
	}


}
