<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="question" style="display: none;" class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
	<br>
	<!-- Recently Favorited -->
	<div class="widget dashboard-container my-adslist table-responsive">
		<h3 class="widget-header">고객 문의 내역</h3>
		<table class="table table-hover" style="text-align: center">
			<thead>
				<tr>
					<th class="text-center" width="10%">번호</th>
					<th class="text-center" width="15%">카테고리</th>
					<th class="text-center" width="25%">이메일</th>
					<th class="text-center" width="20%">문의일자</th>
					<th class="text-center" width="20%">답변 여부</th>
				</tr>
			</thead>
			<tbody id="questionListArray">
				
				<!-- 답변 리스트가 동적으로 생성됩니다. -->
				
			</tbody>
		</table>
		
		<!-- pagination -->
		<nav>
		  <ul class="pagination justify-content-center" id="innerPaginationForQuestionList">
		  
		  	<!-- 동적으로 처리됩니다. -->
		    
		  </ul>
		</nav>
		<br>
		<div class="row">
		
			<div class="col">
				
				<select id="completedForQuestionList" class="form-control">
					<option value="all">전체</option>
					<option value="true">답변 완료</option>
					<option value="false">답변 미완료</option>
				</select>
				
			</div>
		
			<div class="col">
				
				<select id="searchOptionForQuestionList" class="form-control">
					<option value="all">전체</option>
					<option value="email">이메일</option>
					<option value="content">내용</option>
				</select>
				
			</div>
				
			<div class="col col-md-5">
			
				<input type="text" class="form-control" id="searchValueForQuestionList" placeholder="검색어를 입력하세요" />
			
			</div>
				
			<div class="col">
			
				<input type="button" class="btn btn-main" id="searchButtonForQuestionList" value="검색">
			
			</div>
		
		</div>
		
	</div>

</div>

<div class="modal fade" id="answerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="answerModalTitle">답변하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
          		문의번호: <span id="qnaNo"></span><br>
            	문의자 : <span id="qnaEmail"></span><br>
            	카테고리: <span id="qnaCategory"></span><br>
            	문의일자: <span id="qnaDate"></span><br>
            	문의 내용: <span id="qnaContent"></span><br>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">답변:</label>
            <textarea class="form-control" id="answerText"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" id="answerSubmitButton" class="btn btn-primary">답변하기</button>
      </div>
    </div>
  </div>
</div>