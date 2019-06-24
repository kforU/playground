package com.teamproject3.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.service.ProductService;
import com.teamproject3.vo.Product;

@Controller
@RequestMapping("/product/")
public class ProductController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@RequestMapping(
			value="/productList",
			method=RequestMethod.GET)
	public String productList(Model model) {
		
		List<Product> products = productService.findAllProduct();
		
		model.addAttribute("products", products);
		
		return "product/productList";
	}
	
	@RequestMapping(
			value="/productSortLowPrice",
			method=RequestMethod.GET)
	public String productSortByLowPrice(Model model) {
		
		List<Product> products = productService.sortProductByLowPrice();
		
		model.addAttribute("products", products);
		
		return "product/productList";
	}
	
	@RequestMapping(
			value="/productSortHighPrice",
			method=RequestMethod.GET)
	public String productSortByHighPrice(Model model) {
		
		List<Product> products = productService.sortProductByHighPrice();
		
		model.addAttribute("products", products);
		
		return "product/productList";
	}
	
	@RequestMapping(
			value="/productCategoryList",
			method=RequestMethod.GET)
	public String productCategoryList(String productCategory, Model model) {
		
		List<Product> products = productService.findProductByCategory(productCategory);
		
		model.addAttribute("products", products);
		
		return "product/productCategoryList";
	}
	
	@RequestMapping(
			value="/productDetail/{productNo}",
			method=RequestMethod.GET)
	public String productDetail(@PathVariable int productNo, Model model) {
		
		Product product = productService.findByProductNo(productNo);
		
		if(product == null) {
			return "redirect:productList";
		}
		
		model.addAttribute("product", product);
		
		return "product/productDetail";
	}
	
	@RequestMapping(
			value="/productWrite",
			method=RequestMethod.GET)
	public String productWrite() {
		
		return "product/productWrite";
	}
	
	@RequestMapping(
			value="/productWrite",
			method=RequestMethod.POST)
	public String productPost(MultipartHttpServletRequest req, Product product) {
		
		MultipartFile imageFile = req.getFile("productImage2");
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/images/tmp");
		
		String userFileName =  imageFile.getOriginalFilename();
		if (userFileName.contains("\\")) { // iexplore 경우
			//C:\AAA\BBB\CCC.png -> CCC.png 
			userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
		}

		try {
			userFileName = System.currentTimeMillis() + "_" + userFileName;
			imageFile.transferTo(new File(path, userFileName));
			
			product.setProductImage(userFileName);
		
			
			productService.saveProduct(product);
		} catch (Exception ex) {
			ex.printStackTrace();
		}			
			
		return "redirect:/product/productList";
	}

	@RequestMapping(
			value="/productUpdate/{productNo}",
			method=RequestMethod.GET)
	public String productUpdateForm(@PathVariable int productNo, Model model) {
		
		Product product = productService.findByProductNo(productNo);
		if (product == null) {
			return "redirect:/product/productList";
		}
		
		//조회 결과를 request 객체에 저장 (JSP에서 사용할 수 있도록)
		model.addAttribute("product", product);
		
		return "product/productUpdate";
	}
	
	@RequestMapping(path="/productUpdate",
				 	method = RequestMethod.POST)
	public String productUpdate(MultipartHttpServletRequest req, Product product) {
		
		MultipartFile imageFile = req.getFile("productImage2");
		boolean test = (imageFile == null || imageFile.isEmpty());
		
		if(test == false) {
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("resources/images/tmp");
			
			String userFileName =  imageFile.getOriginalFilename();
			if (userFileName.contains("\\")) { // iexplore 경우
				//C:\AAA\BBB\CCC.png -> CCC.png 
				userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
			}
	
			try {
				userFileName = userFileName + "_" + System.currentTimeMillis() + ".jpg";
				imageFile.transferTo(new File(path, userFileName));
	
				product.setProductImage(userFileName);
				
				productService.modifyProduct(product);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if(test == true) {
			productService.modifyProduct(product);
			return "redirect:/product/productDetail/" + product.getProductNo();
		}
		return "redirect:/product/productDetail/" + product.getProductNo();
	}
	
	@RequestMapping(
			value="/productDelete/{productNo}",
			method=RequestMethod.GET)
	public String productDelete(@PathVariable int productNo) {
		
		productService.deleteProduct(productNo);
		
		return "redirect:/product/productList";
	}
	
	@RequestMapping(
			value="/deleteImage/{productNo}",
			method=RequestMethod.GET)
	public String productDeleteImage(@PathVariable int productNo) {
		
	productService.deleteProductImage(productNo);

		return "redirect:/product/productUpdate/" + productNo;
	}
	
	@RequestMapping(path = "/productSearch", method = RequestMethod.GET)
	public String productSearch(String search, Model model, Product product) {
		
		List<Product> searchProduct = productService.searchProductByName(search);
		
		model.addAttribute("searchProduct", searchProduct); 
		model.addAttribute("search", search); 
		
		return "/product/productResultList";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
		
	}
	
}
