<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">
<head>

	<!-- SITE TITTLE -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Calssimax</title>
  
	<jsp:include page="../include/cssimport.jsp" />
  
</head>

<body class="body-wrapper">

<jsp:include page="../include/header.jsp" />

<section class="popular-deals section bg-gray" style="min-height: 800px">
	<div class="container">
		<div class="row">
			<div class="col col-md-12">
				<!-- 로그인 -->
				<div class="widget personal-info">
					<h3 class="widget-header user">회원 가입</h3>
					<form id="registerForm" action="#">
					
						<!-- 이메일 -->
						<div class="form-group">
							<label for="email">이메일</label>
							<input type="email" class="form-control" name="email" id="email">
						</div>
						
						<!-- 비밀번호 -->
						<div class="form-group">
							<label for="passwd">비밀번호</label>
							<input type="password" class="form-control" name="passwd" id="passwd">
						</div>
						
						<!-- 비밀번호 확인 -->
						<div class="form-group">
							<label for="confirm-passwd">비밀번호 확인</label>
							<input type="password" class="form-control" name="confirmPasswd" id="confirm-passwd">
						</div>
						
						<!-- 이름 -->
						<div class="form-group">
							<label for="name">이름</label>
							<input type="text" class="form-control" name="name" id="name">
						</div>
						
						<button id="registerButton" class="btn btn-transparent">회원 가입</button>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../include/footer.jsp" />

<jsp:include page="../include/jsimport.jsp" />
  
<script type="text/javascript">

$("#registerButton").on("click", function(e){
	e.preventDefault();
	doRegister();
});

function doRegister() {
	
	if (!confirm("회원가입을 진행하시겠습니까?")){
		return;
	}
	
	var contextPath = $("#contextPath").val();
	
	var email = $("#email").val();
	var passwd = $("#passwd").val();
	var confirmPasswd = $("#confirm-passwd").val();
	var name = $("#name").val();
	
	if (email.length === 0) {
		alert("이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}
	
	if (passwd.length === 0) {
		alert("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return;
	}
	
	if (passwd !== confirmPasswd) {
		alert("비밀번호가 일치하지 않습니다.");
		$("#confirm-passwd").val('');
		$("#confirm-passwd").focus();
		return;
	}
	
	if (name.length === 0) {
		alert("이름을 입력해 주세요.");
		$("#name").focus();
		return;
	}
	
	$.ajax({
		type: "post",
		url: contextPath + "/member/register",
		dataType: "text",
		data: $("#registerForm").serialize(),
		success: function(resp) {
			if (resp === 'success') {
				alert("회원가입이 정상적으로 처리되었습니다.");
				location.href = contextPath + "/member/login";
			} else if (resp === 'wrong_email'){
				alert("이미 존재하는 이메일이거나 사용이 불가한 이메일입니다.");
				return;
			} else if (resp === 'wrong_passwd') {
				alert("사용 불가능한 비밀번호이거나, 비밀번호가 일치하지 않습니다.");
				return;
			} else if (resp === 'wrong_name') {
				alert("이름을 다시 한번 확인 바랍니다.");
				return;
			}
		},
		error: function(err) {
			// do nothing...
		}
	});
	
}

</script>

</body>

</html>