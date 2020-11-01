package com.moonstarmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	/* 메인 상품 리스트 */
	@ModelAttribute
	public void productList(Model model) throws Exception{
		
		List<Map<String, Object>> newList = service.newProductList();
		
		for(int i=0; i<newList.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();	
			
			// map key를 소문자로 변경
			for(String key : newList.get(i).keySet()) {
				vo.put(key.toLowerCase(), newList.get(i).get(key));
			}
			
			// 변경된 map을 다시 list에 세팅
			newList.set(i, vo);
		}
		model.addAttribute("newProductList", newList);
	}
	
}
