package com.moonstarmall.dao;

import com.moonstarmall.domain.AdminVO;
import com.moonstarmall.dto.AdminDTO;

public interface AdminDAO {
	
	/* 관리자 로그인 */
	public AdminVO login(AdminDTO dto) throws Exception;

}
