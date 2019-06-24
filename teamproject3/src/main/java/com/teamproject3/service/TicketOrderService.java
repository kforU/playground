package com.teamproject3.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.teamproject3.repository.TicketOrderRepository;
import com.teamproject3.vo.PageRequest;
import com.teamproject3.vo.Ticket;
import com.teamproject3.vo.TicketOrder;

@Service
public class TicketOrderService {
	
	@Inject
	TicketOrderRepository repository;
	private static final String SUCCESS = "success";
	private static final String FAILED = "falied";
	
	public List<TicketOrder> findAll(int start, int end, PageRequest pageRequest) {
		List<TicketOrder> orders = repository.selectAll(
				start, end, 
				pageRequest.getSearchOption(), 
				pageRequest.getSearchValue());
		for (TicketOrder order: orders) {
			// 티켓 유효일이 오늘보다 이전이면 만료된 티켓으로 간주
			order.setExpired(new Date().after(order.getTicketOrderUseDate()));
		}
		return orders;
	}
	
	public int count(PageRequest pageRequest) {
		return repository.count(
				pageRequest.getSearchOption(), 
				pageRequest.getSearchValue());
	}
	
	public String approveTicket(int ticketOrderNo) {
		
		try {
			repository.approveTicket(ticketOrderNo);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		
		return SUCCESS;
	}

	// 존재하는 모든 티켓을 가져옴
	@Cacheable
	public List<Ticket> findAllTicket() {
		return repository.selectAllTicket();
	}
	
	public void orderTicket(TicketOrder vo) {
		repository.insertTicket(vo);
	}
}
