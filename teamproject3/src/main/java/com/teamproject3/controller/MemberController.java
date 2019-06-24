package com.teamproject3.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject3.service.MemberService;
import com.teamproject3.service.QnAService;
import com.teamproject3.service.TicketOrderService;
import com.teamproject3.util.CountHelper;
import com.teamproject3.util.Pagination;
import com.teamproject3.vo.Member;
import com.teamproject3.vo.PageRequest;
import com.teamproject3.vo.QnA;
import com.teamproject3.vo.TicketOrder;
import com.teamproject3.vo.User;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject MemberService memberService;
	@Inject QnAService qnAService;
	@Inject TicketOrderService ticketOrderService;
	@Inject CountHelper countHelper;
	
	@RequestMapping(
			value="/login",
			method=RequestMethod.GET)
	public String login(HttpSession session) {
		session.invalidate();
		return "redirect:/member/loginView";
	}

	@RequestMapping(
			path="/loginView",
			method=RequestMethod.GET)
	public String loginView() {
		return "member/login";
	}
	
	@RequestMapping(
			value="/register",
			method=RequestMethod.GET)
	public String registerView() {
		return "member/register";
	}
	
	/*
	 * 회원 가입 처리 컨트롤러입니다.
	 */
	@RequestMapping(
			value="/register",
			method=RequestMethod.POST,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String register(
			Member member, 
			@RequestParam("confirmPasswd") String confirmPasswd) {
		
		// 비밀번호와 비밀번호 확인이 다르면 오류 문자열을 던짐
		if (!member.getPasswd().equals(confirmPasswd)) {
			return MemberService.WRONG_PASSWD;
		}
		
		// 회원 가입 처리후, 결과에 따라 다른 문자열 반환
		return memberService.registerMember(member);
	}
	
	// 회원 정보를 보기 위한 컨트롤러
	@RequestMapping(
			value="/info",
			method=RequestMethod.GET)
	public String infoView(Authentication auth) {		
		return "member/info";
	}
	
	// 프로필 사진을 가져오는 컨트롤러
	@RequestMapping(
			value="/getProfileImage",
			method=RequestMethod.GET,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getProfileImage(@RequestParam("email") String email) {
		return memberService.getProfileImage(email);
	}
	
	// 프로필 사진을 업로드하여 성공 여부를 문자열로 반환하는 Handler
	@RequestMapping(
			value="/uploadProfileImage",
			method=RequestMethod.POST,
			produces="text/plain;chasert=utf-8")
	@ResponseBody
	public String uploadProfileImage(
			@RequestParam("email") String email,
			@RequestPart("profileImageFile") MultipartFile profileImage) throws IOException {
		return memberService.uploadProfileImage(email, profileImage);
	}
	
	// 탈퇴 처리
	@RequestMapping(
			value="/delete",
			method=RequestMethod.GET,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String deleteMember(
			@RequestParam("email") String email,
			Authentication auth) {
		
		Member member = ((User)auth.getPrincipal()).getMember();
		if (!member.getRole().equals("ROLE_ADMIN") && !member.getEmail().equals(email)) {
			logger.debug("[{}] : 권한 없음 [{}]", email, member.getRole());
			return MemberService.FAILED;
		}
		
		return memberService.deleteMember(email);
	}
	
	// 계정 복구
	@RequestMapping(
			value="/recover",
			method=RequestMethod.GET,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String recoverMember(
			@RequestParam("email") String email, Authentication auth) {
		
		Member member = ((User)auth.getPrincipal()).getMember();
		if (!member.getRole().equals("ROLE_ADMIN") && !member.getEmail().equals(email)) {
			return MemberService.FAILED;
		}
		
		return memberService.recoverMember(email);
	}
	
	// 계정 비활성화
	@RequestMapping(
			value="/inactivate",
			method=RequestMethod.GET,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String inactiveMember(
			@RequestParam("email") String email, Authentication auth) {
		
		Member member = ((User)auth.getPrincipal()).getMember();
		if (!member.getRole().equals("ROLE_ADMIN") && !member.getEmail().equals(email)) {
			return MemberService.FAILED;
		}
		
		return memberService.inactivateMember(email);
	}
	
	// 계정 활성화
	@RequestMapping(
			value="/activate",
			method=RequestMethod.GET,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String activeMember(
			@RequestParam("email") String email, Authentication auth) {
		
		Member member = ((User)auth.getPrincipal()).getMember();
		if (!member.getRole().equals("ROLE_ADMIN") && !member.getEmail().equals(email)) {
			return MemberService.FAILED;
		}
		
		return memberService.activateMember(email);
	}
	
	// 비밀번호 변경
	@RequestMapping(
			value="/changePassword",
			consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
			produces="text/plain;charset=utf-8")
	@ResponseBody
	public String changePassword(@RequestBody String json) {
		return memberService.changePassword(json);
	}
	
	// 이름 변경
	@RequestMapping(
			value="/changeName",
			consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String changeName(@RequestBody String json) {
		return memberService.changeName(json);
	}
	
	// 사용자의 질문 리스트를 가져오는 컨트롤러
	@RequestMapping(
			value="/getQuestionList",
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getQuestionList(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="email") String email) {
		
		int count = memberService.countQuestionById(email);
		Pagination p = new Pagination(page, count, 10, 3);
		
		int start = p.getPageBegin();
		int end = p.getPageEnd();
		
		List<QnA> questions = qnAService.findAll(start, end, new PageRequest());
		// 해당 유저가 쓴 글만 필터링
		List<QnA> questionList = new ArrayList<>();
		for (QnA qna: questions) {
			if (email.equals(qna.getEmail()))
				questionList.add(qna);
		}
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("questions", questionList);
		resultMap.put("pagination", p);
		
		return resultMap;
	}
	
	// 티켓 예약 리스트를 가져오는 컨트롤러
	@RequestMapping(
			path="/getReservationList", 
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getReservationList(PageRequest pageRequest,
			@RequestParam(value="email") String email) {
		
		int count = ticketOrderService.count(pageRequest);
		
		Pagination p = new Pagination(pageRequest.getPage(), count, 10, 3);
		int start = p.getPageBegin();
		int end = p.getPageEnd();
		
		// 요청한 유저의 정보만 필터링
		List<TicketOrder> orders = ticketOrderService.findAll(start, end, pageRequest);
		List<TicketOrder> reservationList = new ArrayList<>();
		for (TicketOrder order: orders) {
			if (order.getEmail().equals(email))
				reservationList.add(order);
		}
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("reservationList", reservationList);
		resultMap.put("pagination", p.getResultAsMap());
		resultMap.put("tickets", ticketOrderService.findAllTicket());
		
		return resultMap;
	}
	
	// 티켓 예약 수를 가져옴
	@RequestMapping(
			path="/getCountForReservationList",
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForReservationList(@RequestParam("email") String email) {
		int count = countHelper.getCountForReservation(email);
		logger.debug("[{}]의 티켓 예약 수 : {}", email, count);
		return Integer.toString(count);
	}
	
	// 질문의 수를 가져옴
	@RequestMapping(
			path="/getCountForQuestionList",
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForQuestionList(@RequestParam("email") String email) {
		int count = countHelper.getCountForQuestionList(email);
		logger.debug("[{}]의 상품 질문 갯수 : {}", email, count);
		return Integer.toString(count);
	}
		
	// 상품 구매 내역의 수를 가져옴
	@RequestMapping(
			path="/getCountForProductList",
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForProductList(@RequestParam("email") String email) {
		int count = countHelper.getCountForProductList(email);
		logger.debug("[{}]의 구매 내역 수 : {}", email, count);
		return Integer.toString(count);
	}

}
