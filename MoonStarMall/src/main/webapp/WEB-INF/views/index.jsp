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
<script>
	if("${msg}"=="LOGIN_SUCCESS"){
		alert("로그인 되었습니다.\n환영합니다!");
		
	} else if("${msg}"=="LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다.");
		
	} else if("${msg}"=="JOIN_SUCCESS"){
		alert("성공적으로 회원가입 되었습니다.\n로그인 해주세요.");
		
	} else if("${msg}"=="MODIFY_USER_SUCCESS"){
		alert("회원 정보가 수정되었습니다.");
		
	} else if("${msg}"=="CHANGE_PW_SUCCESS"){
		alert("비밀번호가 성공적으로 변경되었습니다.");
		
	} else if("${msg}"=="DELETE_USER_SUCCESS"){
		alert("회원 탈퇴되었습니다. 감사합니다.");
		
	}
</script>
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header.jsp" %>
	
	<%@include file="/WEB-INF/views/include/main_topbar.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">MoonStarMall - <small>MAIN</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item"><a href="#">Layout</a></li>
							<li class="breadcrumb-item active">Top Navigation</li>
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
					<div class="col-lg-6">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								
								<p class="card-text">
								  Some quick example text to build on the card title and make up the bulk of the card's
								  content.
								</p>
								
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						</div>
					</div>
					<!-- /.col-md-6 -->
					<div class="col-lg-6">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title m-0">Featured</h5>
							</div>
							<div class="card-body">
								<h6 class="card-title">Special title treatment</h6>
								
								<p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
								<a href="#" class="btn btn-primary">Go somewhere</a>
							</div>
						</div>
					</div>
					<!-- /.col-md-6 -->
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

<%@include file="/WEB-INF/views/include/plugins.jsp" %>
</body>
</html>