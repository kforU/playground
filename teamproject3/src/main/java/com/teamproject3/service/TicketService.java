package com.teamproject3.service;

import java.util.List;

import com.teamproject3.vo.Product;
import com.teamproject3.vo.Ticket;

public interface TicketService {

	List<Product> findAllTicket();	
	
	List<Product> findAllTicketImage(int TicketNo);
	
	Product findByTicketNo(int ticketNo);
	
	int saveTicket(Ticket ticket);	
	
	void modifyTicket(Ticket ticket);
	
	void deleteTicket(int TicketNo);
}
