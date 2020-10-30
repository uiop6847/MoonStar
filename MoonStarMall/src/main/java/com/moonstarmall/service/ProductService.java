package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.util.SortCriteria;

public interface ProductService {

	/* 1차 카테고리 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차 카테고리 */
	public List<CategoryVO> subCategoryList(String cat_code) throws Exception;
	
	/* new상품 리스트(main진열) */
	public List<Map<String, Object>> newProductList() throws Exception;
	
	/* 카테고리별 상품 리스트 */
	public List<Map<String, Object>> categoryProductList(String cat_code, SortCriteria cri) throws Exception;
	
	/* 카테고리별 상품 총건수 */
	public int categoryProductCount(String cat_code, SortCriteria cri) throws Exception;
	
}
