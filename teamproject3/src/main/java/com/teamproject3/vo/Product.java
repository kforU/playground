package com.teamproject3.vo;

import java.util.ArrayList;
import java.util.Date;

import lombok.Data;

@Data
public class Product {

	private int productNo;
	private String productName;
	private String productContent;
	private int productCount;
	private String productImage;
	private int productPrice;
	private boolean deleted;
	private String productCategory;
	private Date regDate;

}
