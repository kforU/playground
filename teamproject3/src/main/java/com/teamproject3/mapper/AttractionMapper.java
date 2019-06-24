package com.teamproject3.mapper;

import java.util.List;

import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

public interface AttractionMapper {

	//attractionList 조회
	List<Attraction> selectAttractionList();
	
	//attraction 작성
	void insertAttraction(Attraction attraction);
	void insertAttractionFile(AttractionAttachments attractionAttatchment);

	Attraction selectAttractionByAttractionNo(int attractionNo);

	List<AttractionAttachments> selectAttractionImage(int attractionNo);

	void deleteAttraction(int attractionNo);

	

}
