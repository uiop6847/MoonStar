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
<!-- ckeditor -->
<script src="/ckeditor/ckeditor.js"></script>
<!-- Handlebars -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<%-- 상품등록 유효성 검사 --%>
<script type="text/javascript" src="/js/admin/insert.js"></script>
<%--table all ckeckbox기능 --%>
<script type="text/javascript" src="/js/check.js"></script>
<script>

	/* 이미지 미리보기 */
	function imgPreview(value) {
		
		// 선택된 행의 img태그 찾기
		var accImg = $("div[name='proDtl']").not(".selected").children().children().children();
		
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
		//console.log("index : " + index);
		
		$("#productRowAddInfo div[name='proDtl']").addClass("selected"); // 모든 div태그 숨기기
		$("#productRowAddInfo>div").eq(index).removeClass("selected"); // 선택한 행의 div태그 보이기
	}
	
	/* CKEditor 불러오기 */
	function ckEditorLoad(id){
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

		// config.js 설정 사용
		//CKEDITOR.replace("pro_dtl_info", ckeditor_config);
		CKEDITOR.replace(id, ckeditor_config);
	}
</script>
<style>
	.table td {
		padding: 0;
		text-align: center;
		vertical-align: middle;
	}
	
	.selected { 
		display: none;
	}
	
	.checkSelected{background-color: navy;color: #fff; font-weight: bold;}
	
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
							<li class="breadcrumb-item active">상품 관리</li>
							<li class="breadcrumb-item active">상품 등록</li>
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
							<form id="productInsertForm" action="/admin/product/insertOK" method="post" enctype="multipart/form-data">
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
												<tr style="text-align: center;">
													<th><input type="checkbox" id="checkAll" name="checkAll"></th>
													<th>상품명</th>
													<th>제조사</th>
													<th>판매가</th>
													<th>할인율</th>
													<th>판매수량</th>
													<th>판매가능상태</th>
												</tr>
											</thead>
											<tbody id="productRowAdd">
											</tbody>
										</table>
									</div>
									<div id="productRowAddInfo">
									</div>
									<div class="box-footer">
										<div>
											<hr>
										</div>
										<button id="btn_submit" type="button" class="btn btn-primary">상품등록</button>
	
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

<!-- productTable Handlebar Template -->
<script id="productRowAddTemplate" type="text/x-handlebars-template">
	<tr onclick="productDtlInfo(this);">
		<td>
			<input type="checkbox" name="check" class="check" checked="checked">
		</td>
		<td>
			<input type="text" id="pro_nm" name="pro_nm" class="form-control">
		</td>
		<td>
			<input type="text" id="pro_publisher" name="pro_publisher" class="form-control"> 
		</td>
		<td>
			<input type="number" id="pro_price" name="pro_price" class="form-control">
		</td>
		<td>
			<input type="number" id="pro_discount" name="pro_discount" class="form-control">
		</td>
		<td>
			<input type="number" id="pro_count" name="pro_count" class="form-control">
		</td>
		<td>
			<select id="pro_buy_yn" name="pro_buy_yn" class="form-control">
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select>
		</td>
	</tr>
</script>

<script id="productRowAddInfoTemplate" type="text/x-handlebars-template">
<div class="form-group" name="proDtl">
	<div class="row">
		<div class="col-md-2">
			<img id="LoadImg" style="width: 150px;" height="150px;">
		</div>
		<div class="col-md-10">
			<label for="file1">상품 대표 이미지</label>
			<input type="file" id="file1" name="file1" class="form-control" onchange="imgPreview(this);" />
		</div>
	</div>
	<label>상품상세설명</label>
	<textarea class="textarea" placeholder="Place some text here" id="pro_dtl_info" name="pro_dtl_info"
		style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">
	</textarea>
</div>
</script>
<script>
$(function(){
	
	var cnt = 0; // 동적ID값 목적 : pro_dtl_info_(cnt) 
	
	/* 2차 카테고리 처리 */
	$("#mainCategory").on("change", function(){
		
		var mainCatCode = $(this).val(); // 1차카테고리 코드
		var url = "/admin/product/subCategoryList/" + mainCatCode;
		
		// REST 방식으로 전송
		$.getJSON(url, function(data){
			subCategory(data, $("#subCategory"), $("#subCategoryTemplate"));
		});
	});
	
	/* 2차카테고리 템플릿 적용함수 */
	var subCategory = function(subCGStr, target, templateObject){
		
		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr);
		
		$("#subCategory option").remove();
		target.append(options);
	}
	
	/* 상품등록 테이블 행추가 */
	$("#btn_add").click(function(){
		
		var target = $("#productRowAdd");
		var templateObject = $("#productRowAddTemplate");
		var template = Handlebars.compile(templateObject.html());
		
		target.append(template);
		
		//target.children(":last").children(":first").children().prop("checked", true);

		/* 이미지, 상세설명 추가 */
		pro_info();
		
	});
	
	/* 이미지, 상세설명 추가 */
	function pro_info(){
		var target = $("#productRowAddInfo");
		var templateObject = $("#productRowAddInfoTemplate");
		var template = Handlebars.compile(templateObject.html());
		
		target.children().addClass("selected");
		target.append(template);
		
		var ckId = target.children(":last").children(":last").attr("id", "pro_dtl_info_" + cnt);
		
		ckEditorLoad(ckId.attr("id"));
		cnt += 1;
	}
	
	/* 상품등록 테이블 행삭제 */
	$("#btn_remove").click(function(){
		
		var length = $("#productRowAdd tr").length-1;

		for(i = length; i >= 0; i--){
			
			if($("#productRowAdd tr").eq(i).children().children().is(":checked") == true) {
				
				$("#productRowAddInfo>div").eq(i).remove();
			}
		}
		
		if($("input[name=check]").is(":checked") == true) { //체크된 요소가 있으면
			
			var i = $("input[name='check']:checked").parents("tr");
		
			i.remove();
		}else {
			alert("삭제할 항목을 선택해주세요!");
		}
	});
	/*
	$(document).on("click","input[name=check]",function(){
		var adultYn = $("input[name=check]").is(":checked")?"Y":"N"; //3항연산자, checkbox 체크 여부

		if(adultYn == "Y"){
			$("input[name=check]").attr("checked", "checked");
		}else{
			$("input[name=check]").removeAttr("checked");
		}
		console.log(adultYn);
	});
	*/
});
</script>
</body>
</html>