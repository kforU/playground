package com.teamproject3.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.repository.AttractionRepository;
import com.teamproject3.service.AttractionService;
import com.teamproject3.util.Util;
import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

@Controller
public class AttractionController {

	@Autowired
	@Qualifier("attractionService")
	private AttractionService attractionService;
	
	
	//어트랙션 조회
	@RequestMapping(value = "/attractionList", method= RequestMethod.GET )
	public String attraction(Model model) {
		
		List<Attraction> attractions = attractionService.findAttraction();
		
		//조회 결과를 request 객체에 저장 (JSP에서 사용할 수 있도록)
		model.addAttribute("attractions", attractions);

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
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("/resources/uploadFile");
			
			
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
				attraction.setAttractionImage(userFileName);
				
				//데이터 저장				
				attractionService.registerAttraction(attraction);
				
				

			} catch (Exception ex) {
				ex.printStackTrace();
			}
		
		
		return "redirect:attractionList";
	}
	
	//attractionDetail
	@RequestMapping(value ="/attractionDetail/{attractionNo}", method = RequestMethod.GET)
		public String attractionDetail(@PathVariable int attractionNo, Model model) {
		
		Attraction attraction = attractionService.findAttractionByAttractionNo(attractionNo);
		
		if (attraction == null) {
			return "redirect:attractionList";
		}
		
		List<AttractionAttachments> attractionAttachments = attractionService.findAttractionImages(attractionNo);
		attraction.setFiles((ArrayList<AttractionAttachments>)attractionAttachments);
	
		model.addAttribute("attraction", attraction);
		return "attraction/attractionDetail";
		
	}
	
	@RequestMapping( value = "/attractionDelete/{attractionNo}", method=RequestMethod.GET)
	public String attractionDelete(@PathVariable int attractionNo ) {
		
		attractionService.deleteAttraction(attractionNo);
		
		return "redirect:attractionList";
		
	}
	
	


	


}
