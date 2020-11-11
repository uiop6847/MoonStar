package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.domain.DeliveryVO;
import com.moonstarmall.domain.OrderVO;

public interface OrderDAO {
	
	/* 상품상세정보에 대한 주문요청내역 조회 */
	public List<Map<String, Object>> orderInfoSelect(CartVO vo) throws Exception;
	
	/* 주문요청내역 조회 : 단건 */
	public List<Map<String, Object>> orderInfoSelect(int cart_cd) throws Exception;
	
	/* 주문요청내역 조회 : 여러건 */
	public List<Map<String, Object>> orderInfoSelect(Map<String, Object> map) throws Exception;
	
	/* 기본배송지 조회 */
	public DeliveryVO defaultAddr(String user_id) throws Exception;

	/* 사용자배송지 조회 */
	public DeliveryVO userAddr(String user_id) throws Exception;
	
	/* 사용자 적립금 조회 */
	public int userPoint(String user_id) throws Exception;
	
	/* 주문번호 시퀀스 조회 */
	public int orderSeq() throws Exception;
	
	/* 주문정보 저장 */
	public void orderInsert(OrderVO vo) throws Exception;
	
	/* 주문정보상세 저장 */
	public void orderDtlInsert(Map<String, Object> map) throws Exception;
}
