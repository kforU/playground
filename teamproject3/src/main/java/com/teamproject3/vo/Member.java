package com.teamproject3.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Member implements Serializable{
	
	private static final long serialVersionUID = -6378329029525378054L;
	private String email;
	private String name;
	private String passwd;
	private Date regDate;
	private boolean active;
	private String role;
	private String image;
	private boolean deleted;
	
}
