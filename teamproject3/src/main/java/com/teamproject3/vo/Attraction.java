package com.teamproject3.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Attraction {
	
	private int attractionNo; 
	private String attractionName;
	private String attractionImage;
	private String attractionContent;
	
	
	private ArrayList<AttractionAttachments> files;
	
}
