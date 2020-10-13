$(function(){

    var form = $("form[role='form']");
	var isCheckEmail = "false";
	var isCheckEmailCd = "false";

    /* 이메일 중복체크 */
	$("#btn_check_email").on("click", function(){
	
		var user_email = $("#user_email");
		var emailMsg = $("#email_availability");
		if(user_email.val() == "" || user_email.val() == null) {

			idMsgTag(user_email, emailMsg, "ERROR");

			emailMsg.html("이메일을 입력해주세요.");
			
			return;
		}

		// 이메일 정규식 체크
		var emailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
        if(!emailCheck.test(user_email.val())){

			idMsgTag(user_email, emailMsg, "ERROR");
			emailMsg.html("이메일 형식에 맞게 입력해주세요. ex)sample01@example.com");

			return;
        }
		
		$.ajax({
			url: '/member/userEmailCheck',
			type: 'post',
			dataType: 'text',
			data: {user_email : user_email.val()},
			success: function(data){
				if(data == 'SUCCESS'){
					// 사용 가능한 이메일
					idMsgTag(user_email, emailMsg, "SUCCESS");
					emailMsg.html("사용가능한 이메일 입니다.");

					isCheckEmail = "true";
					
					user_email.attr("readonly",true); // 이메일 input box
					$("#form_email_authCode").css("display", ""); // 이메일 인증번호

				} else{
					// 이미 존재하는 이메일
					idMsgTag(user_email, emailMsg, "ERROR");
					emailMsg.html("이미 존재하는 이메일입니다. \n다시 시도해주세요.");
				}
			}
		});
		
	});

	/* 이메일 인증 클릭 시 */
	$("#btn_send_authCode").on("click", function(){

		var receiveMail = $("#user_email").val();
		var email_authCode = $("#email_authCode");
		var email_auth_status = $("#e_authCode_status");
		
		idMsgTag(email_authCode, email_auth_status, "WARNING");
		email_auth_status.html('인증코드 메일을 전송중입니다.  잠시만 기다려주세요...');
		
		$.ajax({
			url: '/email/send',    // EmailController.java
			type: 'post',
			dataType: 'text',
			data: {receiveMail : receiveMail},
			success: function(data){
				idMsgTag(email_authCode, email_auth_status, "SUCCESS");
				email_auth_status.html('메일이 전송되었습니다. 인증코드 확인 후 입력해주세요.');
				
				email_authCode.removeClass("is-valid"); // 인증코드 input box를 default상태로 바꾸기
				$("#form_btn_authCode").css("display", "none"); // 인증번호발송 버튼 숨기기
				$("#form_btn_check_authCode").css("display", ""); // 인증코드 확인 버튼 보이기
			}
		});
	});
	
	/* 인증코드 입력 후 확인 클릭 시 */
	$("#btn_check_authCode").on("click", function(){
		var code = $("#email_authCode").val(); // 메일을 통하여 받았던 인증코드를 보고 입력하면 인증코드를참조 
		
		$.ajax({
			url: '/member/checkAuthcode',
			type: 'post',
			dataType: 'text',
			data: {code : code},
			success: function(data){
				if(data == 'SUCCESS'){
					idMsgTag($("#email_authCode"), $("#e_authCode_status"), "SUCCESS");
					$("#e_authCode_status").html('인증 성공');

					$("#email_authCode").attr("readonly",true);
					$("#btn_send_authCode").attr("disabled", true);
					//$("#btn_check_authCode").attr("disabled", true);
					
					isCheckEmailCd = "true";
					
					return;
					
				} else {
					idMsgTag($("#email_authCode"), $("#e_authCode_status"), "ERROR");
					$("#e_authCode_status").html('인증 실패. 다시 시도해주세요.');

					$("#form_btn_authCode").css("display", ""); // 인증번호발송 버튼 보이기
					$("#form_btn_check_authCode").css("display", "none"); // 인증코드 확인 버튼 숨기기
					
					return;
				}
			}
		});
	});

	// idMsgTag(input태그 ID, msg태그 ID, 상태)
	function idMsgTag(id, msgId, status){

		if(status == "SUCCESS"){

			id.removeClass("is-invalid");
			id.removeClass("is-warning");

			msgId.css("color", "#228B22");
			id.addClass("is-valid");

		} else if(status == "ERROR"){

			id.removeClass("is-valid");
			id.removeClass("is-warning");
			
			msgId.css("color", "#CC0000");
			id.addClass("is-invalid");
			id.focus();

		} else if(status == "WARNING"){

			id.removeClass("is-valid");
			id.removeClass("is-invalid");
			
			msgId.css("color", "#FFD700");
			id.addClass("is-warning");
			
		}
	}


    /* 회원정보수정 버튼 클릭 시 */ 
	$("#btn_submit").on("click", function(){

		var user_pw = $("#user_pw");
		var user_pw_confirm = $("#user_pw_confirm");
		var user_email = $("#user_email");
		var tel_phone = $("#tel_phone");
        var cell_phone = $("#cell_phone");
        
        /**
		 * passwdCheck : 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자
		 * nameCheck : 2~6글자의 한글만 입력
		 * telPhoneCheck : 숫자로된 2~3자리-3~4자리-4자리
		 * cellPhoneCheck : 01로 시작하여 그 다음은 0,1,7,9 중 하나와 매칭되는지 체크한뒤 7~8자리인지 검사
		 */
		var userPwCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{10,16}$/);
		var telPhoneCheck = RegExp(/^\d{2,3}-\d{3,4}-\d{4}$/);
		var cellPhoneCheck = RegExp(/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/);

		/* 유효성 검사 */
		if(user_pw.val() == null || user_pw.val() == ""){
			alert("비밀번호를 입력해주세요.");
			user_pw.focus();
			
		} else if(user_pw_confirm.val() == null || user_pw_confirm.val() == ""){
			alert("비밀번호 확인 란을 입력해주세요.");
			user_pw_confirm.focus();
			
		} else if(user_pw.val() != user_pw_confirm.val()){
			alert("입력하신 비밀번호가 다릅니다.\n비밀번호를 다시 확인해주세요.");
			user_pw_confirm.focus();

		} else if(user_email.val() == null || user_email.val() == ""){
			alert("이메일을 입력해주세요.");
			user_email.focus();

        } else if(user_email.val() != $("#old_user_email").val()){
            if(isCheckEmail == "false"){
                alert("이메일 중복 체크를 해주세요.");
                user_email.focus();
                
            } else if(isCheckEmailCd == "false"){
                alert("이메일 인증을 해주세요.");
                cell_phone.focus();
    
            } 

		} else if(cell_phone.val() == null || cell_phone.val() == ""){
			alert("휴대전화를 입력해주세요.");
			cell_phone.focus();

		} else if(!userPwCheck.test(user_pw.val())){
            alert("비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합하여 10자~16자로 입력해주세요. ");
            user_pw.focus();

        }else if(tel_phone.val()){
			if(!telPhoneCheck.test(tel_phone.val())){
				alert("일반전화를 올바르게 입력했는지 확인해주세요. ex) 02-0000-0000");
				tel_phone.focus();
			}
			
		} else if(!cellPhoneCheck.test(cell_phone.val())){
			alert("휴대전화를 올바르게 입력했는지 확인해주세요. ex) 010-0000-0000");
			cell_phone.focus();

		} else {
            form.attr("action", "/member/modifyOK");
			form.submit();
		}
    });
    
    /* 회원탈퇴 */
   $("#btn_delete").on("click", function(){
        form.attr("action", "/member/deleteUser");
        form.submit();

    });
	
	$("#btn_cancle").on("click", function(){
		
		var result = confirm("수정을 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else {}
    });
    
});