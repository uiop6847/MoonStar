package com.moonstarmall.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moonstarmall.domain.UserInfoVO;
import com.moonstarmall.dto.LoginDTO;
import com.moonstarmall.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder passwdEncrypt;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	/* 회원가입 이동     /member/join */ 
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void join() {
		logger.info("/member/join");
	}
	
	/* 회원가입 처리 */ 
	@RequestMapping(value = "joinOK", method = RequestMethod.POST)
	public String userInfoAdd(UserInfoVO vo, RedirectAttributes rttr) throws Exception {
		
		logger.info("UserInfoVO: " + vo.toString());
		
		
		// 비밀번호 암호화 처리
		vo.setUser_pw(passwdEncrypt.encode(vo.getUser_pw()));
		service.userInfoAdd(vo);
		rttr.addFlashAttribute("msg", "JOIN_SUCCESS");
		
		return "redirect:/";
	}
	
	/* 아이디 중복체크 */
	@RequestMapping(value = "userIdCheck", method = RequestMethod.POST)
	public ResponseEntity<String> userIdCheck(@RequestParam("user_id") String user_id) throws Exception {
		
		logger.info("userIdCheck() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			
			int count = service.userIdCheck(user_id);
			
			// count가 0이면 사용가능. 1이면 사용불가능.
			if(count != 0) {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 이메일 중복체크 */
	@RequestMapping(value = "userEmailCheck", method = RequestMethod.POST)
	public ResponseEntity<String> userEmailCheck(@RequestParam("user_email") String user_email) throws Exception {
		
		logger.info("userEmailCheck() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			
			int count = service.userEmailCheck(user_email);
			
			// count가 0이면 사용가능. 1이면 사용불가능.
			if(count != 0) {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 
	 * 이메일 인증 코드 확인   // /member/checkAuthcode
	 * - 입력된 인증 코드와 세션에 저장해 두었던 인증 코드가 일치하는지 확인
	 */
	@ResponseBody
	@RequestMapping(value = "checkAuthcode", method=RequestMethod.POST)
	public ResponseEntity<String> checkAuthcode(@RequestParam("code") String code, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		try {
			if(code.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				// 인증코드 불일치
				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 로그인 이동     /member/login */ 
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() {
		logger.info("/member/login");
	}
	
	/* 로그인     /member/loginOK */
	@RequestMapping(value="loginOK", method = RequestMethod.POST)
	public String loginOK(LoginDTO dto, RedirectAttributes rttr, HttpSession session,
						  Model model, HttpServletResponse response) throws Exception {
		logger.info("loginOK() called");
		
		LoginDTO loginDTO = service.loginOK(dto);
		if(loginDTO != null) {
			logger.info("Login SUCCESS");
			
			session.setAttribute("user", loginDTO);
/*
			if(loginDTO.isUserCookie()) {
				
				// 쿠키 저장
				int amount = 60*60*24*7;  //  7일
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
				
				service.saveCookie(session.getId(), sessionLimit, loginDTO.getUser_id());
			}
*/
			rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
			
			return "redirect:/";
			//return "redirect:" + (String) session.getAttribute("dest");
			
		}else {
			logger.info("Login FAIL");
			rttr.addFlashAttribute("msg", "LOGIN_FAIL");
		}
		
		return "redirect:/member/login";
	}
	
	/* 로그아웃     /member/logout */
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		logger.info("logout() called");
		
		session.invalidate(); // 세션정보를 서버메모리에서 제거
		rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		
		return "redirect:/";
	}
	
	/* 마이페이지 이동     /member/mypage */ 
	@RequestMapping(value = "mypage", method = RequestMethod.GET)
	public void mypage() {
		logger.info("/member/mypage");
	}
	
	/* 회원정보 상세조회 및 페이지 이동     /member/modify */ 
	@RequestMapping(value = "modify", method = RequestMethod.GET)
	public String modify(HttpSession session, Model model) throws Exception {
		logger.info("/member/modify");
		
		LoginDTO dto = (LoginDTO)session.getAttribute("user");
		
		model.addAttribute("vo", service.userInfoSelect(dto.getUser_id()));
		
		// 이동전화번호, 휴대전화번호 split
		/*
		if(vo.getTel_phone() != null) {
			String str = vo.getTel_phone();
			String[] telPhone = str.split("-");
			
			List<String> telPhoneList = new ArrayList<String>();
			telPhoneList.add(telPhone[0]);
			telPhoneList.add(telPhone[1]);
			telPhoneList.add(telPhone[2]);
			

			model.addAttribute("telPhone", telPhoneList);
		}
		
		if(vo.getTel_phone() != null) {
			String str = vo.getTel_phone();
			String[] telPhone = str.split("-");
			
			List<String> cellPhoneList = new ArrayList<String>();
			cellPhoneList.add(telPhone[0]);
			cellPhoneList.add(telPhone[1]);
			cellPhoneList.add(telPhone[2]);

			model.addAttribute("cellPhone", cellPhoneList);
		}
		*/
		
		return "/member/modify";
	}
	
	/* 회원정보수정     /member/modifyOK */ 
	@RequestMapping(value = "modifyOK", method = RequestMethod.POST)
	public String modifyOK(UserInfoVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		logger.info("modifyOK() called");
		
		LoginDTO dto = new LoginDTO();
		dto.setUser_id(vo.getUser_id());
		dto.setUser_pw(vo.getUser_pw());
		
		// 비밀번호 암호화작업
		vo.setUser_pw(passwdEncrypt.encode(vo.getUser_pw()));
		service.modifyUserInfo(vo);
		
		session.setAttribute("user", service.loginOK(dto));
		
		rttr.addFlashAttribute("msg", "MODIFY_USER_SUCCESS");
		
		return "redirect:/";
	}
	
	/* 회원 탈퇴     /member/deleteUser */
	@RequestMapping(value="deleteUser", method = RequestMethod.POST)
	public String deleteUser(String user_id, HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("deleteUser() called"); 
		
		service.deleteUser(user_id);
		
		// 회원탈퇴시 세션 소멸작업
		session.invalidate();
		rttr.addFlashAttribute("msg", "DELETE_USER_SUCCESS");
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "deleteUser/{user_id}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteUser(@PathVariable("user_id") String user_id) {
		logger.info("deleteUser() called");
		
		ResponseEntity<String> entity = null;
	    try {
	    	service.deleteUser(user_id);
	    	//session.invalidate();
	    	entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	    	
	    	
	    } catch (Exception e) {
	    	e.printStackTrace();
	        entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	    
	    return entity;
	}

}
