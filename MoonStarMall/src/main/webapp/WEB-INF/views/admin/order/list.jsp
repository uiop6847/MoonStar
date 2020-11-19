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
						<h1 class="m-0 text-dark">Admin Page <small>Order List</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item active">주문 관리</li>
							<li class="breadcrumb-item active">주문 목록</li>
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
								<h3 class="card-title">주문 목록</h3>
							</div>
							<div class="card-body p-0">
								<table class="table table-sm">
									<tr>
										<th class="col-right">주문처리상태</th>
										<td>
											<select id="statusType" name="statusType" class="form-control" style="width: 170px; display: inline-block;">
								        		<option value="all" <c:out value="${cri.statusType == null?'selected':''}"/>>전체</option>
								        		<option value="01" <c:out value="${cri.statusType eq '01'?'selected':''}"/>>입금대기중</option>
								        		<option value="02" <c:out value="${cri.statusType eq '02'?'selected':''}"/>>결제완료</option>
								        		<option value="03" <c:out value="${cri.statusType eq '03'?'selected':''}"/>>배송준비중</option>
												<option value="04" <c:out value="${cri.statusType eq '04'?'selected':''}"/>>배송중</option>
												<option value="05" <c:out value="${cri.statusType eq '05'?'selected':''}"/>>배송완료</option>
							        		</select>
							        	</td>
									</tr>
									<tr>
										<th class="col-right">주문일자</th>
										<td>
											<input type="date" class="form-control" id="fromDate" name="fromDate" value="${cri.fromDate }" style="width: 170px; display: inline-block;">
											<span>~</span>
											<input type="date" class="form-control" id="toDate" name="toDate" value="${cri.toDate }" style="width: 170px; display: inline-block;">
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
										</td>
									</tr>
									<tr>
										<th class="col-right">검색어</th>
										<td>
											<select class="form-control" id="searchType" name="searchType" style="width:180px; display: inline-block;">
												<option value="null"
													<c:out value="${cri.searchType == null?'selected':''}"/>>검색조건 선택</option>
												<option value="ord_cd"
													<c:out value="${cri.searchType eq 'ord_cd'?'selected':''}"/>>주문번호</option>
												<option value="ord_nm"
													<c:out value="${cri.searchType eq 'ord_nm'?'selected':''}"/>>주문자명</option>
												<option value="addr"
													<c:out value="${cri.searchType eq 'addr'?'selected':''}"/>>주소</option>
												<option value="tel_phone"
													<c:out value="${cri.searchType eq 'tel_phone'?'selected':''}"/>>일반전화</option>
												<option value="cell_phone"
													<c:out value="${cri.searchType eq 'cell_phone'?'selected':''}"/>>휴대전화</option>
												<option value="pay_nm"
													<c:out value="${cri.searchType eq 'pay_nm'?'selected':''}"/>>입금자명</option>
											</select>
											<!-- SEARCH -->
											<input class="form-control" type="text" name='keyword' id="keyword" style="width:250px; display: inline-block;" value='${cri.keyword}' />
										</td>
									</tr>
								</table>
							</div>
							<div class="row">
								<div class="col-12" style="text-align: center; padding: 10px;">
									<button type="button" class="btn btn-default" id="btn_search">조회</button>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-12" style="text-align: right; padding: 10px;">
									<button class="btn btn-info" type="button" id="btn_edit">
										주문상태수정</button>
								</div>
							</div>
							<form id="productListForm" method="post">
								<div class="card-body p-0">
									<table id="tbl_orderList" class="table table-sm table-hover table-bordered text-nowrap">
										<thead>
										<tr class="col-center">
											<th><input type="checkbox" id="checkAll"></th>
											<th>주문일자<br>[주문번호]</th>
											<th>아이디</th>
											<th>받는사람</th>
											<th>주소</th>
											<th>일반전화</th>
											<th>휴대전화</th>
											<th>결제금액</th>
											<th>결제수단</th>
											<th>입금자명</th>
											<th>주문처리상태</th>
										</tr>
										</thead>
										<tbody id="tbl_orderListRow">
											<%-- 주문리스트 출력 --%>
											<c:if test="${empty orderList}">
											<tr>
												<td colspan="11">
													<p style="padding:50px 0px; text-align: center;">등록된 상품이 존재하지 않습니다. </p>
												</td>
											</tr>
											</c:if>
											<c:forEach items="${orderList }" var="list" varStatus="i">
											<tr>
												<td>
													<input type="checkbox" name="check" class="check">
												</td>
												<td class="col-center">
													<fmt:formatDate value="${list.ord_date }" pattern="yyyy-MM-dd"/>
													<br>[${list.ord_cd }]
													<input type="hidden" name="ord_cd" value="${list.ord_cd }">
												</td>
												<td class="col-center">${list.user_id }</td>
												<td class="col-center">${list.ord_nm }</td>
												<td class="col-md-2"  style="white-space: normal;">
													<p>(${list.zip_num})&nbsp;${list.addr}&nbsp;${list.addr_dtl}</p>
												</td>
												<td class="col-center">${list.tel_phone }</td>
												<td class="col-center">${list.cell_phone }</td>
												<td class="col-center"><fmt:formatNumber value="${list.pay_amount }" pattern="#,###"/></td>
												<td class="col-center">${list.payment }</td>
												<td class="col-center">${list.pay_nm }</td>
												<td class="col-center">
													<select class="form-control" name="ord_status" style="width:140px;">
														<c:forEach var="status" items="${statusList}">
															<option value="${status.status_cd }"
																<c:out value="${status.status_cd == list.ord_status?'selected':''}"/>>${status.status_nm }</option>
														</c:forEach>
													</select>
												</td>
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
											<li class="page-item"><a class="page-link" href="list${pm.makeOrderSearch(pm.startPage-1)}">&laquo;</a></li>
										</c:if>
										<!-- 페이지목록번호 :  1  2  3  4  5  -->
										<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
											<li class="page-item <c:out value="${pm.cri.page == idx?'active':''}"/>">
												<a class="page-link" href="list${pm.makeOrderSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>
										<!-- 다음표시 여부  [다음]-->
										<c:if test="${pm.next && pm.endPage > 0}">
											<li class="page-item"><a class="page-link" href="list${pm.makeOrderSearch(pm.endPage +1)}">&raquo;</a></li>
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
	/* 조회버튼 클릭 시 */
	$("#btn_search").on("click", function(){
		console.log($("select[name='ord_status'] option:selected").val());
		self.location = "/admin/order/list"
			+ "${pm.makeQuery(1)}"
			+ "&statusType="
			+ $("select[name='statusType'] option:selected").val()
            + "&fromDate=" + $("#fromDate").val()
            + "&toDate=" + $("#toDate").val()
			+ "&searchType="
			+ $("select[name='searchType'] option:selected").val()
			+ "&keyword=" + $("#keyword").val();
			
    });
	
	/* 검색어 조건 default 선택 시 */
	$("#searchType").on("change", function(){
		if($(this).val() == "null"){
			$("#keyword").val("");
		}
	});
	
	/* table 행의 주문처리상태 변경시 */
	$("select[name='ord_status']").on("change", function(){
		$(this).parent().siblings().find(":checkbox").prop("checked", true);
	});
	
    /* 주문상태수정버튼 클릭 시 */
    $("#btn_edit").on("click", function(){
        
        var ordCd = [];
        var ordStatus = [];
        
        if($(":checkbox:checked").length == 0){
            alert("선택된 주문정보가 없습니다.\n수정할 주문정보를 선택해주세요.");
			return false;
        }

        $("#tbl_orderListRow tr").each(function(i){
        	
            if($(this).find(":checkbox").is(":checked")){
            	
            	ordCd.push($("input[name='ord_cd']:eq("+$(this).index()+")").val());
            	ordStatus.push($("select[name='ord_status']:eq("+$(this).index()+") option:selected").val());
            }
        });
        
        $.ajax({
			url : "/admin/order/ordStatusUpdate",
			type : "post", 
			dataType: "text",
			data : {
				ordCd : ordCd,
				ordStatus : ordStatus
				},
			success : function(data) {

				if(data == "SUCCESS"){
                    alert("주문처리상태가 수정되었습니다.");
                    location.href="/admin/order/list${pm.makeOrderSearch(pm.cri.page)}";
                }
			}
        });
    });
    
    /* 날짜조건 버튼 클릭 이벤트 */
    // 오늘
    $("#btn_toDay").on("click", function(){

        $("#fromDate").val($(this).data("date"));
    });

    // 1주일
    $("#btn_weekago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
    });

    // 1개월
    $("#btn_monthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
    });

    // 3개월
    $("#btn_threeMonthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
    });

    // 6개월
    $("#btn_sixMonthago").on("click", function(){

        $("#fromDate").val($(this).data("date"));
    });
	
});
</script>
</body>
</html>