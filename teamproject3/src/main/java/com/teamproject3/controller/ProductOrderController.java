package com.teamproject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.service.ProductOrderService;
import com.teamproject3.service.ProductService;
import com.teamproject3.vo.Product;
import com.teamproject3.vo.ProductOrder;

@Controller
@RequestMapping("/product/")
public class ProductOrderController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Autowired
	@Qualifier("productOrderService")
	private ProductOrderService productOrderService;
	
	@RequestMapping(value = "/productPayment/{productNo}", method = RequestMethod.GET)
	public String productPaymentForm(@PathVariable int productNo, Model model) {
		
		Product product = productService.findByProductNo(productNo);
		
		if(product == null) {
			return "redirect:productDetail";
		}
		
		model.addAttribute("product", product);
		
		return "product/productPayment";
		
	}
	
	@RequestMapping(value="/productPayment/{productNo}", method = RequestMethod.POST)
	public String productOrderInsert(ProductOrder productOrder) {
		
			productOrderService.saveProductOrder(productOrder);
		
		return "redirect:/product/productOrderComplete";
		
	}

	@RequestMapping(value="/productOrderComplete", method = RequestMethod.GET)
	public String productOrderComplete() {
		
		return "product/productOrderComplete";
		
	}
}
