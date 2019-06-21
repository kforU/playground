package com.teamproject3.repository;

import java.util.List;

import com.teamproject3.vo.Product;
import com.teamproject3.vo.Ticket;

public interface TicketRepository {
	
	List<Product> selectAllTicket();	// 상품 목록
	
	List<Product> selectAllTicketImage(int ticketNo);
	
	Product selectOneTicketNo(int ticketNo);
	
	int insertTicket(Ticket ticket);	// 상품 등록
	
	void updateTicket(Ticket ticket);	// 상품 수정
	
	void deleteTicket(int ticketNo);	// 상품 삭제
	
}
