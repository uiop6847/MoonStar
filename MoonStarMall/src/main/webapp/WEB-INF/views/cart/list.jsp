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
								<h3 class="card-title">상품(${listTotal})</h3>
							</div>
							<div class="card-body table-responsive p-0">
								<c:if test="${empty cartList}">
									<p style="padding:50px 0px; text-align: center;">장바구니가 비어있습니다. </p>
								</c:if>
								<c:if test="${!empty cartList}">
									<form id="cartForm" action="/order/orderForm" method="post">
										<table id="tbl_cartList" class="table table-hover table-bordered text-nowrap">
											<thead>
											<tr class="col-center">
												<th><input type="checkbox" id="checkAll"></th>
												<th>이미지</th>
												<th>상품정보</th>
												<th>판매가</th>
												<th>수량</th>
												<th>적립금</th>
												<th>배송비</th>
												<th>합계</th>
												<th>선택</th>
											</tr>
											</thead>
											<tbody id="tbl_cartListRow">
												<%-- 장바구니리스트 출력 --%>
												<c:set var="total_price" value="0" />
												<c:forEach items="${cartList }" var="list" varStatus="i">
													<tr class="col-center">
														<td>
															<input type="checkbox" name="check" class="check">
															<input type="hidden" id="list[${i.index }].pro_num" name="pro_num" value="${list.pro_num }">
															<input type="hidden" id="list[${i.index }].cart_cd" name="cart_cd" value="${list.cart_cd }">
														</td>
														<td>
															<a href="/product/detail?pro_num=${list.pro_num }"><img src="/product/displayFile?fileName=${list.pro_main_img }" style="width: 80px;"></a>
															<input type="hidden" name="img_${list.pro_num }" value="${list.pro_main_img }">
														</td>
														<td class="col-md-2 col-left">
															<a href="/product/detail?pro_num=${list.pro_num }" style="color: #807F89;">${list.pro_nm }</a>
														</td>
														<td>
															<span><fmt:formatNumber value="${list.discount_price }" /></span>
															<input type="hidden" id="list[${i.index }].discount_price" name="discount_price" value="${list.discount_price }">
														</td>
														<td>
															<%--상품수량이 있으면 --%>
															<c:if test="${list.pro_count > 0}">
																<div style="margin: auto; margin-bottom:10px; width: 70px;">
																	<input class="form-control" type="number" id="list[${i.index }].buy_count" name="buy_count" value="${list.buy_count }">
																</div>
																<button type="button" id="list[${i.index }].btn_count_update" class="btn btn-flat btn-default">변경</button>
															</c:if>
															<%--상품수량이 없으면 --%>
															<c:if test="${list.pro_count <= 0}">
																<div style="margin: auto; margin-bottom:10px; width: 70px;">
																	<input class="form-control" value="${list.buy_count }" readonly="readonly" style="background-color: white;">
																</div>
																<p style="font-weight: bold; color: red;">품절</p>
																<input type="hidden" name="pro_count" value="${list.pro_count }">
															</c:if>
														</td>
														<td>-</td>
														<td>무료</td>
														<td>
															<span><fmt:formatNumber value="${list.discount_price * list.buy_count}" /></span>
															<c:set var="total_price" value="${total_price + (list.discount_price * list.buy_count) }"/>
															<input type="hidden" id="list[${i.index }].pro_total_price" name="pro_total_price" value="${list.discount_price * list.buy_count}">
														</td>
														<td>
															<button type="button" id="list[${i.index }].btn_buy" class="btn btn-flat btn-secondary" style="width: 91px; margin-bottom: 5px;">
															주문하기</button>
															<br>
															<button type="button" id="list[${i.index }].btn_delete" class="btn btn-flat btn-default" style="width: 91px;">
															삭제하기</button>
														</td>
													</tr>
												</c:forEach>
												<tr>
													<td colspan="9">
														<p class="col-right" style="margin: 10px 0;">
															상품구매금액
															<label id="buy_price_1"><fmt:formatNumber value="${total_price}" /></label>
															+ 배송비 0(무료) = 합계 :
															<label id="buy_total_price_1" style="font-size: x-large;"><fmt:formatNumber value="${total_price}" /></label>
														</p>
													</td>
												</tr>
											</tbody>
										</table>
									</form>
									<div class="row" style="margin: 30px 0;">
										<div class="col-6">
										 	선택상품을 <button type="button" id="btn_check_delete" class="btn btn-flat btn-secondary">
										 	삭제하기</button>
										</div>
										<div class="col-6 col-right">
											<button type="button" id="btn_all_delete" class="btn btn-flat btn-default">
											장바구니 비우기</button>
										</div>
									</div>
									<table class="table table-bordered col-center">
										<tr>
											<th>총 상품금액</th>
											<th>총 배송비</th>
											<th>결제예정금액</th>
										</tr>
										<tr style="font-size: xx-large;">
											<td><span id="buy_price_2"><fmt:formatNumber value="${total_price}" /></span></td>
											<td>0</td>
											<td>= <span id="buy_total_price_2"><fmt:formatNumber value="${total_price}" /></span></td>
										</tr>
									</table>
								</c:if>
							</div><!-- /.card-body -->
							<div class="card-footer">
								<!-- 전체상품주문, 선택상품주문, 쇼핑계속하기(이전화면) -->
								<div class="row" style="margin: 20px 0;">
									<div class="col-12 col-center">
										<button type="button" id="btn_all_buy" class="btn btn-flat btn-secondary" style="padding: 20px; background-color: #3d4145;">
										전체상품주문</button>
										<button type="button" id="btn_check_buy" class="btn btn-flat btn-secondary" style="padding: 20px;">
										선택상품주문</button>
									</div>
								</div>
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