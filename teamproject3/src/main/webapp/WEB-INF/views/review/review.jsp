<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>
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

<!--===============================
=            Hero Area            =
================================-->

<section class="hero-area bg-1 text-center overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					
					
				</div>
				
				
			</div>
		</div> 
	</div>
	<!-- Container End -->
</section>
  <!-- content-->

  <article>
        <header class="section background-dark">
          <div class="line">        
            <h1 class="Detail Page Title">REVIEW</h1>
            <p class="margin-bottom-0 text-size-16">자유로운 감상평을 남기세요!</p>
          </div>  
        </header>
     <div>

         <div id="buttons"> 
     	<input class="btn" type="button" id="write" value="작성">
     	</div>

     	<table class="table"style="width:850px; text-align:center">
     		<tr>
     		<td style="width:100px">번호</td>
     		<td>제목</td>
     		<td>조회수</td>
     		<td style="width:300px">날짜</td>
     		</tr>
     		<c:forEach var="review" items="${ reviews }">
     		<tr>
     		<td>${ review.reviewNo }</td>
     		<td><a href="reviewDetail/${ review.reviewNo }">
     		${ review.reviewTitle }</a></td>
     		<td>${ review.reviewHit }</td>
     		<td>${ review.regDate }</td>
     		</tr>
     		</c:forEach>
     	</table>
     	
     </div>
</article>




  
  <!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />
  
    <!-- JAVASCRIPTS -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$('#write').on('click', function(event){
    		location.href="${path}/review/reviewWrite";
    		});
    	});
    
    </script>
  
  </body>
</html>