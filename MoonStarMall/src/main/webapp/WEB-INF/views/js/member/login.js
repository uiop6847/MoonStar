$(function(){

    var form = $("#loginForm");
	
	$("#btn_login").on("click", function(){ login(); });
	$("#user_pw").keyup(function(e){ if(e.keyCode == 13)  login(); });
	
   /* 로그인 기능 */
	function login(){

		var user_id = $("#user_id");
		var user_pw = $("#user_pw");

		if(user_id.val() == null || user_id.val() == ""){
			alert("로그인ID를 입력해주세요.");
            user_id.focus();

		} else if(user_pw.val() == null || user_pw.val() == ""){
			alert("비밀번호를 입력해주세요.");
            user_pw.focus();
        } else {
			form.submit();
		}
	}
    
    /* 회원가입 버튼 클릭 시 */
    $("#btn_join").on("click", function(){
		location.href="/member/join";
	});

});