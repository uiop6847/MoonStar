<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	
<!-- 로그인 유효성검사 자바스크립트(JQuery) -->
<script type="text/javascript" src="/js/member/login.js"></script>
<script>
	if("${msg}"=="LOGIN_FAIL"){	
		alert("로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 확인해주세요.");
	}
</script>
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">LOGIN</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">MAIN</a></li>
							<li class="breadcrumb-item active">LOGIN</li>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
	
		<!-- Main content -->
		<div class="content">
			<div class="container">
				<div class="row">
					<div class="col-lg-4">
						<div class="card">
							<div class="card-body">
								<form id="loginForm" class="form-signin" action="/member/loginOK" method="post">
									<input type="text" class="form-control" id="user_id" name="user_id" placeholder="ID" autofocus>
									<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="PW" required>
									<div class="checkbox">
										<label>
											<input type="checkbox" name="useCookie"> 자동로그인
										</label>
									</div>
									<button class="btn btn-block btn-primary" type="button" id="btn_login">
									로그인</button>
									<button class="btn btn-block btn-outline-primary" type="button" id="btn_join">
									회원가입</button>
									<span class='text-center'><a href="#" class="text-sm">아이디 찾기</a></span>
									<span>&nbsp;/&nbsp;</span>
									<span class='text-center'><a href="#" class="text-sm">비밀번호 찾기</a></span>
								</form>
							</div>
						</div>
					</div>
				</div>
			<!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	
	<!-- Control Sidebar -->
	<%@include file="/WEB-INF/views/include/main_sidebar.jsp" %>
	<!-- /.control-sidebar -->
	
	<!-- Main Footer -->
	<%@include file="/WEB-INF/views/include/main_footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<%@include file="/WEB-INF/views/include/plugins.jsp" %>
</body>
</html>