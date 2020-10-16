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
<style>
	.col-center	{
		text-align: center;
	}
	table, th, td {
		vertical-align: middle !important; 
	}
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
							<div class="card-header" style="background-color: #F9D5D3;">
								<h3 class="card-title">상품 목록</h3>
							</div>
							<div class="card-body">
								<select class="form-control" name="searchType" style="width:180px; display: inline-block;">
									<option value="null"
										<c:out value="${cri.searchType == null?'selected':''}"/>>검색조건 선택</option>
									<option value="name"
										<c:out value="${cri.searchType eq 'name'?'selected':''}"/>>상품명</option>
									<option value="detail"
										<c:out value="${cri.searchType eq 'detail'?'selected':''}"/>>내용</option>
									<option value="company"
										<c:out value="${cri.searchType eq 'company'?'selected':''}"/>>제조사</option>
									<option value="name_detail"
										<c:out value="${cri.searchType eq 'name_detail'?'selected':''}"/>>상품명+내용</option>
									<option value="name_company"
										<c:out value="${cri.searchType eq 'name_company'?'selected':''}"/>>상품명+제조사</option>
									<option value="all"
										<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>상품명+내용+제조사</option>
								</select>
								<!-- SEARCH -->
								<input class="form-control" type="text" name='keyword' id="keyword" style="width:250px; display: inline-block;" value='${cri.keyword}' />
								<%--<button id="btn_search" class="btn btn-default">검색</button>--%>
								<button class="btn btn-defalt" type="button">
									<i class="fas fa-search"></i>
								</button>
							</div>
							<div class="card-body table-responsive p-0">
								<table id="tbl_productList" class="table table-hover table-bordered text-nowrap">
									<tr class="col-center">
										<th><input type="checkbox" id="checkAll"></th>
										<th>번호</th>
										<th>이미지</th>
										<th>상품명</th>
										<th>판매가</th>
										<th>할인가</th>
										<th>제조사</th>
										<th>수량</th>
										<th>판매상태</th>
										<th>상품등록일자</th>
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
											<td class="col-center">${productVO.pro_num}</td>
											<td class="col-center">
												<img src="/admin/product/displayFile?fileName=${productVO.pro_main_img }" style="width: 80px;">
												<input type="hidden" name="img_${productVO.pro_num }" value="${productVO.pro_main_img }">
											</td>
											<td class="col-md-2">
												<a href="/admin/product/read${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pro_num}" style="color: #807F89;">
													${productVO.pro_nm}&nbsp;<ion-icon name="search-outline"></ion-icon>
												</a>
											</td>
											<td class="col-md-1 col-center">${productVO.pro_price}</td>
											<td class="col-md-1 col-center">${productVO.pro_discount}</td>
											<td class="col-md-2 col-center">${productVO.pro_publisher}</td>
											<td class="col-md-1 col-center">${productVO.pro_count }</td>
											<td class="col-center">
												<select class="form-control" name="buy${productVO.pro_num}" style="width: 60px; display: inline-block;">
												  <option <c:out value="${productVO.pro_buy_yn == 'Y'?'selected':''}"/>>Y</option>
												  <option <c:out value="${productVO.pro_buy_yn == 'N'?'selected':''}"/>>N</option>
												</select>
											</td>
											<td class="col-md-1 col-center">${productVO.sta_date }</td>
										</tr>
										</c:forEach>
								</table>
							</div><!-- /.card-body -->
							<div class="card-footer">
								<ul class="pagination pagination-sm m-0 text-center">
									<!-- 이전표시 여부  [이전] -->
									<c:if test="${pm.prev}">
										<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.startPage-1)}">&laquo;</a></li>
									</c:if>
									<!-- 페이지목록번호 :  1  2  3  4  5  -->
									<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
										<li class="page-item" <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
											<a class="page-link" href="list${pm.makeSearch(idx)}">${idx}</a>
										</li>
									</c:forEach>
									<!-- 다음표시 여부  [다음]-->
									<c:if test="${pm.next && pm.endPage > 0}">
										<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.endPage +1)}">&raquo;</a></li>
									</c:if>
								</ul>
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
</body>
</html>