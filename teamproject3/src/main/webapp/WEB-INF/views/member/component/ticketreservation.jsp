<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="ticketReservation" style="display: none; min-height: 1000px;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">나의 티켓 예약 현황</h3>
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th class="text-center">ReservNo</th>
					<th class="text-center">TicketName</th>
					<th class="text-center">ReservDate</th>
					<th class="text-center">Amount</th>
					<th class="text-center">Approved</th>
				</tr>
			</thead>
			<tbody id="reservationListArray">
			
				<!-- 동적으로 생성됩니다. -->
				
			</tbody>
		</table>
		
		<!-- pagination -->
		<nav>
		  <ul class="pagination justify-content-center" id="paginationForReservation">
		    
		    <!-- 동적으로 생성됩니다. -->
		    
		  </ul>
		</nav>
		
	</div>
</div>