package com.moonstarmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.AdminDAO;
import com.moonstarmall.domain.AdminVO;
import com.moonstarmall.dto.AdminDTO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO dao;

	@Override
	public AdminVO login(AdminDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	
	
	

}
