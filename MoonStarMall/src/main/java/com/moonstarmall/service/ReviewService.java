package com.moonstarmall.service;

import java.util.List;

import com.moonstarmall.domain.ReviewVO;
import com.moonstarmall.util.Criteria;

public interface ReviewService {
	
	/* 상품 후기 쓰기 */
	public void reviewWrite(ReviewVO vo) throws Exception;
	
	/* 상품 후기 수정 */
	public void reviewModify(ReviewVO vo) throws Exception;
	
	/* 상품 후기 삭제 */
	public void reviewDelete(int rew_num) throws Exception;
	
	/* 상품 후기 리스트(페이지 포함) */
	public List<ReviewVO> reviewList(int pro_num, Criteria cri) throws Exception;
	
	/* 상품 후기 총 개수 */
	public int reviewCount(int pro_num) throws Exception;

}
