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
						<h1 class="m-0 text-dark">Product Detail Info</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item active">상품 목록</li>
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
									<label for="mainCategory" style="width:30%; margin-right:20px;" >1차 카테고리</label>
									<label for="subCategory" style="width:30%;" >2차 카테고리</label> <br />
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.cat_prtcode}</span>
									<span class="form-control" style="width:40%;  display:inline-block;">${vo.cat_code}</span>
								</div>
								<div class="form-group">
									<label for="pro_nm">상품명</label>
									<span class="form-control">${vo.pro_nm}</span>
								</div>
								<div class="form-group">
									<label for="pro_publisher">제조사</label> 
									<span class="form-control">${vo.pro_publisher}</span>
								</div>
								<div class="form-group">
									<label for="pro_price" style="width:40%; margin-right:10px;">가격</label> 
									<label for="pro_discount" style="width:40%;">할인율</label>
									<span class="form-control">${vo.pro_price}</span>
									<span class="form-control">${vo.pro_discount}</span>
								</div>
								<div class="form-group">
									<label for="file1">상품 대표 이미지</label> 
									<span class="form-control"><c:out value="${vo.pro_main_img}" /></span>
								</div>
								<div class="form-group">
									<label for="pro_dtl_info">상품상세설명</label>
									<div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
										${vo.pro_dtl_info}
									</div>
								</div>
								<div class="form-group">
									<label for="pro_count" style="width:30%; margin-right:10px;">판매수량</label> 
									<label for="pro_buy_yn" style="width:15%;">판매상태</label><br /> 
									<span class="form-control">${vo.pro_count}</span>
									<span class="form-control">${vo.pro_buy_yn}</span>
								</div>
								<div class="form-group">
									<label style="width:30%;" >상품등록일</label>
									<label style="width:30%;" >상품수정일</label>
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">
										<fmt:formatDate value="${vo.sta_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span class="form-control" style="width:40%; display: inline-block;">
										<fmt:formatDate value="${vo.udt_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
								</div>
								<div class="box-footer">
									<div>
										<hr>
									</div>

									<ul class="mailbox-attachments clearfix uploadedList">
									</ul>

									<button id="btn_list" type="button" class="btn btn-primary" >상품 목록</button>

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