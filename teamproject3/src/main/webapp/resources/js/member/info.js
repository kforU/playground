$(document).ready(function(e){
	getProfileImage();
	getQuestionList(1);
	getProductList(1);
	getReservationList(1);
	
	getAllProducts();
	getCountForReservationList();
	getCountForQuestionList();
	getCountForProductList();
});

/* ========================================= 동적 메뉴 변경 =============================================== */

// #showProfileButton => 프로필 페이지를 표시하는 버튼 (Default display: none)
// #showTikectReservationButton => 티켓 예약 현황 페이지를 표시하는 버튼
// #showQuestionButton => 사용자가 등록한 질문 페이지를 표시하는 버튼

var profile = $("#profile"); // 프로필 페이지
var ticketReservation = $("#ticketReservation"); // 티켓 예매 현황 페이지
var productList = $("#productList");
var question = $("#question"); // 질문 현황 페이지

// 프로필 이미지 보이기 버튼을 클릭하면 프로필 페이지를 display: initial로 변경하고 나머지는 display: none으로 변경한다.
$("#showProfileButton").on("click", function(e){
	e.preventDefault();
	// 해당 페이지를 표시함
	showPage($(profile));
	// 해당 페이지를 보이게 한 버튼을 활성화 시킴
	activateButton($(this));
});

$("#showTicketReservationButton").on("click", function(e){
	e.preventDefault();
	showPage($(ticketReservation))
	activateButton($(this));
});

$("#showProductListButton").on("click", function(e){
	e.preventDefault();
	showPage($(productList));
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
	$(profile).css("display", "none");
	$(ticketReservation).css("display", "none");
	$(productList).css("display", "none");
	$(question).css("display", "none");
}

// 해당 버튼을 활성화
function activateButton(button) {
	inactiveAll();
	button.parent().attr("class", "active");
}

// 모든 버튼을 비활성화
function inactiveAll() {
	$("#showProfileButton").parent().removeAttr("class");
	$("#showTicketReservationButton").parent().removeAttr("class");
	$("#showProductListButton").parent().removeAttr("class");
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

/* ========================================= 비밀번호 변경 =============================================== */

$("#passwordChangeButton").on("click", function(e){
	e.preventDefault();
	changePassword();
});

function changePassword() {
	
	if (!confirm("정말 변경하시겠습니까?"))
		return;
	
	var email = $("#email").val();
	
	var currentPassword = $("#current-password").val();
	var newPassword = $("#new-password").val();
	var confirmPassword = $("#confirm-password").val();
	
	if (currentPassword.length === 0 ||
		newPassword.length === 0 || 
		confirmPassword. length === 0){
		alert("비밀번호를 입력해 주세요");
		return;
	}
	
	var sendData = {
			"email": email,
			"passwd": currentPassword,
			"newPassword": newPassword,
			"confirmPassword": confirmPassword
	}
	
	console.log(sendData);
	
	$.ajax({
		type: "post",
		url: $("#contextPath").val() + "/member/changePassword",
		contentType: "application/json;charset=UTF-8",
		processData: false,
		dataType: "text",
		data: JSON.stringify(sendData),
		success: function(resp) {
			if (resp === 'success') {
				alert("비밀번호를 변경했습니다. 다시 로그인 해주세요.");
				location.href = $("#contextPath").val() + "/member/logout";
			} else if (resp === 'authentication_failed') {
				alert("기존 비밀번호가 일치하지 않습니다.");
				return;
			} else if (resp === 'password_not_match') {
				alert("새 비밀번호가 일치하지 않습니다.");
				return;
			}
		},
		error: function(err) {
			console.log(err);
		}
	});
}

/* ========================================= 이름 변경 =============================================== */

$("#nameChangeButton").on("click", function(e){
	e.preventDefault();
	changeName();
});

function changeName() {
	
	var name = $("#name").val();
	var email = $("#email").val();
	var passwd = $("#passwd").val();
	
	if (!confirm("[" + name + "] 으로 변경하시겠습니까?")) return;
	
	var sendData = {
			"email": email,
			"name": name,
			"passwd": passwd
	}
	
	$.ajax({
		type: "post",
		url: $("#contextPath").val() + "/member/changeName",
		contentType: "application/json;charset=UTF-8",
		dataType: "text",
		processData: false,
		data: JSON.stringify(sendData),
		success: function(resp) {
			if (resp === 'success') {
				alert("이름을 변경했습니다.");
				return;
			} else {
				alert("실패");
			}
		}, error: function(err) {
			console.log(err);
		}
	});
}

/* ========================================= 로그아웃 처리 =============================================== */

$("#logoutButton").on("click", function(e){
	e.preventDefault();
	if (!confirm("로그아웃 하시겠습니까?")) return;
	location.href = $("#contextPath").val() + "/member/logout";
});

/* ========================================= 탈퇴 처리 =============================================== */

$("#delete").on("click", function(e){
	e.preventDefault();
	if (confirm("정말 탈퇴하시게요?")){
		deleteMember();
	}
});

function deleteMember(){
var email = $("#email").val();
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/delete?email=" + email,
		dataType: "text",
		success: function(resp) {
			if (resp === 'success'){
				alert("탈퇴처리되었습니다.");
				location.href = $("#contextPath").val() + "/member/logout";
			} else {
				alert("실패...")
			}
		},
		error: function(err) {
			console.log(err);
		}
	});
}

/* ========================================= 나의 qna가져오기 =============================================== */

var searchOptionForQuestionList = "all";
var searchValueForQuestionList = "";

function getQuestionList(page) {
	
	var email = $("#email").val();
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/getQuestionList?page="
			+ page + "&searchOption=" + searchOptionForQuestionList
			+ "&searchValue=" + searchValueForQuestionList
			+ "&email=" + email,
		dataType: "json",
		success: function(resp) {
			
			var questions = resp.questions;
			var pagination = resp.pagination;
			
			renderQuestionList(questions);
			renderPaginationForQuestionList(pagination);
			
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

function renderQuestionList(list) {
	
	var content = '';
	
	for (var i = 0; i < list.length; i++) {
		content += '<tr>';
		
		content += 		'<td class="text-center">';
		content += 			list[i].qnaNo;
		content += 		'</td>';
		
		content += 		'<td class="text-center">';
		content += 			list[i].qnaCategory;
		content += 		'</td>';
		
		content += 		'<td class="text-center">';
		content += 			'<a href="javascript:showQuestionContent(';
		content += 				 '&#39;' + list[i].qnaContent + '&#39;)">';
		content += 				'문의 내용 보기</a>';
		content += 		'</td>';
		
		content += 		'<td class="text-center">';
		content += 			new Date(list[i].regDate).toLocaleDateString();
		content += 		'</td>';
		
		content += 		'<td class="text-center">';
		if (list[i].completed) {
			content += '<a href="javascript:showQuestionContent(';
			content += 		'&#39;' + list[i].qnaAnswer + '&#39;)">';
			content += 			'<span style="color: blue">답변완료</span>';
		}
		else
			content += '<span style="color: red">답변대기</span>';
		content += 		'</td>';
		
		content += '</tr>';
	}
	
	$("#myQuestionList").html(content);
}

function renderPaginationForQuestionList(pagination) {
	
	var content = '';
	
	if (pagination.block !== 1) {
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getQuestionList(' + '&#39;' + pagination.prevBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-left"></i></span>';
		content += 		'</a>';
		content += '</li>';
	}
	
	for (var i = pagination.blockBegin; i <= pagination.blockEnd; i++) {
		
		if (pagination.page === i){
			content += '<li class="page-item active">';
			content += 		'<a class="page-link" href="#">' + i + '</a>';
			content += '</li>';
		} else {
			content += '<li class="page-item">';
			content += 		'<a class="page-link" href="javascript:getQuestionList(' + '&#39;' + i + '&#39;' + ')">';
			content += 			i;
			content += 		'</a>'
			content += '</li>';
		}
	}
	
	if (pagination.block !== pagination.totBlock){
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getQuestionList(' + '&#39;' + pagination.nextBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-right"></i></span>';
		content += 		'</a>'
		content += '</li>';
	}
	
	$("#paginationForQuestionList").html(content);
	
}

$("#searchButtonForQuestionList").on("click", function(e){
	e.preventDefault();
	searchOptionForQuestionList = $("#searchOptionForQuestionList").val();
	searchValueForQuestionList = $("#searchValueForQuestionList").val();
	getQuestionList(1);
});

function showQuestionContent(content) {
	$("#questionContent").html(content);
	$("#questionContentModal").modal("show");
}

function showAnswerContenxt(content) {
	$("#answerContent").html(content);
	$("#answerContentModal").modal("show");
}

/* ========================================= 상품 구매 내역 가져오기 =============================================== */

// 등록된 상품 테이블을 캐싱한다
var products;
function getAllProducts() {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/product/getAllProducts",
		dataType: "json",
		success: function(resp) {
			products = resp.products;
		},
		error: function(err) {
			console.log(err);
		}
	});
}

var approvalForProductList = "all";

function getProductList(page) {
	
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/product/getProductList?page=" + page + 
			"&approved=" + approvalForProductList +
			"&email=" + $("#email").val(),
		dataType: "json",
		success: function(resp) {
			var productOrderList = resp.productOrderList;
			var pagination = resp.pagination;

			renderProductOrderList(productOrderList);
			renderPaginationForProductOrderList(pagination);
		},
		error: function(err) {
			console.log(err);
		}
	});
	
}

function renderProductOrderList(list) {
	
	var content = '';
	
	for (var i = 0; i < list.length; i++) {
		content += '<tr>';
		
		content += '<td class="text-center">';
		content += 		list[i].productOrderNo
		content += '</td>';
		
		content += '<td class="text-center">';
		content += 		list[i].productOrderCount
		content += '</td>';
		
		content += '<td class="text-center">';
		content += 		list[i].email;
		content += '</td>';
		
		content += '<td class="text-center">';
		$(products).each(function(idx, item) {
			if (item.productNo == list[i].productNo)
				content += item.productName;
		});
		content += '</td>';
		
		content += '<td class="text-center">';

			if (list[i].approval) {
				content += '<span style="color: green; font-size: 20px"><i class="fa fa-check-circle"></i></span>';
				content += '&nbsp;<span style="color: lightgrey; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
			} else {
				content += '<span style="color: lightgrey; font-size: 20px"><i class="fa fa-check-circle"></i></span>';
				content += '&nbsp;<span style="color: red; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
			}
		
		content += '</td>';
		
		content += '</tr>';
	}
	
	$("#productListArray").html(content);
	
}

function renderPaginationForProductOrderList(pagination) {
	
	var content = '';
	
	if (pagination.block !== 1) {
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getProductList(' + '&#39;' + pagination.prevBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-left"></i></span>';
		content += 		'</a>';
		content += '</li>';
	}
	
	for (var i = pagination.blockBegin; i <= pagination.blockEnd; i++) {
		
		if (pagination.page === i){
			content += '<li class="page-item active">';
			content += 		'<a class="page-link" href="#">' + i + '</a>';
			content += '</li>';
		} else {
			content += '<li class="page-item">';
			content += 		'<a class="page-link" href="javascript:getProductList(' + '&#39;' + i + '&#39;' + ')">';
			content += 			i;
			content += 		'</a>'
			content += '</li>';
		}
	}
	
	if (pagination.block !== pagination.totBlock){
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getProductList(' + '&#39;' + pagination.nextBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-right"></i></span>';
		content += 		'</a>'
		content += '</li>';
	}

	$("#paginationForProductOrderList").html(content);
	
}

/* ========================================= 나의 티켓 예약 현황 가져오기 =============================================== */

var searchOptionForReservation = 'all';
var searchValueForReservation = '';
var allTickets;

function getReservationList(page) {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/getReservationList" + 
			"?page=" + page + 
			"&searchOption=" + searchOptionForReservation + 
			"&searchValue=" + searchValueForReservation +
			"&email=" + $("#email").val(),
		dataType: "json",
		success: function(resp) {
			var reservationList = resp.reservationList;
			var pagination = resp.pagination;
			allTickets = resp.tickets;

			renderReservationList(reservationList);
			renderPagination(pagination);
		}
	});
}

function renderReservationList(list) {
	var content = '';
	
	for (var i = 0; i < list.length; i++) {
		content += '<tr>';
		content += '<td class="text-center">';
		content += 		list[i].ticketOrderNo;
		content += '</td>';
		
		content += '<td class="text-center">';

		$(allTickets).each(function(idx, item) {
			if (item.ticketNo == list[i].ticketNo)
				content += item.ticketName;
		})
		
		content += '</td>';
		
		content += '<td class="text-center">';
		content += 		new Date(list[i].ticketOrderDate).toLocaleDateString();
		content += '</td>';
		
		content += '<td class="text-center">';
		content += 		list[i].ticketOrderCount;
		content += '</td>';
		
		content += '<td class="text-center">';
		if (list[i].approval) {
			content += '<span style="color: green; font-size: 20px"><i class="fa fa-check-circle"></i></span>&nbsp;';
			content += '<span style="color: lightgrey; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
		} else {
			content += '<span style="color: lightgrey; font-size: 20px"><i class="fa fa-check-circle"></i></span>&nbsp;';
			content += '<span style="color: red; font-size: 20px"><i class="fa fa-times-circle"></i></span>';
		}
		content += '</td>';
		content += '</tr>';
	}
	
	$("#reservationListArray").html(content);
}

function renderPagination(pagination) {
	
	var content = '';
	
	if (pagination.block !== 1) {
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getReservationList(' + '&#39;' + pagination.prevBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-left"></i></span>';
		content += 		'</a>';
		content += '</li>';
	}
	
	for (var i = pagination.blockBegin; i <= pagination.blockEnd; i++) {
		
		if (pagination.page === i){
			content += '<li class="page-item active">';
			content += 		'<a class="page-link" href="#">' + i + '</a>';
			content += '</li>';
		} else {
			content += '<li class="page-item">';
			content += 		'<a class="page-link" href="javascript:getReservationList(' + '&#39;' + i + '&#39;' + ')">';
			content += 			i;
			content += 		'</a>'
			content += '</li>';
		}
	}
	
	if (pagination.block !== pagination.totBlock){
		content += '<li class="page-item">'
		content += 		'<a class="page-link" href="javascript:getReservationList(' + '&#39;' + pagination.nextBlock + '&#39;' + ')" aria-label="Next">';
		content += 			'<span aria-hidden="true"><i class="fa fa-angle-right"></i></span>';
		content += 		'</a>'
		content += '</li>';
	}
	
	$("#paginationForReservation").html(content);
	
}

/* ========================================= 총 예약 수 가져옴 =============================================== */

function getCountForReservationList() {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/getCountForReservationList?email=" + $("#email").val(),
		dataType: "text",
		success: function(resp) {
			$("#reservationCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
}

/* ========================================= 총 질문 수 가져옴 =============================================== */

function getCountForQuestionList() {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/getCountForQuestionList?email=" + $("#email").val(),
		dataType: "text",
		success: function(resp) {
			$("#questionCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
}

/* ========================================= 총 상품 구매 내역 수 가져옴 =============================================== */

function getCountForProductList() {
	$.ajax({
		type: "get",
		url: $("#contextPath").val() + "/member/getCountForProductList?email=" + $("#email").val(),
		dataType: "text",
		success: function(resp) {
			$("#productCount").text(resp);
		},
		error: function(err) {
			console.log(err);
		}
	});
}

function dummy() {
	// do nothing...
}