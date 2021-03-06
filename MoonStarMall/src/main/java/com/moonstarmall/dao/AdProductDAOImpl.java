package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;
import com.moonstarmall.util.SearchCriteria;

@Repository
public class AdProductDAOImpl implements AdProductDAO {
	
	@Autowired
	private SqlSession session;
	
	public final static String NS = "com.moonstarmall.mappers.AdProductMapper";

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

	/* 상품 등록 */
	@Override
	public void productInsertOK(ProductVO vo) throws Exception {
		session.insert(NS + ".insertOK", vo);
	}

	/* 상품 리스트 */
	@Override
	public List<ProductVO> productList(SearchCriteria cri) throws Exception {
		return session.selectList(NS + ".list", cri);
	}

	/* 검색조건별 상품 총 건수 */
	@Override
	public int productSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NS + ".searchCount", cri);
	}

	/* 상품 상세정보 조회 */
	@Override
	public ProductVO readProduct(int pro_num) throws Exception {
		return session.selectOne(NS + ".readProduct", pro_num);
	}

	/* 체크된 상품리스트 조회 */
	@Override
	public List<ProductVO> productEditList(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".editList", map);
	}

	/* 상품 수정 */
	@Override
	public void productEditOK(ProductVO vo) throws Exception {
		session.update(NS + ".editOK" , vo);
	}

	/* 상품 삭제 */
	@Override
	public void productDelete(Map<String, Object> map) throws Exception {
		session.delete(NS + ".delete", map);
	}
	
	
	
	

}
