package com.teamproject3.mapper;

import java.util.List;

import com.teamproject3.vo.Product;

public interface ProductMapper {

	List<Product> selectAllProduct();	// 상품 목록

	List<Product> selectToyProduct();
	
	List<Product> selectWearProduct();
	
	List<Product> selectPhrasesProduct();
	
	List<Product> selectApplianceProduct();
	
	List<Product> selectAccessoryProduct();
	
	List<Product> selectAllProductImage(int productNo);
	
	Product selectOneProductNo(int productNo);
	
	void insertProduct(Product product);	// 상품 등록
	
	void updateProduct(Product product);	// 상품 수정
	
	void deleteProduct(int productNo);	// 상품 삭제

	void deleteProductImage(int productNo);
	
	List<Product> searchProductByName(String search);

	
}
