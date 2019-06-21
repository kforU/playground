package com.teamproject3.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TicketOrder {
	
	private String ticketOrderNo;
	private Date ticketOrderDate;
	private Date ticketOrderUseDate;
	private int ticketOrderCount;
	private String email;
	private int ticketNo;
	private boolean approval;
	private boolean expired;
	
}
