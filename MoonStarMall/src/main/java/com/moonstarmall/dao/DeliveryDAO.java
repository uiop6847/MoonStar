package com.moonstarmall.dao;

import com.moonstarmall.domain.DeliveryVO;

public interface DeliveryDAO {
	
	/* 기본배송지 조회 */
	public DeliveryVO defaultAddr(String user_id) throws Exception;

	/* 사용자배송지 조회 */
	public DeliveryVO userAddr(String user_id) throws Exception;

}
