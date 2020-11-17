package com.moonstarmall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.service.ProductService;

@Controller
public class MainController {
	
	@Autowired
	private ProductService service;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		logger.info("mainProductList() called");
		/* 메인 상품 리스트 */
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
		
		return "index";
	}
}
