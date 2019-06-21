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
	<style>
		th{ width:100px;
			text-align:center;
			}
	</style>
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
            <h1 class="Detail Page Title">상세 보기</h1>
          </div>  
        </header>
       <div>
         <div id="buttons" style='display:${ member.name eq "관리자" ? "block" : "none" }'>
     	<input class="btn" type="button" id="write" value="작성">
     	<input class="btn" type="button" id="edit" value="수정">
     	<input class="btn" type="button" id="deleted" value="삭제">
     	</div>
     	
       <table class="table" >
       <tr>
       <th>제목</th>
       <td>${ announcement.announceTitle }</td>
       </tr>
       <tr>
       <th>작성자</th>
       <td>
      	<h3>관리자</h3>
       </td>
       </tr>
       <tr>
       <th>분류</th>
       <td>${ announcement.category }</td>
       </tr>
       <tr>
       <th>내용</th>
       <td>${ announcement.announcementContent }</td>
       </tr>
       </table>
       </div>
       <input class="btn" type="button" id="return" value="목록">
     </article>





  
  <!-- Footer Bottom -->
 


<!--============================
=            Footer            =
=============================-->


<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$('#write').on('click', function(event){
    		location.href="${ path }/announcement/announceWrite";
    		});
    		
    		$('#edit').on('click', function(event){
    			location.href="${ path }/announcement/announceUpdate/${ announcement.announcementNo }";
    		});
    		
    		$('#deleted').on('click', function(event){
    			location.href="${ path }/announcement/announcedelete/${ announcement.announcementNo }"
    		});
    		$('#return').on('click', function(event){
    			location.href="${ path }/announcement/announce"
    		})

    	});
    </script>

  </body>
</html>