package com.moonstarmall.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.domain.OrderVO;
import com.moonstarmall.dto.LoginDTO;
import com.moonstarmall.service.OrderService;
import com.moonstarmall.util.DateCriteria;
import com.moonstarmall.util.PageMaker;

@Controller
@RequestMapping("/order/*")
public class OrderController {
	
	@Autowired
	private OrderService service;
	
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	/* 주문요청내역 조회  
	 * 
	 * @cartType
	 * 	D : 상품상세정보 -> 주문하기
	 * 	A : 장바구니 -> 주문하기
	 * 	All : 장바구니 -> 전체주문, 선택주문
	 * */
	@RequestMapping(value = "orderForm", method = RequestMethod.POST)
	public void orderInfoSelect(@RequestParam("cartType") String type, CartVO list, Model model, HttpSession session) throws Exception {
		logger.info("orderInfoSelect() called");
		
		LoginDTO dto = (LoginDTO) session.getAttribute("user");
		String user_id = dto.getUser_id();
		
		list.setUser_id(user_id); // type D에서 사용할 목적
		
		List<Map<String, Object>> orderInfo = service.orderInfoSelect(type, list);
			
		for(int i=0; i<orderInfo.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();
			
			// map key를 소문자로 변경
			for(String key : orderInfo.get(i).keySet()) {
				vo.put(key.toLowerCase(), orderInfo.get(i).get(key));
			}
			// 변경된 map을 다시 list에 세팅
			orderInfo.set(i, vo);
		}
		
		logger.info("=====orderInfo : " + orderInfo);
		model.addAttribute("orderInfoList", orderInfo); // 주문내역
			
		model.addAttribute("orderAddr", service.orderAddrInfo(user_id)); // 배송정보
		model.addAttribute("userPoint", service.userPoint(user_id)); // 사용가능 적립금
	}
	
	/* 주문정보 저장처리 */
	@RequestMapping(value = "orderInfoAdd", method = RequestMethod.POST)
	public String orderInfoAdd(CartVO cartList, OrderVO order, int use_point, HttpSession session) throws Exception {
		logger.info("orderInfoAdd() called");
		
		LoginDTO dto = (LoginDTO) session.getAttribute("user");
		String user_id = dto.getUser_id();
		
		service.orderInfoAdd(cartList, order, user_id, use_point);
		
		return "redirect:/order/orderComplete";
	}
	
	/* 주문완료 화면으로 이동 */
	@RequestMapping(value = "orderComplete", method = RequestMethod.GET)
	public String orderComplete() {
		logger.info("orderComplete() called");
		
		return "/order/orderComplete";
	}
	
	/* 주문내역 조회 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String orderList(@ModelAttribute("cri") DateCriteria cri, HttpSession session, Model model) throws Exception {
		logger.info("orderList() called");
		
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login";
		}
		
		LoginDTO dto = (LoginDTO) session.getAttribute("user");
		String user_id = dto.getUser_id();
		
		// 검색조건이 없으면 2년전 날짜까지 조회하도록 세팅
		if(cri.getFromDate() == null || cri.getToDate() == null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(new Date());
			cri.setToDate(format.format(cal.getTime()));
			
			cal.add(Calendar.YEAR, -2);
			cri.setFromDate(format.format(cal.getTime()));
		}
		
		List<Map<String, Object>> list = service.orderList(cri, user_id);
		for(int i=0; i<list.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();	
			
			// map key를 소문자로 변경
			for(String key : list.get(i).keySet()) {
				vo.put(key.toLowerCase(), list.get(i).get(key));
			}
			// 변경된 map을 다시 list에 세팅
			list.set(i, vo);
		}
		model.addAttribute("orderList", list);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.orderCount(cri, user_id));
		
		model.addAttribute("pm", pm);
		
		return "/order/list";
	}

}
