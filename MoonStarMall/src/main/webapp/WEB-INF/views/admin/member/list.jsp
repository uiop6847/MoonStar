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
<style>
	.col-center	{
		text-align: center;
	}
	table, th, td {
		vertical-align: middle !important; 
	}
	.col-right	{
		text-align: right;
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

	<%@include file="/WEB-INF/views/include/main_header_admin.jsp" %>
	<%--<%@include file="/WEB-INF/views/include/top_admin.jsp" %> --%>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Admin Page <small>Member List</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item active">회원 관리</li>
							<li class="breadcrumb-item active">회원 목록</li>
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
							<div class="card-header" style="background-color: #F9D5D3;">
								<h3 class="card-title">회원 목록</h3>
							</div>
							<div class="card-body">
								<select class="form-control" name="searchType" style="width:180px; display: inline-block;">
									<option value="null"
										<c:out value="${cri.searchType == null?'selected':''}"/>>검색조건 선택</option>
									<option value="id"
										<c:out value="${cri.searchType eq 'id'?'selected':''}"/>>ID</option>
									<option value="name"
										<c:out value="${cri.searchType eq 'name'?'selected':''}"/>>회원명</option>
								</select>
								<!-- SEARCH -->
								<input class="form-control" type="text" name='keyword' id="keyword" style="width:250px; display: inline-block;" value='${cri.keyword}' />
								<%--<button id="btn_search" class="btn btn-default">검색</button>--%>
								<button class="btn btn-defalt" type="button" id="btn_search">
									<i class="fas fa-search"></i>
								</button>
							</div>
							<form id="productListForm" method="post">
								<div class="card-body table-responsive p-0">
									<table id="tbl_userList" class="table table-hover table-bordered text-nowrap">
										<thead>
										<tr class="col-center">
											<th>아이디</th>
											<th>회원명</th>
											<th>이메일</th>
											<th>수신여부</th>
											<th>포인트</th>
											<th>상품구매개수</th>
											<th>상품결제합계</th>
											<th>회원가입일</th>
											<th>마지막접속일</th>
										</tr>
										</thead>
										<tbody id="tbl_userListRow">
											<%-- 회원리스트 출력 --%>
											<c:if test="${empty userList}">
											<tr>
												<td colspan="9">
													<p style="padding:50px 0px; text-align: center;">회원이 존재하지 않습니다. </p>
												</td>
											</tr>
											</c:if>
											<c:forEach items="${userList }" var="list">
											<tr>
												<td class="col-center">${list.user_id}</td>
												<td class="col-center">${list.user_nm}</td>
												<td class="col-center">${list.user_email}</td>
												<td class="col-center">${list.email_rev_yn}</td>
												<td class="col-center"><fmt:formatNumber value="${list.user_point}" pattern="#,###"/></td>
												<td class="col-center"><fmt:formatNumber value="${list.ord_cnt}" pattern="#,###"/></td>
												<td class="col-center"><fmt:formatNumber value="${list.pay_amount}" pattern="#,###"/></td>
												<td class="col-center"><fmt:formatDate value="${list.sta_date }" pattern="yyyy-MM-dd"/></td>
												<td class="col-center"><fmt:formatDate value="${list.last_date }" pattern="yyyy-MM-dd"/></td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div><!-- /.card-body -->
							</form>
							<div class="card-footer">
								<nav aria-label="Contacts Page Navigation">
									<ul class="pagination justify-content-center m-0">
										<!-- 이전표시 여부  [이전] -->
										<c:if test="${pm.prev}">
											<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.startPage-1)}">&laquo;</a></li>
										</c:if>
										<!-- 페이지목록번호 :  1  2  3  4  5  -->
										<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
											<li class="page-item <c:out value="${pm.cri.page == idx?'active':''}"/>">
												<a class="page-link" href="list${pm.makeSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>
										<!-- 다음표시 여부  [다음]-->
										<c:if test="${pm.next && pm.endPage > 0}">
											<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.endPage +1)}">&raquo;</a></li>
										</c:if>
									</ul>
								</nav>
							</div>
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
<script>
$(function(){
	/* 검색버튼 클릭 시 */
	$("#btn_search").on("click", function(){
		self.location = "list"
			+ '${pm.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keyword').val();
    });
});
</script>
</body>
</html>