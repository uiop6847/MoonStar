package com.moonstarmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.service.AdMemberService;
import com.moonstarmall.util.PageMaker;
import com.moonstarmall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/member/*")
public class AdMemberController {
	
	@Autowired
	AdMemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdMemberController.class);
	
	/* 회원 리스트 조회 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void userList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info("userList() called");
		
		List<Map<String, Object>> list = service.userList(cri);
		for(int i=0; i<list.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();	
			
			// map key를 소문자로 변경
			for(String key : list.get(i).keySet()) {
				vo.put(key.toLowerCase(), list.get(i).get(key));
			}
			// 변경된 map을 다시 list에 세팅
			list.set(i, vo);
		}
		model.addAttribute("userList", list);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.userCount(cri));
		logger.info("=====PageMaker : " + pm);
		model.addAttribute("pm", pm);
		
	}

}
