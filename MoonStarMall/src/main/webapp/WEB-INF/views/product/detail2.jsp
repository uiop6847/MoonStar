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

<style>
	td {
		 padding: 8px 16px;
	}
	
	td:last-child {
		text-align: right;
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
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
							<c:forEach var="cat" items="${categoryList}">
								<!--클릭한 카테고리가 1차 카테고리인 경우 -->
								<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode == null}">
									<li class="breadcrumb-item active">${cat.cat_name}</li>
								</c:if>
								<!--클릭한 카테고리가 2차 카테고리인 경우 -->
								<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode != null}">
									<c:forEach var="cat" items="${categoryList}">
										<c:if test="${cat.cat_prtcode == null}">
											<li class="breadcrumb-item"><a href="/product/category?cat_code=${cat.cat_code}">${cat.cat_name}</a></li>
										</c:if>
										<c:if test="${cat.cat_code == cat_code && cat.cat_prtcode != null}">
											<li class="breadcrumb-item active">${cat.cat_name}</li>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
		
		    <!-- Main content -->
		<div class="content">
			<div class="container">
			
				<!-- Default box -->
				<div class="row">
					<div class="col-12 col-sm-6">
						<h3 class="d-inline-block d-sm-none">${vo.pro_nm }</h3>
						<!-- 상품 메인 이미지 -->
						<div class="col-12">
							<img src="/product/displayFile?fileName=${vo.pro_main_img}" class="product-image" alt="Product Image">
						</div>
						<!-- 상품 메인 이미지
						<div class="col-12 product-image-thumbs">
							<div class="product-image-thumb active"><img src="../../dist/img/prod-1.jpg" alt="Product Image"></div>
							<div class="product-image-thumb" ><img src="../../dist/img/prod-2.jpg" alt="Product Image"></div>
							<div class="product-image-thumb" ><img src="../../dist/img/prod-3.jpg" alt="Product Image"></div>
							<div class="product-image-thumb" ><img src="../../dist/img/prod-4.jpg" alt="Product Image"></div>
							<div class="product-image-thumb" ><img src="../../dist/img/prod-5.jpg" alt="Product Image"></div>
						</div>
						-->
					</div>
					<div class="col-12 col-sm-6">
						<h3 class="my-3">${vo.pro_nm }</h3>
						<!-- 상품 상세설명 -->
						<p></p>
						<hr>
						<!-- 
						<h4>Available Colors</h4>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-default text-center active">
								<input type="radio" name="color_option" id="color_option1" autocomplete="off" checked="">
								Green
								<br>
								<i class="fas fa-circle fa-2x text-green"></i>
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option2" autocomplete="off">
								Blue
								<br>
								<i class="fas fa-circle fa-2x text-blue"></i>
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option3" autocomplete="off">
								Purple
								<br>
								<i class="fas fa-circle fa-2x text-purple"></i>
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option4" autocomplete="off">
								Red
								<br>
								<i class="fas fa-circle fa-2x text-red"></i>
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option5" autocomplete="off">
								Orange
								<br>
								<i class="fas fa-circle fa-2x text-orange"></i>
							</label>
						</div>
						-->
						<!-- 
						<h4 class="mt-3">Size <small>Please select one</small></h4>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option1" autocomplete="off">
								<span class="text-xl">S</span>
								<br>
								Small
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option1" autocomplete="off">
								<span class="text-xl">M</span>
								<br>
								Medium
							</label>
							<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option1" autocomplete="off">
								<span class="text-xl">L</span>
								<br>
								Large
							</label>
								<label class="btn btn-default text-center">
								<input type="radio" name="color_option" id="color_option1" autocomplete="off">
								<span class="text-xl">XL</span>
								<br>
								Xtra-Large
							</label>
						</div>
						-->
						<table style="width: 100%;">
							<tr>
								<td>판매가</td>
								<td colspan="2"><span id="pro_price"><fmt:formatNumber value="${vo.discount_price }" /></span></td>
							</tr>
							<tr>
								<td>적립금</td>
								<td colspan="2"><fmt:parseNumber value="${vo.discount_price * 0.01}" integerOnly="true"/>원(${vo.pro_discount}%)</td>
							</tr>
							<tr>
								<td>수량</td>
								<td style="width: 100px;"><input id="count" type="number" class="form-control" value="1"></td>
								<td><span id="total_price"><fmt:formatNumber var="total_price" value="${vo.discount_price }" /></span></td>
							</tr>
						</table>
						
						<div class="mt-4">
							<div class="btn btn-secondary btn-lg btn-flat">
								BUY IT NOW
							</div>
							<div class="btn btn-outline-secondary btn-lg btn-flat">
								<i class="fas fa-cart-plus fa-lg mr-2"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="row mt-4">
					<nav class="w-100">
						<div class="nav nav-tabs" id="product-tab" role="tablist">
							<a class="nav-item nav-link active" id="product-info-tab" data-toggle="tab" href="#product-info" role="tab" aria-controls="product-info" aria-selected="true">
							상세정보</a>
							<a class="nav-item nav-link" id="product-review-tab" data-toggle="tab" href="#product-review" role="tab" aria-controls="product-review" aria-selected="false">
							 후기</a>
							<a class="nav-item nav-link" id="product-board-tab" data-toggle="tab" href="#product-board" role="tab" aria-controls="product-board" aria-selected="false">
							Q &amp; A </a>
						</div>
					</nav>
					<div class="w-100 tab-content p-3" id="nav-tabContent">
							<div class="tab-pane fade show active" id="product-info" role="tabpanel" aria-labelledby="product-info-tab" style="text-align: center;">
							${vo.pro_dtl_info }
							</div>
							<div class="tab-pane fade" id="product-review" role="tabpanel" aria-labelledby="product-review-tab"> 
								<div>
									<!-- 상품후기쓰기 부분 -->
									 <div>
										<label for="review">Review</label><br>
										<div class="rating">
											<p id="star_grade">
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
											</p>
										</div>
										<textarea id="reviewContent" rows="3" style="width:100%;"></textarea><br>
									
										<!-- 상품 후기 리스트 -->
									 	<ul class="timeline">
				 							 <!-- timeline time label -->
											<li class="time-label" id="repliesDiv">
												<span class="btn btn-default">
											    	상품후기 보기 <small id='replycntSmall'> [ ${totalReview} ] </small>
											    </span>
											    <button class="btn btn-primary" id="btn_write_review" type="button">상품후기쓰기</button>
											</li>
											<li class="noReview" style="display:none;">
												<i class="fa fa-comments bg-blue"></i>
												<div class="timeline-item" >
													 <h3 class="timeline-header">
														상품후기가 존재하지 않습니다.<br>
														상품후기를 입력해주세요.</h3>
												</div>
											</li>
											 
										</ul>
										<!-- 상품 후기 리스트 페이지부분 -->  
										<div class='text-center'>
											<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
									 	</div>
									 </div>
									 
									 
									 <%-- Modal : 상품후기 수정/삭제 팝업 --%>
									<div id="modifyModal" class="modal modal-primary fade" role="dialog">
									  <div class="modal-dialog">
									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header" >
									        <button type="button" class="close" data-dismiss="modal">&times;</button>
									        <div class="modal-title">
												<p id="star_grade_modal">
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
									        </div>
									      </div>
									      <div class="modal-body" data-rv_num>
									        <p><input type="text" id="replytext" class="form-control"></p>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-info" id="btn_modal_modify">MODIFY</button>
									        <button type="button" class="btn btn-default" data-dismiss="modal">CLOSE</button>
									      </div>
									    </div>
									  </div>
									</div>      
							</div>
							</div>
							<div class="tab-pane fade" id="product-board" role="tabpanel" aria-labelledby="product-board-tab"> </div>
						</div>
					</div>
			    </div>
			    <!-- /.card-body -->
			  </div>
			  <!-- /.card -->
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
	
	$("#count").on("change", function(){
		
		if($(this).val() < 1){
			alert("최소 주문수량은 1개 입니다.");
			$(this).val(1);
		}else{
			var total_price;
			total_price = $("#pro_price").text() * $(this).val();
			
			console.log($(this).val());
			$("#total_price").val(total_price);
		}
	});
});
</script>
</body>
</html>