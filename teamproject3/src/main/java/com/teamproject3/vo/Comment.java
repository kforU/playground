package com.teamproject3.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Comment {

	private int commentNo;
	private String commentContent;
	private Date regDate;
	private int reviewNo;
	private String email;
	
}
