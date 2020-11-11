package com.moonstarmall.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.domain.DeliveryVO;
import com.moonstarmall.service.DeliveryService;

@Controller
@RequestMapping("/delivery/*")
public class DeliveryController {
	
	@Autowired
	private DeliveryService service;
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryController.class);
	
	/* 주문내역 주소 조회 */
	@RequestMapping(value = "orderAddrInfo", method = RequestMethod.POST)
	public void orderAddrInfo(String user_id, Model model) throws Exception {
		logger.info("orderAddrInfo() called");
		
		DeliveryVO vo = service.orderAddrInfo(user_id);
		
		logger.info("=====vo : " + vo);
		
		model.addAttribute("addrInfo", vo);
	}
}
