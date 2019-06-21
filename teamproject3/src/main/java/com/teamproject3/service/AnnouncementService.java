package com.teamproject3.service;

import java.util.List;

import com.teamproject3.vo.Announcement;
import com.teamproject3.vo.AnnouncementAttachment;

public interface AnnouncementService {

	int registerAnnouncement(Announcement announcement);
	List<Announcement> findAnnouncement();
	void registerAnnouncementAttachment(AnnouncementAttachment announcementAttachment);
	Announcement findAnnouncementByNo(int announcementNo);
	List<AnnouncementAttachment> findAttachmentByNo(int announcementNo);
	void deletedByNo(int announcementNo);
	AnnouncementAttachment findattachmentByAttachNo(int fileNo);
	void deletedByAttachNo(int fileNo);
	void updateAnnouncement(Announcement announcement);
	int registerNotFile(Announcement announcement);

}