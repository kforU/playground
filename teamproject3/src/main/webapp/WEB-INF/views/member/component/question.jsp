<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="question" style="display: none; min-height: 1000px;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">나의 문의 내역</h3>
		<table class="table">
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">카테고리</th>
					<th class="text-center">내용</th>
					<th class="text-center">등록일자</th>
					<th class="text-center">답변 여부</th>
				</tr>
			</thead>
			<tbody id="myQuestionList">
			
				<!-- 나의 문의 내역은 동적으로 생성됩니다. -->
				
			</tbody>
		</table>
		
		<!-- pagination -->
		<nav>
		  <ul class="pagination justify-content-center" id="paginationForQuestionList">
		  
		  	<!-- 페이징 처리는 동적으로 이루어집니다. -->

		  </ul>
		</nav>
		
	</div>
</div>

<div class="modal fade" id="questionContentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">문의내용</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

          <div class="form-group">
            <label for="message-text" class="col-form-label">Message:</label>
            <div id="questionContent"></div>
          </div>
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="answerContentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">답변내용</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

          <div class="form-group">
            <label for="message-text" class="col-form-label">Message:</label>
            <div id="answerContent"></div>
          </div>
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>