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
          <div class="line" style="width:900px">        
            <h1 class="Detail Page Title" style="text-align: center">작성 페이지(EVENT)</h1>
          </div>  
        </header>
       <div>
       <form action="eventWrite" id="frm" method="POST" enctype="Multipart/form-data">
       <table class="table">
       <tr>
       <th>제목</th>
       <td><input type="text" name="announceTitle" style="width:1100px"></td>
       </tr>
       <tr>
       <th>작성자</th>
       <td><input type="hidden" name="email" value="${ member.email }">${ member.name }</td>
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
       <td><input type="file" name="attachment"></td>
       </tr>
       <tr>
       <th>내용</th>
       <td><textarea name="announcementContent" id="content" style="width:1100px" rows="17"></textarea></td>
       </tr>
       </table>
       <br>
       <div style="text-align:center;">
       <input type="button" class="btn" id="savebutton" value="작성" />&nbsp;
       <input type="button" class="btn" id="cancel" value="취소" />
       </div>
       </form>

       </div><br><br><br><br>
     </article>





  
  <!-- Footer Bottom -->
 


<!--============================
=            Footer            =
=============================-->


<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />

<!-- javascript -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${ path }/resources/annNavereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type='text/javascript'>
$(function(){
	
    $("#cancel").on('click', function(event){
    	location.href="${ path }/announcement/announce";
    })
	
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
    

})
</script>
  
  </body>
</html>