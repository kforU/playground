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

<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
			
<!--===================================
=            Store Section            =
====================================-->
<section class="section bg-gray">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<!-- Left sidebar -->
			<div class="col-md-8">
				<form action="/controller/product/productUpdate" id="frm" method="post" enctype="multipart/form-data">
					<div>
					<input type="hidden" name="productNo" value="${ product.productNo }">
					<table class="table table-bordered product-table">
						<h3>제품상세</h3>
								  <tbody>
								  	<tr>
								      <td>제품명</td>
								      <td><input type="text" name="productName" value="${ product.productName }" style="width:500px"></td>
								    </tr>
								    <tr>
								      <td>판매가</td>
								      <td><input type="number" name="productPrice" value="${ product.productPrice }" style="width:500px">원</td>
								    </tr>
								    <tr>
								      <td>재고수량</td>
								      <td><input type="number" name="productCount" value="${ product.productCount }" style="width:100px"></td>
								    </tr>
								    <tr>
								      <td style="vertical-align: middle;">카테고리</td>
								      <td>
								      	<select class="form-control" id="inputLocation4" name="productCategory" >
											<option>완구</option>
											<option>의류</option>
											<option>문구</option>
											<option>가전</option>
											<option>악세사리</option>
										</select>
									   </td>
								    </tr>
								    <tr>
								      <td>첨부이미지</td>
								      <c:choose>
								      	<c:when test="${product.productImage ne null }">
								      	<td>
								      		${ product.productImage }
								      		[<a href="/controller/product/deleteImage/${ product.productNo }">삭제</a>]
								      		
								      	</td>
								      	</c:when>
								      	<c:otherwise>
								      	<td>
								      		<input type="file" name="productImage2" />
								      	</td>
								      	</c:otherwise>
								      </c:choose>
								    </tr>
								</tbody>
							</table>
						</div>
					<div style="margin-top: 5px;">
						<h3>제품설명</h3>
						<textarea name="productContent" id="productContent" style="width:705px" rows="15">
							${ product.productContent }
						</textarea>
					</div>
					<br>
					<div class="col-12">
						<button type="submit" class="btn btn-main" id="savebutton">등록</button>
						<a href="/controller/productDetail/${ product.productNo }"><button type="button" class="btn btn-white">취소</button></a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<!--============================
=            Footer            =
=============================-->

<footer class="footer section section-sm">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-lg-3 col-md-7 offset-md-1 offset-lg-0">
        <!-- About -->
        <div class="block about">
          <!-- footer logo -->
          <img src="images/logo-footer.png" alt="">
          <!-- description -->
          <p class="alt-color">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 offset-lg-1 col-md-3">
        <div class="block">
          <h4>Site Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 col-md-3 offset-md-1 offset-lg-0">
        <div class="block">
          <h4>Admin Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Promotion -->
      <div class="col-lg-4 col-md-7">
        <!-- App promotion -->
        <div class="block-2 app-promotion">
          <a href="">
            <!-- Icon -->
            <img src="images/footer/phone-icon.png" alt="mobile-icon">
          </a>
          <p>Get the Dealsy Mobile App and Save more</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Container End -->
</footer>
			
			</div>
		</div>
	</div>
</section>

<!-- Footer Bottom -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<jsp:include page="/WEB-INF/views/include/jsimport.jsp" />

<!-- javascript -->
<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${ path }/resources/annNavereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type='text/javascript'>
$(function(){
    //전역변수선언
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "productContent",
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
        editor_object.getById["productContent"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증

        //폼 submit
        $("#frm").submit();
    })
})
</script>

</body>

</html>