<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="ticketReservation" style="display: none;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">티켓 예약 일람</h3>
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th class="text-center">ReservNo</th>
					<th class="text-center">Reserver</th>
					<th class="text-center">ResevDate</th>
					<th class="text-center">Detail</th>
					<th class="text-center">Expired</th>
					<th class="text-center">Approved</th>
				</tr>
			</thead>
			<tbody id="reservationListArray">
				
				<!-- 동적으로 생성됩니다. -->
				
			</tbody>
		</table>
		
		<nav>
		  <ul class="pagination justify-content-center" id="innerPaginationForReservationList">
		  
		  	<!-- 동적으로 처리됩니다. -->
		    
		  </ul>
		</nav>
		<br>
		
		<div class="row">
		
			<div class="col">
				
				<select id="searchOptionForReservation" class="form-control">
					<option value="all">전체</option>
					<option value="email">이메일</option>
					<option value="ticketName">티켓 이름</option>
				</select>
				
			</div>
				
			<div class="col col-md-5">
			
				<input type="text" class="form-control" placeholder="검색어를 입력해 주세요" id="searchValueForReservation" />
			
			</div>
				
			<div class="col">
			
				<input type="button" class="btn btn-main" id="searchButtonForReservation" value="검색">
			
			</div>
		
		</div>
		
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="ticketOrderDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">예약 상세</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		주문번호	 : <span id="ticketOrderNo"></span><br>
		주문일	 : <span id="ticketOrderDate"></span><br>
		유효일	 : <span id="ticketOrderUseDate"></span><br>
		수량		 : <span id="ticketAmount"></span><br>
		주문자	 : <span id="ticketEmail"></span><br>
		티켓 이름	 : <span id="ticketName"></span><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>