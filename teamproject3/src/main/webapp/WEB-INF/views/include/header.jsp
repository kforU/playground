<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>

<link href="${ path }/resources/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">

<section>
	<input type="hidden" id="contextPath" value="${path}" />
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg  navigation">
					<a class="navbar-brand" href="${ path }/">
						<img src="${ path }/resources/images/logo.png" alt="">
						
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
							<li class="nav-item dropdown dropdown-slide">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									즐길거리 <span><i class="fa fa-angle-down"></i></span>
								</a>
								<!-- Dropdown list -->
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="${path}/attractionList">어트랙션</a>
									<a class="dropdown-item" href="${ path }/review/review">후기 게시판</a>
									
								</div>
							</li>
							<li class="nav-item dropdown dropdown-slide">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									상품 <span><i class="fa fa-angle-down"></i></span>
								</a>
								<!-- Dropdown list -->
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="${ path }/ticket/reservation">티켓 구매</a>
									<a class="dropdown-item" href="/controller/productList">기프트 샵</a>
									
								</div>
							</li>
							<li class="nav-item dropdown dropdown-slide">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									이용 안내 <span><i class="fa fa-angle-down"></i></span>
								</a>
								<!-- Dropdown list -->
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="#">운영/ 운휴</a>
									<a class="dropdown-item" href="${ path }/announcement/announce">공지사항</a>
									<a class="dropdown-item" href="${ path }/announcement/eventpage">이벤트 안내</a>
									<a class="dropdown-item" href="#">편의시설</a>
								</div>
							</li>
							<li class="nav-item dropdown dropdown-slide">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									고객지원 <span><i class="fa fa-angle-down"></i></span>
								</a>
								<!-- Dropdown list -->
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="${ path }/announcement/QnApage">고객 소리함</a>
									<a class="dropdown-item" href="#">건의사항</a>
								</div>
							</li>
						</ul>
						<ul class="navbar-nav ml-auto mt-10">
						
							<sec:authorize access="hasRole('ADMIN')">
								<li class="nav-item">
									<a class="nav-link login-button" href="${ path }/admin/info">관리자 페이지</a>
								</li>
							</sec:authorize>
							
							<sec:authorize access="hasRole('USER')">
								<li class="nav-item">
									<a class="nav-link login-button" href="${ path }/member/info">사용자 페이지</a>
								</li>
							</sec:authorize>
							
							<c:if test="${member ne null}">
								<li class="nav-item">
									<a class="nav-link login-button" href="${ path }/member/logout">로그아웃</a>
								</li>
							</c:if>
							
							<c:if test="${member eq null}">
								<li class="nav-item">
									<a class="nav-link login-button" href="${ path }/member/login">로그인</a>
								</li>
							</c:if>
							
							<li class="nav-item">
								<span class="nav-link login-button" style="cursor:pointer" onclick="openNav()">
								My Menu
								</span>
							</li>
						</ul>
						
						

					</div>
				</nav>
				
			</div>
		</div>
	</div>
</section>