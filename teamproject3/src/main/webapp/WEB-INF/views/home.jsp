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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" />
	
</head>

<body class="body-wrapper">

<jsp:include page="include/header.jsp" />

<jsp:include page="include/side.jsp" />

<!--===============================
=            Hero Area            =
================================-->


	<!-- Container Start -->
	<section class="section">
		<div class="fotorama" data-autoplay="true" style=" max-width: 100%; height: auto;">
			<img src="${path}/resources/images/home/hero01.jpg">
		  	<img src="${path}/resources/images/home/hero02.jpg">
		  	<img src="${path}/resources/images/home/hero03.jpg">
		</div>
	</section>
	<!-- Container End -->

<!--===========================================
=            Popular deals section            =
============================================-->

<section class="popular-deals section bg-gray">
	<div class="container">
	
	
		<div class="row">
			<div class="col-md-12">
				<div class="section-title">
					<h2>이벤트</h2>
					<p>오늘의 이벤트를 확인하세요.</p>
				</div>
			</div>
		</div>
		
		<ul class="bx">
<c:forEach var="announcement" items="${ announcements }">
	<li class="listyle">
					<!-- product card -->
	<div class="product-item bg-light">
		<div class="card">
		<a href="announcement/eventDetail/${ announcement.announcementNo }">
			<div class="thumb-content">
				<!-- <div class="price">$200</div> -->
				<img class="card-img-top img-fluid" src="${ path }/resources/annNavereditor/annUpload/${ announcement.announceImage }" alt="Card image cap">
			</div>
			<div class="card-body">
			    <h4 class="card-title">${ announcement.announceTitle }</h4>
			    <ul class="list-inline product-meta">
			    	<li class="list-inline-item">
			    		<i class="fa fa-calendar"></i>26th December
			    	</li>
			    </ul>
			   
			</div>
		</a>
		</div>
	</div>

	</li>
</c:forEach>	
</ul>
		
		
		
	</div>
</section>

<section id="" class="main TicketLink">
	<div class="">
		<header class="align-center">
			<p>할인 어쩌구 꾸밈텍스트 예매하러 바로 가기</p>
			<h2><a class="ticket-button" style="color: #dedede;" href="${ path }/ticket/reservation">
					지금 티켓 구매
			</a></h2>
		</header>
	</div>
</section>



<!--==========================================
=            All Category Section            =
===========================================-->

<section class=" section">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Section title -->
				<div class="section-title">
					<h2>어트랙션 바로가기</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perferendis, provident!</p>
				</div>
				
				<div class="row">
				
				
					<!-- Category list -->
					
					<c:forEach var="attraction" items="${ attractions }">
					
					<div class="col-lg-3 offset-lg-0 col-md-5 offset-md-1 col-sm-6 col-6">
					<a href="attractionDetail/${ attraction.attractionNo}">
						<div class="category-block">
							<div class="header">
								<h4>${ attraction.attractionName }</h4>
							</div>
								<img src="${path}/resources/images/uploadFile/${ attraction.attractionImage }" >
							<ul class="category-list" >
								<div class="">보러가기</div>
							</ul>
						</div>
					</a>
					</div> <!-- /Category List -->
					
					</c:forEach>
					
					
					
				</div>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>




<!--============================
=            Footer            =
=============================-->


<!-- Footer Bottom -->
<jsp:include page="include/footer.jsp" />

<jsp:include page="include/jsimport.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<script>
  var bx = $(".bx").bxSlider({
    minSlides: 1, //Value should match moveSlides value
    moveSlides: 1, //Value should match minSlides value
    maxSlides: 4, //Make total slides a numerator of this number
    slideWidth: 320, //Required for horizontal carousel
    slideMargin: 5,
    shrinkItems: true // Recalculates and adjusts when resized
  });
  </script>

</body>

</html>