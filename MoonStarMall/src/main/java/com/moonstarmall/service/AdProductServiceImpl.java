package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.AdProductDAO;
import com.moonstarmall.domain.CategoryVO;

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

}
