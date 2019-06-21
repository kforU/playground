package com.teamproject3.vo;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class QnA {

	private int qnaNo;
	private String email;
	private String qnaContent;
	private String qnaAnswer;
	private String qnaCategory;
	private Date regDate;
	private Boolean completed;
	
}
