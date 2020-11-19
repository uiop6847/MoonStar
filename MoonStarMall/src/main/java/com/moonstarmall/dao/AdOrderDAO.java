package com.moonstarmall.dao;

import java.util.List;

import com.moonstarmall.domain.OrderVO;
import com.moonstarmall.util.OrderSearchCriteria;

public interface AdOrderDAO {
	
	/* 주문목록 조회 */
	public List<OrderVO> orderList(OrderSearchCriteria cri) throws Exception;
	
	/* 주문 총 건수 */
	public int orderCount(OrderSearchCriteria cri) throws Exception;
	
	/* 주문처리상태 update*/
	public void ordStatusUpdate(List<OrderVO> list) throws Exception;

}
