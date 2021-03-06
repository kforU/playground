<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

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
  
	<jsp:include page="../include/cssimport.jsp" />

</head>

<body class="body-wrapper">

<jsp:include page="../include/header.jsp" />

<section style="background-color: #f5f5f5">
	<div class="container" style="min-height: 1000px">
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
				<br>
				<div class="sidebar">
					<!-- User Widget -->
					<div class="widget user-dashboard-profile">
						<!-- User Image -->
						<div class="profile-thumb">
						
							<!-- 프로필 이미지는 동적으로 생성됩니다. -->
							<div id="profileImageDiv" align="center"></div>
							
							<input type="file" id="profileImageFile" style="display: none;" />
							<input type="hidden" id="email" value="${member.email}" />
							<br>
						</div>
						<!-- User Name -->
						<h5 class="text-center">${member.name}</h5>
						<p>Joined 
							<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd hh:mm"/>
						</p>
					</div>
					<!-- Dashboard Links -->
					<div class="widget user-dashboard-menu">
						<ul>
							<li class="active">
								<a href="#" id="showMemberListButton"><i class="fa fa-user"></i> 전체 회원 열람 <span id="memberCount"></span></a></li>
							<li>
								<a href="#" id="showTicketReservationButton"><i class="fa fa-bookmark-o"></i> 티켓 예약 처리 <span id="reservationCount"></span></a>
							</li>
							<li>
								<a href="#" id="showProductListButton"><i class="fa fa-fighter-jet"></i> 상품 예약 처리 <span id="reservationCount"></span></a>
							</li>
							<li>
								<a href="#" id="showQuestionButton"><i class="fa fa-question-circle"></i> 사용자 문의 처리 <span id="questionCount"></span></a>
							</li>
							<li>
								<a id="logoutButton" href="#"><i class="fa fa-cog"></i> 로그아웃</a>
							</li>
							<li>
								<a href="#" id="delete"><i class="fa fa-power-off"></i> 탈퇴하기</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<jsp:include page="component/memberlist.jsp" />
			
			<jsp:include page="component/question.jsp" />
			
			<jsp:include page="component/reservation.jsp" />
			
		</div>
	</div>
</section>

<jsp:include page="../include/footer.jsp" />

<jsp:include page="../include/jsimport.jsp" />
  
<script src="${ path }/resources/js/admin/info.js"></script>

</body>

</html>