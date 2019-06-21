package com.teamproject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.teamproject3.repository.AnnouncementRepository;
import com.teamproject3.vo.Announcement;
import com.teamproject3.vo.AnnouncementAttachment;


public class AnnouncementServiceImpl implements AnnouncementService {
	

	private AnnouncementRepository announcementRepository;
	public AnnouncementRepository getAnnouncementRepository() {
		return announcementRepository;
	}

	public void setAnnouncementRepository(AnnouncementRepository announcementRepository) {
		this.announcementRepository = announcementRepository;
	}

	@Override
	public int registerAnnouncement(Announcement announcement) {
		

		int newAnnouncementNo = announcementRepository.insertAnnounce(announcement);
		for(AnnouncementAttachment file : announcement.getFiles() ) {
			file.setAnnouncementNo(newAnnouncementNo);
			announcementRepository.insertAnnouncementAttachment(file);
		};
		return newAnnouncementNo;

	};

	@Override
	public List<Announcement> findAnnouncement() {
		List<Announcement> announcements = announcementRepository.selectAllAnnouncement();
		return announcements;
	}

	@Override
	public void registerAnnouncementAttachment(AnnouncementAttachment announcementAttachment) {
		announcementRepository.insertAnnouncementAttachment(announcementAttachment);
		
	}

	@Override
	public Announcement findAnnouncementByNo(int announcementNo) {
		
		Announcement announcement = announcementRepository.selectAnnouncementByNo(announcementNo);
		
		return announcement;
	}

	@Override
	public List<AnnouncementAttachment> findAttachmentByNo(int announcementNo) {
		List<AnnouncementAttachment> files = announcementRepository.selectAttachmentByNo(announcementNo);
		return files;
	}

	@Override
	public void deletedByNo(int announcementNo) {
		
		announcementRepository.deletedByNo(announcementNo);
		
	}

	@Override
	public AnnouncementAttachment findattachmentByAttachNo(int fileNo) {
		AnnouncementAttachment file = announcementRepository.selectOne(fileNo);
		return file;
	}

	@Override
	public void deletedByAttachNo(int fileNo) {
		announcementRepository.deletedByAttachNo(fileNo);
		
	}

	@Override
	public void updateAnnouncement(Announcement announcement) {
		announcementRepository.update(announcement);
		
	}

	@Override
	public int registerNotFile(Announcement announcement) {
		int newAnnouncementNo = announcementRepository.insertNotFile(announcement);
		
		return newAnnouncementNo;
	}


}
