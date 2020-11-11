package com.moonstarmall.service;

import com.moonstarmall.domain.DeliveryVO;

public interface DeliveryService {
	
	/* 주문내역 주소 조회 */
	public DeliveryVO orderAddrInfo(String user_id) throws Exception;

}
