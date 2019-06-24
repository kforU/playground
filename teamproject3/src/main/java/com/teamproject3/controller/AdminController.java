package com.teamproject3.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject3.service.MemberService;
import com.teamproject3.service.QnAService;
import com.teamproject3.service.TicketOrderService;
import com.teamproject3.util.Pagination;
import com.teamproject3.vo.Member;
import com.teamproject3.vo.PageRequest;
import com.teamproject3.vo.QnA;
import com.teamproject3.vo.TicketOrder;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Inject MemberService memberService;
	@Inject QnAService qnAService;
	@Inject TicketOrderService ticketOrderService;
	
	@RequestMapping(
			value="/info",
			method=RequestMethod.GET)
	public String infoView() {
		return "admin/info";
	}
	
	/*
	 * 관리자 페이지의 유저 리스트는 검색 section을 제외하고 ajax로 동적 구성됩니다.
	 * page, searchOption, searchValue 를 인자로 받아
	 * 검색 결과에 따른 유저 리스트를 반환하고(기본값은 모두 다),
	 * 페이징을 위한 pagination객체를 반환합니다. 
	 */
	@RequestMapping(
			value	="/getMemberList",
			method	=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getMemberList(PageRequest pageRequest){
		
		int memberCount = memberService.count(pageRequest);
		// 페이징 Pagination(표시하고자 하는 페이지 번호, 총 멤버 수, 한 페이지당 표시할 멤버 수, 한 블럭당 표시할 페이지의 수)
		Pagination p = new Pagination(pageRequest.getPage(), memberCount, 10, 3);
		int start = p.getPageBegin();
		int end = p.getPageEnd();
		List<Member> members = memberService.findAll(start, end, pageRequest);
		
		// 대상에서 관리자 권한의 계정은 제외한다.
		List<Member> memberList = new ArrayList<>();
		for (Member member: members) {
			if ("ROLE_USER".equals(member.getRole()))
				memberList.add(member);
		}

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("members", memberList);
		resultMap.put("pagination", p.getResultAsMap());
		
		return resultMap;
	}
	
	/*
	 * 질문과 답변 리스트를 가져옵니다.
	 */
	@RequestMapping(
			value="/getQuestionList",
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getQuestionList(PageRequest pageRequest) {
		
		int questionCount = qnAService.count(pageRequest);
		Pagination p = new Pagination(pageRequest.getPage(), questionCount, 10, 3);
		
		int start = p.getPageBegin();
		int end = p.getPageEnd();
		
		List<QnA> QnAs = qnAService.findAll(start, end, pageRequest);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("questions", QnAs);
		resultMap.put("pagination", p.getResultAsMap());
		
		return resultMap;
	}
	
	// 답변 처리 컨트롤러
	@RequestMapping(
			value="/answer",
			method=RequestMethod.POST,
			consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
			produces="text/plain;chartset=UTF-8")
	@ResponseBody
	public String answerQuestion(@RequestBody String json) {
		return qnAService.answerQuestion(json);
	}
	
	// 티켓 승인 처리 컨트롤러
	@RequestMapping(
			path="/approveTicket",
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String approveTicket(@RequestParam(value="ticketOrderNo") int ticketOrderNo) {
		return ticketOrderService.approveTicket(ticketOrderNo);
	}
	
	// 티켓 예약 리스트를 가져오는 컨트롤러
	@RequestMapping(
			path="/getReservationList", 
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getReservationList(PageRequest pageRequest) {
		
		int count = ticketOrderService.count(pageRequest);
		
		Pagination p = new Pagination(pageRequest.getPage(), count, 10, 3);
		int start = p.getPageBegin();
		int end = p.getPageEnd();
		
		List<TicketOrder> reservationList = ticketOrderService.findAll(start, end, pageRequest);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("reservationList", reservationList);
		resultMap.put("pagination", p.getResultAsMap());
		resultMap.put("tickets", ticketOrderService.findAllTicket());
		
		return resultMap;
	}
	
	// 회원의 수를 가져옵니다.
	@RequestMapping(
			path="/getCountForMemberList", 
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForMemberList() {
		int count = memberService.count(new PageRequest());
		return  Integer.toString(count);
	}
	
	// 예약의 수를 가져옵니다.
	@RequestMapping(
			path="/getCountForReservationList", 
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForReservationList() {
		int count = ticketOrderService.count(new PageRequest());
		return  Integer.toString(count);
	}
	
	// 질문의 수를 가져옵니다.
	@RequestMapping(
			path="/getCountForQuestionList", 
			method=RequestMethod.GET,
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountForQuestionList() {
		int count = qnAService.count(new PageRequest());
		return  Integer.toString(count);
	}
	
}
