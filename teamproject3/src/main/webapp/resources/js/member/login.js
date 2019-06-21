$(document).ready(function(e){
	invalidateSession();
});

/* ========================================= 로그인 =============================================== */

$("#loginButton").on("click", function(e){
	e.preventDefault();
	doLogin();
});

function doLogin() {
	
	var contentPath = $("#contextPath").val();
	
	var email = $("#email").val();
	var passwd = $("#passwd").val();
	
	if (email.length === 0){
		alert("이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}
	
	if (passwd.length === 0){
		alert("비밀번호를 입력해 주세요");
		$("#passwd").focus();
		return;
	}
	
	$.ajax({
		method: "post",
		url: contentPath + "/member/doLogin",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		dataType: "text",
		data: $("#loginForm").serialize(),
		success: function(resp) {
			if (resp === 'success'){
				alert("로그인되었습니다.");
				location.href = "${path}/";
				return;
			} else {
				alert("아이디가 존재하지 않거나, 비밀번호가 일치하지 않습니다.");
				return;
			}
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

/* ========================================= 세션 무효화 =============================================== */

function invalidateSession() {
	console.log("세션 종료");
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/invalidateSession",
		success: function(resp) {
			// do nothing...
			console.log(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
}