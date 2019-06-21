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
			valign:auto;
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
            <h1 class="Detail Page Title">공지사항 작성</h1>
          </div>  
        </header>
       <div>
       <form action="${ path }/announcement/eventupdate" id="frm" method="POST" enctype="Multipart/form-data">
       <input type="hidden" name="announcementNo" value="${ announcement.announcementNo }">
       <table class="table" >
       <tr>
       <th>제목</th>
       <td><input type="text" name="announceTitle" value="${ announcement.announceTitle }" style="width:1100px;"></td>
       </tr>
       <tr>
       <th>작성자</th>
       <td><input type="hidden" name="email" value="${ member.email }">
       ${ member.name }
       </td>
       </tr>
       <tr>
       <th>유형</th>
       <td><select name="category">
       <option value="공지">공지</option>
       <option value="이벤트">이벤트</option>
       </select></td>
       </tr>
     <tr>
       <th>첨부파일</th>
       <td>
       <c:forEach var="file" items="${ announcement.files }">
		   <div id="file-${ file.annAttachmentNo }">
		        ${ file.annAttachmentMediaType } 
		   [<a id="delate-link-${ file.annAttachmentNo }" 
		   href="javascript:" 
		   data-fileno="${ file.annAttachmentNo }">삭제</a>]
		   </div>
		</c:forEach>
       <input type="file" name="attachment"/>
       </td>
       </tr>     
       <tr>
       <th>내용</th>
       <td><textarea name="announcementContent" id="content" style="width:1100px" rows="17">${ announcement.announcementContent }</textarea></td>
       </tr>
       </table>
       <input type="button" class="btn" id="savebutton" value="작성" />&nbsp;
       <input type="button" class="btn" id="cancel" value="취소" />
       </form>
       </div>
     </article>





  
  <!-- Footer Bottom -->
 


<!--============================
=            Footer            =
=============================-->


<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />

<!-- javascript -->
<script src="http://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${ path }/resources/annNavereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(function() {
			
	//첨부파일 삭제처리.
	$('a[id ^=delate-link]').on('click', function(event) {
		
		var announcementNo = '${ announcement.announcementNo }';
		var fileNo = $(event.target).attr('data-fileno');
		
		var yes = confirm(fileNo + '번 파일을 삭제할까요?');
		if (!yes) {
			return;
		}
		
		$.ajax({
			url: '${ path }/announcement/delete-file/' + announcementNo + '/' + fileNo,
			method: "GET",
			success: function(data, status, xhr) {
				if (data == 'success') {	//data : 서버에서 응답한 값
					$('#file-' + fileNo).remove();
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
	
	 //전역변수선언
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "content",
        sSkinURI: "${ path }/resources/annNavereditor/SmartEditor2Skin.html", 
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }
    });
     
    //전송버튼 클릭이벤트
    $("#savebutton").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        editor_object.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증

        //폼 submit
        $("#frm").submit();
    });
    
    //취소처리
    $('#cancel').on('click', function(event){
    	location.href="${ path }/announcement/eventDetail/${ announcement.announcementNo }"
    })
});
 </script>
 
  </body>
</html>