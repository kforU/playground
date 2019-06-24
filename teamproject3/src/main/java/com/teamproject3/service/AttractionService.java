package com.teamproject3.service;

import java.util.List;

import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;


public interface AttractionService {

	
	int registerAttraction(Attraction attraction);
	void redisterAttractionAttachments(AttractionAttachments attractionAttatchment);
	
	
	
	List<Attraction> findAttraction();
	Attraction findAttractionByAttractionNo(int attractionNo);
	List<AttractionAttachments> findAttractionImages(int attractionNo);
	void deleteAttraction(int attractionNo);
	

}