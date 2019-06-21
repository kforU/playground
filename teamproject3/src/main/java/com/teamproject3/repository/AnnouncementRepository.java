package com.teamproject3.repository;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//import com.teamproject3.vo.AnnouncementAttachment;
import com.teamproject3.vo.Announcement;
import com.teamproject3.vo.AnnouncementAttachment;


public class AnnouncementRepository {
	
	private static final String Announce_namespace = "com.teamproject3.mapper.AnnounceMapper";
	
	private SqlSessionTemplate sqlSessionTemplate;
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public int insertAnnounce(Announcement announcement) {
		sqlSessionTemplate.insert(Announce_namespace.concat(".insertAnnounce"), announcement);
		return announcement.getAnnouncementNo();
	}

	public void insertAnnouncementAttachment(AnnouncementAttachment file) {
		sqlSessionTemplate.insert(Announce_namespace.concat(".insertAttachment"), file);
		
	}

	public List<Announcement> selectAllAnnouncement() {
		List<Announcement> announcements = sqlSessionTemplate.selectList(Announce_namespace.concat(".selectAllAnnounce"));
		
		return announcements;
	}

	public Announcement selectAnnouncementByNo(int announcementNo) {
		Announcement announcement = sqlSessionTemplate.selectOne(Announce_namespace.concat(".selectOneAnnounce"), announcementNo);
		return announcement;
	}

	public List<AnnouncementAttachment> selectAttachmentByNo(int announcementNo) {
		List<AnnouncementAttachment> files = sqlSessionTemplate.selectList(Announce_namespace.concat(".selectOneAttachment"), announcementNo);
		return files;
	}

	public void deletedByNo(int announcementNo) {
		sqlSessionTemplate.delete(Announce_namespace.concat(".delete"), announcementNo);
		
	}

	public AnnouncementAttachment selectOne(int fileNo) {
		AnnouncementAttachment file = sqlSessionTemplate.selectOne(Announce_namespace.concat(".selectAttachment"), fileNo);
		return file;
	}

	public void deletedByAttachNo(int fileNo) {
		sqlSessionTemplate.delete(Announce_namespace.concat(".deleteAttach"),fileNo);
		
	}

	public void update(Announcement announcement) {
		sqlSessionTemplate.update(Announce_namespace.concat(".update"), announcement);
		
	}

	public int insertNotFile(Announcement announcement) {
		sqlSessionTemplate.insert(Announce_namespace.concat(".insertNotFile"), announcement);
		return announcement.getAnnouncementNo();
	}

	
}
