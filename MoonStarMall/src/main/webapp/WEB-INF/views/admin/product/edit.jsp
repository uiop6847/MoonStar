<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<%-- ckeditor --%>
<script src="/ckeditor/ckeditor.js"></script>
<%-- Handlebars --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<%--table all ckeckbox기능 --%>
<script type="text/javascript" src="/js/check.js"></script>
<script type="text/javascript" src="/js/admin/edit.js"></script>
<script>

	//페이지 로드시 자바스크립트 실행
	window.onload = pageLoad;
	function pageLoad(){
		ckEditorLoad();// CKEditor 불러오기
	};
	
	/* 이미지 미리보기 */
	function imgPreview(value) {
		
		// 선택된 행의 img태그 찾기
		var accImg = $("div[name='proDtl']:not(.selected)").find("img");
		
		if(value.files && value.files[0]){
			var reader = new FileReader();
			
			reader.onload = function(e){
				accImg.attr("src", e.target.result);
			}
			
			reader.readAsDataURL(value.files[0]);
		}
	}
	
	/* 테이블 행클릭 이벤트 */
	function productDtlInfo(tr){
		
		var index = tr.rowIndex - 1;
		
		$("#productRowAdd tr").removeClass("lastFocus");
		$("#productRowAdd tr").eq(index).addClass("lastFocus");
		
		$("#productRowAddInfo div[name='proDtl']").addClass("selected"); // 모든 div태그 숨기기
		$("#productRowAddInfo>div").eq(index).removeClass("selected"); // 선택한 행의 div태그 보이기
		
		// 선택한 행의 카테고리로 변경
		selectCategory(index);
	}


	/* CKEditor 불러오기 */
	function ckEditorLoad(){
		/* 
			ckEditor 작업
			config.js를 사용하지 않고 개별 설정하는 부분
		*/
		var ckeditor_config = {
				resize_enabled : true,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCancollapse : true, 
				removePlugins : "elementspath",
				filebrowserUploadUrl : '/admin/product/imgUpload'
		};

		$("div[name=proDtl]").each(function(i){
			CKEDITOR.replace("list["+i+"].pro_dtl_info", ckeditor_config);
		});
	}
	
	/* 선택한 행의 카테고리로 변경 */
	function selectCategory(i){
		
		var main = $("input[id='list["+i+"].cat_prtcode']").val();
		
		//$("#mainCategory > option").removeAttr("selected");
		$("#mainCategory > option[value="+main+"]").prop("selected", true);
		
		// REST 방식으로 전송
		var url = "/admin/product/subCategoryList/" + main;
		
		$.getJSON(url, function(data){
			subCategory(data, $("#subCategory"), $("#subCategoryTemplate"));
		});
		
		/* 2차카테고리 템플릿 적용함수 */
		var subCategory = function(subCGStr, target, templateObject){
			
			var template = Handlebars.compile(templateObject.html());
			var options = template(subCGStr);
			
			$("#subCategory option").remove();
			target.append(options);

			var sub = $("input[id='list["+i+"].cat_code']").val();

			//$("#subCategory > option").removeAttr("selected");
			$("#subCategory > option[value="+sub+"]").prop("selected", true);
		}
	}
</script>
<style>
	.table th {
		text-align: center;
	}
	.table td {
		padding: 0;
		text-align: center;
		vertical-align: middle;
	}
	.selected { 
		display: none;
	}
	.lastFocus {
		background-color: #D7DBD1;
	}
</style>
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header_admin.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Admin Page <small>Product Insert</small></h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/admin/main">HOME</a></li>
							<li class="breadcrumb-item"><a href="/admin/product/list${pm.makeSearch(pm.cri.page)}">상품 목록</a></li>
							<li class="breadcrumb-item active">상품 수정</li>
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
					<div class="col-lg-12">
						<div class="card">
							<form id="productEditForm" action="/admin/product/editOK" method="post" enctype="multipart/form-data">
								<div class="card-body">
									<div class="form-group">
										<div class="row">
											<div class="col-md-4"><label for="mainCategory">1차 카테고리</label></div>
											<div class="col-md-4"><label for="subCategory">2차 카테고리</label></div>
										</div>
										<div class="row">
											<div class="col-md-4">
												<select class="form-control" id="mainCategory" name="cat_prtcode">
													<option value="default">1차 카테고리 선택</option>
													<c:forEach items="${mainCategory}" var="main">
														<option value="${main.cat_code}">${main.cat_name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-4">
												<select class="form-control" id="subCategory" name="cat_code">
												 	<option value="default">2차 카테고리 선택</option>
												</select>
											</div>
										</div>
									</div>
									<div class="table-responsive p-0" style="height: 300px;">
										<div class="row float-right">
											<div class="btn-group" style="padding-right: 10px;">
												<button class="btn btn-default" type="button" id="btn_add">
													<ion-icon src="/ionicons/add-outline.svg"></ion-icon></button>
												<button class="btn btn-default" type="button" id="btn_remove">
													<ion-icon src="/ionicons/remove-outline.svg"></ion-icon></button>
											</div>
										</div>
										<table class="table table-head-fixed table-hover text-nowrap" id="tbl_product">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll" name="checkAll"></th>
													<th>번호</th>
													<th>상품명</th>
													<th>제조사</th>
													<th>판매가</th>
													<th>할인율</th>
													<th>판매수량</th>
													<th>판매가능상태</th>
												</tr>
											</thead>
											<tbody id="productRowAdd">
											<c:forEach var="vo" items="${editList}" varStatus="i">
												<tr onclick="productDtlInfo(this);">
													<td>
														<input type="checkbox" name="check" class="check" checked="checked">
														<input type="hidden" id="list[${i.index }].cat_code" name="cat_code" value="${vo.cat_code}">
														<input type="hidden" id="list[${i.index }].cat_prtcode" name="cat_prtcode" value="${vo.cat_prtcode}">
													</td>
													<td style="min-width: 10px;">
														<input type="hidden" id="list[${i.index }].pro_num" name="pro_num" value="${vo.pro_num}">
														<span>${vo.pro_num}</span>
													</td>
													<td>
														<input type="text" id="list[${i.index }].pro_nm" name="pro_nm" value="${vo.pro_nm}" class="form-control">
													</td>
													<td>
														<input type="text" id="list[${i.index }].pro_publisher" name="pro_publisher" value="${vo.pro_publisher}" class="form-control"> 
													</td>
													<td>
														<input type="number" id="list[${i.index }].pro_price" name="pro_price" value="${vo.pro_price}" class="form-control">
													</td>
													<td>
														<input type="number" id="list[${i.index }].pro_discount" name="pro_discount" value="${vo.pro_discount}" class="form-control">
													</td>
													<td>
														<input type="number" id="list[${i.index }].pro_count" name="pro_count" value="${vo.pro_count}" class="form-control">
													</td>
													<td>
														<select id="list[${status.index }].pro_buy_yn" name="pro_buy_yn" class="form-control">
															<option <c:out value="${vo.pro_buy_yn == 'Y'?'selected':''}"/>>Y</option>
													  		<option <c:out value="${vo.pro_buy_yn == 'N'?'selected':''}"/>>N</option>
														</select>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
									<div>
										<hr>
									</div>
								<c:set var="originFile" value="${originFile}" />
								<c:forEach var="vo" items="${editList}" varStatus="i">
									<div id="productRowAddInfo">
										<div class="form-group selected" name="proDtl">
											<div class="row">
												<div class="col-md-2">
													<label for="file1">상품 대표 이미지</label>
													<img id="LoadImg" style="width: 100px;" height="100px;" src="/admin/product/displayFile?fileName=${vo.pro_main_img }">
												</div>
												<div class="col-md-10">
													<input type="hidden" name="pro_main_img" value="${vo.pro_main_img}" />
													<span id="fileName" style="margin-left:5px; font-size:14px;">현재 등록된 파일: <c:out value="${originFile[i.index]}"/></span>
													<input type="file" id="list[${i.index }].file1" name="file1" class="form-control" onchange="imgPreview(this);" />
												</div>
											</div>
											<label>상품상세설명</label>
											<textarea class="textarea" placeholder="Place some text here" id="list[${i.index }].pro_dtl_info" name="pro_dtl_info" 
											style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">
											${vo.pro_dtl_info }</textarea>
										</div>
									</div>
						        </c:forEach>
									<div class="box-footer">
										<div>
											<hr>
										</div>
										<div class="row float-right">
											<div class="col-md-12">
												<button id="btn_submit" type="button" class="btn" style="background-color: #F9D5D3;">
												상품수정</button>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			<!-- /.row -->
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

<!-- subCategory Handlebar Template -->
<script id="subCategoryTemplate" type="text/x-handlebars-template">
	<option value="default">2차 카테고리  선택</option>
	{{#each .}}
		<option value="{{cat_code}}">{{cat_name}}</option>
	{{/each}}
</script>

<%-- 버튼 클릭 이벤트 --%>
<script>
$(function(){
	
	/* 2차 카테고리 처리 */
	$("#mainCategory").on("change", function(){
		
		var mainCatCode = $(this).val(); // 1차카테고리 코드
		var url = "/admin/product/subCategoryList/" + mainCatCode;
		
		// REST 방식으로 전송
		$.getJSON(url, function(data){
			subCategory(data, $("#subCategory"), $("#subCategoryTemplate"));
		});
		
		// 변경한 1차카테고리를 해당 row에 적용
		var main = $("#productRowAdd").find(".lastFocus").find("td").eq(0).find("input[id$=cat_prtcode]");
		main.val(mainCatCode);
		console.log("change : " + main.val());
	});
	
	/* 2차카테고리 템플릿 적용함수 */
	var subCategory = function(subCGStr, target, templateObject){
		
		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr);
		
		$("#subCategory option").remove();
		target.append(options);
	}
	
	$("#subCategory").on("change", function(){
		
		var subCatCode = $(this).val(); // 1차카테고리 코드
		var sub = $("#productRowAdd").find(".lastFocus").find("td").eq(0).find("input[id$=cat_code]");
		sub.val(subCatCode);
	});
	
});
</script>
</body>
</html>