package com.moonstarmall.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/order/*")
public class AdOrderController {

	private static final Logger logger = LoggerFactory.getLogger(AdOrderController.class);
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void orderList() {
		logger.info("orderList() called");
		
	}
}
