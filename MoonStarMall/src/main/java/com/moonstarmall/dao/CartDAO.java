package com.moonstarmall.dao;

import java.util.List;

import com.moonstarmall.domain.CartVO;

public interface CartDAO {
	
	/* 장바구니 조회 */
	public List<CartVO> cartList(int pro_num, String user_id) throws Exception;
	
	/* 동일한 상품이 장바구니에 존재하는지 확인 */
	public int cartItemCheck(CartVO vo) throws Exception;
	
	/* 장바구니 수량 변경 */
	public void cartUpdate(CartVO vo) throws Exception;
	
	/* 장바구니 삭제 */
	public void cartDelete(int cart_cd) throws Exception;

}
