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
            <h1 class="Detail Page Title">자주찾는 질문</h1>
            <p class="margin-bottom-0 text-size-16">관련질문을 찾고 확인하세요.</p>
          </div>  
        </header>
     <div>
		<div id="Q1">
			<h3>티켓 예약은 어떻게 하나요?</h3>	
		</div>
		<div id="A1">
			<h4>티켓은 상품페이지에 티켓예약에서 확인하실 수 있습니다.</h4>
		</div>
		<hr>
		<div id="Q2">
			<h3>회원가입은 어떻게 하나요?</h3>	
		</div>
		<div id="A2">
			<h4>회원가입페이지에 이메일,이름,비밀번호를 입력하시고 회원가입하시면 됩니다.</h4>
		</div>
		<hr>
		<div id="Q3">
			<h3>비밀번호를 변경하고 싶은데요.</h3>	
		</div>
		<div id="A3">
			<h4>화면 우측상단에 있는 사용자 페이지에서 비밀번호를 변경 하실 수 있습니다.</h4>
		</div>
     	<hr>
		<div id="Q4">
			<h3>상품배송은 얼마나 걸리나요?</h3>	
		</div>
		<div id="A4">
			<h4>상품은 택배회사의 운송시간에 따라 소요시간이 발생합니다.</h4>
		</div>
		<hr>
		<div id="Q5">
			<h3>운영시간이 어떻게 되나요?</h3>	
		</div>
		<div id="A5">
			<h4>어트렉션은 일~목은 오전 9시30분부터 22시까지며 금요일과 토요일은 9시30분부터 23시까지입니다.
			자세한 운영일정은 운휴기간페이지를 참고하세요.</h4>
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
    		$('#A1').hide();
    		jQuery('#Q1').click(function () {  
    		    if($("#A1").css("display") == "none"){   
    		        jQuery('#A1').show();  
    		    } else {  
    		        jQuery('#A1').hide();  
    		    }  
    		});
    		$('#A2').hide();
    		jQuery('#Q2').click(function () {  
    		    if($("#A2").css("display") == "none"){   
    		        jQuery('#A2').show();  
    		    } else {  
    		        jQuery('#A2').hide();  
    		    }  
    		});
    		$('#A3').hide();
    		jQuery('#Q3').click(function () {  
    		    if($("#A3").css("display") == "none"){   
    		        jQuery('#A3').show();  
    		    } else {  
    		        jQuery('#A3').hide();  
    		    }  
    		});
    		$('#A4').hide();
    		jQuery('#Q4').click(function () {  
    		    if($("#A4").css("display") == "none"){   
    		        jQuery('#A4').show();  
    		    } else {  
    		        jQuery('#A4').hide();  
    		    }  
    		});
    		$('#A5').hide();
    		jQuery('#Q5').click(function () {  
    		    if($("#A5").css("display") == "none"){   
    		        jQuery('#A5').show();  
    		    } else {  
    		        jQuery('#A5').hide();  
    		    }  
    		});

    	});
    
    </script>
  
  </body>
</html>