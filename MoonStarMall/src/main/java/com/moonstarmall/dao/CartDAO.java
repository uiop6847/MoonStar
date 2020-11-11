package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CartVO;

public interface CartDAO {
	
	/* 동일한 상품이 장바구니에 존재하는지 확인 */
	public int cartItemCheck(CartVO vo) throws Exception;
	
	/* 장바구니 수량 변경 */
	public void cartUpdate(CartVO vo) throws Exception;
	
	/* 장바구니 list */
	public List<Map<String, Object>> cartList(String user_id) throws Exception;
	
	/* 장바구니에 등록된 상품 수량 변경 */
	public void buyCountUpdate(CartVO vo) throws Exception;
	
	/* 장바구니 삭제 */
	public void cartDelete(Map<String, Object> map) throws Exception;
	
	/* 사용자의 장바구니 총 개수 */
	public int cartCount(String user_id) throws Exception;

}
