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
					<h1>404 Page Not Found.</h1>
					
					<hr>
						<span style="text-align: center">요청하신 페이지를 찾을 수 없습니다.</span>
						
					<div style="margin: 15px;" align="center">
						<a href="${path}/" class="btn btn-main">메인으로</a>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../include/footer.jsp" />

<jsp:include page="../include/jsimport.jsp" />

</body>

</html>