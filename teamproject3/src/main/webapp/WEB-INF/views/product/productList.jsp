<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">
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

<!--==================================
=            Product Shop            =
===================================-->
					<section class="page-search">
						<div class="container">
							<div class="row">
								<div class="col-md-12">
									<!-- Advance Search -->
									<div class="advance-search">
										<form>
											<div class="form-row">
												<div style="margin-left: 15px; margin-right: 15px;">
													<input type="text" class="form-control" id="inputtext4" placeholder="검색어를 입력해주세요" style="width: 500px;">
												</div>
												<div>
													<select class="form-control" id="inputLocation4"
														style="height: 50px">
														<option style="color: black;" value="" disabled selected hidden>카테고리를선택해 주세요</option>
														<option style="color: black;" value="완구">완구</option>
														<option style="color: black;" value="의류">의류</option>
														<option style="color: black;" value="문구">문구</option>
														<option style="color: black;" value="가전">가전</option>
														<option style="color: black;" value="악세사리">악세사리</option>
													</select>
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
<section class="section-sm">
					<div class="container">
							<div class="row">
								<div class="col-md-12">
									<div class="search-result bg-gray">
										<h2>"Electronics"로 검색한 결과 총 123 건</h2>
									</div>
								</div>
							</div>
						<div class="row">
							<div class="col-md-3">
								<div class="category-sidebar">
									<div class="widget category-list">
										<h4 class="widget-header">카테고리</h4>
											<ul class="category-list">
												<li><a href="category.html">완구 <span>0</span></a></li>
												<li><a href="category.html">의류 <span>0</span></a></li>
												<li><a href="category.html">문구 <span>0</span></a></li>
												<li><a href="category.html">가전 <span>0</span></a></li>
												<li><a href="category.html">악세사리 <span>0</span></a></li>
											</ul>
									</div>
										<div class="widget product-shorting">
											<h4 class="widget-header">정렬 조건</h4>
												<div class="form-check">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="sort" value="">
														인기상품순
													</label>
											</div>
											<div class="form-check">
												<label class="form-check-label">
													<input class="form-check-input" type="radio" name="sort" value="">
													최근상품순
												</label>
											</div>
											<div class="form-check">
												<label class="form-check-label">
													<input class="form-check-input" type="radio" name="sort" value="">
													낮은가격순
												</label>
											</div>
											<div class="form-check">
												<label class="form-check-label">
													<input class="form-check-input" type="radio" name="sort" value="">
													높은가격순
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-9">
									<div class="product-grid-list">
										<div class="row mt-30">
											<c:forEach var="product" items="${ products }">
												<div class="col-sm-12 col-lg-4 col-md-6">
													<!-- product card -->
													<div class="product-item bg-light">
														<div class="card">
															<div class="thumb-content">
																<a href="productDetail/${ product.productNo }">
																	<img class="card-img-top img-fluid"
																		 src="resources/images/tmp/${ product.productImage }"
																		 alt="Card image cap"
																		 style="height: 200px">
																</a>
															</div>
															<div class="card-body">
																<h4 class="card-title">
																	<a href="productDetail/${ product.productNo }">${ product.productName }</a>
																</h4>
																<ul class="list-inline product-meta">
																	<li class="list-inline-item"><a href="productDetail/${ product.productNo }"><i
																			class="fa fa-folder-open-o"></i>${ product.productCategory }</a></li>
																	<li class="list-inline-item"><a href="productDetail/${ product.productNo }"><i
																			class="fa fa-calendar"></i>${ product.regDate }</a></li>
																	<li class="list-inline-item" style="text-align: right;">${ product.productPrice }원</li>
																</ul>
																<c:choose>
																	<c:when test="${ product.productCount > 0 }">
																		<p class="card-text">재고있음</p>
																	</c:when>
																	<c:otherwise>
																		<p class="card-text">일시 품절</p>
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
							<div class="pagination justify-content-center">
								<nav aria-label="Page navigation example">
									<ul class="pagination">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												<span class="sr-only">Previous</span>
										</a></li>
										<li class="page-item active"><a class="page-link"
											href="#">1</a></li>
										<li class="page-item"><a class="page-link" href="#">2</a></li>
										<li class="page-item"><a class="page-link" href="#">3</a></li>
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												<span class="sr-only">Next</span>
										</a></li>
									</ul>
								</nav>
							</div>
							<c:if test="${ member.role eq 'ROLE_ADMIN' }">
							<div align="right" style="padding-right: 400px;">
								<a class="btn btn-primary" href="productWrite">상품 등록</a>
							</div>
							</c:if>
						</div>
				</div>
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
						<img src="${ path }/resources/images/logo-footer.png" alt="">
						<!-- description -->
						<p class="alt-color">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit, sed do eiusmod tempor incididunt ut labore et
							dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
							exercitation ullamco laboris nisi ut aliquip ex ea commodo
							consequat.</p>
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
						<a href=""> <!-- Icon --> <img
							src="${ path }/resources/images/footer/phone-icon.png"
							alt="mobile-icon">
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