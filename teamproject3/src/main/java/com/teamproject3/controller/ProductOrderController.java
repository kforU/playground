package com.teamproject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject3.service.ProductService;
import com.teamproject3.vo.Product;

@Controller
public class ProductOrderController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@RequestMapping(value = "/productPayment/{productNo}", method = RequestMethod.GET)
	public String productPaymentForm(@PathVariable int productNo, Model model) {
		
		Product product = productService.findByProductNo(productNo);
		
		if(product == null) {
			return "redirect:productDetail";
		}
		
		model.addAttribute("product", product);
		
		return "product/productPayment";
		
	}
	
	
	
}
