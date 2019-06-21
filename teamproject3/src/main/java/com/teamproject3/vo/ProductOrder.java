package com.teamproject3.vo;

import lombok.Data;

@Data
public class ProductOrder {


	private int productOrderNo;
	private int productOrderCount ;
	private String email;
	private int productNo;
	private boolean approval;
	
	}