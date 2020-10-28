package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.ProductDAO;
import com.moonstarmall.domain.CategoryVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO dao;

	/* 1차 카테고리 */
	@Override
	public List<CategoryVO> mainCategory() throws Exception {
		return dao.mainCategory();
	}

	/* 2차 카테고리 */
	@Override
	public List<CategoryVO> subCategoryList(String cat_code) throws Exception {
		return dao.subCategoryList(cat_code);
	}

}
