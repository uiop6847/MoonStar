<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header class="main-header">
<%--
	<!-- Logo -->
	<a href="/" class="logo">
		<span class="logo-lg">MoonStarMall</span>
	</a>
	 --%>
	<!-- Header Navbar -->
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<!-- Logo -->
			<div class="navbar-header">
		      <a class="navbar-brand" href="/">MoonStarMall</a>
		    </div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<!-- 로그인 전 -->
					<li><a href="/member/login"><span>LOGIN</span></a></li>
					<!-- 로그인 후 -->
					<li><a href="#"><span>LOGOUT</span></a></li>
					<li><a href="/member/join"><span>JOIN US</span></a></li>
					<li><a href="#"><span>CART</span></a></li>
					<li><a href="#"><span>ORDER</span></a></li>
					<li><a href="#"><span>MYPAGE</span></a></li>
				</ul>
				<!-- search form -->
				<form action="#" method="get" class="navbar-form navbar-right">
					<div class="input-group">
						<input type="text" name="q" class="form-control">
						<span class="input-group-btn">
							<button type="submit" name="search" id="search-btn" class="btn btn-default">
								&nbsp;<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span>NOTICE</span></a></li>
					<li><a href="#"><span>Q & A</span></a></li>
					<li><a href="#"><span>REVIEW</span></a></li>
				</ul>
			</div><!-- /.navbar-collapse -->
		</div><!-- /.container-fluid -->
	</nav>
</header>