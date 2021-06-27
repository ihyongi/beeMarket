package com.bee.beeMarket.fleemarket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bee.beeMarket.fleemarket.service.FleeMarketServiceImpl;
import com.bee.beeMarket.fleeorder.service.FleeOrderServiceImpl;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.FleeMarketCommentVO;

@Controller
@RequestMapping("/fleemarket/*")
@ResponseBody
public class RestFleeMarketController {
	
	@Autowired
	private FleeMarketServiceImpl fleeMarketService;
	
	@Autowired
	private FleeOrderServiceImpl fleeOrderService;
	
	@RequestMapping("orderDataLoarding.do")
	public HashMap<String, Object> orderDataLoarding(int fleemarket_no) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		
		
		ArrayList<HashMap<String, Object>> totalMap = fleeMarketService.selectOrderListByCustomerToSeller(fleemarket_no);
		
		map.put("totalMap", totalMap);
		
		return map;
	}
	
	
	
	//신청
	@RequestMapping("applicant.do")
	public void applicant(HttpSession session, int fleemarket_no) {
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		int customer_no = customerVO.getCustomer_no();
		
		fleeMarketService.applicant(fleemarket_no, customer_no);
		
		
	}
	
	//신청데이터 가져오
	@RequestMapping("getApplicantData.do")
	public HashMap<String, Object> getApplicantData(HttpSession session, int fleemarket_no){
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		
		int applicantCount = fleeMarketService.getApplicantCount(fleemarket_no);
		map.put("applicantTotalCount", applicantCount);
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		if(customerVO != null) {
			int customer_no = customerVO.getCustomer_no();
			int myApplicantCount = fleeMarketService.getMyApplicantCount(fleemarket_no, customer_no);
			map.put("myApplicantCount", myApplicantCount);
		}else {
			map.put("myApplicantCount", 0);
		}
		
		return map;
		
	}
	//댓글 쓰기
	@RequestMapping("writeComment.do")
	public void writeComment(HttpSession session, FleeMarketCommentVO fleeMarketCommentVO,int fleemarket_no) {
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		fleeMarketCommentVO.setCustomer_no(customerVO.getCustomer_no());
		
		fleeMarketService.insertComment(fleemarket_no ,fleeMarketCommentVO);
		
	}
	//댓글 삭제
	@RequestMapping("deleteComment.do")
	public void deleteComment(int comment_no) {
		fleeMarketService.deleteComment(comment_no);
	}
	
	//댓글리시트 뽑기
	@RequestMapping("getCommentList.do")
	public ArrayList<HashMap<String,Object>> getCommentList(int fleemarket_no){
		
		return fleeMarketService.getCommentList(fleemarket_no);
	
	}
	
	//제품 후기 수정
	@RequestMapping("rewriteComment.do")
	public void rewriteComment(HttpSession session, FleeMarketCommentVO fleeMarketCommentVO) {
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		fleeMarketCommentVO.setCustomer_no(customerVO.getCustomer_no());
		
		fleeMarketService.updateComment(fleeMarketCommentVO);
	}
		
		
		
	// 통계데이터 가져오기 (06.08)
	@RequestMapping("getOrderGenderChartData.do")
	public HashMap<String, Object> getOrderGenderChartData(int fleemarket_no) {
		
		HashMap<String, Object> ChartData = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> genderData = fleeOrderService.getOrderFleeGenderChartData(fleemarket_no);
		ArrayList<HashMap<String, Object>> ageData = fleeOrderService.getOrderFleeAgeChartData(fleemarket_no);
		
		ChartData.put("genderData", genderData);
		ChartData.put("ageData", ageData);
		System.out.println(ageData);
		
		return ChartData;
	}
	
	
	
}
