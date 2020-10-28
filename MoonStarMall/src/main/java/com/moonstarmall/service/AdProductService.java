package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;
import com.moonstarmall.util.SearchCriteria;

public interface AdProductService {
	
	/* 1차카테고리 조회 */
	public List<CategoryVO> mainCategory() throws Exception;
	
	/* 2차카테고리 조회 */
	public List<CategoryVO> subCategory(String cat_code) throws Exception;
	
	/* 상품 등록 */
	public void productInsertOK(ProductVO vo) throws Exception;
	
	/* 상품 리스트 */
	public List<ProductVO> productList(SearchCriteria cri) throws Exception;
	
	/* 검색조건별 상품 총 건수 */
	public int productSearchCount(SearchCriteria cri) throws Exception;
	
	/* 상품 상세정보 조회 */
	public ProductVO readProduct(int pro_num) throws Exception;
	
	/* 체크된 상품리스트 조회 */
	public List<ProductVO> productEditList(Map<String, Object> map) throws Exception;
	
	/* 상품 수정 */
	public void productEditOK(ProductVO vo) throws Exception;
	
	/* 상품 삭제 */
	public void productDelete(Map<String, Object> map) throws Exception;

}
