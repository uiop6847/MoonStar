package com.moonstarmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.DeliveryDAO;
import com.moonstarmall.domain.DeliveryVO;

@Service
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	private DeliveryDAO dao;
	
	/* 주문내역 주소 조회 */
	@Override
	public DeliveryVO orderAddrInfo(String user_id) throws Exception {
		return dao.defaultAddr(user_id);
	}

}
