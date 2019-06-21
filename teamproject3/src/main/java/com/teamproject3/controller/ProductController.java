package com.teamproject3.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teamproject3.service.ProductOrderService;
import com.teamproject3.service.ProductService;
import com.teamproject3.util.CountHelper;
import com.teamproject3.util.Pagination;
import com.teamproject3.vo.Product;
import com.teamproject3.vo.ProductOrder;

@Controller
public class ProductController {
	
	private static Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Inject ProductOrderService productOrderService;
	@Inject CountHelper countHelper;
	
	@RequestMapping(
			value="/productList",
			method=RequestMethod.GET)
	public String productList(Model model) {
		
		List<Product> products = productService.findAllProduct();
		
		model.addAttribute("products", products);
		
		return "product/productList";
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
			
		return "redirect:productList";
	}

	@RequestMapping(
			value="/product/productUpdate/{productNo}",
			method=RequestMethod.GET)
	public String productUpdateForm(@PathVariable int productNo, Model model) {
		
		Product product = productService.findByProductNo(productNo);
		if (product == null) {
			return "redirect:product/productList";
		}
		
		//조회 결과를 request 객체에 저장 (JSP에서 사용할 수 있도록)
		model.addAttribute("product", product);
		
		return "product/productUpdate";
	}
	
	@RequestMapping(path="product/productUpdate",
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
			return "redirect:/productDetail/" + product.getProductNo();
		}
		return "redirect:/productDetail/" + product.getProductNo();
	}
	
	@RequestMapping(
			value="/productDelete/{productNo}",
			method=RequestMethod.GET)
	public String productDelete(@PathVariable int productNo) {
		
		productService.deleteProduct(productNo);
		
		return "redirect:/productList";
	}
	
	@RequestMapping(
			value="/product/deleteImage/{productNo}",
			method=RequestMethod.GET)
	public String productDeleteImage(@PathVariable int productNo) {
		
	productService.deleteProductImage(productNo);

		return "redirect:/product/productUpdate/" + productNo;
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
		
	}
	
	/*
	 * 요청 페이지, 승인 여부를 가지고 Product 주문 내역을 가져옴
	 */
	@RequestMapping(
			path="/product/getProductList",
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getProductList(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="email") String email,
			@RequestParam(value="approved", defaultValue="all") String approved) {
		
		// 승인 여부에 따라 구매 내역 갯수를 구함
		int count = countHelper.getCountForProductList(email);

		// 페이징 객체 생성
		Pagination pagination = new Pagination(page, count, 10, 3);
		int start = pagination.getPageBegin();
		int end = pagination.getPageEnd();

		// 요청 페이지에 따른 튜플만 가져옴
		List<ProductOrder> orders = productOrderService.findAll(start, end, approved, email);
		
		logger.debug("[{}]의 구매내역 : {}", email, orders);
		
		// 결과 리턴
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("productOrderList", orders);
		resultMap.put("pagination", pagination);
		
		return resultMap;
	}
	
	/*
	 * 등록되어 있는 상품 목록 전부를 가져옴
	 */
	@Cacheable
	@RequestMapping(
			path="/product/getAllProducts", 
			method=RequestMethod.GET,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getAllProducts() {
		List<Product> products = productService.findAllProduct();
		Map<String, Object> result = new HashMap<>();
		result.put("products", products);
		return result;
	}
	
}
