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
<script type="text/javascript" src="/js/admin/login.js"></script>
<script>
	if("${msg}"=="LOGIN_SUCCESS"){
		alert("로그인 되었습니다.\n환영합니다!");
		
	} else if("${msg}"=="LOGIN_FAIL"){
		alert("로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 확인해주세요.");
		
	} else if("${msg}"=="LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다.");
		
	}
</script>
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
							<li class="breadcrumb-item active">HOME</li>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
	
		<%-- 로그인 안 한 상태 --%>
		<c:if test="${sessionScope.admin == null}">
		<!-- Main content -->
		<div class="login-page" style="height: 500px; background: none; justify-content: flex-start;">
			<div class="card login-box">
				<div class="card-header" style="background-color: #F9D5D3;">
				  <h3 class="card-title">Sign in to start your session</h3>
				</div>
				<form class="form-horizontal" id="loginForm" action="/admin/loginOK" method="post">
					<div class="card-body">
						<div class="form-group row">
							<label for="admin_id" class="col-sm-2 col-form-label">ID</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="admin_id" name="admin_id" placeholder="ID">
							</div>
						</div>
						<div class="form-group row">
							<label for="admin_pw" class="col-sm-2 col-form-label">PW</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="admin_pw" name="admin_pw" placeholder="PW">
							</div>
						</div>
					</div>
					<!-- /.card-body -->
				<div class="card-footer">
				  <button type="submit" class="btn float-right" style="background-color: #F9D5D3;">
				  Sign in</button>
				</div>
				<!-- /.card-footer -->
				</form>
			</div>
		</div>
		<!-- /.content -->
		</c:if>		
		<!-- Main content -->
		<div class="content">
			<div class="container">
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.admin != null}">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<h4>welcome!<br/></h4>
								<h6>This is Admin Main page. <br/> 
									Please click on the menu you want to work on :)</h6>
							</div>
						</div>
					</div>
				</c:if>
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