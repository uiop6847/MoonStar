package com.moonstarmall.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moonstarmall.domain.AdminVO;
import com.moonstarmall.dto.AdminDTO;
import com.moonstarmall.service.AdminService;



@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	/* 관리자 메인 이동    /admin/main */
	@RequestMapping(value="main", method = RequestMethod.GET)
	public void main() {
		logger.info("/admin/main");
	}
	
	/* 관리자 로그인 */
	@RequestMapping(value="loginOK", method = RequestMethod.POST)
	public String loginOK(AdminDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("loginOK() called");
		
		AdminVO vo = service.login(dto);
		
		if(vo != null) {
			
			session.setAttribute("admin", vo);
			rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
			
		}else {
			rttr.addFlashAttribute("msg", "LOGIN_FAIL");
		}
		
		return "redirect:/admin/main";
	}
	
	/* 관리자 로그아웃 */
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		logger.info("logout() called");
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		
		return "redirect:/admin/main";
	}
	

}
