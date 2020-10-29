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
		<div class="content">
			<div class="container">
				<!-- START ACCORDION & CAROUSEL-->
				<%@include file="/WEB-INF/views/include/carousel.jsp" %>
				<!-- END ACCORDION & CAROUSEL-->
			</div>
		</div>
		
		<!-- Main content -->
		<div class="content">
			<div class="container">
				<div class="row">
					<c:forEach items="${newProductList}" var="newList" >
						<div class="col-lg-3 col-md-6 mb-3">
							<div class="card h-100">
								<a href="/product/detail?pro_num=${newList.pro_num}">
									<img class="card-img-top" src="/admin/product/displayFile?fileName=${newList.pro_main_img}">
								</a>
								<div class="card-body">
									<a href="/product/detail?pro_num=${newList.pro_num}" style="color: black; font-size: 16px;">
									${newList.pro_nm}</a>
									<c:if test="${newList.pro_discount == 0}">
										<br><p>${newList.pro_price}</p>
									</c:if>
									<c:if test="${newList.pro_discount != 0}">
										<br><span style="text-decoration:line-through;">${newList.pro_price}</span>
										<br>
										<span style="color: #ECA4A6;">할인판매가 : 
											<fmt:formatNumber value="${newList.pro_price - newList.pro_price div newList.pro_discount}" />
										</span>
									</c:if>
								</div>
								<div class="card-footer" style="height: 72px;">
									<c:if test="${newList.avg_score == 0}">
										<div style="width:95px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
									</c:if>
									<c:if test="${newList.avg_score != 0}">
										<div style="position:absolute; width:95px; overflow:hidden; color:#cdcdcd;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
										<c:set var="width" value="${(newList.avg_score/5)*95}"></c:set>
										<div style="position:absolute; width:${width}px; overflow:hidden; white-space:nowrap; color:#312E41;">
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
											<ion-icon src="/ionicons/star.svg"></ion-icon>
										</div>
										<br><span style="color: #807F89; position:relative;">[${newList.avg_score}]</span>
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