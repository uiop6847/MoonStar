package com.moonstarmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moonstarmall.domain.CartVO;
import com.moonstarmall.dto.LoginDTO;
import com.moonstarmall.service.CartService;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Autowired
	private CartService service;
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
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
		
		return entity;
	}
	
	/* 장바구니 list */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String cartList(Model model, HttpSession session) throws Exception {
		logger.info("cartList() called");
		
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login";
		}
		
		LoginDTO dto = (LoginDTO) session.getAttribute("user");
		List<Map<String, Object>> list = service.cartList(dto.getUser_id());
		logger.info("=====list : " + list);
		for(int i=0; i<list.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();	
			
			// map key를 소문자로 변경
			for(String key : list.get(i).keySet()) {
				vo.put(key.toLowerCase(), list.get(i).get(key));
			}
			// 변경된 map을 다시 list에 세팅
			list.set(i, vo);
		}

		model.addAttribute("cartList", list);
		model.addAttribute("listTotal", list.size());
		
		return "/cart/list";
	}
	
	/* 장바구니에 등록된 상품 수량 변경 */
	@RequestMapping(value = "buyCountUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> buyCountUpdate(CartVO vo){
		logger.info("buyCountUpdate() called");
		
		logger.info("=====CartVO : " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.buyCountUpdate(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

	/* 장바구니 삭제 */
	@RequestMapping(value = "cartDelete", method = RequestMethod.POST)
	public ResponseEntity<String> cartDelete(@RequestParam("cartCdArr[]") List<Integer> cartCdArr) {
		logger.info("cartCheckDelete() called");
		logger.info("cartCdArr : " + cartCdArr);
		ResponseEntity<String> entity = null;
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			String cart_cd = null;

			for(int i=0; i<cartCdArr.size(); i++) {
				cart_cd += "," + cartCdArr.get(i);
			}
			cart_cd = cart_cd.substring(5); // null,을 제외한 값 가져오기
			logger.info("cart_cd : " + cart_cd);
			map.put("cart_cd", cart_cd);
			
			service.cartDelete(map);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
