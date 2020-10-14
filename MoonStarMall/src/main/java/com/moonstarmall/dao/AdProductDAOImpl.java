package com.moonstarmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CategoryVO;

@Repository
public class AdProductDAOImpl implements AdProductDAO {
	
	@Autowired
	SqlSession session;
	
	public final static String NS="com.moonstarmall.mappers.AdProductMapper";

	/* 1차카테고리 조회 */
	@Override
	public List<CategoryVO> mainCategory() throws Exception {
		return session.selectList(NS + ".mainCategory");
	}

	/* 2차카테고리 조회 */
	@Override
	public List<CategoryVO> subCategory(String cat_code) throws Exception {
		return session.selectList(NS + ".subCategory", cat_code);
	}
	

}
