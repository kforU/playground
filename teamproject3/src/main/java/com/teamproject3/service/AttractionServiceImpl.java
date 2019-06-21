package com.teamproject3.service;

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
	

	@Override
	public int registerAttraction(Attraction attraction) {
			int newAttractionNo = attractionRepository.insertAttraction(attraction);
			for (AttractionAttachments file : attraction.getFiles()) {
				file.setAttractionNo(newAttractionNo);
				attractionRepository.insertAttraction(attraction);
			}
			
		return newAttractionNo;
	}




	

}
