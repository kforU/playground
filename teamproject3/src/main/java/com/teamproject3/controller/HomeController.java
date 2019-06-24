package com.teamproject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject3.service.AttractionService;
import com.teamproject3.vo.Attraction;

@Controller
public class HomeController {
	

	@Autowired
	@Qualifier("attractionService")
	
	private AttractionService attractionService;
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		List<Attraction> attractions = attractionService.findAttraction();
		model.addAttribute("attractions", attractions);

		return "home";
	}
	
}
