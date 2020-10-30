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
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header.jsp" %>
	
	<%@include file="/WEB-INF/views/include/main_topbar.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<div class="content">
			<div class="container">
				<div class="row">
					<p style="width:100%; color:#807F89; text-align:center; margin-bottom:30px;">
						outwear</p>
				</div>
			</div>
		</div>
		
		<!-- Main content -->
		<div class="content">
			<div class="container">
				<div class="row">
					<c:forEach items="${categoryProductList}" var="catList" >
						<div class="col-lg-3 col-md-6 mb-3">
							<div class="card h-100">
								<a href="/product/detail?pro_num=${catList.pro_num}">
									<img class="card-img-top" src="/product/displayFile?fileName=${catList.pro_main_img}">
								</a>
								<div class="card-body">
									<a href="/product/detail?pro_num=${catList.pro_num}" style="color: black; font-size: 16px;">
									${catList.pro_nm}</a>
									<c:if test="${catList.pro_discount == 0}">
										<br><span><fmt:formatNumber value="${catList.pro_price}" /></span>
									</c:if>
									<c:if test="${catList.pro_discount != 0}">
										<br><span style="text-decoration:line-through;"><fmt:formatNumber value="${catList.pro_price}" /></span>
										
										<br>
										<span style="color: #ECA4A6;">할인판매가 : 
											<fmt:formatNumber value="${catList.pro_price - catList.pro_price div catList.pro_discount}" />
										</span>
									</c:if>
								</div>
								<div class="card-footer" style="height: 72px;">
									<small>후기 [${catList.rew_cnt}]</small>
									<c:if test="${catList.avg_score == 0}">
										<div style="width:95px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
									</c:if>
									<c:if test="${catList.avg_score != 0}">
										<div style="position:absolute; width:130px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<small style="color: #807F89;">(${catList.avg_score})</small>
										</div>
										<c:set var="width" value="${(catList.avg_score/5)*95}"></c:set>
										<div style="position:absolute; width:${width}px; overflow:hidden; white-space:nowrap; color:#312E41;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- /.row -->
			</div>
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