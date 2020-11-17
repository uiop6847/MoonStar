package com.moonstarmall.dao;

import java.util.List;
import java.util.Map;

import com.moonstarmall.util.SearchCriteria;

public interface AdMemberDAO {
	
	/* 회원 리스트 */
	public List<Map<String, Object>> userList(SearchCriteria cri) throws Exception;
	
	/* 회원 총 건수 */
	public int userCount(SearchCriteria cri) throws Exception;

}
