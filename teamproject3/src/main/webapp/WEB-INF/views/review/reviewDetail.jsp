<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
	<!-- SITE TITTLE -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Calssimax</title>
	
	<jsp:include page="/WEB-INF/views/include/cssimport.jsp" />
	<style>
		th{ width:100px;
			text-align:center;
			}
	</style>
</head>

<body class="body-wrapper">

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<jsp:include page="/WEB-INF/views/include/side.jsp" />

<!--===============================
=            Hero Area            =
================================-->

<section class="hero-area bg-1 text-center overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					
					
				</div>
				
				
			</div>
		</div> 
	</div>
	<!-- Container End -->
</section>
  <!-- content-->

  	<article>
        <header class="section background-dark">
          <div class="line">        
            <h1 class="Detail Page Title">상세 보기</h1>
          </div>  
        </header>
       <div>
       <table class="table" >
       <tr>
       <th>제목</th>
       <td>${ review.reviewTitle }</td>
       </tr>
       <tr>
       <th>작성자</th>
       <td>
      	<h3>${ review.email }</h3>
       </td>
       </tr>
       <tr>
       <th>내용</th>
       <td>${ review.reviewContent }</td>
       </tr>
       </table>
       <div id="buttons">
     	<input class="btn" type="button" id="write" value="작성">
     	<input class="btn" type="button" id="return" value="목록">
     	<c:if test="${ member.email eq review.email }">
     	<input class="btn" type="button" id="edit" value="수정">
     	<input class="btn" type="button" id="deleted" value="삭제">
     	</c:if>
     	</div>
       </div>
       
       
        <!-- comment list -->
        <c:if test="${ not empty review.comments and review.comments[0].commentNo != 0 }">
        	<br>
        	<hr style="width:550px;margin:0 auto">
        	<br>
        	<table id="comment-list" class="table">        				
			<c:forEach var="comment" items="${ review.comments }">
			<tr id="tr${ comment.commentNo }">
				<td style="text-align:left;margin:5px;border-bottom: solid 1px;">
					
	        		<div id='commentview${ comment.commentNo }'>
	        			${ comment.email } &nbsp;&nbsp;
	        			[${ comment.regDate }]
	                    <br /><br />
	                    <span>
	                    ${ comment.commentContent }
	                    </span>
	                    <br /><br />
	                    <div style='display:${ member.email eq comment.email ? "block" : "none" }'>
	                    	<a class="editcomment" data-commentno='${ comment.commentNo }' href="javascript:">편집</a>
	                    	&nbsp;
	                    	<a class="deletecomment" 
	                    	   href="javascript:"
	                    	   data-commentno="${ comment.commentNo }">삭제</a>
	                    </div>
	                </div>	                
	                <div id='commentedit${ comment.commentNo }' style="display: none">
	                	${ comment.email } &nbsp;&nbsp;
	        			[${ comment.regDate }]
						<br /><br />
						<form id="updateform${ comment.commentNo }">
						<input type="hidden" name="commentNo" value="${ comment.commentNo }" />
						<textarea name="commentContent" style="width: 550px" rows="3" 
							maxlength="200">${ comment.commentContent }</textarea>
						</form>
						<br />
						<div>
							<a class="comment" href="javascript:" data-commentno="${ comment.commentNo }">수정</a> 
							&nbsp; 
							<a class="cancel" data-commentno="${ comment.commentNo }" href="javascript:">취소</a>
						</div>
					</div>
		
				</td>
        	</tr>        	
        	</c:forEach>
        	
	        </table>
	    </c:if>

<!-- write comment area -->
		<form id="commentform">
			<input type="hidden" name="reviewNo" value="${ review.reviewNo }" />			
			<input type="hidden" name="email" value="${ member.email }" />
			<table class="table">
	            <tr>
	                <td style="width:1000px">	                	
	                    <textarea id="comment_content" name="commentContent" 
	                    	style="width:1000px" rows="3"></textarea>	                    
	                </td>
	                <td style="width:50px;vertical-align:middle">
	                	<a id="writecomment" href="javascript:" style="text-decoration:none">
	                		댓글<br />등록
	                	</a>
	                </td>
	            </tr>                    
	        </table>
        </form>
        
       
     </article>





  
  <!-- Footer Bottom -->
 


<!--============================
=            Footer            =
=============================-->


<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />
<!-- javascript -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">
    	// 리뷰 버튼 컨트롤
    	$(function(){
    		$('#write').on('click', function(event){
    		location.href="${ path }/review/reviewWrite";
    		});
    		
    		$('#edit').on('click', function(event){
    			location.href="${ path }/review/reviewUpdate/${ review.reviewNo }";
    		});
    		
    		$('#deleted').on('click', function(event){
    			location.href="${ path }/review/reviewdelete/${ review.reviewNo }"
    			
    		});
    		$('#return').on('click', function(event){
    			location.href="${ path }/review/review"
    		})
    		
//************************덧글 제어 컨트롤******************************************************************
    		
    		$('#writecomment').on('click', function(event) {
    			
    			//serialize : <form에 포함된 입력 요소의 값을 이름=값&이름=값&... 형식으로 만드는 함수
    			var formData = $('#commentform').serialize();
    			// alert(formData)
    			
     			$.ajax({
    				url: "${ path }/review/write-comment",
    				method: "POST",
    				data: formData,
    				success: function(data, status, xhr) {
    					// alert(data);
    					$("#comment-list").load('${ path }/review/comment-list', 
    											{ "reviewNo" : ${ review.reviewNo } }, 
    											function() {})
    					$("#comment_content").val("");
    				},
    				error: function(xhr, status, err) {
    					alert(err);
    				}
    			});
    		});
    		
    		var currentCommentNo = -1;
    		//$('.editcomment').on('click', function(event) {
    		$('#comment-list').on('click', '.editcomment', function(event) {
    			commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
    			
    			//이전에 편집중인 항목을 원래 상태로 복구
    			if (currentCommentNo != -1) {
    				$('#commentview' + currentCommentNo).css('display', '');
    				$('#commentedit' + currentCommentNo).css('display', 'none');
    			}
    			
    			$('#commentview' + commentNo).css('display', 'none');
    			$('#commentedit' + commentNo).css('display', '');
    			currentCommentNo = commentNo;
    		});
    		
    		$('#comment-list').on('click', '.cancel', function(event) {
    			commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
    			$('#commentview' + commentNo).css('display', '');
    			$('#commentedit' + commentNo).css('display', 'none');
    			currentCommentNo = -1;			
    		});
    		
    		$('#comment-list').on('click', '.deletecomment', function(event) {
    			commentNo = $(this).attr('data-commentno');
    			$.ajax({
    				url: "${ path }/review/delete-comment",
    				method: "GET",
    				data: "commentNo=" + commentNo,
    				success: function(data, status, xhr) {
    					if (data == 'success') {
    						$('#tr' + commentNo).remove();
    						alert('삭제했습니다.');
    					} else {
    						alert('삭제 실패 1');
    					}
    				},
    				error: function(xhr, status, err) {
    					alert('삭제 실패 2');
    				}
    			});
    		});
    		
    		$('#comment-list').on('click', '.updatecomment', function(event) {
    			//현재 클릭된 <a 의 data-commentno 속성 값 읽기
    			var commentNo = $(this).attr('data-commentno');
    			var content = $('#updateform' + commentNo + ' textarea').val();
    			var inputData = $('#updateform' + commentNo).serialize();
    			
    			//ajax 방식으로 데이터 수정
    			$.ajax({
    				"url": "${ path }/review/update-comment",
    				"method": "POST",
    				"data": inputData,
    				"success": function(data, status, xhr) {
    					alert('댓글을 수정했습니다.');
    					var span = $('#commentview' + commentNo + ' span');					
    					span.html(content.replace(/\n/gi, '<br>'));
    					//view-div는 숨기고, edit-div는 표시하기	
    					$('#commentview' + commentNo).css('display', 'block');
    					$('#commentedit' + commentNo).css('display', 'none');
    				},
    				"error": function(xhr, status, err) {
    					alert('댓글 수정 실패');
    				}
    			});
    		});
    		

    	});
    </script>

  </body>
</html>