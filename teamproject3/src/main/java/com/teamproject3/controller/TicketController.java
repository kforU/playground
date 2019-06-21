package com.teamproject3.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject3.service.TicketOrderService;
import com.teamproject3.vo.Ticket;
import com.teamproject3.vo.TicketOrder;

@Controller
@RequestMapping(path ="/ticket")
public class TicketController {
	
	@Autowired
	@Qualifier("ticketOrderService")
	private TicketOrderService ticketOrderService;
	
	@RequestMapping(value = "/reservation", method = RequestMethod.GET)
	public String showReservationForm() {
		
		return "ticket/reservation";
		
	}
	
	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String showPaymentForm(Ticket ticket, Model model) {
		
		System.out.printf("[%d][%d][%d]", ticket.getAdultPrice(), ticket.getYouthPrice(), ticket.getKidPrice());
		
		// int total = ticket.getAdultPrice() +  ticket.getYouthPrice() + ticket.getKidPrice();		
		//model.addAttribute("total", total);
		
		model.addAttribute("ticket", ticket);
		model.addAttribute("ticketOrderCount", (int)(Math.random() * 10) + 1);
		
		return "ticket/payment";
		
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, false));
	}
	
	@RequestMapping(value = "/ticket-order", method = RequestMethod.POST)
	public String orderTicket(TicketOrder vo) {
		
		ticketOrderService.orderTicket(vo);
		
		return "redirect:/";
	}

}
