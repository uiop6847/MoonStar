package com.moonstarmall.dao;

import java.util.List;

import com.moonstarmall.domain.StatusVO;

public interface StatusDAO {
	
	/* 상태테이블 리스트 조회 */
	public List<StatusVO> statusList(String div_nm) throws Exception;

}
