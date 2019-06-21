package com.teamproject3.repository;

import java.util.ArrayList;
import java.util.List;

import com.teamproject3.vo.Product;

public interface ProductRepository {
	
	List<Product> selectAllProduct();	// 상품 목록
	
	List<Product> selectAllProductImage(int productNo);
	
	Product selectOneProductNo(int productNo);
	
	int insertProduct(Product product);	// 상품 등록
	
	void updateProduct(Product product);	// 상품 수정
	
	void deleteProduct(int productNo);	// 상품 삭제
	
	void deleteProductImage(int productNo);
	
}
