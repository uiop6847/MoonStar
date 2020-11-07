package com.moonstarmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	// 원래 요청한 주소정보를 저장
	private void saveDest(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String query = req.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		// 사용자가 요청한 방식이 GET방식이면
		if(req.getMethod().equals("GET")) {
			logger.info("dest: " + (uri + query));
			//원래요청한 주소저장
			req.getSession().setAttribute("dest", uri+query);
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		System.out.println("session : " + session.getAttribute("user"));
		if(session.getAttribute("user") == null) {
			System.out.println("getMethod : " + request.getMethod());
			if(request.getMethod().equals("AJAX")) {
				
				response.sendError(400);
				
			}else {
				saveDest(request);
				response.sendRedirect("/member/login");
			}
			
			return false;
		}
		
		return true;
	}
	
}
