package com.teamproject3.vo;

import java.util.Date;
import java.util.ArrayList;

import lombok.Data;

@Data
public class Announcement {
	
	private int announcementNo;
	private String announceTitle;
	private String email;
	private String category;
	private String announceImage;
	private String announcementContent;
	private Date regDate;
	private boolean deleted;


	
	private ArrayList<AnnouncementAttachment> files;

}
