<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Calssimax</title>
  
  <jsp:include page="../include/cssimport.jsp" />
	
</head>

<body class="body-wrapper">

<jsp:include page="../include/header.jsp" />

<jsp:include page="../include/side.jsp" />

<section class="dashboard section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
			
			<h3>날짜 선택</h3>
			
			<form action="/ticket/date-transform" method="post">
				 <input type="date" name="ticketOrderDate"><br>
						
			</form>
			
			<section class="container">
			<h1> 티켓 예매 </h1>
			
			
			  <div class="row">
			    <article class="onedaycard ">
			      
			      <section class="card-cont">
			      	<hr>
			        <h3>1. 1 day 자유이용권(종합)</h3>
			        <div class="even-date">
			         <i class="fa fa-calendar"></i>
			         <time>
			           <span> 2019년 </span>
			           <span>08:55pm to 12:00 am</span>
			         </time>
			        </div>
			        <hr>
			        <form id="reservation-form" action="payment" method="get">
			        <input type="hidden" name="ticketNo" value="1">
			        <span> 성인 </span>
			        <input name="adultPrice" type="number" value="57000" min="0" max="10000000" step="57000"/>
			        
			         <span> 청소년 </span>
			        <input name="youthPrice" type="number" value="50000" min="0" max="10000000" step="50000"/>
			        
			         <span> 아이 </span>
			        <input name="kidPrice" type="number" value="46000" min="0" max="10000000" step="46000"/>
			        
			        <br>
			        
			        <!-- <a href="/playground/ticket/payment" class='.button'>결제</a> -->
			        <input type="submit" value="구매">
			        </form>
			        
			      </section>  
			    </article>
			    
			    <article class="onedaycard ">
			      
			      <section class="card-cont">
			      	<hr>
			        <h3>2. AFTER4(16시 이후)(종합)</h3>
			        <div class="even-date">
			         <i class="fa fa-calendar"></i>
			         <time>
			           <span> 2019년 </span>
			           <span>16:00pm to 12:00 am</span>
			         </time>
			        </div>
			        <hr>
			        
			        <form id="reservation-form" action="payment" method="get">
			        			        <input type="hidden" name="ticketNo" value="2">
			        <span> 성인 </span>
			        <input name="adultPrice" type="number" value="57000" min="0" max="10000000" step="57000"/>
			        
			         <span> 청소년 </span>
			        <input name="youthPrice" type="number" value="50000" min="0" max="10000000" step="50000"/>
			        
			         <span> 아이 </span>
			        <input name="kidPrice" type="number" value="46000" min="0" max="10000000" step="46000"/>
			        
			        <br>
			        
			        <!-- <a href="/playground/ticket/payment" class='.button'>결제</a> -->
			        <input type="submit" value="구매">
			        </form>
			        
			      </section>  
			    </article>
			    
			     <article class="onedaycard ">
			      
			      <section class="card-cont">
			      	<hr>
			        <h3>3. 1 day 자유이용권(파크)</h3>
			        <div class="even-date">
			         <i class="fa fa-calendar"></i>
			         <time>
			           <span> 2019년 </span>
			           <span>08:55pm to 12:00 am</span>
			         </time>
			        </div>
			        <hr>
			        <form id="reservation-form" action="payment" method="get">
			        <input type="hidden" name="ticketNo" value="3">
			        <span> 성인 </span>
			        <input name="adultPrice" type="number" value="57000" min="0" max="10000000" step="57000"/>
			        
			         <span> 청소년 </span>
			        <input name="youthPrice" type="number" value="50000" min="0" max="10000000" step="50000"/>
			        
			         <span> 아이 </span>
			        <input name="kidPrice" type="number" value="46000" min="0" max="10000000" step="46000"/>
			        
			        <br>
			        
			        <!-- <a href="/playground/ticket/payment" class='.button'>결제</a> -->
			        <input type="submit" value="구매">
			        </form>
			      </section>  
			    </article>
			    
			    <article class="onedaycard ">
			      
			      <section class="card-cont">
			      	<hr>
			        <h3>4. AFTER4(16시 이후)(파크)</h3>
			        <div class="even-date">
			         <i class="fa fa-calendar"></i>
			         <time>
			           <span> 2019년 </span>
			           <span>16:00pm to 12:00 am</span>
			         </time>
			        </div>
			        <hr>
			        <form id="reservation-form" action="payment" method="get">
			        <input type="hidden" name="ticketNo" value="4">
			        <span> 성인 </span>
			        <input name="adultPrice" type="number" value="57000" min="0" max="10000000" step="57000"/>
			        
			         <span> 청소년 </span>
			        <input name="youthPrice" type="number" value="50000" min="0" max="10000000" step="50000"/>
			        
			         <span> 아이 </span>
			        <input name="kidPrice" type="number" value="46000" min="0" max="10000000" step="46000"/>
			        
			        <br>
			        
			        <!-- <a href="/playground/ticket/payment" class='.button'>결제</a> -->
			        <input type="submit" value="구매">
			        </form>
			      </section>  
			    </article>
			    <!-- *********************************************** -->
			    
			    <hr class="division">
			    <div class="res_cont end">
			
				<ul class="tab tab_red">
					
					
						<li class="three"><a href="#sec_tab01">상품안내</a></li>
						
					
						<li class="three on"><a href="#sec_tab03">취소/환불</a></li>
						
					
				</ul>
				
				
				
					<div id="sec_tab01" class="tabCont on" style="display: block;">
						<!-- class="on" 기본 보여지는 화면 --><img alt="" class="w100" src="/playground/resources/images/201703024ab0394260d04693b53f83046f41f6ad.png">
					<div class="pd5">
					<p class="tit_info mgb20">모험과 신비의 나라&nbsp;CLASSIMAX 어드벤처</p>
					<img alt="" src="/playground/resources/images/20170302bdc830a62ab64b958838279fc4de6cd8.png">
					<p class="mgb20">다채로운 놀이시설, 실내 어드벤처</p>
					<img alt="" src="/playground/resources/images/201703028ba285edb4834632baa4e389cd07729f.png">
					<p class="mgb20">스릴이 가득한, 매직아일랜드</p>
					
					<h2>운영시간 안내</h2>
					
					<div class="price_table">
					<table class="table table-bordered product-table">
						<caption>운영시간 안내</caption>
						<colgroup>
							<col width="40%">
							<col width="23%">
							<col width="37%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">요일</th>
								<th scope="col">운영시간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="ac bln" rowspan="2">어드벤처<br>
								(실내, 실외)</td>
								<td class="ac">일 ~ 목</td>
								<td class="ac">9:30 ~ 22:00</td>
							</tr>
							<tr>
								<td class="ac">금 ~ 토</td>
								<td class="ac">9:30 ~ 23:00</td>
							</tr>
						</tbody>
					</table>
					</div>
					
					<p class="asterisk">야간개장은 오후 4시부터 입니다.</p>
					
					<p class="asterisk">민속박물관은 오후 7시 이전 입장가능합니다.</p>
					
					<p class="asterisk">현장상황에 따라 운영 일정이 예고 없이 변경될 수 있으니 방문일자의 운영 현황을 확인해 주세요.</p>
					
					<p class="asterisk mgb10">점검현황에 따라 일부 시설이 미 운영할 수 있으니 자세한 내용은 홈페이지를 참고해 주시기 바랍니다.</p>
					
					<p class="hyphenStyle mgb20"><a class="txtColorType08" href="#" onclick="mbf_OpenBrowser('http://www.lotteworld.com/app/suspendInfo/view.asp?cmsCd=CM0259');">운휴정보 바로가기</a></p>
					<img alt="" class="mgb10" src="/simgs/display/1210/upload/20170302011a5eec0e5449babf38eca808073db2">
					<h2>이용요금 안내</h2>
					
					<div class="table table-bordered product-table">
					<table>
						
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="23%">
							<col width="23%">
							<col width="23%">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2" scope="col">구분</th>
								<th scope="col">성인</th>
								<th scope="col">청소년</th>
								<th scope="col">어린이</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="ac bln txtColorType03" rowspan="2">종합이용권</td>
								<td class="ac txtColorType03">1일권</td>
								<td class="ac txtColorType03">57,000원</td>
								<td class="ac txtColorType03">50,000원</td>
								<td class="ac txtColorType03">46,000원</td>
							</tr>
							<tr>
								<td class="ac txtColorType03">After4</td>
								<td class="ac txtColorType03">46,000원</td>
								<td class="ac txtColorType03">40,000원</td>
								<td class="ac txtColorType03">35,000원</td>
							</tr>
							<tr>
								<td class="ac bln" rowspan="3">파크이용권</td>
								<td class="ac">1일권</td>
								<td class="ac">54,000원</td>
								<td class="ac">48,000원</td>
								<td class="ac">45,000원</td>
							</tr>
							<tr>
								<td class="ac">After4</td>
								<td class="ac">43,000원</td>
								<td class="ac">38,000원</td>
								<td class="ac">34,000원</td>
							</tr>
						</tbody>
					</table>
					</div>
					
					<p class="asterisk">종합이용권은 CLASSIMAX 실내/외 입장, 놀이시설, 민속박물관을 자유롭게 이용하실 수 있습니다.<br>
					파크이용권은 CLASSIMAX 실내/외 입장, 놀이시설을 자유롭게 이용하실 수 있습니다.</p>
					
					<p class="asterisk">(환상의 숲, 게임시설 등 일부 유료시설 제외)</p>
					
					<p class="asterisk mgb10">베이비 : 36개월 미만<br>
					어린이 : 36개월 이상~만 12세<br>
					청소년 : 만 13세 이상~만 18세</p>
					
					<h2>베이비 이용안내</h2>
					
					<ul class="listTypeNum mgb20">
						<li>1. 베이비용 종합이용권은 14,000원입니다.</li>
						<li>2. 0~12개월 미만 베이비는 파크 입장과 유아놀이시설을 무료로 이용하실 수 있습니다.</li>
						<li>3. 12개월 이상~36개월 미만 베이비는 파크 입장은 무료이나 유아 놀이시설 이용 시는 유료입니다.</li>
						<li>4. 해당 혜택을 위해서는 반드시 나이를 확인할 수 있는 서류를 지참해 주세요.</li>
					</ul>
					
					<h2>특별 우대 (현장매표소에서 예매해 주세요!)</h2>
					
					<ul class="listTypeNum mgb20">
						<li>1. 만 65세 이상 고객은 어린이요금이 적용됩니다.</li>
						<li>2. 장애인의 경우 30% 우대할인 적용됩니다.(동반1인)</li>
						<li>3. 국가유공자의 경우 50% 우대할인 적용됩니다.(동반1인)</li>
						<li>4. 해당 우대를 적용받으시기 위해 증빙서류를 반드시 지참해주시기 바랍니다.(주민등록증, 장애인등록증 등)</li>
					</ul>
					
					<h2>꼭 읽어주세요!</h2>
					
					<ul class="listTypeNum mgb10">
						<li>1. 입장 당일 '무료 주차'가능
						<p class="hyphenStyle">CLASSIMAX 어드벤처 입장 후 중앙 안내데스크에서 확인(무료주차 확인 시 차량번호 확인 필수)</p>
						</li>
						<li>2. 기상현상으로 인해 일부 놀이기구의 운영이 중단될 수 있는 점 양해바랍니다.</li>
						<li>3. 해당 티켓은 재판매가 불가능합니다.</li>
						<li>4. 방문날짜 및 권종 수정이 불가능합니다. 예매를 취소하신 뒤 재구매 해주시기 바랍니다.</li>
					</ul>
				</div>
					
			</div>
							
					<div id="#sec_tab03" class="tabCont" style="display: none;">
					
						<div class="pd5">
						
					<h2>예매취소 안내</h2>
					
					<ul class="listTypeDot mgb20">
						<li>온라인 예매 시 <span class="txtColorType03">선택한 날짜에만 방문 및 이용이 가능</span>하며, 해당날짜가 지나면 자동 취소 됩니다. (미 발권 시)
					
						<ul class="listTypeHyphen">
							<li>시스템 자동 취소가 될 경우 제휴카드 실적은 은행영업일 기준 2~3일 후에 복구됩니다.&nbsp;</li>
							<li>별도의 취소 수수료는 없으나 발권 후 환불요청 시 각 카드사에 따라 수수료를 차감합니다.</li>
							<li>예매취소를 원하시는 경우 [마이페이지 &gt; 결제내역]에서 취소하실 수 있습니다.</li>
						</ul>
						</li>
						<li>예매 후에는 반드시 예매확인을 통하여 예매내역을 확인해 주시기 바랍니다.</li>
						<li>발권 후 취소는 현장 방문하시어 매표소에 문의하신 후 취소하셔야 합니다.</li>
					</ul>
					
					<h2>환불 안내</h2>
					
					<p class="txtColorType08 mgt10">[발권 전]</p>
					
					<ul class="listTypeDot">
						<li>유효기간 내 : 100% 환불</li>
						<li>유효기간 후 : 100%(자동취소)</li>
					</ul>
					
					<p class="txtColorType08 mgt10">[발권 후]</p>
					
					<ul class="listTypeDot">
						<li>당일 발권 후 당일&nbsp;환불요청 시 :&nbsp;100% 환불</li>
						<li>당일 발권 후 익일 이후 환불요청 시 :&nbsp;환불불가</li>
					</ul>
					</div>
					
				</div>
								
							
						
			</div>
							
							
							
					<!-- *************************************************************** -->		
				
				
					
										
									
										
										
									
					<div id="sec_tab03" class="tabCont" style="display: block;">
						<div class="pd5">
					<h2>예매취소 안내</h2>
					
					<ul class="listTypeDot mgb20">
						<li>온라인 예매 시 <span class="txtColorType03">선택한 날짜에만 방문 및 이용이 가능</span>하며, 해당날짜가 지나면 자동 취소 됩니다. (미 발권 시)
					
						<ul class="listTypeHyphen">
							<li>시스템 자동 취소가 될 경우 제휴카드 실적은 은행영업일 기준 2~3일 후에 복구됩니다.&nbsp;</li>
							<li>별도의 취소 수수료는 없으나 발권 후 환불요청 시 각 카드사에 따라 수수료를 차감합니다.</li>
							<li>예매취소를 원하시는 경우 [마이페이지 &gt; 결제내역]에서 취소하실 수 있습니다.</li>
						</ul>
						</li>
						<li>예매 후에는 반드시 예매확인을 통하여 예매내역을 확인해 주시기 바랍니다.</li>
						<li>발권 후 취소는 현장 방문하시어 매표소에 문의하신 후 취소하셔야 합니다.</li>
					</ul>
					
					<h2>환불 안내</h2>
					
					<p class="txtColorType08 mgt10">[발권 전]</p>
					
					<ul class="listTypeDot">
						<li>유효기간 내 : 100% 환불</li>
						<li>유효기간 후 : 100%(자동취소)</li>
					</ul>
					
					<p class="txtColorType08 mgt10">[발권 후]</p>
					
					<ul class="listTypeDot">
						<li>당일 발권 후 당일&nbsp;환불요청 시 :&nbsp;100% 환불</li>
						<li>당일 발권 후 익일 이후 환불요청 시 :&nbsp;환불불가</li>
					</ul>
					</div>
					
						</div>
							
						
					
				</div>

			
			</div>
		</div>
	</div>
</section>

<!-- Footer Bottom -->
<jsp:include page="../include/footer.jsp" />

<jsp:include page="../include/jsimport.jsp" />

</body>

</html>