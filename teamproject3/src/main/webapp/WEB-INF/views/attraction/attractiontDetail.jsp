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
  
  <jsp:include page="/WEB-INF/views/include/cssimport.jsp" />

</head>

<body class="body-wrapper">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-md-12">

<article>
    <div class="container">
      <header class="section background-dark">
        <div class="line">        
          <h1 class="Detail Page Title" style="font-size: 45px;">AttractionName- 어트랙션 디테일 페이지</h1>
          <p class="margin-bottom-0 text-size-16">Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.<br>
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod.</p>
        </div>  
      </header>
    </div>
</article>

<div class="container">
    <div class="margin-bottom-15">

    </div>
        <img class="AttractionContentimg" src="images/pic01.jpg" />
      <div class="Detail contentArea">
        콘텐츠 작성할 부분
      </div>


</div>

			
	</div>
	</div>
</div>
</section>
  <div class="container-bottom"></div>  

<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />

</body>

</html>