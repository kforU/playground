<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
  
  <jsp:include page="include/cssimport.jsp" />

</head>

<body class="body-wrapper">

<jsp:include page="include/header.jsp" />
<jsp:include page="include/side.jsp" />

<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
			
			<!-- 여기에 내용을 입력 -->
			
			</div>
		</div>
	</div>
</section>

<!-- Footer Bottom -->
<jsp:include page="include/footer.jsp" />
<jsp:include page="include/jsimport.jsp" />

</body>

</html>