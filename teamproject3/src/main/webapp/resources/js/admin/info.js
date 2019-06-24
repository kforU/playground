$(document).ready(function(e){
	getProfileImage();
	getMemberList(1);
	getReservationList(1);
	getQuestionList(1);
	
	getCountForMemberList();
	getCountForReservationList();
//	getCountForProductList();
	getCountForQuestionList();

});

/* ========================================= 모든 멤버 가져오기 =============================================== */

var searchOptionForMemberList = "all";
var searchValueForMemberList = "";

function getMemberList(page) {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/getMemberList" + 
				"?page=" + page + 
				"&searchOption=" + searchOptionForMemberList + 
				"&searchValue=" + searchValueForMemberList,
		dataType: "json",
		cache: false,
		success: function(resp) {
			var members = resp.members;
			var pagination = resp.pagination;
			renderMemberList(members);
			renderPagination("#paginationForMemberList", "getMemberList", pagination);
		},
		error: function(err){
			console.log(err);
		}
	});
	
}

function renderMemberList(memList) {
	
	var content = "";
	
	for (var i = 0; i < memList.length; i++) {
		
		content += '<tr>';
		content += 		'<td class="text-center">';
		content +=			memList[i].name;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			memList[i].email;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			new Date(memList[i].regDate).toLocaleDateString();
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		
		if (memList[i].active) {
			content += '<span style="color: green; font-size: 20px">';
			content += 		'<i class="fa fa-check-circle"></i>';
			content += '</span>&nbsp;';
			content += '<a href="javascript:inactivateMember(' + '&#39;' + memList[i].email + '&#39;' + ')">';
			content += 		'<span style="color: lightgrey; font-size: 20px">';
			content += 			'<i class="fa fa-times-circle"></i>';
			content += 		'</span>';
			content += '</a>';
		} else {
			content += '<a href="javascript:activateMember(' + '&#39;' + memList[i].email + '&#39;' + ')">';
			content += 		'<span style="color: lightgrey; font-size: 20px">';
			content += 			'<i class="fa fa-check-circle"></i>';
			content += 		'</span>';
			content += '</a>&nbsp;';
			content += '<span style="color: red; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
		}
							
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		
		if (!memList[i].deleted) {
			content += '<span style="color: green; font-size: 20px"><i class="fa fa-check-circle"></i></span>&nbsp;';
			content += '<a href="javascript:deleteMember(' + '&#39;' + memList[i].email + '&#39;' + ')">';
			content += 		'<span style="color: lightgrey; font-size: 20px">';
			content += 			'<i class="fa fa-times-circle"></i>';
			content += 		'</span>';
			content += '</a>';
		} else {
			content += '<a href="javascript:recoverMember(' + '&#39;' + memList[i].email + '&#39;' + ')">';
			content += 		'<span style="color: lightgrey; font-size: 20px">';
			content += 			'<i class="fa fa-check-circle"></i>';
			content += 		'</span>';
			content += '</a>&nbsp;';
			content += '<span style="color: red; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
		}

		content +=		'</td>';
		
		content += '</tr>';
		
	}
	
	$("#memberListArray").html(content);
	
}

$("#searchButtonForMemberList").on("click", function(e){
	e.preventDefault();
	searchOptionForMemberList = $("#searchOptionForMemberList").val();
	searchValueForMemberList = $("#searchValueForMemberList").val();
	getMemberList(1);
});

/* ========================================= 계정 삭제 & 비활성화 =============================================== */

function activateMember(email) {
	if (!confirm("[" + email + "] : 해당 계정을 활성화 하시겠습니까?")) return;
	doActivateMember(email);
}

function inactivateMember(email) {
	if (!confirm("[" + email + "] : 해당 계정을 비활성화 하시겠습니까?")) return;
	doInactivateMember(email);
}

function deleteMember(email) {
	if (!confirm("[" + email + "] : 해당 계정을 탈퇴 처리하시겠습니까?")) return;
	doDeleteMember(email);
}

function recoverMember(email) {
	if (!confirm("[" + email + "] : 해당 계정을 복구하시겠습니까?")) return;
	doRecoverMember(email);
}

function doActivateMember(email) {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/activate?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success'){
				alert("[" + email + "] : 활성화 되었습니다.");
				getMemberList(1);
			} else {
				alert("실패");
			}
		}, error: function(err) {
			alert("통신 실패");
		}
	});
}

function doInactivateMember(email) {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/inactivate?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success') {
				alert("[" + email + "] : 비활성화 되었습니다.");
				getMemberList(1);
			} else {
				alert("실패");
			}
		}, error: function(err) {
			alert("통신 실패");
		}
	});
}

function doDeleteMember(email) {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/delete?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success') {
				alert("[" + email + "] : 탈퇴 처리되었습니다.");
				getMemberList(1);
			} else {
				alert("실패");
			}
		}, error: function(err) {
			alert("통신 실패");
		}
	});
}

function doRecoverMember(email) {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/recover?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success') {
				alert("[" + email + "] : 계정을 복구했습니다.");
				getMemberList(1);
			} else {
				alert("실패");
			}
		}, error: function(err) {
			alert("통신 실패");
		}
	});
}

/* ========================================= 질문&답변 리스트 가져오기 =============================================== */

var searchOptionForQuestion = 'all';
var searchValueForQuestion = '';
var completedForQuestionList = 'all';

function getQuestionList(page) {
	
	var contextPath = $("#contextPath").val();
	
	$.ajax({
		type: "get",
		url: contextPath + "/admin/getQuestionList?page=" + 
							page + "&searchOption=" + searchOptionForQuestion + 
							"&searchValue=" + searchValueForQuestion + 
							"&completed=" + completedForQuestionList,
		cache: false,
		dataType: "json",
		success: function(resp) {
			var questionList = resp.questions;
			var pagination = resp.pagination;
			renderQuestionList(questionList);
			renderPagination("#paginationForQuestionList", "getQuestionList", pagination);
		}
		
	});
	
}

function renderQuestionList(questionList) {
	
	var content = "";
	
	for (var i = 0; i < questionList.length; i++) {
		
		content += '<tr>';
		content += 		'<td class="text-center">';
		content +=			questionList[i].qnaNo;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			questionList[i].qnaCategory;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			questionList[i].email;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content += 			new Date(questionList[i].regDate).toLocaleDateString();
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		
		if (questionList[i].completed) {
			content += '<span style="color: blue">';
			content += 		'처리됨';
			content += '</span>';
		} else {
			content += '<span style="color: red">';
			content += 		'미처리&nbsp;<a href="javascript:showAnswerModal(';
			content += 			'&#39;' + questionList[i].qnaNo + '&#39;&#44; ';
			content += 			'&#39;' + questionList[i].email + '&#39;&#44; ';
			content += 			'&#39;' + questionList[i].qnaCategory + '&#39;&#44; ';
			content += 			'&#39;' + new Date(questionList[i].regDate).toLocaleDateString() + '&#39;&#44; ';
			content += 			'&#39;' + questionList[i].qnaContent + '&#39;';
			content += 			')"><i class="fa fa-pencil"></i></a>';
			content += '</span>';
		}
		
		content += '</tr>';
		
	}
	
	$("#questionListArray").html(content);
	
}

function showAnswerModal(qnaNo, qnaEmail, qnaCategory, qnaDate, qnaContent) {
	$("#answerModal #qnaNo").text(qnaNo);
	$("#answerModal #qnaEmail").text(qnaEmail);
	$("#answerModal #qnaCategory").text(qnaCategory);
	$("#answerModal #qnaDate").text(qnaDate);
	$("#answerModal #qnaContent").html(qnaContent);
	$("#answerModal").modal("show");
}

$("#answerSubmitButton").on("click", function(e){
	e.preventDefault();
	submitAnswer();
});

function submitAnswer() {
	
	if (!confirm("한 번 답변을 등록하면 수정할 수 없습니다. 진행하시겠습니까?")) return;
	
	var qnaNo = $("#answerModal #qnaNo").text();
	var text = $("#answerModal #answerText").val();
	
	var sendData = {
			"qnaNo": qnaNo,
			"answerText": text
	}
	
	$.ajax({
		type: "post",
		url: $("#contextPath").val() + "/admin/answer",
		contentType: "application/json;charset=UTF-8",
		dataType: "text",
		data: JSON.stringify(sendData),
		success: function(resp) {
			if (resp === 'success'){
				alert("답변 성공!");
				// 모달을 닫고
				$("#answerModal").modal("toggle");
				// 질문과 답변 refresh.
				getQuestionList(1);
			} else {
				alert("실패...");
			}
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

$("#searchButtonForQuestionList").on("click", function(e){
	e.preventDefault();
	searchOptionForQuestion = $("#searchOptionForQuestionList").val();
	searchValueForQuestion = $("#searchValueForQuestionList").val();
	completedForQuestionList = $("#completedForQuestionList").val();
	getQuestionList(1);
});

/* ========================================= 예약 현황 가져오기 =============================================== */

var searchOptionForReservation = 'all';
var searchValueForReservation = '';
var allTickets;

function getReservationList(page) {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/getReservationList" + 
			"?page=" + page + 
			"&searchOption=" + searchOptionForReservation + 
			"&searchValue=" + searchValueForReservation,
		processData: false,
		dataType: "json",
		success: function(resp) {
			var reservationList = resp.reservationList;
			var pagination = resp.pagination;
			
			allTickets = resp.tickets;
			
			renderReservationList(reservationList);
			renderPagination("#paginationForReservationList", "getReservationList", pagination);
		},
		error: function(err) {
			console.log(err.status);
		}
	});
	
}

function renderReservationList(list) {
	
	var content = "";
	
	for (var i = 0; i < list.length; i++) {
		
		content += '<tr>';
		content += 		'<td class="text-center">';
		content +=			list[i].ticketOrderNo;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			list[i].email;
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			new Date(list[i].ticketOrderDate).toLocaleDateString();
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
		content +=			'<a href="javascript:showTicketDetailModal('
		content += 				'&#39;' + list[i].ticketOrderNo + '&#39;, '		
		content += 				'&#39;' + new Date(list[i].ticketOrderDate).toLocaleDateString() + '&#39;, '		
		content += 				'&#39;' + new Date(list[i].ticketOrderUseDate).toLocaleDateString() + '&#39;, '		
		content += 				'&#39;' + list[i].ticketOrderCount + '&#39;, '		
		content += 				'&#39;' + list[i].email + '&#39;, '
		content += 				'&#39;' + list[i].ticketNo + '&#39;'
		content += 			')"><span style="font-size: 20px; color: blue">';
		content +=				'<i class="fa fa-info-circle"></i>';
		content +=			'</span></a>';
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
			if (list[i].expired) {
				content += '<span style="color: lightgrey; font-size: 20px">';
				content += 		'<i class="fa fa-check-circle"></i>';
				content += '</span>&nbsp;';
				
				content += '<span style="color: red; font-size: 20px">';
				content += 		'<i class="fa fa-times-circle"></i>';
				content += '</span>';
			} else {
				content += 	'<span style="color: green; font-size: 20px">';
				content += 		'<i class="fa fa-check-circle"></i>';
				content += 	'</span>&nbsp;';
				
				content += '<span style="color: lightgrey; font-size: 20px">';
				content += 		'<i class="fa fa-times-circle"></i>';
				content += '</span>';
			}
		content +=		'</td>';
		
		content += 		'<td class="text-center">';
			if (list[i].approval) {
				content += '<span style="color: green; font-size: 20px">';
				content += 		'<i class="fa fa-check-circle"></i>';
				content += '</span>&nbsp;';
				
				content += '<span style="color: lightgrey; font-size: 20px">';
				content += 		'<i class="fa fa-times-circle"></i>';
				content += '</span>';
			} else {
				content += '<a href="javascript:approveTicket(' + '&#39;' + list[i].ticketOrderNo + '&#39;' + ')">';
				content += 		'<span style="color: lightgrey; font-size: 20px">';
				content += 			'<i class="fa fa-check-circle"></i>';
				content += 		'</span>';
				content += '</a>&nbsp;';
				
				content += '<span style="color: red; font-size: 20px">';
				content += 		'<i class="fa fa-times-circle"></i>';
				content += '</span>';
			}
	content +=		'</td>';
		
		content += '</tr>';
		
	}
	
	$("#reservationListArray").html(content);
	
}

$("#searchButtonForReservation").on("click", function(e){
	e.preventDefault();
	searchOptionForReservation = $("#searchOptionForReservation").val();
	searchValueForReservation = $("#searchValueForReservation").val();
	getReservationList(1);
});

// 승인 처리하는 함수
function approveTicket(ticketOrderNo) {
	if (!confirm("승인 처리하시겠습니까? 한 번 승인하면 취소할 수 없습니다.")) return;
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/approveTicket?ticketOrderNo=" + ticketOrderNo,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success') {
				alert("승인처리되었습니다.");
				getReservationList(1);
			} else {
				alert("실패...");
			}
		},
		error: function(err) {
			console.log(err);
		}
	});
}

// 티켓 상세 페이지 표시 함수
function showTicketDetailModal(ticketOrderNo, date, useDate, count, email, ticketNo) {
	$("#ticketOrderDetailModal #ticketOrderNo").text(ticketOrderNo);
	$("#ticketOrderDetailModal #ticketOrderDate").text(date);
	$("#ticketOrderDetailModal #ticketOrderUseDate").text(useDate);
	$("#ticketOrderDetailModal #ticketAmount").text(count);
	$("#ticketOrderDetailModal #ticketEmail").text(email);
	
	$(allTickets).each(function(idx, item){
		if (item.ticketNo == ticketNo) {
			$("#ticketOrderDetailModal #ticketName").text(item.ticketName);
		}
	});
	
	$("#ticketOrderDetailModal").modal("show");
}

/* ========================================= 회원 수를 가져옴 =============================================== */

function getCountForMemberList() {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/getCountForMemberList",
		dataType: "text",
		success: function(resp) {
			$("#memberCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

/* ========================================= 예약 수를 가져옴 =============================================== */

function getCountForReservationList() {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/getCountForReservationList",
		dataType: "text",
		success: function(resp) {
			$("#reservationCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

/* ========================================= 상품 승인 요청 수를 가져옴 =============================================== */

function getCoutnProductList() {
	// do somethig...
}

/* ========================================= 질문 수를 가져옴 =============================================== */

function getCountForQuestionList() {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/admin/getCountForQuestionList",
		dataType: "text",
		success: function(resp) {
			$("#questionCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

/* ========================================= 동적 메뉴 변경 =============================================== */

// #showProfileButton => 프로필 페이지를 표시하는 버튼 (Default display: none)
// #showTikectReservationButton => 티켓 예약 현황 페이지를 표시하는 버튼
// #showQuestionButton => 사용자가 등록한 질문 페이지를 표시하는 버튼

var memberList = $("#memberList"); // 프로필 페이지
var ticketReservation = $("#ticketReservation"); // 티켓 예매 현황 페이지
var question = $("#question"); // 질문 현황 페이지

// 멤버 리스트 보이기 버튼을 클릭하면 해당 페이지를 display: initial로 변경하고 나머지는 display: none으로 변경한다.
$("#showMemberListButton").on("click", function(e){
	e.preventDefault();
	// 해당 페이지를 표시함
	showPage($(memberList));
	// 해당 페이지를 보이게 한 버튼을 활성화 시킴
	activateButton($(this));
});

$("#showTicketReservationButton").on("click", function(e){
	e.preventDefault();
	showPage($(ticketReservation))
	activateButton($(this));
});

$("#showQuestionButton").on("click", function(e){
	e.preventDefault();
	showPage($(question))
	activateButton($(this));
});

function showPage(page) {
	hideAll();
	page.css("display", "initial");
}

//모든 페이지를 숨김
function hideAll() {
	$(memberList).css("display", "none");
	$(ticketReservation).css("display", "none");
	$(question).css("display", "none");
}

// 해당 버튼을 활성화
function activateButton(button) {
	inactiveAll();
	button.parent().attr("class", "active");
}

// 모든 버튼을 비활성화
function inactiveAll() {
	$("#showMemberListButton").parent().removeAttr("class");
	$("#showTicketReservationButton").parent().removeAttr("class");
	$("#showQuestionButton").parent().removeAttr("class");
}

/* ========================================= 프로필 이미지 가져오기 =============================================== */

function getProfileImage() {
	
	var contextPath = $("#contextPath").val();
	var email = $("#email").val();
	
	$.ajax({
		type: "get",
		url: contextPath + "/member/getProfileImage?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'email_cannot_be_null'){
				alert("프로필 이미지 취득 실패");
			} else {
				renderProfileImage(resp);
			}
				
		},
		error: function(err) {
			alert("프로필 이미지 취득 실패");
		}
	});
	
}

// 기본 프로필 이미지를 렌더링합니다.
function renderDefaultProfileImage() {
	var content = '';
	content += '<img id="profileImage" src="' + $("#contextPath").val() + '/resources/images/user/anonymous-user.png"';
	content += 		'alt="" class="rounded-circle" />';
	
	$("#profileImageDiv").html(content);
}

// 사용자 프로필 이미지를 렌더링합니다.
function renderProfileImage(profileImage) {
	var content = '';
	
	if (profileImage === null || profileImage.length === 0) {
		content += '<img id="profileImage" src="' + $("#contextPath").val() + '/resources/images/user/anonymous-user.png"';
		content += 		'alt="" class="rounded-circle" />';
	} else {
		content += '<img id="profileImage" src="' + $("#contextPath").val() + '/resources/images/user/profile/' + profileImage + '"';
		content += 		'alt="" class="rounded-circle" />';
	}
	
	$("#profileImageDiv").html(content);
}

/* ========================================= 프로필 이미지 수정 =============================================== */

// #profileImage => 프로필 이미지 <img> 태그
// #profileImageFile => 프로필 이미지 등록을 위한 <input type="file"> 태그

var profileImageFlag = false;

// 프로필 이미지를 클릭하면 input[type=file] 창이 뜨게 하는 이벤트 리스너 등록
$(document).on("click", "#profileImage", function(e){
	
	// 이미 전송중이면 막음.
	if (profileImageFlag) return;
	e.preventDefault();
	$("#profileImageFile").trigger("click");
});

// 프로필 사진이 등록되면 이를 감지하여 프로필 사진을 전송
$("#profileImageFile").on("change", function(e){
	e.preventDefault();
	submitProfileImage();
});

// 프로필 이미지를 ajax로 전송
// jpg, jpeg, png, gif, bmp포맷만 등록이 가능하도록 제한해야 한다.
function submitProfileImage(){

	// 중복 전송 안되게 버튼 비활성화
	profileImageFlag = true;
	
	var contextPath = $("#contextPath").val();
	var profileImageFile = document.querySelector("#profileImageFile").files[0];
	var email = $("#email").val();
	var formData = new FormData();
	formData.append("profileImageFile", profileImageFile);
	formData.append("email", email);
	$.ajax({
		type: "post",
		url: contextPath + "/member/uploadProfileImage",
		contentType: false,
		dataType: "text",
		processData: false,
		data: formData,
		success: function(resp){
			if (resp === 'success') {
				alert("프로필 이미지 업로드 성공");
				getProfileImage();
			} else if (resp === 'format_not_accept') {
				alert("이미지 파일만 업로드 가능합니다.");
			} else {
				alert("프로필 이미지 업로드에 실패했습니다.");
			}
			
			// 버튼 활성화
			profileImageFlag = false;
			
		}, error:function(resp){
			alert("통신 실패...");
			
			// 버튼 활성화
			profileImageFlag = false;
		}
	});
}

/* ========================================= 로그아웃 처리 =============================================== */

$("#logoutButton").on("click", function(e){
	var contextPath = $("#contextPath").val();
	e.preventDefault();
	if (confirm("로그아웃하시겠습니까?")){
		location.href = contextPath + "/member/logout";
	}
});

/* ========================================= 탈퇴 처리 =============================================== */

$("#delete").on("click", function(e){
	e.preventDefault();
	if (confirm("정말 탈퇴하시게요?")){
		deleteMember_();
	}
});

function deleteMember_(){
	alert("관리자 계정은 삭제할 수 없습니다.");
}

/* ========================================= pagination 생성 함수 =============================================== */
// copyTo : 페이지네이션을 어디에 붙일지 지정 ex) '#textArea'
// callback : 버튼을 누르면 무슨 함수가 실행될지 지정 ex) 'getMemberList'
// pagination : 페이징 객체
function renderPagination(copyTo, callback, pagination) {
	
	let nav = document.createElement("nav");
	
	let ul = document.createElement("ul");
	$(ul).attr("class", "pagination justify-content-center");
	
	if (pagination.block != 1) {
		let li = document.createElement("li");
		$(li).attr("class", "page-item");
		
		let a = document.createElement("a");
		$(a).attr("class", "page-link");
		$(a).attr("href", "javascript:" + callback + "(" + pagination.prevBlock + ")");
		$(a).attr("aria-label", "Next");
		
		let span = document.createElement("span");
		$(span).attr("aria-hidden", "true");
		 
		let i = document.createElement("i");
		$(i).attr("class", "fa fa-angle-left");
		
		span.append(i);
		a.append(span);
		li.append(a);
		ul.append(li);
	}
	
	for (var i = pagination.blockBegin; i <= pagination.blockEnd; i++) {
		if (pagination.page == i) {
			let li = document.createElement("li");
			$(li).attr("class", "page-item active");

			let a = document.createElement("a");
			$(a).attr("class", "page-link");
			$(a).attr("href", "#");
			$(a).text(i);
			
			li.append(a);
			ul.append(li);
		} else {
			let li = document.createElement("li");
			$(li).attr("class", "page-item");
			
			let a = document.createElement("a");
			$(a).attr("class", "page-link");
			$(a).attr("href", "javascript:" + callback + "(" + i + ")");
			$(a).text(i);
			
			li.append(a);
			ul.append(li);
		}
	}
	
	if (pagination.block !== pagination.totBlock) {
		let li = document.createElement("li");
		$(li).attr("class", "page-item");
		
		let a = document.createElement("a");
		$(a).attr("class", "page-link");
		$(a).attr("href", "javascript:" + callback + "(" + pagination.nextBlock + ")");
		
		let span = document.createElement("span");
		$(span).attr("aria-hidden", "true");
		
		let i = document.createElement("i");
		$(i).attr("class", "fa fa-angle-right");
		
		span.append(i);
		a.append(span);
		li.append(a);
		ul.append(li);
	}
	
	nav.append(ul);
	
	$(copyTo).html(ul);
}
