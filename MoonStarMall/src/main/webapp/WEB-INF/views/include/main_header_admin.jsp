<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand-md navbar-light" style="background-color: #D7DBD1;">
	<div class="container">
		<a href="/admin/main" class="navbar-brand">
			<span id="nav_brand" class="brand-text font-weight-light" style="color: #ECA4A6; font-size: 20pt; font-family: Impact;
				text-shadow: 0px 1px #ffffff, 4px 4px 0px #FFFAFA;">
			MoonStarMall</span>
		</a>
    
		<button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse order-3" id="navbarCollapse">
			<!-- top navbar links -->
			<ul class="navbar-nav">
				<%-- 로그인 안 한 상태 --%>
				<c:if test="${sessionScope.admin == null}">
					<li class="nav-item">
						<a href="/admin/login" class="nav-link">LOGIN</a>
					</li>
				</c:if>
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.admin != null}">
					<li class="nav-item">
						<a href="/admin/logout" class="nav-link">LOGOUT</a>
					</li>
					<li class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle">
						상품 관리</a>
						<ul class="dropdown-menu border-0 shadow">
						  <li><a href="/admin/product/insert" class="dropdown-item">상품 등록</a></li>
						  <li><a href="/admin/product/list" class="dropdown-item">상품 목록</a></li>
						  <li><a href="/admin/product/category" class="dropdown-item">상품 카테고리 관리</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">
						주문 관리</a>
						<ul class="dropdown-menu border-0 shadow">
						  <li><a href="/admin/order/list" class="dropdown-item">주문 목록</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle">
						회원 관리</a>
						<ul class="dropdown-menu border-0 shadow">
						  <li><a href="/admin/member/list" class="dropdown-item">회원 목록</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<a href="#" class="nav-link dropdown-toggle">
						통계</a>
						<ul class="dropdown-menu border-0 shadow">
						  <li><a href="#" class="dropdown-item">일별 누적 접속자 통계</a></li>
						</ul>
					</li>
				</c:if>
			</ul>
		</div>

		<!-- Right navbar links -->
		<ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
<%--
			<li class="nav-item">
				<a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button"><i
				    class="fas fa-th-large"></i></a>
			</li>
--%>
			<li class="nav-item">
			  <a href="#" class="nav-link">NOTICE</a>
			</li>
			<li class="nav-item">
			  <a href="#" class="nav-link">Q &amp; A</a>
			</li>
			<li class="nav-item">
			  <a href="#" class="nav-link">REVIEW</a>
			</li>
			
			<!-- SEARCH FORM -->
			<form class="form-inline ml-0 ml-md-3">
				<div class="input-group input-group-sm">
					<input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
					<div class="input-group-append">
						<button class="btn btn-navbar" type="submit">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
			</form>
		</ul>
	</div>
</nav>
<!-- /.navbar -->