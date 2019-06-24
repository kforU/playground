package com.teamproject3.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.service.AnnouncementService;
import com.teamproject3.util.Util;
import com.teamproject3.vo.Announcement;
import com.teamproject3.vo.AnnouncementAttachment;

@Controller
@RequestMapping("/announcement/")
public class AnnounceController {
	
	@Autowired
	@Qualifier("announcementService")
	private AnnouncementService announcementService;

	@RequestMapping(path = "announce", method= RequestMethod.GET )
	public String announce(Model model) {
			
		
		List<Announcement> announcements = announcementService.findAnnouncement();
		
		model.addAttribute("announcements", announcements);
		
		return "announcement/announce";
	};
	
	@RequestMapping(path = "announceWrite", method= RequestMethod.GET)
	public String announceWrite(Model model) {
		
		return "announcement/announceWrite";
	}
	
	@RequestMapping(path = "announceAttachment", method= RequestMethod.POST, produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String announceAttachment(HttpServletRequest req, HttpServletResponse resp) {
		
		System.out.println(req.getRequestURI());
		
		String sFileInfo = "";
		//파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
		String name = req.getHeader("file-name");
		String ext = name.substring(name.lastIndexOf(".")+1);
		//파일 기본경로
		String defaultPath = req.getSession().getServletContext().getRealPath("/");
		//파일 기본경로 _ 상세경로
		String path = defaultPath + "resources" + File.separator + "annNavereditor" + File.separator+ "annUpload" + File.separator;
		System.out.println("path : " + path);
		File file = new File(path);
		if(!file.exists()) {
		    file.mkdirs();
		}
		
		try {
			String realname = UUID.randomUUID().toString() + "." + ext;
			//if(ext.equals(anObject))
			InputStream is = req.getInputStream();
			OutputStream os=new FileOutputStream(path + realname);
			int numRead;
			// 파일쓰기
			byte b[] = new byte[Integer.parseInt(req.getHeader("file-size"))];
			while((numRead = is.read(b,0,b.length)) != -1){
			    os.write(b,0,numRead);
			}
			if(is != null) {
			    is.close();
			}
			os.flush();
			os.close();
			sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+req.getContextPath()+"/resources/annNavereditor/annUpload/"+realname;
//			PrintWriter out = resp.getWriter();
//			
//			out.println(sFileInfo);
		} catch(Exception ex){
			
		}

		return sFileInfo;

	}
	
	@RequestMapping(path = "announceWrite", method= RequestMethod.POST)
	public String announceWrite(Announcement announcement) {
		
				//데이터 저장				
				announcementService.registerNotFile(announcement);

		return "announcement/announceDetail";
	}
	
	@RequestMapping(path = "announceDetail/{announcementNo}", method=RequestMethod.GET)
	public String announceDetail(@PathVariable int announcementNo, Model model) {
		
		Announcement announcement = announcementService.findAnnouncementByNo(announcementNo);
		if(announcement == null) {
			return "announcement/announce";
		}

		model.addAttribute("announcement", announcement);
		
		return "announcement/announceDetail";

	}
	
	@RequestMapping(path="announcedelete/{announcementNo}", method=RequestMethod.GET)
	public String announceDelete(@PathVariable int announcementNo) {
		
		announcementService.deletedByNo(announcementNo);
		
		return "announcement/announce";
	}
	
	@RequestMapping(path="delete-file/{announcementNo}/{fileNo}", 
					method=RequestMethod.GET,
					produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String attachmentDelete(@PathVariable int announcementNo, @PathVariable int fileNo, Model model) {
		AnnouncementAttachment file = announcementService.findattachmentByAttachNo(fileNo);
		File f = new File(file.getAnnAttachmentFileUrl());
		if(f.exists()) {
			f.delete();
		}
		announcementService.deletedByAttachNo(fileNo);
		
		return "success";
	}
	
	@RequestMapping(path="announceUpdate/{announcementNo}", method=RequestMethod.GET)
	public String announceUpdatePage(@PathVariable int announcementNo, Model model) {
		Announcement announcement = announcementService.findAnnouncementByNo(announcementNo);
		if(announcement == null) {
			return "announcement/announce";
		}
		
		model.addAttribute("announcement", announcement);
		
		return "announcement/announceUpdate";
	}
	
	@RequestMapping(path="update", method= RequestMethod.POST)
	public String Update(Announcement announcement) {
		                              
		
				announcementService.updateAnnouncement(announcement);

		return "redirect:/announcement/announceDetail/"+announcement.getAnnouncementNo();
	}
	
	@RequestMapping(path = "eventpage", method= RequestMethod.GET )
	public String eventpage(Model model) {
			
		
		List<Announcement> announcements = announcementService.findAnnouncement();
		//announcementService.findAttachmentByNo(announcementNo);
		
		model.addAttribute("announcements", announcements);
		
		return "announcement/eventpage";
	};
	
	@RequestMapping(path = "eventDetail/{announcementNo}", method=RequestMethod.GET)
	public String eventDetail(@PathVariable int announcementNo, Model model) {
		
		Announcement announcement = announcementService.findAnnouncementByNo(announcementNo);
		if(announcement == null) {
			return "announcement/announce";
		}
		List<AnnouncementAttachment> files = announcementService.findAttachmentByNo(announcementNo);
		announcement.setFiles((ArrayList<AnnouncementAttachment>) files);
		
		model.addAttribute("announcement", announcement);
		
		return "announcement/eventDetail";

	}
	@RequestMapping(path="eventupdate", method= RequestMethod.POST)
	public String eventUpdate(MultipartHttpServletRequest req, Announcement announcement) {
		                              
		MultipartFile mf = req.getFile("attachment");
		if (mf != null) {
			
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/resources/annNavereditor/annUpload");
			
			String userFileName = mf.getOriginalFilename();
			if (userFileName.contains("\\")) { // iexplore 경우
				//C:\AAA\BBB\CCC.png -> CCC.png 
				userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
			}
			String savedFileName = Util.makeUniqueFileName(userFileName);
			
			try {
				mf.transferTo(new File(path, savedFileName)); //파일 저장
				
				
				
				AnnouncementAttachment announcementAttachment = new AnnouncementAttachment();
				announcementAttachment.setAnnAttachmentMediaType(userFileName);
				announcementAttachment.setAnnAttachmentFileUrl(savedFileName);
				announcementAttachment.setAnnouncementNo(announcement.getAnnouncementNo());
				announcementService.registerAnnouncementAttachment(announcementAttachment);
				announcement.setAnnounceImage(savedFileName);
				
				
				//데이터 저장				
				announcementService.updateAnnouncement(announcement);

			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		
		return "redirect:/announcement/eventDetail/"+announcement.getAnnouncementNo();
	}
	
	@RequestMapping(path="eventUpdate/{announcementNo}", method=RequestMethod.GET)
	public String eventUpdatePage(@PathVariable int announcementNo, Model model) {
		Announcement announcement = announcementService.findAnnouncementByNo(announcementNo);
		if(announcement == null) {
			return "announcement/announce";
		}
		List<AnnouncementAttachment> files = announcementService.findAttachmentByNo(announcementNo);
		announcement.setFiles((ArrayList<AnnouncementAttachment>) files);
		
		model.addAttribute("announcement", announcement);
		
		return "announcement/eventUpdate";
	}
	
	@RequestMapping(path = "eventWrite", method= RequestMethod.GET)
	public String eventWrite(Model model) {
		
		return "announcement/eventWrite";
	}
	
	@RequestMapping(path = "eventWrite", method= RequestMethod.POST)
	public String eventWrite(MultipartHttpServletRequest req, Announcement announcement) {
		
		
		
		MultipartFile mf = req.getFile("attachment");
		if (mf != null) {
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/resources/annNavereditor/annUpload");
			
			String userFileName = mf.getOriginalFilename();
			if (userFileName.contains("\\")) { // iexplore 경우
				//C:\AAA\BBB\CCC.png -> CCC.png 
				userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
			}
			String savedFileName = Util.makeUniqueFileName(userFileName);
			
			try {
				mf.transferTo(new File(path, savedFileName)); //파일 저장
								
				AnnouncementAttachment announcementAttachment = new AnnouncementAttachment();
				announcementAttachment.setAnnAttachmentMediaType(userFileName);
				announcementAttachment.setAnnAttachmentFileUrl(savedFileName);
				ArrayList<AnnouncementAttachment> files = new ArrayList<AnnouncementAttachment>();
				files.add(announcementAttachment);
				announcement.setFiles(files);
				announcement.setAnnounceImage(savedFileName);
				
				//데이터 저장				
				announcementService.registerAnnouncement(announcement);
			
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} 

		return "announcement/eventDetail";
	}
	
	@RequestMapping(path="FAQpage", method=RequestMethod.GET)
	public String FAQpage() {
		
		return "announcement/FAQpage";
	}
	
	@RequestMapping(path="eventdelete/{announcementNo}", method=RequestMethod.GET)
	public String eventDelete(@PathVariable int announcementNo) {
		
		announcementService.deletedByNo(announcementNo);
		
		return "announcement/eventpage";
	}
}