package com.moonstarmall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.moonstarmall.domain.CategoryVO;

public interface ProductService {

	/* 1차 카테고리 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차 카테고리 */
	public List<CategoryVO> subCategoryList(String cat_code) throws Exception;
}
