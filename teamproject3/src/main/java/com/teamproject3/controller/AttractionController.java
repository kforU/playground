package com.teamproject3.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.service.AttractionService;
import com.teamproject3.util.Util;
import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

@Controller
public class AttractionController {

	@Autowired
	@Qualifier("attractionService")
	private AttractionService attractionService;
	
	@RequestMapping(value = "/attractionList", method= RequestMethod.GET )
	public String attraction(Model model) {
		
		
		return "attraction/attractionList";
	};
	
	//attractionWrite
	@RequestMapping(value = "/attractionWrite", method= RequestMethod.GET )
	public String attractionWrtie(Model model) {
		
		return "attraction/attractionWrite";
	};
	
	@RequestMapping(value = "attractionWrite", method= RequestMethod.POST)
	public String attractionWrite(MultipartHttpServletRequest req, Attraction attraction) {
		
		MultipartFile mf = req.getFile("attach");
		if (mf != null) {
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/upload-files");
			
			String userFileName = mf.getOriginalFilename();
			if (userFileName.contains("\\")) { 
				userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
			}
			String savedFileName = Util.makeUniqueFileName(userFileName);
			
			try {
				mf.transferTo(new File(path, savedFileName)); //파일 저장
								
				AttractionAttachments attractionAttrachment = new AttractionAttachments();
				attractionAttrachment.setAttractionMediaType(userFileName);
				attractionAttrachment.setAttractionFileUrl(savedFileName);
				ArrayList<AttractionAttachments> files = new ArrayList<AttractionAttachments>();
				files.add(attractionAttrachment);
				attraction.setFiles(files);
				
				//데이터 저장				
				attractionService.registerAttraction(attraction);
				
				

			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		
		return "redirect:attraction";
	}
	
	
		
		
	
	
	
	
	


}
