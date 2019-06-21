<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="userDetails" />
	<c:set var="member" value="${userDetails.member}" />
</sec:authorize>

<c:set var="path" value="${ pageContext.request.contextPath }"/>



<!DOCTYPE html>
<html>
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

  <title>티켓 결제</title>
  
  <jsp:include page="../include/cssimport.jsp" />

</head>

<body class="body-wrapper">

<jsp:include page="../include/header.jsp" />

<jsp:include page="../include/side.jsp" />



<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        	지불 사항
                    </h3>
                    <div class="checkbox pull-right">
                        <label>
                            <input type="checkbox" />
                            Remember
                        </label>
                    </div>
                </div>
                <div class="panel-body">
                    <form role="form">
                    <div class="form-group">
                        <label for="cardNumber">
                            CARD NUMBER</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="cardNumber" placeholder="Valid Card Number"
                                required autofocus />
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-7 col-md-7">
                            <div class="form-group">
                                <label for="expityMonth">
                                    EXPIRY DATE</label>
                                <div class="col-xs-6 col-lg-6 pl-ziro">
                                    <input type="text" class="form-control" id="expityMonth" placeholder="MM" required />
                                </div>
                                <div class="col-xs-6 col-lg-6 pl-ziro">
                                    <input type="text" class="form-control" id="expityYear" placeholder="YY" required /></div>
                            </div>
                        </div>
                        <div class="col-xs-5 col-md-5 pull-right">
                            <div class="form-group">
                                <label for="cvCode">
                                    CV CODE</label>
                                <input type="password" class="form-control" id="cvCode" placeholder="CV" required />
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            <form id="order-form" action="ticket-order" method="post">
            <input type="hidden" name="email" value="${member.email}">
            <input type="hidden" name="ticketNo" value="${ ticket.ticketNo }">
            <input type="hidden" name="ticketOrderCount" value="${ ticketOrderCount }">
            <ul class="nav nav-pills nav-stacked">            	
                <li class="active">
                	<a href="javascript:" id="order-link">                		
	                	<span class="badge pull-right">	                			                	
	                		<span class="glyphicon glyphicon-krw"></span>	                		 
	                		&#8361; ${ ticket.adultPrice + ticket.youthPrice + ticket.kidPrice }	                		
	                	</span>
	                	최종 결제 	                	
                	</a>
                </li>
            </ul>
            </form>
            <br/>
           <!--  <a href="http://localhost:8088/controller/member/info" class="btn btn-success btn-lg btn-block" role="button">지불</a> -->
        </div>
    </div>
</div>




<!-- Footer Bottom -->
<jsp:include page="../include/footer.jsp" />
<jsp:include page="../include/jsimport.jsp" />

<script type="text/javascript">
$(function() {
	$('#order-link').on('click', function(event) {
		var ok = confirm('주문할까요');
		if (ok) {
			$('#order-form').submit();
		}
	});
});
</script>

</body>

</html>