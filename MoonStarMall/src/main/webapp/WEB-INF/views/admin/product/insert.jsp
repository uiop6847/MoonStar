<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
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
	<!-- summernote -->
	<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.css">
<script>
	
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
						<h1 class="m-0 text-dark">Admin Page <small>Product Insert</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">상품 관리</a></li>
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
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<form id='registerForm' role="form" action="/admin/product/insert" method="post" enctype="multipart/form-data">
									<div class="box-body">
										<div class="form-group">
											<label for="mainCategory" style="width:30%; margin-right:20px;" >1차 카테고리</label>
											<label for="subCategory" style="width:30%;" >2차 카테고리</label> <br />
											<select class="form-control" id="mainCategory" name="cat_prtcode" style="width:30%; margin-right:10px; display: inline-block;" >
											  <option value="default">1차 카테고리 선택</option>
											  <c:forEach items="${mainCategory}" var="main">
											  	<option value="${main.cat_code}">${main.cat_name}</option>
											  </c:forEach>
											</select>
											<select class="form-control" id="subCategory" name="cat_code" style="width: 30%; display: inline-block;">
											 	<option value="default">2차 카테고리 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="pro_name">상품명</label> <input
												type="text" id="pro_name" name="pro_name" class="form-control"
												placeholder="Enter Product name">
										</div>
										<div class="form-group">
											<label for="pro_publisher">제조사</label> <input
												type="text" id="pro_publisher" name="pro_publisher" class="form-control"
												placeholder="Enter pro_publisher">
										</div>
										<div class="form-group">
											<label for="pro_price" style="width:40%; margin-right:10px;">가격</label> 
											<label for="pro_discount" style="width:40%;">할인율</label> 
											<input style="width:40%; margin-right:10px; display: inline-block;"
												type="text" id="pro_price" name="pro_price" class="form-control" 
												placeholder="Enter price" />
											<input style="width:40%; display: inline-block;"
												type="text" id="pro_discount" name="pro_discount" class="form-control "
												placeholder="Enter discounted price" />
										</div>
										<div class="form-group">
											<label for="exampleInputPassword1">상품상세설명</label>
											<textarea class="textarea" placeholder="Place some text here"
			          							style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
										</div>
										<div class="form-group">
											<label for="exampleInputEmail1">대표상품 이미지</label> <input
												type="file" id="file1" name="file1" class="form-control" />
										</div>
										
										<div class="form-group">
											<label for="exampleInputEmail1" style="width:30%; margin-right:10px;">상품개수</label> 
											<label for="exampleInputEmail1" style="width:15%;">판매가능상태</label><br /> 
											<input style="width:30%; margin-right:10px; display: inline-block;"
												type="text" id="pro_amount" name='pro_amount' class="form-control" 
												placeholder="Enter Amount" />
											<select class="form-control" id="pro_buy" name="pro_buy" style="width: 15%; display: inline-block;">
											  <option>Y</option>
											  <option>N</option>
											</select>
										</div>
									</div>
	
									<!-- /.box-body -->
	
									<div class="box-footer">
										<div>
											<hr>
										</div>
	
										<ul class="mailbox-attachments clearfix uploadedList">
										</ul>
	
										<button id="btn_submit" type="button" class="btn btn-primary">등록</button>
	
									</div>
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

<%@include file="/WEB-INF/views/include/plugins.jsp" %>
<!-- Summernote -->
<script src="/plugins/summernote/summernote-bs4.min.js"></script>
<script>
  $(function () {
    // Summernote
    $('.textarea').summernote()
  })
</script>
</body>
</html>