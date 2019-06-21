package com.teamproject3.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.teamproject3.repository.ProductOrderRepository;
import com.teamproject3.vo.ProductOrder;

@Service
public class ProductOrderService {
	
	@Inject
	ProductOrderRepository productOrderRepository;
	
	public ProductOrderRepository getProductOrderRepository() {
		return productOrderRepository;
	}

	public void setProductOrderRepository(ProductOrderRepository productOrderRepository) {
		this.productOrderRepository = productOrderRepository;
	}

	public List<ProductOrder> findAll(int start, int end, String approved, String email){
		return productOrderRepository.selectAll(start, end, approved, email);
	}
	
	public int count(String approved) {
		return productOrderRepository.count(approved);
	}

	public int saveProductOrder(ProductOrder productOrder) {
		
		int newProductOrderNo = productOrderRepository.insertProductOrder(productOrder);
		
		return newProductOrderNo;
	}
	
}
