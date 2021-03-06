package com.teamproject3.service;

import java.util.List;

import com.teamproject3.repository.ProductRepository;
import com.teamproject3.vo.Product;

public class ProductServiceImpl implements ProductService {

	private ProductRepository productRepository;
	
	public ProductRepository getProductRepository() {
		return productRepository;
	}

	public void setProductRepository(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	
	@Override
	public List<Product> findAllProduct() {
		
		List<Product> products = productRepository.selectAllProduct();
		return products;
	}
	
	@Override
	public List<Product> findProductByCategory(String productCategory) {
		List<Product> products = productRepository.selectProductByCategory(productCategory);
		return products;
	}
	
	@Override
	public List<Product> findAllProductImage(int ProductNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Product findByProductNo(int productNo) {
		
		Product product = productRepository.selectOneProductNo(productNo);
		
		return product;
	}

	@Override
	public int saveProduct(Product product) {
		
		int newProductNo = productRepository.insertProduct(product);
		
		return newProductNo;
		
	}
	
	@Override
	public void modifyProduct(Product product) {
		
		productRepository.updateProduct(product);
		
	}

	@Override
	public void deleteProduct(int productNo) {
		
		productRepository.deleteProduct(productNo);
		
	}

	@Override
	public void deleteProductImage(int productNo) {
		
		productRepository.deleteProductImage(productNo);
		
	}

	@Override
	public List<Product> searchProductByName(String search) {
	
		search = "%" + search + "%";
		List<Product> searchProduct = productRepository.searchProductByName(search);
		
		return searchProduct;
	}

	@Override
	public List<Product> sortProductByLowPrice() {
		
		List<Product> products = productRepository.sortProductByLowPrice();
		return products;
	}

	@Override
	public List<Product> sortProductByHighPrice() {
		
		List<Product> products = productRepository.sortProductByHighPrice();
		return products;
	}
	
}
