<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="productList" style="display: none; min-height: 1000px;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">상품 구매 내역</h3>
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th class="text-center">orderNo</th>
					<th class="text-center">amount</th>
					<th class="text-center">email</th>
					<th class="text-center">productName</th>
					<th class="text-center">approved</th>
				</tr>
			</thead>
			<tbody id="productListArray">
			
				<!-- 동적으로 생성됩니다. -->
				
			</tbody>
		</table>
		
		<!-- pagination -->
		<nav>
		  <ul class="pagination justify-content-center" id="paginationForProductOrderList">
		    
		    <!-- 동적으로 생성됩니다. -->
		    
		  </ul>
		</nav>
		
	</div>
</div>