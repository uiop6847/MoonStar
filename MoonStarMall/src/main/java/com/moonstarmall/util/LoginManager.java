package com.moonstarmall.util;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginManager implements HttpSessionBindingListener {

	// 해당클래스를 싱글톤 패턴으로 구성
	private static LoginManager loginManager = null;
	
	private LoginManager() {}
	
	// synchronized : 요청에 의한 모든 스레드들이 순차적으로 메서드를 호출되도록 하기 위한 동기화 작업
	public static synchronized LoginManager getInstance() {
		if(loginManager == null) {
			loginManager = new LoginManager();
		}
		
		return loginManager;
	}
	
	// 로그인시 사용자아이디 저장
	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<HttpSession, String>();
	
	/* 세선졍보 추가시 호출되는 이벤트 */
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		loginUsers.put(event.getSession(), event.getName());
		
		System.out.println(event.getName() + " 로그인 완료");
		System.out.println("현재 접속자 수 : ");
	}

	/* 세션소멸(제거) 시 호출되는 이벤트 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession());
	}
	
	/* 아이디 중복로그인 방지목적으로 체크 */
	public boolean isUsing(String userId) {
		return loginUsers.containsValue(userId);
	}
	
	/* 로그인을 확인 후 아이디를 세션형태로 저장 */
	public void setSession(HttpSession session, String userId) {
		session.setAttribute(userId, this);
	}
	
	public String getUserID(HttpSession session) {
		return loginUsers.get(session);
	}
	
	/* 현재 접속자수 확인 */
	public int getUserCount() {
		return loginUsers.size();
	}
	
	/* 현재 접속중인 모든 사용자 아이디를 출력 */
	public void printLoginUsers() {
		
		Enumeration<HttpSession> e = loginUsers.keys();
		HttpSession session = null;
		System.out.println("===========================================");
		int i = 0;
		while(e.hasMoreElements()) {
			session = e.nextElement();
			System.out.println((++i) + ". 접속자: " + loginUsers.get(session));
		}
		System.out.println("===========================================");
	}
	
	/* 현재 접속중인 모든 사용자리스트를 리턴 */
	public Collection<String> getUsers(){
		Collection<String> collection = loginUsers.values();
		return collection;
	}

}
