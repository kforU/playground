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
  
  <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <jsp:include page="/WEB-INF/views/include/cssimport.jsp" />
	
</head>

<body class="body-wrapper">

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />

			
<!--===================================
=            Store Section            =
====================================-->

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
					</div>
					<div>
						<h3 class="tab-title">상품 상세</h3>
						<table class="table table-bordered product-table"
							style="font-size: 15px;">
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
				</div>
			</div>
			<div class="col-md-4">
				<form action="productOrderComplete" method="post">
				<div class="sidebar" style="margin-top: 100px">
					<div class="widget disclaimer">
						<input type="hidden" name="productNo" value="${ product.productNo }" >
						<input type="hidden" name="email" value="${ member.email }" >
						<h5 class="widget-header text-center">주문 수량</h5>
								<ul>
									<li><input type="number" min="1" max="${ product.productCount }" name="productOrderCount" id="count" oninput="countValue()" value="1" class="form-control" required>개 <p id="orderCount" style="color:red;"></p> </li>
								</ul>
					</div>
					<!-- Safety tips widget -->
					<div class="widget disclaimer">
						<h5 class="widget-header text-center">주문 확인</h5>
								<ul>
									<li id="orderDetail">${ product.productName } X 1 = ${ product.productPrice }</li>
								</ul>
					</div>
					<div class="widget price text-center" >
						<h4>가격</h4>
						<p id="price">${ product.productPrice }원</p>
					</div>
						<div class="widget disclaimer">
								<div class="row">
										<div class="panel panel-default">
											<div class="panel-heading">
												<h3 class="panel-title">지불 사항</h3>
												<div class="checkbox pull-right">
													<label> <input type="checkbox" /> Remember
													</label>
												</div>
											</div>
											<div class="panel-body">
													<div class="form-group">
														<label for="cardNumber">CARD NUMBER</label>
														<div class="input-group">
															<input type="text" class="form-control" id="cardNumber" 
																   maxlength="16" placeholder="Valid Card Number" required autofocus /> <span
																class="input-group-addon"><span
																class="glyphicon glyphicon-lock"></span></span>
														</div>
													</div>
													<div class="row">
														<div class="col-xs-7 col-md-7">
															<div class="form-group">
																<label for="expityMonth"> EXPIRY DATE</label>
																<div class="col-xs-6 col-lg-6 pl-ziro">
																	<input type="text" class="form-control"
																		id="expityMonth" placeholder="MM" maxlength="2" min="01" max="12" required />
																</div>
																<div class="col-xs-6 col-lg-6 pl-ziro">
																	<input type="text" class="form-control" id="expityYear"
																		placeholder="YY" maxlength="2" max="99" required />
																</div>
															</div>
														</div>
														<div class="col-xs-5 col-md-5 pull-right">
															<div class="form-group">
																<label for="cvCode"> CV CODE</label> <input
																	type="password" class="form-control" id="cvCode"
																	placeholder="CV" maxlength="3" required />
															</div>
														</div>
													</div>
												
											</div>
										</div>
										<br />
										<button class="btn btn-success btn-lg btn-block" type="submit">주문하기</button>
									</div>
									</form>
								</div>
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
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
	function countValue() {
		var x = document.getElementById("count").value;
		document.getElementById("orderDetail").innerHTML = "${ product.productName }"
				+ "&nbsp"
				+ "X"
				+ "&nbsp"
				+ x
				+ "&nbsp"
				+ "="
				+ "&nbsp"
				+ "${ product.productPrice }" * x
		document.getElementById("price").innerHTML = "${ product.productPrice }"
				* x + "원";

		if (x == "${ product.productCount }") {
			document.getElementById("orderCount").innerHTML = "더 이상 구매할 수 없습니다."
		} else if (x < "${ product.productCount }") {
			document.getElementById("orderCount").innerHTML = ""
		} else if (x.equals("")) {
			x == 1;
		} else if (x > "${ product.productCount }") {
			x == "${ product.productCount }"
		}

	}
	function cardNumber(num) {

		if (isFinite(num.value) == false) {
			alert("카드번호는 숫자만 입력할 수 있습니다.");
			num.value = "";
			return false;
			}
	}
	$("#count").keypress(function(evt) {
		evt.preventDefault();
	});

	$("#count").keydown(function(e) {
		var elid = $(document.activeElement).hasClass('textInput');
		console.log(e.keyCode + ' && ' + elid);
		//prevent both backspace and delete keys
		if ((e.keyCode === 8 || 
			 e.keyCode === 46 || 
			 e.keyCode === 110 || 
			 e.keyCode === 16 || 
			 e.keyCode === 69) && !elid) {
			return false;
		}
	
	});
	
	$("#cardNumber").keypress(function(event) {

		if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
			event.preventDefault();
		}
	});
</script>
</html>