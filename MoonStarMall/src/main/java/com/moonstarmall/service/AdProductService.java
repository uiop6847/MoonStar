package com.moonstarmall.service;

import java.util.List;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;

public interface AdProductService {
	
	/* 1차카테고리 조회 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차카테고리 조회 */
	public List<CategoryVO> subCategory(String cat_code) throws Exception;
	
	/* 상품 등록 */
	public void productInsertOK(ProductVO vo) throws Exception;

}
