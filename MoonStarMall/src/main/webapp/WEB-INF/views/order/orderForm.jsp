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
<script type="text/javascript" src="/js/order/orderForm.js"></script>
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
	
	input[readonly="readonly"]{
		background-color: #fff !important;
	}
	
	.row-title {
		margin: 40px 0 0;
	}
	
	.selected {
		display: none;
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
						<h1 class="m-0 text-dark">ORDER</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
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
						<form id="orderInfo" action="/order/orderInfoAdd" method="post">
							<div class="card-header">
								<h3 class="card-title">주문내역</h3>
							</div>
							<div class="card-body table-responsive p-0">
								<table id="tbl_cartList" class="table table-hover table-bordered text-nowrap">
									<thead>
									<tr class="col-center">
										<th>이미지</th>
										<th>상품정보</th>
										<th>판매가</th>
										<th>수량</th>
										<th>적립금</th>
										<th>배송비</th>
										<th>합계</th>
									</tr>
									</thead>
									<tbody id="tbl_cartListRow">
										<%-- 장바구니리스트 출력 --%>
										<c:set var="total_price" value="0" />
										<c:set var="pro_total_point" value="0" />
										<c:forEach items="${orderInfoList }" var="orderList" varStatus="i">
										<c:set var="point" value="0" />
											<tr class="col-center">
												<td>
													<input type="hidden" id="list[${i.index }].pro_num" name="list[${i.index }].pro_num" value="${orderList.pro_num }">
													<input type="hidden" id="list[${i.index }].cart_cd" name="list[${i.index }].cart_cd" value="${orderList.cart_cd }">
													<input type="hidden" id="list[${i.index }].buy_count" name="list[${i.index }].buy_count" value="${orderList.buy_count }">
													<a href="/product/detail?pro_num=${orderList.pro_num }"><img src="/product/displayFile?fileName=${orderList.pro_main_img }" style="width: 80px;"></a>
													<input type="hidden" name="img_${orderList.pro_num }" value="${orderList.pro_main_img }">
												</td>
												<td class="col-md-2 col-left">
													<a href="/product/detail?pro_num=${orderList.pro_num }" style="color: #807F89;">${orderList.pro_nm }</a>
												</td>
												<td>
													<span><fmt:formatNumber value="${orderList.discount_price }" /></span>
													<input type="hidden" id="list[${i.index }].discount_price" name="discount_price" value="${orderList.discount_price }">
												</td>
												<td>
													${orderList.buy_count }
												</td>
												<td>
													<c:set var="point" value="${orderList.discount_price * (1/100) * orderList.buy_count}" />
													<fmt:formatNumber value="${point}" pattern="#,###"/>원(1%)
													<c:set var="pro_total_point" value="${pro_total_point + point}"/>
												</td>
												<td>무료</td>
												<td>
													<span><fmt:formatNumber value="${orderList.discount_price * orderList.buy_count}" /></span>
													<c:set var="total_price" value="${total_price + (orderList.discount_price * orderList.buy_count) }"/>
													<input type="hidden" id="list[${i.index }].pro_total_price" name="pro_total_price" value="${orderList.discount_price * orderList.buy_count}">
												</td>
											</tr>
										</c:forEach>
										<tr>
											<td colspan="8">
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
								<div class="row row-title">
									<div class="col-6"><label>배송정보</label></div>
									<div class="col-md-6 col-right">
										<span style="color: #FA8072">*</span><small>&nbsp;필수입력사항</small>
									</div>
								</div>
								<table class="table" style="border-bottom: 1px solid #dee2e6;">
									<tr>
										<th style="width: 150px;">배송지선택</th>
										<td>
											<label><input type="radio" name = "buy_addr" checked="checked">기본배송지</label>
											<label><input type="radio" name = "buy_addr">새로입력</label>
											<button type="button" class="btn btn-flat btn-default">배송지관리</button>
											<!-- 기본배송지 저장목적 -->
											<input type="hidden" id="def_nm" value="${orderAddr.de_nm }">
											<input type="hidden" id="def_zip_num" value="${orderAddr.de_zip_num }">
											<input type="hidden" id="def_addr" value="${orderAddr.de_addr }">
											<input type="hidden" id="def_addr_dtl" value="${orderAddr.de_addr_dtl }">
											<input type="hidden" id="def_tel_phone" value="${orderAddr.de_tel_phone }">
											<input type="hidden" id="def_cell_phone" value="${orderAddr.de_cell_phone }">
										</td>
									</tr>
									<tr>
										<th>받으시는분&nbsp;<span style="color: #FA8072">*</span></th>
										<td><input type="text" class="form-control" id="ord_nm" name="ord_nm" style="width: 100px;" value="${orderAddr.de_nm }"></td>
									</tr>
									<tr>
										<th>주소&nbsp;<span style="color: #FA8072">*</span></th>
										<td>
											<div class="row">
												<div style="width: 100px;">
													<input type="text" class="form-control" id="sample2_postcode" name="zip_num" readonly="readonly" value="${orderAddr.de_zip_num }">
												</div>
												<div style="width: 200px;">
													<button type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default">
													우편번호찾기&nbsp;<i class="fa fa-search"></i>
													</button>
												</div>
											</div>
											<div class="row">
												<input type="text" class="form-control" id="sample2_address" name="addr" readonly="readonly" style="width: 60%;" value="${orderAddr.de_addr }">
												<label>&nbsp;기본주소</label>
											</div>
											<div class="row">
												<input type="text" class="form-control" id="sample2_detailAddress" name="addr_dtl" style="width: 60%;" value="${orderAddr.de_addr_dtl }">
												<label>&nbsp;상세주소(선택입력가능)</label>
												<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
											</div>
										</td>
									</tr>
									<tr>
										<th>일반전화</th>
										<td>
											<input type="text" class="form-control" id="tel_phone" name="tel_phone" style="width: 200px;" value="${orderAddr.de_tel_phone }">
										</td>
									</tr>
									<tr>
										<th>휴대전화&nbsp;<span style="color: #FA8072">*</span></th>
										<td>
											<input type="text" class="form-control" id="cell_phone" name="cell_phone" style="width: 200px;" value="${orderAddr.de_cell_phone }">
										</td>
									</tr>
								</table>
								<div class="row row-title">
									<div class="col-12"><label>결제 예정 금액</label></div>
								</div>
								<table class="table table-bordered col-center">
									<tr>
										<th>총 주문금액</th>
										<th>총 할인금액</th>
										<th>총 결제예정금액</th>
									</tr>
									<tr style="font-size: xx-large;">
										<td>
											<span id="buy_price_2"><fmt:formatNumber value="${total_price}" /></span>
											<input type="hidden" id="total_price" value="${total_price }">
										</td>
										<td id="total_discount_2">- 0</td>
										<td>
											= <span id="buy_total_price_2"><fmt:formatNumber value="${total_price}" /></span>
										</td>
									</tr>
									<tr>
										<th>총 할인금액</th><td colspan="3" id="total_discount_1" class="col-left">- 0</td>
									</tr>
									<tr>
										<td class="col-left">구매적립금</td>
										<td colspan="3" class="col-left">
											<input type="number" class="form-control" id="use_point" name="use_point" value="0" style="width: 200px; display: inline-block; text-align: right;" min="0" max="${userPoint }">
											원(총 사용가능 구매적립금 <span><fmt:formatNumber value="${userPoint }"/></span>원)
											<input type="hidden" id="user_point" value="${userPoint }">
										</td>
									</tr>
								</table>
								<div class="row row-title">
									<div class="col-12"><label>결제 수단</label></div>
								</div>
								<div style="margin: 10px;">
									<label><input type="radio" id="payment_0" name="payment" value="cash" checked="checked">
									무통장입금</label>
									<label><input type="radio" id="payment_1" name="payment" value="card">
									카드결제</label>
								</div>
								<div style="margin:10px; padding: 20px; border: 1px solid #ced4da; height: 200px;">
									<table class="table" id="cash_section" style="border-bottom: 1px solid #dee2e6;">
										<tr>
											<td>입금자명</td>
											<td><input type="text" class="form-control" id="pay_nm" name="pay_nm" style="width: 100px;"></td>
										</tr>
										<tr>
											<td>입금은행</td>
											<td><span>국민은행 : 123456789 관리자</span></td>
										</tr>
									</table>
								</div>
							</div><!-- /.card-body -->
							<div class="card-footer">
								<div class="row" id="payArea">
									<div class="col-4">
										<table class="table table-bordered">
											<tr>
												<td>총 적립예정금액</td>
												<td>
													<span id="total_point"><fmt:formatNumber value="${pro_total_point}" pattern="#,###"/>원</span>
												</td>
												
											</tr>
											<tr>
												<td>상품별 구매적립금</td>
												<td>
													<span id="pro_point"><fmt:formatNumber value="${pro_total_point}" pattern="#,###"/>원</span>
												</td>
											</tr>
										</table>
									</div>
									<div class="col-5" style="border-left: 1px solid rgba(0,0,0,.1); font-size: large;">
										<p>
											<strong id="pay_name">무통장입금</strong>
											 <span>최종결제금액&nbsp;<b id="pay_price"><fmt:formatNumber value="${total_price}" /></b></span>
										</p>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" id="chk_agreement">
											<label class="form-check-label" for="chk_agreement">결제정보를 확인하였으며, 구매진행에 동의합니다.</label>
				                        </div>
									</div>
									<div class="col-3">
										<div class="col-right" style="margin: 20% 0;">
											<input type="hidden" id="pay_amount" name="pay_amount" value="${total_price }">
											<input type="hidden" id="re_point" name="re_point" value="<fmt:parseNumber value="${pro_total_point}" integerOnly="true" />">
											<button type="button" id="btn_buy" class="btn btn-flat btn-secondary" style="width:200px; padding: 20px; background-color: #3d4145;">
											결제하기</button>
										</div>
									</div>
								</div>
							</div>
						</form>
						</div><!-- /.card -->
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	
	<%-- 우편번호API 동작코드 --%>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/member/postCode.js"></script>
	
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