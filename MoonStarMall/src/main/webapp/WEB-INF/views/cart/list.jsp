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
<%--table all ckeckbox기능 --%>
<script type="text/javascript" src="/js/check.js"></script>
<style>
	/* sub category */
	li.nav-item.active .nav-link {
    	color: #a0a0a0;
    	border: 1px solid #c0c0c0;
	}
	a.sub.nav-link {
		margin: 0 5px;
		color: #b1b0b0;
    	border: 1px solid #ebebeb;
	}
	
	.col-center	{
		text-align: center;
	}
	table, th, td {
		vertical-align: middle !important; 
	}
	.col-right	{
		text-align: right;
	}
</style>
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
						<h1 class="m-0 text-dark">SHOPPING CART</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
							<li class="breadcrumb-item active">CART</li>
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
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">상품(${cartCount})</h3>
							</div>
								<div class="card-body table-responsive p-0">
									<table id="tbl_cartList" class="table table-hover table-bordered text-nowrap">
										<thead>
										<tr class="col-center">
											<th><input type="checkbox" id="checkAll"></th>
											<th>이미지</th>
											<th>상품정보</th>
											<th>판매가</th>
											<th>적립금</th>
											<th>배송비</th>
											<th>합계</th>
											<th>선택</th>
										</tr>
										</thead>
										<tbody id="tbl_productListRow">
											<%-- 상품리스트 출력 --%>
											<c:if test="${empty cartList}">
											<tr>
												<td colspan="10">
													<p style="padding:50px 0px; text-align: center;">등록된 상품이 존재하지 않습니다. </p>
												</td>
											</tr>
											</c:if>
											<c:forEach items="${cartList }" var="vo">
											<tr>
												<td>
													<img src="/admin/product/displayFile?fileName=${vo.pro_main_img }" style="width: 80px;">
													<input type="hidden" name="img_${vo.pro_num }" value="${vo.pro_main_img }">
												</td>
											</tr>	
											</c:forEach>
										</tbody>
									</table>
								</div><!-- /.card-body -->
							<div class="card-footer">
							<!-- 전체상품주문, 선택상품주문, 쇼핑계속하기(이전화면) -->
							</div>
						</div><!-- /.card -->
					</div><!-- /.col -->
				</div><!-- /.row -->
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