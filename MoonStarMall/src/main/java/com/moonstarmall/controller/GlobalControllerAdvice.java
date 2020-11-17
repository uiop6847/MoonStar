package com.moonstarmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.moonstarmall.service.ProductService;

@ControllerAdvice(basePackages = {"com.moonstarmall.controller"})
public class GlobalControllerAdvice {

	@Autowired
	private ProductService service;
	
	/* 1차 카테고리 메뉴 표시 */
	@ModelAttribute
	public void categoryList(Model model) throws Exception{
		model.addAttribute("mainCategoryList", service.mainCategory());
	}
	
}
