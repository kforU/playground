package com.teamproject3.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject3.service.AnnouncementService;
import com.teamproject3.service.AttractionService;
import com.teamproject3.vo.Announcement;
import com.teamproject3.vo.Attraction;

@Controller
public class HomeController {
	

	@Inject AttractionService attractionService;
	@Inject AnnouncementService announcementService;
	
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		List<Attraction> attractions = attractionService.findAttraction();
		model.addAttribute("attractions", attractions);
		
		List<Announcement> announcements = announcementService.findAnnouncement();
		model.addAttribute("announcements", announcements);

		return "home";
	}
	
}
