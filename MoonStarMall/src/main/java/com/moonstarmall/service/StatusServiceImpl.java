package com.moonstarmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.StatusDAO;
import com.moonstarmall.domain.StatusVO;

@Service
public class StatusServiceImpl implements StatusService {
	
	@Autowired
	private StatusDAO dao;

	/* 상태테이블 리스트 조회 */
	@Override
	public List<StatusVO> statusList(String div_nm) throws Exception {
		return dao.statusList(div_nm);
	}

}
