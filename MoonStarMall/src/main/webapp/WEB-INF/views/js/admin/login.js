$(document).ready(function() {
	
	var form = $("#loginForm");
	
	// 로그인 버튼 클릭 시 
	$("#btn_login").on("click", function(){
		
		var admin_id = $("#admin_id");
		var admin_pw = $("#admin_pw");

		if(admin_id.val()==null || admin_id.val()==""){
			alert("아이디를 입력해주세요.");
			admin_id.focus();
			
		} else if(admin_pw.val()==null || admin_pw.val()==""){
			alert("비밀번호를 입력해주세요.");
			admin_pw.focus();

		} else {
			form.submit();
		}
	});
	
});

