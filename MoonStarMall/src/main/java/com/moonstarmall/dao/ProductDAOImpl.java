package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CategoryVO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired
	private SqlSession session;
	
	public final static String NS = "com.moonstarmall.mappers.ProductMapper";

	/* 1차 카테고리 */
	@Override
	public List<CategoryVO> mainCategory() throws Exception {
		return session.selectList(NS + ".mainCategory");
	}

	/* 2차 카테고리 */
	@Override
	public List<CategoryVO> subCategoryList(String cat_code) throws Exception {
		return session.selectList(NS + ".subCategory", cat_code);
	}

	/* new상품 리스트(main진열) */
	@Override
	public List<Map<String, Object>> newProductList() throws Exception {
		return session.selectList(NS + ".newProductList");
	}

}
