package com.bee.beeMarket.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bee.beeMarket.product.controller.ProductController;

@Controller
public class Main {
	
	@Autowired
	private ProductController productController;
	
	@RequestMapping("/")
	public String test(Model model) {
		return productController.productMainPage(model);
	}
}
