package com.teamproject3.util;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.teamproject3.service.MemberService;
import com.teamproject3.service.ProductOrderService;
import com.teamproject3.service.QnAService;
import com.teamproject3.service.TicketOrderService;
import com.teamproject3.vo.PageRequest;
import com.teamproject3.vo.ProductOrder;
import com.teamproject3.vo.QnA;
import com.teamproject3.vo.TicketOrder;

@Service
public class CountHelper {
	
	@Inject MemberService memberService;
	@Inject TicketOrderService ticketOrderService;
	@Inject QnAService qnaService;
	@Inject ProductOrderService productOrderService;
	
	// 해당 유저의 예약만 카운트하여 반환
	public int getCountForReservation(String email) {
		int count = ticketOrderService.count(new PageRequest());
		List<TicketOrder> orders = ticketOrderService.findAll(1, count, new PageRequest());
		List<TicketOrder> result = new ArrayList<>();
		for (TicketOrder order: orders) {
			if (order.getEmail().equals(email))
				result.add(order);
		}
		return result.size();
	}
	
	// 해당 유저의 질의만 카운트하여 반환
	public int getCountForQuestionList(String email) {
		int count = memberService.count(new PageRequest());
		List<QnA> questions = qnaService.findAll(1, count, new PageRequest());
		List<QnA> result = new ArrayList<>();	
		for (QnA question: questions) {
			if (question.getEmail().equals(email))
				result.add(question);
		}
		return result.size();
	}
	
	// 해당 유저의 주문 내역만 카운트하여 반환
	public int getCountForProductList(String email) {
		int count = productOrderService.count("all");
		List<ProductOrder> orders = productOrderService.findAll(1, count, "all", email);
		return orders.size();
	}
	
}
