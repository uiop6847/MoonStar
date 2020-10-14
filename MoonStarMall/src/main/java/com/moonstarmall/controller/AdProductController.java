package com.moonstarmall.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moonstarmall.domain.CategoryVO;
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
	
	@ResponseBody
	@RequestMapping(value="subCategoryList/{cat_code}", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cat_code") String cat_code) {
		logger.info("subCategoryList() called");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cat_code), HttpStatus.OK);

		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);		
		}
		
		return entity;
	}

}
