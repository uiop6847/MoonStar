package com.moonstarmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moonstarmall.domain.ReviewVO;
import com.moonstarmall.dto.LoginDTO;
import com.moonstarmall.service.ReviewService;
import com.moonstarmall.util.Criteria;
import com.moonstarmall.util.PageMaker;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	/* 상품 후기 쓰기 */
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public ResponseEntity<String> reviewWrite(ReviewVO vo, HttpSession session) {
		logger.info("reviewWrite() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			
			if(session.getAttribute("user") == null) {
				entity = new ResponseEntity<String>("N_SESSION", HttpStatus.OK);
				
			}else {
				LoginDTO dto = (LoginDTO) session.getAttribute("user");
				vo.setUser_id(dto.getUser_id());
				
				logger.info("=====ReviewVO : " + vo);
				service.reviewWrite(vo);
				
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			
		}
		return entity;
	}
	
	/* 상품 후기 수정 */
	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public ResponseEntity<String> reviewModify(ReviewVO vo){
		logger.info("reviewModify() called");
		logger.info("=====ReviewVO : " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.reviewModify(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 상품 후기 삭제 */
	@RequestMapping(value = "{rew_num}", method = RequestMethod.DELETE)
	public ResponseEntity<String> reviewDelete(@PathVariable("rew_num") int rew_num){
		logger.info("reviewDelete() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			service.reviewDelete(rew_num);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 상품 후기 리스트(페이지 포함) */
	@RequestMapping(value = "{pro_num}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("pro_num") int pro_num,
														  @PathVariable("page") int page){
		logger.info("reviewList() called");
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			
			Criteria cri = new Criteria();
			cri.setPage(page);
			logger.info("cri : " + cri);
			
			List<ReviewVO> list = service.reviewList(pro_num, cri);
			int replyCount = service.reviewCount(pro_num);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(replyCount);
			
			// jsp페이지에 상품후기 번호를 내림차순으로 재세팅
			int no = replyCount - (page * cri.getPerPageNum()) + cri.getPerPageNum();
			
			for(int i = 0; i < list.size(); i++) {
				list.get(i).setNo(no--);
				//logger.info("list("+i+") : " + list.get(i));
			}

			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("list", list);
			map.put("pageMaker", pageMaker); // 하단 페이지 작업 추가
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

}
