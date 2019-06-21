package com.teamproject3.repository;

import org.mybatis.spring.SqlSessionTemplate;

import com.teamproject3.mapper.AttractionMapper;
import com.teamproject3.vo.Attraction;

public class AttractionRepositoryImpl implements AttractionRepository{

	private SqlSessionTemplate sqlSessionTemplate;
	public SqlSessionTemplate getSessionTemplate() {
		return sqlSessionTemplate;
	}
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sqlSessionTemplate = sessionTemplate;
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

	


	

	
}
