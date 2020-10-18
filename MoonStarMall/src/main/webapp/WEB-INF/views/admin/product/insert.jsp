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
<script>
	/* 테이블 행클릭 이벤트 */
	function productDtlInfo(){
		/*
		var str = ""
	    var tdArr = new Array();    // 배열 선언
	        
	    // 현재 클릭된 Row(<tr>)
	    var tr = $(this);
	    var td = tr.children();
	    
		// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	    console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	            
	    // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
	    td.each(function(i){
	        tdArr.push(td.eq(i).text());
	    });
	            
	    console.log("배열에 담긴 값 : "+tdArr);
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

<!-- all ckeckbox 기능 -->
<script>
$(document).ready(function(){
    var tbl = $("#tbl_product");
     
    // 테이블 헤더에 있는 checkbox 클릭시
    $(":checkbox:first", tbl).click(function(){
        // 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
        if( $(this).is(":checked") ){
            $(":checkbox", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox", tbl).removeAttr("checked");
        }

        // 모든 체크박스에 change 이벤트 발생시키기               
        $(":checkbox", tbl).trigger("change");
    });
     
    // 헤더에 있는 체크박스외 다른 체크박스 클릭시
    $(":checkbox:not(:first)", tbl).click(function(){
        var allCnt = $(":checkbox:not(:first)", tbl).length;
        var checkedCnt = $(":checkbox:not(:first)", tbl).filter(":checked").length;
         
        // 전체 체크박스 갯수와 현재 체크된 체크박스 갯수를 비교해서 헤더에 있는 체크박스 체크할지 말지 판단
        if( allCnt==checkedCnt ){
            $(":checkbox:first", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox:first", tbl).removeAttr("checked");
        }
    }).change(function(){
        if( $(this).is(":checked") ){
            // 체크박스의 부모 > 부모 니까 tr 이 되고 tr 에 selected 라는 class 를 추가한다.
            $(this).parent().parent().addClass("selected");
        }
        else{
            $(this).parent().parent().removeClass("selected");
        }
    });
    
});
</script>

<style>
	.table td {
		padding: 0;
		text-align: center;
		vertical-align: middle;
	}
	
	table>input {
		border: 0;
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
									<div class="form-group">
										<div class="row">
											<div class="col-md-2">
												<img id="LoadImg" style="width: 150px;" height="150px;">
											</div>
											<div class="col-md-10">
												<label for="file1">상품 대표 이미지</label>
												<input type="file" id="file1" name="file1" class="form-control" onchange="imgPreview(this);" />
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="pro_dtl_info">상품상세설명</label>
						                <textarea class="textarea" placeholder="Place some text here" id="pro_dtl_info" name="pro_dtl_info"
						                          style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
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
	<tr onclick="productDtlInfo()">
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
			<input type="text" id="pro_price" name="pro_price" class="form-control">
		</td>
		<td>
			<input type="text" id="pro_discount" name="pro_discount" class="form-control">
		</td>
		<td>
			<input type="text" id="pro_count" name='pro_count' class="form-control">
		</td>
		<td>
			<select id="pro_buy_yn" name="pro_buy_yn" class="form-control">
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select>
		</td>
	</tr>
</script>

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
		
		var target = $("#productRowAdd");
		var templateObject = $("#productRowAddTemplate");
		
		var template = Handlebars.compile(templateObject.html());
		
		target.append(template);
	});
	
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