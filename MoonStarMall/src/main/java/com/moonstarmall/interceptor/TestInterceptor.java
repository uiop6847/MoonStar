package com.moonstarmall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// /member/** 주소로 요청하는 부분을 인터셉터 설정을 하여 제어를 한다면
public class TestInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		// 리다이렉트 요청주소 구문
		
		// 인터셉터 설정이 관리자메뉴 주소요청이 발생
		// 관리자 로그인 세션여부 체크
		// 1) 정상로그인상태 : return true;
		// 2) 로그인 상태가 아닐 때 : 관리자로그인 주소로 이동작업하고 return false;
		
		return super.preHandle(request, response, handler);
		//return true;인 경우 /member/** 컨트롤러로 넘어간다.
		//return false;경우는 컨트롤러로 넘어가지 않음
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
