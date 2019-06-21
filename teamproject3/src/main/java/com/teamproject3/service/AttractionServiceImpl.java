package com.teamproject3.service;

import java.util.List;

import com.teamproject3.repository.AttractionRepository;
import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

public class AttractionServiceImpl implements AttractionService{
	
	private AttractionRepository attractionRepository;
	public AttractionRepository getAttractionRepository() {
		return attractionRepository;
	}

	public void setAttractionRepository(AttractionRepository attractionRepository) {
		this.attractionRepository = attractionRepository;
	}
	
///////업로드
	@Override
	public int registerAttraction(Attraction attraction) {
			int newAttractionNo = attractionRepository.insertAttraction(attraction);
			for (AttractionAttachments file : attraction.getFiles()) {
				file.setAttractionNo(newAttractionNo);
				//attractionRepository.insertAttraction(attraction);
				attractionRepository.insertAttractionAttachment(file);
			}
			
		return newAttractionNo;
	}
	@Override
	public void redisterAttractionAttachments(AttractionAttachments attractionAttatchment) {
		attractionRepository.insertAttractionAttachment(attractionAttatchment);
		
	}
	
	//////////////////////////////////
	@Override
	public List<Attraction> findAttraction() {
		List<Attraction> attractions = attractionRepository.selectAttractionList();
		return attractions;
	}


	@Override
	public Attraction findAttractionByAttractionNo(int attractionNo) {
		
		Attraction attraction = attractionRepository.selectAttractionByAttractionNo(attractionNo);
		return attraction;
		
	}

	@Override
	public List<AttractionAttachments> findAttractionImages(int attractionNo) {
		List<AttractionAttachments> attractionAttachments = attractionRepository.selectAttractionImages(attractionNo);
		return null;
	}

	@Override
	public void deleteAttraction(int attractionNo) {
		attractionRepository.deleteAttraction(attractionNo);
		
	}



	





	

}
