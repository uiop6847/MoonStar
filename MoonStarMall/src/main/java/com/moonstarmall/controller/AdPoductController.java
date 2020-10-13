package com.moonstarmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/product/*")
public class AdPoductController {
	
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public String productInsert() {
		return "/admin/product/insert";
	}

}
