<%@page import="org.springframework.web.bind.annotation.ModelAttribute"%>
<%@page import="javax.print.attribute.AttributeSet"%>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/product/detail.js"></script>
<%-- 상품 후기 템플릿 --%>
<script id="reviewTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<div class="replyLi" data-rew_num={{rew_num}}>
			<span class="fas bg-maroon" style="border-radius: 15px; min-width: 30px; font-size: 12px;">{{no}}</span>
			<!-- Default box -->
			<div class="timeline-item card">
				<div class="card-header">
					<h4 class="card-title">{{checkRating rew_score}} (<span class="control-label rew_score">{{rew_score}}</span>)</h4>
					<div class="card-tools">
						<span style="color: #999; font-size: 12px; padding: 10px;"><i class="fas fa-user"></i>
							{{user_id}}
						</span>
						<span style="color: #999; font-size: 12px; padding: 10px;"><i class="fas fa-clock"></i>
							{{prettifyDate sta_date}}
						</span>
						<button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
			      		</button>
					</div>
				</div>
				<div class="card-body">
					<p class="rew_content">{{rew_content}}</p>
				</div>
				<!-- /.card-body -->
				<div class="card-footer" style="color: white;">
					{{eqReplyer user_id rew_num}}
				</div>
				<!-- /.card-footer-->
			</div>
			<!-- /.card -->
		</div>
	{{/each}}
</script>
<%-- handlebar 사용자정의 헬퍼 --%>
<script>
$(function(){
	
	/* 
	 * 사용자 정의 헬퍼(prettifyDate)
	 * : 매개변수로 받은 timeValue를 원하는 날짜 형태로 바꿔준다.
	 */
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	 
	/* 
	 * 사용자 정의 헬퍼(checkRating)
	 * : 매개변수로 받은 후기 평점을 별표로 출력
	 */ 
	Handlebars.registerHelper("checkRating", function(rating) {
		var stars = "";
		switch(rating){
			case 1:
				 stars="★☆☆☆☆";
				 break;
			case 2:
				 stars="★★☆☆☆";
				 break;
			case 3:
				 stars="★★★☆☆";
				 break;
			case 4:
				 stars="★★★★☆";
				 break;
			case 5:
				 stars="★★★★★";
				 break;
			default:
				stars="☆☆☆☆☆";
		}
		return stars;
	});
	
	/* 
	 * 사용자 정의 헬퍼(eqReplyer)
	 * : 로그인 한 아이디와 리뷰의 아이디 확인 후, 수정/삭제 버튼 활성화 
	 */ 
	Handlebars.registerHelper("eqReplyer", function(replyer, rew_num) {
		var btnHtml = '';
		var user_id = "${sessionScope.user.user_id}";
		
		if (replyer == user_id) {
			
			btnHtml = '<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modifyModal">수정</button>'
				  + '<button class="btn btn-danger btn-sm" onclick="deleteReview('+rew_num+');">삭제</button>';
		}
		
		return new Handlebars.SafeString(btnHtml);
		
	});
	
});
</script>
<style>
	td {
		 padding: 8px 16px;
	}
	td:last-child {
		text-align: right;
	}
	/* 후기 별점선택 스타일 START */
	#star_grade a {
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on {
        color: black;
    }
    #star_grade_modal a {
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on {
        color: black;
    }
    /* 후기 별점선택 스타일 END */
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
						<input type="hidden" id="pro_num" name="pro_num" value="${vo.pro_num}" />
						<h3 class="d-inline-block d-sm-none">${vo.pro_nm }</h3>
						<!-- 상품 메인 이미지 -->
						<div class="col-12">
							<img src="/product/displayFile?fileName=${vo.pro_main_img}"
								class="product-image" alt="Product Image">
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
								<c:set var="point" value="1"></c:set>
								<td colspan="2"><fmt:parseNumber value="${vo.discount_price * (point/100)}" integerOnly="true"/>원(${point}%)</td>
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
							 후기<small id='replycntSmall'>[${totalReview}]</small></a>
							<a class="nav-item nav-link" id="product-board-tab" data-toggle="tab" href="#product-board" role="tab" aria-controls="product-board" aria-selected="false">
							Q &amp; A </a>
						</div>
					</nav>
					<div class="w-100 tab-content p-3" id="nav-tabContent">
						<%-- 상세정보 --%>
						<div class="tab-pane fade show active" id="product-info" role="tabpanel" aria-labelledby="product-info-tab" style="text-align: center;">
							${vo.pro_dtl_info }
						</div>
						<%-- 후기 --%>
						<div class="tab-pane fade" id="product-review" role="tabpanel" aria-labelledby="product-review-tab">
							<!-- 상품후기쓰기 시작 -->
							<div>
								<!-- 별점선택 -->
								<label for="review">Review</label><br>
								<div class="rating">
									<p id="star_grade">
								        <a href="#"><ion-icon src="/ionicons/star.svg"></ion-icon></a>
								        <a href="#"><ion-icon src="/ionicons/star.svg"></ion-icon></a>
								        <a href="#"><ion-icon src="/ionicons/star.svg"></ion-icon></a>
								        <a href="#"><ion-icon src="/ionicons/star.svg"></ion-icon></a>
								        <a href="#"><ion-icon src="/ionicons/star.svg"></ion-icon></a>
									</p>
								</div>
								<textarea id="reviewContent" rows="3" class="form-control"></textarea><br>
								<!-- 상품후기 리스트 시작  -->
						        <div class="row">
									<div class="col-md-12">
										<!-- timeline start -->
										<div class="timeline">
											<div class="time-label" id="repliesDiv">
												<button class="btn bg-red" id="btn_write_review" type="button">상품후기쓰기</button>
											</div>
											<!-- timeline item -->
											<div class="noReview" style="display: none;">
												<!-- Default box -->
									            <div class="timeline-item card">
													<div class="card-body">
														상품후기가 존재하지 않습니다.
													</div>
													<!-- /.card-body -->
									            </div>
									            <!-- /.card -->
											</div>
											<!-- END timeline item -->
										</div>
										<!-- END timeline -->
									</div>
									<!-- /.col -->
						        </div><!-- 상품후기 리스트 끝  -->
						        
								<!-- 상품 후기 리스트 페이지부분 -->
								<div class="card-footer">
									<nav aria-label="Contacts Page Navigation">
										<ul class="pagination justify-content-center m-0">
											<!-- 이전표시 여부  [이전] -->
											<c:if test="${pm.prev}">
												<li class="page-item"><a class="page-link" href="category${pm.makeSort(pm.startPage-1)}&cat_code=${cat_code}">&laquo;</a></li>
											</c:if>
											<!-- 페이지목록번호 :  1  2  3  4  5  -->
											<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
												<li class="page-item <c:out value="${pm.cri.page == idx?'active':''}"/>">
													<a class="page-link" href="category${pm.makeSort(idx)}&cat_code=${cat_code}">${idx}</a>
												</li>
											</c:forEach>
											<!-- 다음표시 여부  [다음]-->
											<c:if test="${pm.next && pm.endPage > 0}">
												<li class="page-item"><a class="page-link" href="category${pm.makeSort(pm.endPage +1)}&cat_code=${cat_code}">&raquo;</a></li>
											</c:if>
										</ul>
									</nav>
								</div>
								<%-- Modal : 상품후기 수정 --%>
								<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<div class="modal-title" id="modifyModalLabel">
													<p id="star_grade_modal">
														<a href="#">★</a>
														<a href="#">★</a>
														<a href="#">★</a>
														<a href="#">★</a>
														<a href="#">★</a>
													</p>
												</div>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											</div>
											<div class="modal-body">
												<textarea class="form-control" id="replytext" data-rv_num></textarea>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-primary" id="btn_modal_modify">수정</button>
												<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								
							</div><!-- 상품후기쓰기 끝 -->
						
						</div>
						
						<%-- Q & A --%>
						<div class="tab-pane fade" id="product-board" role="tabpanel" aria-labelledby="product-board-tab"> </div>
					</div>
				</div>
	    	</div>
		    <!-- /.container -->
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