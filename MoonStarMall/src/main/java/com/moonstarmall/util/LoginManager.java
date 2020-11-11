package com.moonstarmall.util;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginManager implements HttpSessionBindingListener {

	// 해당클래스를 싱글톤 패턴으로 구성
	private static LoginManager loginManager = null;
	
	private LoginManager() {}
	
	// synchronized : 요청에 의한 모든 스레드들이 순차적으로 메서드를 호출되도록 하기 위한 동기화 작업
	private synchronized static LoginManager getInstance() {
		if(loginManager == null) {
			loginManager = new LoginManager();
		}
		
		return loginManager;
	}
	
	// 로그인시 사용자아이디 저장
	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<HttpSession, String>();
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub

	}

}
