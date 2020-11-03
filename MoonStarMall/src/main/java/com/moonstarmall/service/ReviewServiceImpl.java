package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.ReviewDAO;
import com.moonstarmall.domain.ReviewVO;
import com.moonstarmall.util.Criteria;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDAO dao;
	
	/* 상품 후기 쓰기 */
	@Override
	public void reviewWrite(ReviewVO vo) throws Exception {
		dao.reviewWrite(vo);
	}

	/* 상품 후기 수정 */
	@Override
	public void reviewModify(ReviewVO vo) throws Exception {
		dao.reviewModify(vo);
	}

	/* 상품 후기 삭제 */
	@Override
	public void reviewDelete(int rew_num) throws Exception {
		dao.reviewDelete(rew_num);
	}

	/* 상품 후기 리스트(페이지 포함) */
	@Override
	public List<ReviewVO> reviewList(int pro_num, Criteria cri) throws Exception {
		return dao.reviewList(pro_num, cri);
	}

	/* 상품 후기 총 개수 */
	@Override
	public int reviewCount(int pro_num) throws Exception {
		return dao.reviewCount(pro_num);
	}

}
