package com.bee.beeMarket.commons.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class TestInterSeptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
		if(request.getSession().getAttribute("sessionCustomer") == null) {
			ModelAndView mav = new ModelAndView("customer/loginCustomerPage");
            mav.addObject("message", "추가 에트리뷰트");

            throw new ModelAndViewDefiningException(mav);
		}

		return super.preHandle(request, response, handler);
	}
}
