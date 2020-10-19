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

	/* 테이블 행클릭 이벤트 */
	function productDtlInfo(tr){
		var index = tr.rowIndex - 1;
	    console.log('클릭한 TR index : ' + index);
	    
	    //console.log($(this).attr("data-index"));

	    //var check = $("input[name=check]");
	    //check.val(index);
		//console.log('check value : ' + $("input[name=check]").val());
		
		//$("#temp_file1").attr("data-index", index);
		
		/*
		$(this).each(function(){
			$(this).click(function(){
				$(this).addClass("selected"); //클릭된 부분을 상단에 정의된 CCS인 selected클래스로 적용
				$(this).siblings().removeClass("selected"); //siblings:형제요소들,    removeClass:선택된 클래스의 특성을 없앰
			});
		});
		*/
	
	}
	
	/* 이미지 미리보기 */
	function imgPreview(value) {
		
		if(value.files && value.files[0]){
			var reader = new FileReader();
			
			reader.onload = function(e){
				$("#LoadImg").attr("src", e.target.result)
			}
			
			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
<style>
	.table td {
		padding: 0;
		text-align: center;
		vertical-align: middle;
	}
	
	.selected { 
		background-color: #000080;
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
													<th><input type="checkbox" id="checkAll"></th>
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
									<div id="productRowAddInfo" data-index="">
									<%--
										<div class="form-group">
											<div class="row">
												<div class="col-md-2">
													<img id="LoadImg" style="width: 150px;" height="150px;">
												</div>
												<div class="col-md-10">
													<label for="file1">상품 대표 이미지</label>
													<input data-index="" type="file" id="file1" name="file1" class="form-control" onchange="imgPreview(this);" />
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="pro_dtl_info">상품상세설명</label>
							                <textarea data-index="" class="textarea" placeholder="Place some text here" id="pro_dtl_info" name="pro_dtl_info"
							                          style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">
							                </textarea>
										</div>
									 --%>
									</div>
									<div class="box-footer">
										<div>
											<hr>
										</div>
										<ul class="mailbox-attachments clearfix uploadedList">
										</ul>
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
	<tr onclick="productDtlInfo(this)">
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
			<input type="number" id="pro_count" name='pro_count' class="form-control">
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
<div class="form-group">
	<div class="row">
		<div class="col-md-2">
			<img id="LoadImg" style="width: 150px;" height="150px;">
		</div>
		<div class="col-md-10">
			<label for="file1">상품 대표 이미지</label>
			<input data-index="" type="file" id="file1" name="file1" class="form-control" onchange="imgPreview(this);" />
		</div>
	</div>
</div>
<div class="form-group">
	<label for="pro_dtl_info">상품상세설명</label>
	<textarea data-index="" class="textarea" placeholder="Place some text here" id="pro_dtl_info" name="pro_dtl_info"
		style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">
	</textarea>
</div>
</script>
<script>
$(function(){
	
	var rowIndex;
	
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
	CKEDITOR.replace("pro_dtl_info", ckeditor_config);
	
	
	/* 상품등록 테이블 행추가 */
	$("#btn_add").click(function(){
		
		/* 행추가 */
		var target = $("#productRowAdd");
		var templateObject = $("#productRowAddTemplate");
		var template = Handlebars.compile(templateObject.html());
		
		target.append(template);
		
		/* 이미지, 상세설명 추가 */
		pro_info();
		
		rowIndex = $("#productRowAdd tr:last").index();
		console.log("$('#productRowAdd tr:last'): " + rowIndex);
		
		$("#productRowAdd tr:last td input[name=check]").val(rowIndex);
		$("#productRowAdd tr:last td input[name=check]").attr("data-index", rowIndex);
		console.log("check: " + $("#productRowAdd tr:last td input[name=check]").val());
		
		$("#file1").attr("data-index", rowIndex);
		
	});
	
	/* 이미지, 상세설명 추가 */
	function pro_info(){
		var target = $("#productRowAddInfo");
		var templateObject = $("#productRowAddInfoTemplate");
		var template = Handlebars.compile(templateObject.html());
		
		target.children().hide();
		target.append(template);
	}
	
	/* 상품등록 테이블 행삭제 */
	$("#btn_remove").click(function(){

		if($("input[name=check]").is(":checked") == true){ //체크된 요소가 있으면
            
			var i = $("input[name=check]:checked").parents("tr");
               
			i.remove();
        }else {
            alert("삭제할 항목을 선택해주세요!")
        }
	});
	
	
});
</script>
</body>
</html>