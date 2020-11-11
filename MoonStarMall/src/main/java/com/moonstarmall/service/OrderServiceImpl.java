package com.moonstarmall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moonstarmall.dao.CartDAO;
import com.moonstarmall.dao.MemberDAO;
import com.moonstarmall.dao.OrderDAO;
import com.moonstarmall.domain.CartVO;
import com.moonstarmall.domain.DeliveryVO;
import com.moonstarmall.domain.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDAO dao;
	@Autowired
	private CartDAO cart;
	@Autowired
	private MemberDAO member;
	
	/* 주문요청내역 조회  */
	@Override
	public List<Map<String, Object>> orderInfoSelect(String type, CartVO list) throws Exception {
		
		List<Map<String, Object>> orderInfo = null;
		
		if(type.equals("D")) {
			
			orderInfo = dao.orderInfoSelect(list);
			
		}else if(type.equals("A")) {
			for(CartVO vo : list.getList()) {
				if(vo.getCart_cd() != 0) {
					orderInfo = dao.orderInfoSelect(vo.getCart_cd());
				}
			}
			
		}else if(type.equals("All")) {
			Map<String, Object> map = new HashMap<String, Object>();
			String cartCdList = null;
			
			for(CartVO vo : list.getList()) {
				if(vo.getCart_cd() != 0) {
					cartCdList += "," + vo.getCart_cd();
				}
			}
			cartCdList = cartCdList.substring(5); // null,을 제외한 값 가져오기
			map.put("cart_cd", cartCdList);
			
			orderInfo = dao.orderInfoSelect(map);
			
		}
		
		return orderInfo;
	}

	/* 주문 배송정보 조회 */
	@Override
	public DeliveryVO orderAddrInfo(String user_id) throws Exception {
		
		DeliveryVO vo = null;
		
		// 기본배송지 우선적용
		vo = dao.defaultAddr(user_id);
		
		// 기본배송지가 없으면 사용자정보에 등록된 주소 적용
		if(vo == null) {
			vo = dao.userAddr(user_id);
		}
		
		return vo;
	}

	/* 사용자 적립금 조회 */
	@Override
	public int userPoint(String user_id) throws Exception {
		return dao.userPoint(user_id);
	}

	/* 주문정보 저장처리 */
	@Transactional
	@Override
	public void orderInfoAdd(CartVO cartList, OrderVO order, String user_id, int use_point) throws Exception {
		// 시퀀스번호 조회
		int ordSeq = dao.orderSeq();
		
		if(ordSeq != 0) {
			// 주문정보 저장
			order.setOrd_cd(ordSeq);
			order.setUser_id(user_id);
			System.out.println("=====orderInsert() called");
			System.out.println("=====order : " + order);
			dao.orderInsert(order);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			String cart_cd = null;
			for(CartVO vo : cartList.getList()) {
				if(vo.getCart_cd() != 0) {
					cart_cd += "," + vo.getCart_cd();
				}
			}
			cart_cd = cart_cd.substring(5); // null,을 제외한 값 가져오기

			map.put("ord_cd", ordSeq);
			map.put("cart_cd", cart_cd);
			
			// 주문정보상세 저장
			dao.orderDtlInsert(map);
			
			// 장바구니 삭제
			cart.cartDelete(map);
			
			if(use_point != 0) {
				// 사용한 적립금 차감
				member.usePoint(user_id, use_point);
			}
		}
	}
	
}
