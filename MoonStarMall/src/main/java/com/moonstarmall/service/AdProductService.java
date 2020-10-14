package com.moonstarmall.service;

import java.util.List;

import com.moonstarmall.domain.CategoryVO;

public interface AdProductService {
	
	/* 1차카테고리 조회 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차카테고리 조회 */
	public List<CategoryVO> subCategory(String cat_code) throws Exception;

}
