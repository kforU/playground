package com.teamproject3.repository;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.teamproject3.mapper.AttractionMapper;
import com.teamproject3.vo.Attraction;
import com.teamproject3.vo.AttractionAttachments;

public class AttractionRepositoryImpl implements AttractionRepository{

	private SqlSessionTemplate sqlSessionTemplate;
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	
	
	private AttractionMapper attractionMapper;
	public AttractionMapper getAttractionMapper() {
		return attractionMapper;
	}
	public void setAttractionMapper(AttractionMapper attractionMapper) {
		this.attractionMapper = attractionMapper;
	}


	////////////
	@Override
	public int insertAttraction(Attraction attraction) {
		attractionMapper.insertAttraction(attraction);
		
		return attraction.getAttractionNo();
	}
	
	@Override
	public List<Attraction> selectAttractionList() {
		List<Attraction> attractions =  attractionMapper.selectAttractionList();
		
		return attractions;
	}
	@Override
	public void insertAttractionAttachment(AttractionAttachments attractionAttatchment) {
		attractionMapper.insertAttractionFile(attractionAttatchment);
		
	}
	
	///////////
	@Override
	public Attraction selectAttractionByAttractionNo(int attractionNo) {
		Attraction attraction = attractionMapper.selectAttractionByAttractionNo(attractionNo);
		return attraction;
	}
	
	///
	@Override
	public ArrayList<AttractionAttachments> selectAttractionImages(int attractionNo) {
		List<AttractionAttachments> attractionAttachments = attractionMapper.selectAttractionImage(attractionNo);
	
		return (ArrayList<AttractionAttachments>) attractionAttachments;
	}
	@Override
	public void deleteAttraction(int attractionNo) {
		attractionMapper.deleteAttraction(attractionNo);
		
	}
	

	

	
}
