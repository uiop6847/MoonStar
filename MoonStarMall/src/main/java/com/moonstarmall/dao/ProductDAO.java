package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CategoryVO;

public interface ProductDAO {

	/* 1차 카테고리 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차 카테고리 */
	public List<CategoryVO> subCategoryList(String cat_code) throws Exception;
	
	/* new상품 리스트(main진열) */
	public List<Map<String, Object>> newProductList() throws Exception;
}
