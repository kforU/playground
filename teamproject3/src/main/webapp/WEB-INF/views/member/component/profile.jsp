<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>

<div id="profile" style="min-height: 1000px;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- 비밀번호 변경 -->
	<div class="widget personal-info">
		<h3 class="widget-header user">비밀번호 변경</h3>
		<form action="#">
		
			<input type="hidden" id="email" value="${member.email}" />
		
			<!-- 기존 비밀번호 -->
			<div class="form-group">
				<label for="current-password">기존 비밀번호</label>
				<input type="password" class="form-control" id="current-password">
			</div>
			
			<!-- 새 비밀번호 -->
			<div class="form-group">
				<label for="new-password">새 비밀번호</label>
				<input type="password" class="form-control" id="new-password">
			</div>
			<!-- 새 비밀번호 확인 -->
			<div class="form-group">
				<label for="confirm-password">새 비밀번호 확인</label>
				<input type="password" class="form-control" id="confirm-password">
			</div>
			
			<!-- Submit button -->
			<button id="passwordChangeButton" class="btn btn-transparent">비밀번호 변경</button>
		</form>
		
	</div>
	
	<!-- 이름 변경 -->
	<div class="widget personal-info" style="display: none">
		<h3 class="widget-header user">이름 변경</h3>
		<form action="#">
			<input type="hidden" id="passwd" value="${member.passwd}" />
			<!-- 이름 변경 -->
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" class="form-control" value="${member.name}" id="name">
			</div>
			
			<!-- Submit button -->
			<button id="nameChangeButton" class="btn btn-transparent">이름 변경</button>
			
		</form>
		
	</div>
	
</div>