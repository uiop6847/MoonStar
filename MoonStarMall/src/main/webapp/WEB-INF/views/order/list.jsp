<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
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
	.col-left	{
		text-align: left;
	}
	.col-right	{
		text-align: right;
	}
	table, th, td {
		vertical-align: middle !important; 
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
								<h3 class="card-title">주문내역조회</h3>
							</div>
							<div class="card-body">
					        <br>
					        	<select id="ord_status" name="ord_status" class="form-control" style="width: 170px; display: inline-block;">
					        		<option value="all" <c:out value="${cri.searchType == null?'selected':''}"/>>전체</option>
					        		<option value="01" <c:out value="${cri.searchType eq '01'?'selected':''}"/>>입금대기중</option>
					        		<option value="02" <c:out value="${cri.searchType eq '02'?'selected':''}"/>>결제완료</option>
					        		<option value="03" <c:out value="${cri.searchType eq '03'?'selected':''}"/>>배송준비중</option>
									<option value="04" <c:out value="${cri.searchType eq '04'?'selected':''}"/>>배송중</option>
									<option value="05" <c:out value="${cri.searchType eq '05'?'selected':''}"/>>배송완료</option>
					        	</select>
								<div class="btn-group">
									<!-- 날짜계산 객체 생성 -->
							        <%
							        Calendar cal = Calendar.getInstance();
							        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
							        %>
									<!-- 오늘날짜 구하기 -->
									<%request.setAttribute("toDay", new java.util.Date());%>
									<fmt:formatDate var="toDay" value="${toDay }" pattern="yyyy-MM-dd"/>
									<button type="button" class="btn btn-default" id="btn_toDay" data-date="${toDay }">오늘</button>
									<!-- 1주일 전 날짜 구하기 -->
									<%
									cal.setTime(new Date());
									cal.add(Calendar.DATE, -7);
									request.setAttribute("weekago", df.format(cal.getTime()));
									%>
									<button type="button" class="btn btn-default" id="btn_weekago" data-date="${weekago }">1주일</button>
									<!--  1개월 전 날짜 구하기 -->
									<%
									cal.setTime(new Date());
									cal.add(Calendar.MONTH, -1);
									request.setAttribute("monthago", df.format(cal.getTime()));
									%>
									<button type="button" class="btn btn-default" id="btn_monthago" data-date="${monthago }">1개월</button>
									<!--  3개월 전 날짜 구하기 -->
									<%
									cal.setTime(new Date());
									cal.add(Calendar.MONTH, -3);
									request.setAttribute("threeMonthago", df.format(cal.getTime()));
									%>
									<button type="button" class="btn btn-default" id="btn_threeMonthago" data-date="${threeMonthago }">3개월</button>
									<!--  6개월 전 날짜 구하기 -->
									<%
									cal.setTime(new Date());
									cal.add(Calendar.MONTH, -6);
									request.setAttribute("sixMonthago", df.format(cal.getTime()));
									%>
									<button type="button" class="btn btn-default" id="btn_sixMonthago" data-date="${sixMonthago }">6개월</button>
								</div>
								<div class="form-group" style="display: inline-block;">
									<input type="date" class="form-control" id="fromDate" name="fromDate" value="${cri.fromDate }" style="width: 170px; display: inline-block;">
									<span>~</span>
									<input type="date" class="form-control" id="toDate" name="toDate" value="${cri.toDate }" style="width: 170px; display: inline-block;">
									<button type="button" class="btn btn-default" id="btn_search">조회</button>
								</div>
							</div>
							<div class="card-body">
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
											<!-- <th>선택</th> -->
										</tr>
										</thead>
										<tbody id="tbl_cartListRow">
											<%-- 주문내역 출력 --%>
											<c:forEach items="${orderList }" var="list" varStatus="i">
											<tr>
												<td class="col-center">
													<fmt:formatDate value="${list.ord_date }" pattern="yyyy-MM-dd"/>
													<br>[${list.ord_cd }]
												</td>
												<td class="col-center">
													<img src="/product/displayFile?fileName=${list.pro_main_img }" style="width: 80px;">
													<input type="hidden" name="img_${list.ord_cd }" value="${list.pro_main_img }">
												</td>
												<td class="col-md-1">
													<a href="/product/detail?pro_num=${list.pro_num}" style="color: #807F89;">
														${list.pro_nm}&nbsp;<ion-icon name="search-outline"></ion-icon>
													</a>
												</td>
												<td class="col-center">${list.buy_count }</td>
												<td class="col-center">
													<fmt:formatNumber value="${list.buy_price }" pattern="#,###" />
												</td>
												<td class="col-center">${list.ord_status_nm }
													<input type="hidden" id=ord_status name="ord_status" value="${list.ord_status }">
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:if>
							</div><!-- /.card-body -->
							<div class="card-footer">
								<nav aria-label="Contacts Page Navigation">
									<ul class="pagination justify-content-center m-0">
										<!-- 이전표시 여부  [이전] -->
										<c:if test="${pm.prev}">
											<li class="page-item"><a class="page-link" href="/order/list${pm.makeDate(pm.startPage-1)}">&laquo;</a></li>
										</c:if>
										<!-- 페이지목록번호 :  1  2  3  4  5  -->
										<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
											<li class="page-item <c:out value="${pm.cri.page == idx?'active':''}"/>">
												<a class="page-link" href="list${pm.makeDate(idx)}">${idx}</a>
											</li>
										</c:forEach>
										<!-- 다음표시 여부  [다음]-->
										<c:if test="${pm.next && pm.endPage > 0}">
											<li class="page-item"><a class="page-link" href="/order/list${pm.makeDate(pm.endPage +1)}">&raquo;</a></li>
										</c:if>
									</ul>
								</nav>
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
<script>
$(function(){

    /* 날짜조건 버튼 클릭 이벤트 */
    // 오늘
    $("#btn_toDay").on("click", function(){

        $("#fromDate").val($(this).data("date"));
        search_submit();
    });

    // 1주일
    $("#btn_weekago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
        search_submit();
    });

    // 1개월
    $("#btn_monthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
        search_submit();
    });

    // 3개월
    $("#btn_threeMonthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
        search_submit();
    });

    // 6개월
    $("#btn_sixMonthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
        search_submit();
    });

    /* 조회 버튼 클릭 시 */
    $("#btn_search").on("click", function(){

        search_submit();
    });

    // 데이터 전송
    function search_submit(){
    	
        self.location = "/order/list"
			+ "${pm.makeQuery(1)}"
			+ "&searchType="
			+ $("select option:selected").val()
            + "&fromDate=" + $("#fromDate").val()
            + "&toDate=" + $("#toDate").val();
    }

});
</script>
</body>
</html>