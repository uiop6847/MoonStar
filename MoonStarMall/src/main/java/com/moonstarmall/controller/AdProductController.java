package com.moonstarmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {
	
	/* 상품 등록 이동 */
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public void productInsert(Model model) {
		
		
		// 1차카테고리 출력
		
	}
	
	

}
