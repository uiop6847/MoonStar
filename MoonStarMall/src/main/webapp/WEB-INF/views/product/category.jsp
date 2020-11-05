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
	
	/* pagination style START */
	.page-item.active .page-link {
		background-color:#ECA4A6;
		border:1px solid #ECA4A6;
	}
	a.page-link:hover, a.page-link:focus {
		color:#fff;
		border:1px solid #ECA4A6;
		background-color:#ECA4A6;
	}
	.page-link {
		color: rgba(0,0,0,.5);
	}
	/* pagination style END */
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
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
							<c:forEach var="cat" items="${categoryList}">
								<!--클릭한 카테고리가 1차 카테고리인 경우 -->
								<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode == null}">
									<li class="breadcrumb-item active">${cat.cat_name}</li>
								</c:if>
								<!--클릭한 카테고리가 2차 카테고리인 경우 -->
								<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode != null}">
									<c:forEach var="cat" items="${categoryList}">
										<c:if test="${cat.cat_prtcode == null}">
											<li class="breadcrumb-item"><a href="/product/category?cat_code=${cat.cat_code}">${cat.cat_name}</a></li>
										</c:if>
										<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode != null}">
											<li class="breadcrumb-item active">${cat.cat_name}</li>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
		<div class="content">
			<div class="container">
				<div class="row">
					<div style="width:100%; color:#807F89; text-align:center; margin: 30px 0;">
						<!-- 클릭한 카테고리명  -->
						<c:forEach var="cat" items="${categoryList}">
								${cat.cat_code == cat_code ? cat.cat_name : null}
						</c:forEach>
						<nav class="main-header navbar navbar-expand-md">
							<div style="margin: 0 auto;">
								<!-- top navbar links -->
								<ul class="navbar-nav" >
									<!-- 2차카테고리 -->
									<c:forEach items="${categoryList}" var="cat">
										<c:if test="${!empty cat.cat_prtcode}">
											<li class="nav-item <c:out value="${cat.cat_code == cat_code?'active':''}"/>" value="${cat.cat_code}" style="margin: 20px 10px;">
												<a href="/product/category?cat_code=${cat.cat_code}" class="sub nav-link">
												${cat.cat_name}</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Main content -->
		<div class="content">
			<div class="container">
				<div class="row" style="margin-bottom: 40px; color:#807F89; font-size: small;">
					<div class="col-md-6" style="text-align: left;">
						- TOTAL <b>${pm.totalCount }</b> ITEMS
					</div>
					<div class="col-md-6" style="text-align: right;">
						<a href="/product/category?cat_code=${cat_code}&sort=new">신상품</a><span style="margin: 0 5px">&Iota;</span>
						<a href="/product/category?cat_code=${cat_code}&sort=pro_nm">상품명</a><span style="margin: 0 5px">&Iota;</span>
						<a href="/product/category?cat_code=${cat_code}&sort=low_price">낮은가격</a><span style="margin: 0 5px">&Iota;</span>
						<a href="/product/category?cat_code=${cat_code}&sort=high_price">높은가격</a>
					</div>
				</div>
				<div class="row">
					<c:forEach items="${categoryProductList}" var="productList">
						<div class="col-lg-3 col-md-6 mb-3">
							<div class="card h-100">
								<a href="/product/detail?pro_num=${productList.pro_num}">
									<img class="card-img-top" src="/product/displayFile?fileName=${productList.pro_main_img}">
								</a>
								<div class="card-body">
									<a href="/product/detail?pro_num=${productList.pro_num}" style="color: black; font-size: 16px;">
									${productList.pro_nm}</a>
									<c:if test="${productList.pro_discount == 0}">
										<br><span><fmt:formatNumber value="${productList.pro_price}" /></span>
									</c:if>
									<c:if test="${productList.pro_discount != 0}">
										<br><span style="text-decoration:line-through;"><fmt:formatNumber value="${productList.pro_price}" /></span>
										
										<br>
										<span style="color: #ECA4A6;">할인판매가 : 
											<fmt:formatNumber value="${productList.discount_price}" />
										</span>
									</c:if>
								</div>
								<div class="card-footer" style="height: 72px;">
									<small>후기 [${productList.rew_cnt}]</small>
									<c:if test="${productList.avg_score == 0}">
										<div style="width:95px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
									</c:if>
									<c:set var="score"><fmt:formatNumber value="${productList.avg_score}" pattern=".0"/></c:set>
									<c:if test="${productList.avg_score != 0}">
										<div style="position:absolute; width:130px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<small style="color: #807F89;">(${score})</small>
										</div>
										<c:set var="width" value="${score * 18.7}"></c:set>
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
				<%-- 페이지 표시 --%>
				<div class="card-footer">
					<nav aria-label="Contacts Page Navigation">
						<ul class="pagination justify-content-center m-0">
							<!-- 이전표시 여부  [이전] -->
							<c:if test="${pm.prev}">
								<li class="page-item"><a class="page-link" href="category${pm.makeSort(pm.startPage-1)}&cat_code=${cat_code}">&laquo;</a></li>
							</c:if>
							<!-- 페이지목록번호 :  1  2  3  4  5  -->
							<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
								<li class="page-item <c:out value="${pm.cri.page == idx?'active':''}"/>">
									<a class="page-link" href="category${pm.makeSort(idx)}&cat_code=${cat_code}">${idx}</a>
								</li>
							</c:forEach>
							<!-- 다음표시 여부  [다음]-->
							<c:if test="${pm.next && pm.endPage > 0}">
								<li class="page-item"><a class="page-link" href="category${pm.makeSort(pm.endPage +1)}&cat_code=${cat_code}">&raquo;</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
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