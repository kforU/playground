<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
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
					<h3 class="widget-header user">로그인</h3>
					
					<c:if test="${param.logout ne null}">
						<div style="text-align: center">
							<span style="color: blue; font-size: 16px;">로그아웃되었습니다.</span>
						</div>
					</c:if>
					
					<c:if test="${param.expired ne null}">
						<div style="text-align: center">
							<span style="color: red; font-size: 16px;">세션이 만료되었습니다.</span>
						</div>
					</c:if>
					
					<form id="loginForm">
					
						<!-- 이메일 -->
						<div class="form-group">
							<label for="email">이메일</label>
							<input type="text" class="form-control" name="email" id="email">
						</div>
						
						<!-- 비밀번호 -->
						<div class="form-group">
							<label for="passwd">비밀번호</label>
							<input type="password" class="form-control" name="passwd" id="passwd">
						</div>
						
						<div class="form-group" style="float: left">
							<input type="checkbox" name="remember-me" id="remember-me" />
							<label for="remember-me">로그인 기억하기</label>
						</div>
						
						<div style="float: right">
							<a href="#">비밀번호를 잊으셨나요?</a>
						</div>
						
						<div style="clear: both">
							<button id="loginButton" class="btn btn-transparent">로그인</button>
							
							<a href="${ path }/member/register" class="btn btn-transparent">회원가입</a>
							
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../include/footer.jsp" />

<jsp:include page="../include/jsimport.jsp" />

<script type="text/javascript">

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

</script>

</body>

</html>