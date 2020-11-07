package com.moonstarmall.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.dto.LoginDTO;
import com.moonstarmall.service.CartService;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Autowired
	private CartService service;
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	/* 장바구니 조회 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void cartList() {
		logger.info("cartList() called");
	}
	
	/* 동일한 상품이 장바구니에 존재하는지 확인 */
	@RequestMapping(value = "itemCheck", method = RequestMethod.POST)
	public ResponseEntity<String> cartItemCheck(CartVO vo, HttpSession session){
		logger.info("cartItemCheck() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			if(session.getAttribute("user") == null) {
				entity = new ResponseEntity<String>("N_SESSION", HttpStatus.OK);
				
			}else {
				LoginDTO dto = (LoginDTO) session.getAttribute("user");
				vo.setUser_id(dto.getUser_id());
				
				logger.info("=====CartVO : " + vo);
				int itemCheck = service.cartItemCheck(vo);
				
				if(itemCheck == 0) {
					entity = new ResponseEntity<String>("INSERT", HttpStatus.OK);
				}else {
					entity = new ResponseEntity<String>("UPDATE", HttpStatus.OK);
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 장바구니 등록 및 수량 변경 */
	@RequestMapping(value = "cartUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> cartUpdate(CartVO vo, HttpSession session) {
		logger.info("cartUpdate() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			LoginDTO dto = (LoginDTO) session.getAttribute("user");
			vo.setUser_id(dto.getUser_id());
			
			logger.info("=====CartVO : " + vo);
			service.cartUpdate(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		logger.info("=====entity : " + entity);
		return entity;
	}

	
	/* 장바구니 삭제 */
}
