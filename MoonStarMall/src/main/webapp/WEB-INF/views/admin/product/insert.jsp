<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<h1 class="m-0 text-dark">MoonStarMall - <small>MAIN</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">HOME</a></li>
							<li class="breadcrumb-item">상품 관리</a></li>
							<li class="breadcrumb-item active">상품 등록</li>
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

<!-- jQuery -->
<%@include file="/WEB-INF/views/include/plugins.jsp" %>
</body>
</html>