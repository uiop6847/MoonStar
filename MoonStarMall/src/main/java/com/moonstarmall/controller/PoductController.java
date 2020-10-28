package com.moonstarmall.controller;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.service.ProductService;

@Controller
@RequestMapping("/product/*")
public class PoductController {

	@Autowired
	ProductService service;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PoductController.class);
	
	/* 1차 카테고리에 따른 2차 카테고리 출력*/
	@ResponseBody
	@RequestMapping(value = "subCategoryList/{cat_code}", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cat_code") String cat_code) {
		logger.info("subCategoryList() called");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategoryList(cat_code), HttpStatus.OK); 
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
	
}
