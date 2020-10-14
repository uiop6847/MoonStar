package com.moonstarmall.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.service.AdProductService;

@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {
	
	@Autowired
	private AdProductService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdProductController.class);
	
	/* 상품 등록 이동 */
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public void productInsert(Model model) throws Exception {
		logger.info("productInsert() called");
		
		// 1차카테고리 전송
		model.addAttribute("mainCategory", service.mainCategory());
	}
	
	

}
