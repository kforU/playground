<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>	
		
			<c:forEach var="comment" items="${ comments }">
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
						<input type="hidden" name="commentno" value="${ comment.commentNo }" />
						<textarea name="commentContent" style="width: 550px" rows="3" 
							maxlength="200">${ comment.commentContent }</textarea>
						</form>
						<br />
						<div>
							<a class="updatecomment" href="javascript:" data-commentno="${ comment.commentNo }">수정</a> 
							&nbsp; 
							<a class="cancel" data-commentno="${ comment.commentNo }" href="javascript:">취소</a>
						</div>
					</div>
		
				</td>
        	</tr>
        	</c:forEach>