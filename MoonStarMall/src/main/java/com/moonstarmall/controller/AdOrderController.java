package com.moonstarmall.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moonstarmall.domain.OrderVO;
import com.moonstarmall.service.AdOrderService;
import com.moonstarmall.service.StatusService;
import com.moonstarmall.util.OrderSearchCriteria;
import com.moonstarmall.util.PageMaker;
import com.moonstarmall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Autowired
	private AdOrderService service;
	@Autowired
	private StatusService status;

	private static final Logger logger = LoggerFactory.getLogger(AdOrderController.class);
	
	/* 주문목록 조회 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void orderList(@ModelAttribute("cri") OrderSearchCriteria cri, Model model) throws Exception {
		logger.info("orderList() called");
		
		// 주문일자 입력이 없으면 3달전 날짜로 조회하도록 세팅
		if(cri.getFromDate() == null || cri.getToDate() == null) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(new Date());
			cri.setToDate(format.format(cal.getTime()));
			
			cal.add(Calendar.MONTH, -3);
			cri.setFromDate(format.format(cal.getTime()));
		}
		
		logger.info("=====cri : " + cri);
		
		model.addAttribute("orderList", service.orderList(cri));
		model.addAttribute("statusList", status.statusList("ord_status"));
		
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(service.orderCount(cri));
		
		model.addAttribute("pm", pm);
	}
	
	/* 주문처리상태 수정 */
	@RequestMapping(value = "ordStatusUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> ordStatusUpdate(	@RequestParam("ordCd[]") List<Integer> ordCd, 
													@RequestParam("ordStatus[]") List<String> ordStatus, 
													@ModelAttribute("cri") SearchCriteria cri) {
		logger.info("ordStatusUpdate() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			
			OrderVO vo = null;
			List<OrderVO> list = new ArrayList<OrderVO>();
			
			for(int i=0; i<ordCd.size(); i++) {
				vo = new OrderVO();
				vo.setOrd_cd(ordCd.get(i));
				vo.setOrd_status(ordStatus.get(i));
				
				list.add(i, vo);
			}
			
			service.ordStatusUpdate(list);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
