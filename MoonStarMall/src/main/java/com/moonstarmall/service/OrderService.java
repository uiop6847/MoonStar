package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.domain.DeliveryVO;
import com.moonstarmall.domain.OrderVO;

public interface OrderService {

	/* 주문요청내역 조회 */
	public List<Map<String, Object>> orderInfoSelect(String type, CartVO list) throws Exception;
	
	/* 주문 배송정보 조회 */
	public DeliveryVO orderAddrInfo(String user_id) throws Exception;
	
	/* 사용자 적립금 조회 */
	public int userPoint(String user_id) throws Exception;
	
	/* 주문정보 저장처리 */
	public void orderInfoAdd(CartVO cartList, OrderVO order, String user_id, int use_point) throws Exception;
}
