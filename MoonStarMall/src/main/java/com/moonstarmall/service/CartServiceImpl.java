package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.CartDAO;
import com.moonstarmall.domain.CartVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartDAO dao;

	/* 장바구니 조회 */
	@Override
	public List<CartVO> cartList(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
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

	/* 장바구니 삭제 */
	@Override
	public void cartDelete(int cart_cd) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
