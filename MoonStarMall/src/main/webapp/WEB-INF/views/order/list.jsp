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
<%--table all ckeckbox기능 --%>
<script type="text/javascript" src="/js/check.js"></script>
<script type="text/javascript" src="/js/cart/list.js"></script>
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
	.col-left	{
		text-align: left;
	}
	.col-right	{
		text-align: right;
	}
	table, th, td {
		vertical-align: middle !important; 
	}
	table tr th{
		border-left: 0px !important;
		border-right: 0px !important;
	}
	table tr td:first-child{
		border-left: 0px !important;
	}
	table tr td:last-child{
		border-right: 0px !important;
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
						<h1 class="m-0 text-dark">ORDER LIST</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
							<li class="breadcrumb-item"><a href="/">MY PAGE</a></li>
							<li class="breadcrumb-item active">ORDER</li>
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
								<h3 class="card-title">주문내역조회(0)</h3>
							</div>
							<div class="card-body table-responsive p-0">
								<c:if test="${empty orderList}">
									<p style="padding:50px 0px; text-align: center;">주문내역이 없습니다.</p>
								</c:if>
								<c:if test="${!empty orderList}">
									<table id="tbl_cartList" class="table table-hover table-bordered text-nowrap">
										<thead>
										<tr class="col-center">
											<th>주문일자<br>[주문번호]</th>
											<th>이미지</th>
											<th>상품정보</th>
											<th>수량</th>
											<th>상품구매금액</th>
											<th>주문처리상태</th>
											<th>선택</th>
										</tr>
										</thead>
										<tbody id="tbl_cartListRow">
											<%-- 주문내역 출력 --%>
											<c:forEach items="${orderList }" var="list" varStatus="i">
											<tr>
												<td>
													<fmt:formatDate value="${list.ord_date }" pattern="yyyy-MM-dd"/>
													<br>[${list.ord_cd }]
												</td>
												<td></td>
												<td></td>
												<td></td>
												<td>${list.pay_amount }</td>
												<td>${list.ord_state }</td>
												<td></td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:if>
							</div><!-- /.card-body -->
							<div class="card-footer">
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