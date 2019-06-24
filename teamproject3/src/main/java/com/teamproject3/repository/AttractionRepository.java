package com.teamproject3.repository;

import java.util.ArrayList;
import java.util.List;

import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

public interface AttractionRepository {

	int insertAttraction(Attraction attraction);
	void insertAttractionAttachment(AttractionAttachments attractionAttatchment);
	
	
	List<Attraction> selectAttractionList();
	Attraction selectAttractionByAttractionNo(int attractionNo);
	
	ArrayList<AttractionAttachments> selectAttractionImages(int attractionNo);
	void deleteAttraction(int attractionNo);


}
