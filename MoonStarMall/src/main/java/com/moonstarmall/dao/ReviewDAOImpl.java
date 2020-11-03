package com.moonstarmall.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moonstarmall.domain.ReviewVO;
import com.moonstarmall.util.Criteria;

@Repository
public class ReviewDAOImpl implements ReviewDAO{
	
	@Autowired
	private SqlSession session;
	
	private final static String NS = "com.moonstarmall.mappers.ReviewMapper";

	/* 상품 후기 쓰기 */
	@Override
	public void reviewWrite(ReviewVO vo) throws Exception {
		session.insert(NS + ".write", vo);
	}

	/* 상품 후기 수정 */
	@Override
	public void reviewModify(ReviewVO vo) throws Exception {
		session.update(NS + ".modify", vo);
	}

	/* 상품 후기 삭제 */
	@Override
	public void reviewDelete(int rew_num) throws Exception {
		session.delete(NS + ".delete", rew_num);
	}

	/* 상품 후기 리스트(페이지 포함) */
	@Override
	public List<ReviewVO> reviewList(int pro_num, Criteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pro_num", pro_num);
		map.put("cri", cri);
		
		return session.selectList(NS + ".list", map);
	}

	/* 상품 후기 총 개수 */
	@Override
	public int reviewCount(int pro_num) throws Exception {
		return session.selectOne(NS + ".totalCount", pro_num);
	}

	
}
