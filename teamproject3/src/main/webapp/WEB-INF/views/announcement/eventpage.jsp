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
            <h1 class="Detail Page Title">EVENT</h1>
            <p class="margin-bottom-0 text-size-16">새로운 이벤트를 확인하세요!</p>
          </div>  
        </header>
     <div>

         <div id="buttons"> 
		<c:if test="${ member.name eq '관리자' }">
     	<input class="btn" type="button" id="write" value="작성">
		</c:if>
     	</div>

     	<div class="event" style="width:1000px;">
     		<c:forEach var="announcement" items="${ announcements }">
     		<c:if test="${ announcement.category eq '이벤트' }">
			<a href="eventDetail/${ announcement.announcementNo }">
     		<span style="height:140px;"><img src="${ path }/resources/annNavereditor/annUpload/${ announcement.announceImage }">
     		</span>
     		<span style="width:300px;">${ announcement.announceTitle }</span>
     		
			</a>
     		</c:if>
     		</c:forEach>
     	</div>

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
    		location.href="${path}/announcement/eventWrite";
    		});
    	});
    
    </script>
  
  </body>
</html>