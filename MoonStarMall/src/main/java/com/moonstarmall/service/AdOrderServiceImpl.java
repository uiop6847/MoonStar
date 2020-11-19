package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.AdOrderDAO;
import com.moonstarmall.domain.OrderVO;
import com.moonstarmall.util.OrderSearchCriteria;

@Service
public class AdOrderServiceImpl implements AdOrderService {
	
	@Autowired
	private AdOrderDAO dao;

	/* 주문목록 조회 */
	@Override
	public List<OrderVO> orderList(OrderSearchCriteria cri) throws Exception {
		return dao.orderList(cri);
	}

	/* 주문 총 건수 */
	@Override
	public int orderCount(OrderSearchCriteria cri) throws Exception {
		return dao.orderCount(cri);
	}

	/* 주문처리상태 update*/
	@Override
	public void ordStatusUpdate(List<OrderVO> list) throws Exception {
		dao.ordStatusUpdate(list);
	}

}
