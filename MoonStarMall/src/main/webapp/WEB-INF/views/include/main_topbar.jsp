<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- Handlebar Template --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
	<div class="container">
		<div style="margin: 0 auto;">
			<!-- top navbar links -->
			<ul class="navbar-nav">
				<!-- 카테고리 -->
				<c:forEach items="${categoryList}" var="list">
					<%--<li class="nav-item mainCategory">
						<a href="/product/list?cat_code=${list.cat_code}" class="nav-link">${list.cat_name}</a>
						<!--  2차카테고리 자식수준으로 추가작업 -->
						<ul class="treeview-menu" id="mainCategory_${list.cat_code}"></ul>
					</li> --%>
					<li class="nav-item dropdown mainCategory" value="${list.cat_code}">
						<a href="/product/category?cat_code=${list.cat_code}" class="nav-link" style="margin: 0 5px;">
						${list.cat_name}</a>
						<ul class="dropdown-menu border-0 shadow" id="mainCategory_${list.cat_code}">
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>
		<ul class="navbar-nav">
			<li class="nav-item" >
				<a class="nav-link">
					<ion-icon src="/ionicons/bag-outline.svg" style="font-size:20px;"></ion-icon></a>
			</li>
		</ul>
	</div>
</nav>
<!-- /.navbar -->
<script id="subCategoryTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<li><a href="/product/category?cat_code={{cat_code}}" class="dropdown-item">{{cat_name}}</a></li>
	{{/each}}
</script>
<%-- 2차 카테고리 템플릿 적용함수 --%>
<script>
$(function(){
	/* 1차 카테고리에 따른 2차 카테고리 작업.   on()메서드: 매번진행 one()메서드: 단1회만 진행 */
	$(".mainCategory").one("mouseover", function(){
		var mainCatCode= $(this).val();
		var url = "/product/subCategoryList/" + mainCatCode;
		
		// REST 방식으로 전송
		$.getJSON(url, function(data){
			// 받은 데이터로 subCategory에 템플릿 적용
			subCategory(data, $("#mainCategory_"+mainCatCode), $("#subCategoryTemplate"));
			
		});

	});
	
	var subCategory = function(subCGStr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr);

		// 기존 option 제거(누적방지)
		//$("#subCategory option").remove();
		target.append(options);
	}
	
});
</script>