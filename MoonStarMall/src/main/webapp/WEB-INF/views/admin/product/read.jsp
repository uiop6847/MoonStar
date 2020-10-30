<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	$(document).ready(function(){
		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
		});
	});
</script>
<style>
	table th {
		width: 10%;
		text-align: right;
	}
	.col-right	{
		text-align: right;
	}
	.col-left	{
		text-align: left;
	}
</style>
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header_admin.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Admin Page <small>Product Detail Info</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item"><a href="/admin/product/list${pm.makeSearch(pm.cri.page)}">상품 목록</a></li>
							<li class="breadcrumb-item active">상품 상세정보</li>
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
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="form-group">
									<div class="row">
										<div class="col-md-4"><label for="mainCategory">1차 카테고리</label></div>
										<div class="col-md-4"><label for="subCategory">2차 카테고리</label></div>
									</div>
									<div class="row">
										<div class="col-md-4">
											<span class="form-control">${vo.cat_prtcode}</span>
										</div>
										<div class="col-md-4">
											<span class="form-control">${vo.cat_code}</span>
										</div>
									</div>
								</div>
								<table class="table table-head-fixed table-hover text-nowrap" id="tbl_product">
										<tr>
											<th>번호</th><td>${vo.pro_num}</td>
										</tr>
										<tr>
											<th>상품명</th><td>${vo.pro_nm}</td>
										</tr>
										<tr>
											<th>제조사</th><td>${vo.pro_publisher}</td>
										</tr>
										<tr>
											<th>가격</th><td>${vo.pro_price}</td>
										</tr>
										<tr>
											<th>할인율</th><td>${vo.pro_discount}</td>
										</tr>
										<tr>
											<th>판매수량</th><td>${vo.pro_count}</td>
										</tr>
										<tr>
											<th>판매상태</th><td>${vo.pro_buy_yn}</td>
										</tr>
										<tr>
											<th>상품등록일</th><td><fmt:formatDate value="${vo.sta_date}" pattern="yyyy-MM-dd"/></td>
										</tr>
										<tr>
											<th>상품수정일</th><td><fmt:formatDate value="${vo.udt_date}" pattern="yyyy-MM-dd"/></td>
										</tr>
										<tr>
											<th>대표 이미지</th><td><img src="/admin/product/displayFile?fileName=${vo.pro_main_img }" style="width: 345px;"></td>
										</tr>
										<tr>
											<th>상세설명</th><td><div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
										${vo.pro_dtl_info}
									</div></td>
										</tr>
								</table>
								<div class="box-footer">
									<div>
										<hr>
									</div>
									<div class="row">
										<div class="col-12">
											<button id="btn_list" type="button" class="btn" style="background-color: #F9D5D3;">
											상품 목록</button>
										</div>
									</div>
								</div>
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

<%@include file="/WEB-INF/views/include/plugins.jsp" %>
</body>
</html>