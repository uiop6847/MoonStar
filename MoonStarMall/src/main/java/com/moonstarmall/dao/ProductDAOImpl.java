package com.moonstarmall.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.util.SortCriteria;

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

	/* 카테고리별 상품 리스트 */
	@Override
	public List<Map<String, Object>> categoryProductList(String cat_code, SortCriteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("cat_code", cat_code);
		map.put("cri", cri);
		
		return session.selectList(NS + ".productList", map);
	}

	/* 카테고리별 상품 총건수 */
	@Override
	public int categoryProductCount(String cat_code, SortCriteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("cat_code", cat_code);
		map.put("cri", cri);
		
		return session.selectOne(NS + ".productCount", map);
	}

}
