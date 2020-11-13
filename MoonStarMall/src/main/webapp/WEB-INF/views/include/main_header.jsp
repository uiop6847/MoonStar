<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand-md navbar-light" style="background-color: #D7DBD1;">
	<div class="container">
		<a href="/" class="navbar-brand">
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
				<c:if test="${sessionScope.user == null}">
					<li class="nav-item">
						<a href="/member/login" class="nav-link">LOGIN</a>
					</li>
					<li class="nav-item">
					  <a href="/member/join" class="nav-link">JOIN US</a>
					</li>
					<li class="nav-item">
					  <a href="#" class="nav-link">CART</a>
					</li>
					<li class="nav-item">
						<a href="/member/login" class="nav-link">ORDER</a>
					</li>
					<li class="nav-item">
						<a href="/member/login" class="nav-link">MY PAGE</a>
					</li>
				</c:if>
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.user != null}">
					<li class="nav-item">
						<a href="/member/logout" class="nav-link">LOGOUT</a>
					</li>
					<li class="nav-item">
					  <a href="/cart/list" class="nav-link">CART</a>
					</li>
					<li class="nav-item">
						<a href="/order/list" class="nav-link">ORDER</a>
					</li>
					<li class="nav-item">
						<a href="/member/mypage" class="nav-link">MY PAGE</a>
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