<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Calssimax</title>
  
  <jsp:include page="/WEB-INF/views/include/cssimport.jsp" />
  
</head>

<body class="body-wrapper">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/side.jsp" />
  <!-- content-->  
 
      <div class="container">
        <header class="section background-dark">
          <div class="line">        
            <h1 class="Detail Page Title" style="font-size: 45px;">어트랙션 등록</h1>
            <p class="margin-bottom-0 text-size-16">어트랙션 등록 관련 관리자 페이지</p>
          </div>  
        </header>
      </div>


<div class="container">
  <div class="widget change-email mb-0">
    <form action="attractionWrite" method="post" enctype="multipart/form-data" id="formfild">
      <!-- Current Password -->
      <div class="form-group" >
        <label for="thumbnail" >어트랙션 이름</label>
        <input type="text" class="form-control" id="QnAtitle" name="attractionName">
      </div>

      <div class="form-group" >
        <label for="thumbnail">썸네일을 첨부해주세요</label>
        <input type="file" name="attach" id="uploadImg">
        <div class="select_img"><img src="" /></div>
      </div>

      <div class="form-group">
        <label for="Attractioncontent">글 작성하기</label>
        <textarea class="textArea" rows="6" id="smarteditor" name="attractionContent" style="width: 100%" >
        </textarea>
      </div>


    <div class="container-contact100-form-btn">
      <button class="contact100-form-btn" id="writebutton">
        <span>
         	 등록하기
        </span>
      </button>
    </div>
  
  </form>
  </div>
</div>
  <div class="container-bottom"></div>  
<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />


<!-- javascript -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${ path }/resources/annNavereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type='text/javascript'>
	$("#uploadImg").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".select_img img").attr("src", data.target.result).width(500);        
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });

$(function(){
    //전역변수선언
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "smarteditor",
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
    $("#writebutton").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증
         
        //폼 submit
        $("#formfild").submit();
    })
})


</script>

</body>

</html>