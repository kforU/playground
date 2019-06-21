package com.teamproject3.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Review {

	private int reviewNo;
	private String reviewContent;
	private String email;
	private String reviewTitle;
	private int reviewHit;
	private Date regDate;
	
	private List<Comment> comments;
	
	
}
