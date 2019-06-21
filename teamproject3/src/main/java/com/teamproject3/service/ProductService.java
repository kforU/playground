package com.teamproject3.service;

import java.util.List;

import com.teamproject3.vo.Product;

public interface ProductService {

	List<Product> findAllProduct();	
	
	List<Product> findAllProductImage(int ProductNo);
	
	Product findByProductNo(int productNo);
	
	int saveProduct(Product product);	
	
	void modifyProduct(Product product);
	
	void deleteProduct(int ProductNo);

	void deleteProductImage(int productNo);
}
