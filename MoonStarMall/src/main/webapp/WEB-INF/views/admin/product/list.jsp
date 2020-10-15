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

	<%@include file="/WEB-INF/views/include/main_header_admin.jsp" %>
	<%--<%@include file="/WEB-INF/views/include/top_admin.jsp" %> --%>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Admin page</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item active">상품 관리</li>
							<li class="breadcrumb-item active">상품 목록</li>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
	
		<!-- Main content -->
		<section class="content">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">상품 목록</h3>
							</div>
							<div class="card-body">
								<table id="tbl_productList" class="table table-bordered table-striped">
									<tr>
										<th><input type="checkbox" id="checkAll" /></th>
										<th>상품 번호</th>
										<th>상품 이미지</th>
										<th>상품명</th>
										<th>판매가</th>
										<th>할인가</th>
										<th>제조사</th>
										<th>수량</th>
										<th>판매여부</th>
										<th>수정/삭제</th>
									</tr>
									<%-- 상품리스트 출력 --%>
									<c:if test="${empty productList}">
									<tr>
										<td colspan="10">
											<p style="padding:50px 0px; text-align: center;">등록된 상품이 존재하지 않습니다. </p>
										</td>
									</tr>
									</c:if>
									<c:forEach items="${productList }" var="productVO">
									<tr>
										<td>
											<input type="checkbox" name="check" class="check" value="${productVO.pro_num}">
										</td>
										<td>
										
										</td>
									</tr>
									
									</c:forEach>
								</table>
							</div><!-- /.card-body -->
						</div><!-- /.card -->
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section>
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