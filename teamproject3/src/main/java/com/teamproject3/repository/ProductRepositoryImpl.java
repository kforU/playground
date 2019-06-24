package com.teamproject3.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.teamproject3.mapper.ProductMapper;
import com.teamproject3.vo.Product;

public class ProductRepositoryImpl implements ProductRepository {

	private SqlSessionTemplate sessionTemplate;
	public SqlSessionTemplate getSessionTemplate() {
		return sessionTemplate;
	}	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	private ProductMapper productMapper;

	public ProductMapper getProductMapper() {
		return productMapper;
	}
	public void setProductMapper(ProductMapper productMapper) {
		this.productMapper = productMapper;
	}
	
	@Override
	public List<Product> selectAllProduct() {
		List<Product> products = productMapper.selectAllProduct();
		
		return products;
	}
	
	@Override
	public Product selectOneProductNo(int productNo) {
		
		Product product = productMapper.selectOneProductNo(productNo);
		
		return product;
	}

	@Override
	public int insertProduct(Product product) {
		
		productMapper.insertProduct(product);
		
		return product.getProductNo();
		
	}
	
	@Override
	public void updateProduct(Product product) {
		
		productMapper.updateProduct(product);
		
	}

	@Override
	public void deleteProduct(int productNo) {
		
		productMapper.deleteProduct(productNo);
		
	}
	@Override
	public void deleteProductImage(int productNo) {
		
		productMapper.deleteProductImage(productNo);
		
	}
	@Override
	public List<Product> searchProductByName(String search) {
		
		List<Product> searchProduct = productMapper.searchProductByName(search);
		
		return searchProduct;
	}
	
	@Override
	public List<Product> selectAllProductImage(int productNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Product> selectProductByCategory(String productCategory) {
		
		List<Product> products = productMapper.selectProductByCategory(productCategory);
		
		return products;
	}
	@Override
	public List<Product> sortProductByLowPrice() {
		
		List<Product> products = productMapper.sortProductByLowPrice();
		
		return products;
	}
	@Override
	public List<Product> sortProductByHighPrice() {

		List<Product> products = productMapper.sortProductByHighPrice();
		
		return products;
	}
	
}
