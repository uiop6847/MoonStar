<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	.col-right	{
		text-align: right;
	}
	.col-left	{
		text-align: left;
	}
	
	input[readonly="readonly"]{
		background-color: #fff !important;
	}
</style>
<!-- 회원정보수정 유효성검사 자바스크립트(JQuery) -->
<script type="text/javascript" src="/js/member/modify.js"></script>
</head>
<body class="hold-transition layout-top-nav">
<div class="wrapper">

	<%@include file="/WEB-INF/views/include/main_header.jsp" %>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">PROFILE</h1>
					</div><!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="/">HOME</a></li>
							<li class="breadcrumb-item active">PROFILE</li>
						</ol>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->
	
		<!-- Main content -->
		<div class="content container">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<form role="form" action="/member/modifyOK" method="post">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6">
										<h5 class="card-title">기본정보</h5>
									</div>
									<div class="col-md-6 col-right">
										<small><span style="color: #FA8072">*</span>&nbsp;필수입력사항</small>
									</div>
								</div>
								<hr>
								
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="user_id" class="control-label">아이디</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<input type="text" class="form-control" id="user_id" name="user_id" value="${vo.user_id}" readonly="readonly">
									</div>
									<div class="col-md-7">
										<small>영문소문자/숫자, 4~16자</small>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="user_pw" class="control-label">비밀번호</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<input type="password" class="form-control" id="user_pw" name="user_pw">
									</div>
									<div class="col-md-7">
										<small>영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자</small>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="user_pw_confirm" class="control-label">비밀번호확인</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<input type="password" class="form-control" id="user_pw_confirm" name="user_pw_confirm">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="user_nm" class="control-label">이름</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<input type="text" class="form-control" id="user_nm" name="user_nm" value="${vo.user_nm}" readonly="readonly">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="sample2_postcode" class="control-label">주소</label>&nbsp;
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control" id="sample2_postcode" name="zip_num" value="${vo.zip_num}" readonly="readonly">
									</div>
									<div class="col-md-8">
										<button type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default">
										우편번호찾기&nbsp;<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="sample2_address" class="control-label">기본주소</label>&nbsp;
									</div>
									<div class="col-md-5">
										<input type="text" class="form-control" id="sample2_address" name="addr" value="${vo.addr}" readonly="readonly">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="sample2_detailAddress" class="control-label">나머지주소</label>&nbsp;
									</div>
									<div class="col-md-5">
										<input type="text" class="form-control" id="sample2_detailAddress" name="addr_dtl" value="${vo.addr_dtl}" placeholder="상세주소">
										<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="tel1" class="control-label">일반전화</label>&nbsp;
									</div>
									<div class="col-md-3">
										<div class="input-group">
						                	<input type="text" class="form-control" id="tel_phone" name="tel_phone" value="${vo.tel_phone }">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="cell1" class="control-label">휴대전화</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<input type="text" class="form-control" id="cell_phone" name="cell_phone" value="${vo.cell_phone }">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label for="user_email" class="control-label">이메일</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-3">
										<input type="email" class="form-control" id="user_email" name="user_email" value="${vo.user_email}">
										<input type="hidden" class="form-control" id="old_user_email" name="old_user_email" value="${vo.user_email}">
									</div>
									<div class="col-md-1.5">
										<button id="btn_check_email" class="btn btn-default" type="button">
										중복 확인</button>
									</div>
									<div class="col-md-4.5">
										<p id="email_availability"></p>
									</div>
								</div>
								<div class="row form-group" id="form_email_authCode" style ="display: none;">
									<div class="col-md-2"></div>
									<div class="col-md-2">
										<input type="text" class="form-control" id="email_authCode" name="email_authCode">
									</div>
									<div class="col-md-2.5" id="form_btn_authCode">
										<button id="btn_send_authCode" class="btn btn-default" type="button">
										인증번호발송</button>
									</div>
									<div class="col-md-1" id="form_btn_check_authCode" style ="display: none;">
										<button id="btn_check_authCode" class="btn btn-default" type="button">
										확인</button>
									</div>
									<div class="col-md-5.5">
										<p id="e_authCode_status"></p>
									</div>
								</div>
								
								<div class="row form-group">
									<div class="col-md-2 col-right">
										<label>수신 동의</label>&nbsp;<span style="color: #FA8072">*</span>
									</div>
									<div class="col-md-10">
										이벤트 등 프로모션 메일 알림 수신에 동의합니다.
										<label><input type="radio" name="email_rev_yn" value="Y" style="margin-left: 20px;" <c:out value="${vo.email_rev_yn == 'Y'?'checked':''}"/>> 예</label>
			      						<label><input type="radio" name="email_rev_yn" value="N" style="margin-left: 20px;" <c:out value="${vo.email_rev_yn == 'N'?'checked':''}"/>> 아니오</label>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-md-6 col-right">
										<button type="button" id="btn_submit" class="btn btn-secondary">
										회원정보수정</button>
									</div>
									<div class="col-md-3 col-left">
										<button type="button" id="btn_cancle" class="btn btn-outline-secondary">
										취소</button>
									</div>
									<div class="col-md-3 col-right">
										<button type="button" id="btn_delete" class="btn btn-outline-secondary">
										회원탈퇴</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div><!-- /.row -->
			
			<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
			<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			
			<%-- 우편번호API 동작코드 --%>
			<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script type="text/javascript" src="/js/member/postCode.js"></script>
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
</body>
</html>