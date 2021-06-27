package com.bee.beeMarket.seller.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bee.beeMarket.admin.service.AdminServiceImpl;
import com.bee.beeMarket.seller.service.SellerServiceImpl;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("/seller/*")
@ResponseBody
public class RestSellerController {

	@Autowired
	private SellerServiceImpl sellerService;
	@Autowired
	private AdminServiceImpl adminService;

	@RequestMapping("existId.do")
	public HashMap<String, Object> existId(String seller_id) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		boolean existId = sellerService.existId(seller_id);

		map.put("result", "success");
		map.put("existId", existId);

		return map;
	}

	public HashMap<String, Object> getSessionSellerNo(HttpSession session) {

		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("result", "success");

		if (sellerVO != null) {
			map.put("seller_no", sellerVO.getSeller_no());
		} else {
			map.put("seller_no", null);
		}

		return map;
	}

	@RequestMapping("updateSellerInfo.do")
	public void updateSellerInfo(String seller_address, String seller_email, int bank_no, String seller_account,
			int seller_no) {
		/*
		 * System.out.println("주소는" + seller_address); System.out.println("이메일은" +
		 * seller_email); System.out.println("은행번호는" + bank_no);
		 * System.out.println("계좌번호는" + seller_account); System.out.println("셀러no" +
		 * seller_no);
		 */

		sellerService.updateSellerVO(seller_address, seller_email, bank_no, seller_account, seller_no);
	}

	// 통계데이터 가져오기
	@RequestMapping("getStatistics.do")
	public HashMap<String, Object> getData(HttpSession session, String order_orderdate) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		System.out.println("오더데이트는:" + order_orderdate);

		int seller_no = sellerVO.getSeller_no();
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> clickData = sellerService.getClickData(seller_no);
		ArrayList<HashMap<String, Object>> rankingData = sellerService.getRankingData(seller_no);
		ArrayList<HashMap<String, Object>> getDateData = sellerService.getDateData(seller_no, order_orderdate);

		map.put("clickData", clickData);
		map.put("rankingData", rankingData);
		map.put("getDateData", getDateData);
		for (int i = 0; i < getDateData.size(); i++) {
			System.out.println(getDateData.get(i).values());

		}

		return map;

	}

	// qna내용 가져오기
	@RequestMapping("getQnAContent.do")
	public HashMap<String, Object> getQnAContent(int no) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		HashMap<String, Object> map2 = sellerService.getContent(no, false);
		ArrayList<HashMap<String, Object>> commentList = adminService.getSellerQnAAnswerList(no);

		map.put("data", map2);
		map.put("commentList", commentList);
		return map;

	}

}
