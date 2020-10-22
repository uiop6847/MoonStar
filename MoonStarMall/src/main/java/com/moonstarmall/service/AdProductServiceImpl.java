package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.AdProductDAO;
import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;
import com.moonstarmall.util.SearchCriteria;

@Service
public class AdProductServiceImpl implements AdProductService {
	
	@Autowired
	private AdProductDAO dao; 

	/* 1차카테고리 조회 */
	@Override
	public List<CategoryVO> mainCategory() throws Exception {
		return dao.mainCategory();
	}

	/* 2차카테고리 조회 */
	@Override
	public List<CategoryVO> subCategory(String cat_code) throws Exception {
		return dao.subCategory(cat_code);
	}

	/* 상품 등록 */
	@Override
	public void productInsertOK(ProductVO vo) throws Exception {
		dao.productInsertOK(vo);
	}
	
	/* 상품 등록 */
	@Override
	public void productInsertOK(Map<String, Object> map) throws Exception {
		dao.productInsertOK(map);
	}

	/* 상품 리스트 */
	@Override
	public List<ProductVO> productList(SearchCriteria cri) throws Exception {
		return dao.productList(cri);
	}

	/* 검색조건별 상품 총 건수 */
	@Override
	public int productSearchCount(SearchCriteria cri) throws Exception {
		return dao.productSearchCount(cri);
	}

	/* 상품 상세정보 */
	@Override
	public ProductVO readProduct(int pro_num) throws Exception {
		return dao.readProduct(pro_num);
	}

}
