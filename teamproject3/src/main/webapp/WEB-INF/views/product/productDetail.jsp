<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

			
<!--===================================
=            Store Section            =
====================================-->
<section class="page-search">
	<div class="container" >
		<div class="row">
			<div class="col-md-12">
				<!-- Advance Search -->
				<div class="advance-search">
					<form>
						<div class="form-row">
							<div style="margin-left: 15px; margin-right: 15px;">
								<input type="text" class="form-control" id="inputtext4" placeholder="검색어를 입력해주세요" style="width: 500px;">
							</div>
							<div class="form-group col-md-2"
								style="margin-left: 15px; margin-right: 15px;">
								<button type="submit" class="btn btn-primary">검색</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="section bg-gray">
	
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<!-- Left sidebar -->
			<div class="col-md-8">
				<div class="product-details">
					<h1 class="product-title">${ product.productName }</h1>
					<div class="product-meta">
						<ul class="list-inline">
							<li class="list-inline-item"><i class="fa fa-user-o"></i> By 판매자</li>
							<li class="list-inline-item"><i class="fa fa-folder-open-o"></i> Category ${ product.productCategory }</li>
						</ul>
					</div>
					<div id="carouselExampleIndicators" class="product-slider carousel slide" data-ride="carousel">
						
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img style="height: 500px;" class="d-block w-100" src="${ path }/resources/images/tmp/${ product.productImage }" alt="First slide">
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
					<div class="content">
						<ul class="nav nav-pills  justify-content-center" id="pills-tab" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">상품 상세</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">상품 정보</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">구매 후기</a>
							</li>
						</ul>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
								<h3 class="tab-title">상품 설명</h3>
<c:set var="enter" value="
" />
								<p>${ fn:replace(product.productContent, enter, "<br>") }</p>
							</div>
							<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
								<h3 class="tab-title">상품 상세</h3>
								<table class="table table-bordered product-table">
								  <tbody>
								    <tr>
								      <td>제품명</td>
								      <td>${ product.productName }</td>
								    </tr>
								    <tr>
								      <td>판매가</td>
								      <td>${ product.productPrice }원</td>
								    </tr>
								    <tr>
								      <td>상품 등록일</td>
								      <td>${ product.regDate }</td>
								    </tr>
								    <tr>
								      <td>재고 수량</td>
								      <td>${ product.productCount }개</td>
								    </tr>
								  </tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
								<h3 class="tab-title">Product Review</h3>
								<div class="product-review">
							  		<div class="media">
							  			<!-- Avater -->
							  			<img src="images/user/user-thumb.jpg" alt="avater">
							  			<div class="media-body">
							  				<!-- Ratings -->
							  				<div class="ratings">
							  					<ul class="list-inline">
							  						<li class="list-inline-item">
							  							<i class="fa fa-star"></i>
							  						</li>
							  						<li class="list-inline-item">
							  							<i class="fa fa-star"></i>
							  						</li>
							  						<li class="list-inline-item">
							  							<i class="fa fa-star"></i>
							  						</li>
							  						<li class="list-inline-item">
							  							<i class="fa fa-star"></i>
							  						</li>
							  						<li class="list-inline-item">
							  							<i class="fa fa-star"></i>
							  						</li>
							  					</ul>
							  				</div>
							  				<div class="name">
							  					<h5>Jessica Brown</h5>
							  				</div>
							  				<div class="date">
							  					<p>Mar 20, 2018</p>
							  				</div>
							  				<div class="review-comment">
							  					<p>
							  						Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremqe laudant tota rem ape riamipsa eaque.
							  					</p>
							  				</div>
							  			</div>
							  		</div>
							  		<div class="review-submission">
							  			<h3 class="tab-title">Submit your review</h3>
						  				<!-- Rate -->
						  				<div class="rate">
						  					<div class="starrr"></div>
						  				</div>
						  				<div class="review-submit">
						  					<form action="#" class="row">
						  						<div class="col-lg-6">
						  							<input type="text" name="name" id="name" class="form-control" placeholder="Name">
						  						</div>
						  						<div class="col-lg-6">
						  							<input type="email" name="email" id="email" class="form-control" placeholder="Email">
						  						</div>
						  						<div class="col-12">
						  							<textarea name="review" id="review" rows="10" class="form-control" placeholder="Message"></textarea>
						  						</div>
						  						<div class="col-12">
						  							<button type="submit" class="btn btn-main">Sumbit</button>
						  						</div>
						  					</form>
						  				</div>
							  		</div>
							  	</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="sidebar" style="margin-top: 100px">
					<div class="widget price text-center" >
						<h4>가격</h4>
						<p>${ product.productPrice }원</p>
					</div>
					<!-- Order widget -->
					<div class="widget rate">
						<c:choose>
							<c:when test="${ product.productCount > 0 }">
							<h5 class="widget-header text-center">상품이 마음에 드십니까?</h5>
								<ul class="list-inline mt-20">
									<li class="list-inline-item"><a href="${ path }/product/productPayment/${ product.productNo }" class="btn btn-transparent">즉시구매</a></li>
									<li class="list-inline-item"><a href="" class="btn btn-transparent">장바구니</a></li>
								</ul>
							</c:when>
							<c:otherwise>
								<h5 class="widget-header text-center">현재 사용할 수 없습니다.</h5>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- Safety tips widget -->
					<div class="widget disclaimer">
					<c:choose>
						<c:when test="${ product.productCount > 0 }">
						<h5 class="widget-header text-center">FOR SALE</h5>
							<ul>
								<li>현재 남은 재고수량은 ${ product.productCount }개입니다.</li>
							</ul>
						</c:when>
						<c:otherwise>
						<h5 class="widget-header text-center">SOLD OUT</h5>
							<ul>
								<li>현재 일시품절 상태입니다.</li>
								<li>이용에 불편을 드려 죄송합니다.</li>
							</ul>
						</c:otherwise>
					</c:choose>
					</div>
					<!-- Admin Widget -->
					<c:if test="${ member.role eq 'ROLE_ADMIN' }">
					<div class="widget coupon text-center">
						<!-- Admin description -->
						<p>
						관리자 전용 기능
						</p>
						<!-- Update button -->
						<a href="${ path }/product/productUpdate/${ product.productNo }" class="btn btn-transparent-white" style="vertical-align: 20px;">게시물 수정</a>
						<!-- Delete button -->
						<a href="${ path }/product/productDelete/${ product.productNo }" class="btn btn-transparent-white">게시물 삭제</a>
					</div>
					</c:if>
				</div>
			</div>
			
		</div>
	</div>
	<!-- Container End -->
</section>
<!--============================
=            Footer            =
=============================-->

<footer class="footer section section-sm">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-lg-3 col-md-7 offset-md-1 offset-lg-0">
        <!-- About -->
        <div class="block about">
          <!-- footer logo -->
          <img src="images/logo-footer.png" alt="">
          <!-- description -->
          <p class="alt-color">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 offset-lg-1 col-md-3">
        <div class="block">
          <h4>Site Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 col-md-3 offset-md-1 offset-lg-0">
        <div class="block">
          <h4>Admin Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Promotion -->
      <div class="col-lg-4 col-md-7">
        <!-- App promotion -->
        <div class="block-2 app-promotion">
          <a href="">
            <!-- Icon -->
            <img src="images/footer/phone-icon.png" alt="mobile-icon">
          </a>
          <p>Get the Dealsy Mobile App and Save more</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Container End -->
</footer>
			
			</div>
		</div>
	</div>
</section>

<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />

</body>

</html>