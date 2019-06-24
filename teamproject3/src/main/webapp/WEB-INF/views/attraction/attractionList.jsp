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
			
			
  <!-- content-->  
  <article>
    <!-- Search Widget
    <div class="container">
      <div class="container3">
      <div class="widget search p-0">
          <div class="input-group">		
              <input type="text" class="form-control" id="expire" placeholder="Search...">
              <span class="input-group-addon"><i class="fa fa-search"></i></span>
          </div>
      </div>
      </div>
    </div>
 -->

      <div class="container">
        <header class="section background-dark">
          <div class="line">        
            <h1 class="Detail Page Title" style="font-size: 45px;">어트랙션 안내</h1>
            <p class="margin-bottom-0 text-size-16">Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.<br>
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod.</p>
          </div>  
        </header>
      </div>


<!--Attraction List -->
<section>
 <div class="container ">

<div id="attraction image container">
  <div class="line">
        <div class="tab-content">
          <div class="margin">
            
            <c:forEach var="attraction" items="${ attractions }">
            	
            	<div class="s-12 m-6 l-3">
            		<a class="our-work-container lightbox margin-bottom"  href="attractionDetail/${ attraction.attractionNo}" >
              			<div class="our-work-text">
              				<h4>${ attraction.attractionName }</h4>
              				
              			</div>
              		<div class="imageContainer">
            		<img class="card-img-top img-fluid" src="${path}/resources/images/uploadFile/${ attraction.attractionImage }">
             		</div>
            		</a>
            	</div>
           	</c:forEach>
            
            </div>
            
          </div>
        </div>  
      
    </div>
  </div>
</div> 

 <div style="float: right;">	
 <sec:authorize access="hasRole('ADMIN')">	
 <div id="buttons">
 	<a class="btn btn-transparent" href="attractionWrite" style="float:right;">새글 등록</a>
</div>
</sec:authorize>

</div>


</section>
</article>
			
			
			
			</div>
		</div>
	</div>
</section>

<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />


</body>

</html>