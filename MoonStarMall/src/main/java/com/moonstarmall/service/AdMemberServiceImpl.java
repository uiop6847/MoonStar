package com.moonstarmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonstarmall.dao.AdMemberDAO;
import com.moonstarmall.util.SearchCriteria;

@Service
public class AdMemberServiceImpl implements AdMemberService {
	
	@Autowired
	private AdMemberDAO dao;

	/* 회원 리스트 */
	@Override
	public List<Map<String, Object>> userList(SearchCriteria cri) throws Exception {
		return dao.userList(cri);
	}

	/* 회원 총 건수 */
	@Override
	public int userCount(SearchCriteria cri) throws Exception {
		return dao.userCount(cri);
	}
}
