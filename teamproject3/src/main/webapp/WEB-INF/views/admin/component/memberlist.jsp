<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="memberList" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">유저 목록</h3>
		<table class="table table-hover" style="text-align: center">
			<thead>
				<tr>
					<th class="text-center" width="15%">이름</th>
					<th class="text-center" width="35%">이메일</th>
					<th class="text-center" width="20%">가입일</th>
					<th class="text-center" width="15%">active</th>
					<th class="text-center" width="15%">탈퇴</th>
				</tr>
			</thead>
			<tbody id="memberListArray">
			
				<!-- document ready 후, 여기에 멤버 리스트를 동적으로 넣습니다. -->
				
			</tbody>
		</table>
		
		<!-- pagination -->
		<div id="paginationForMemberList"></div>

		<br>
		
		<div class="row">
		
			<div class="col col-md justify-content-right">
				
				<select id="searchOptionForMemberList" class="form-control">
					<option value="all">전체</option>
					<option value="email">이메일</option>
					<option value="name">이름</option>
				</select>
				
			</div>
				
			<div class="col col-md justify-content-center">
			
				<input type="text" class="form-control" id="searchValueForMemberList" />
			
			</div>
				
			<div class="col col-md justify-content-between">
			
				<input type="button" class="btn btn-main" id="searchButtonForMemberList" value="검색">
			
			</div>
		
		</div>
		
	</div>
</div>