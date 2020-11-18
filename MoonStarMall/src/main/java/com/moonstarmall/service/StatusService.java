package com.moonstarmall.service;

import java.util.List;

import com.moonstarmall.domain.StatusVO;

public interface StatusService {
	
	/* 상태테이블 리스트 조회 */
	public List<StatusVO> statusList(String div_nm) throws Exception;

}
