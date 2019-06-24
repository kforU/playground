package com.teamproject3.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PageRequest {

	private int page;
	private String searchOption;
	private String searchValue;
	private String completed;
	
	public PageRequest() {
		page = 1;
		searchOption = "all";
		searchValue = "";
		completed = "all";
	}
	
}
