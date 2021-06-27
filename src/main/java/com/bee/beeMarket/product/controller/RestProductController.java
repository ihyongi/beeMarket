package com.bee.beeMarket.product.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Case;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.order.service.OrderServiceImpl;
import com.bee.beeMarket.product.service.ProductServiceImpl;
import com.bee.beeMarket.vo.CategoryDetailVO;
import com.bee.beeMarket.vo.ChatChannelVO;
import com.bee.beeMarket.vo.ChatVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.DiscountVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.ProductCommentVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.ProductWarehouseVO;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("/product/*")
@ResponseBody
public class RestProductController {

	@Autowired
	private ProductServiceImpl productService;

	@Autowired
	private CustomerServiceImpl customerService;
	
	@Autowired
	private OrderServiceImpl orderService;

	// 상품등록
	@RequestMapping("insertProduct.do")
	public void insertProduct(ProductVO productVO, HttpSession session, MultipartFile[] upload_files,
			String[] productdetail_option, int[] productdetail_price, int[] productwarehouse_pluscount) {
		// 상품이미지 업로드
		ArrayList<ProductImageVO> productImageList = new ArrayList<ProductImageVO>();
		if (upload_files != null) {
			for (MultipartFile upload_file : upload_files) {
				if (upload_file.isEmpty()) {
					continue;
				}
				// 파일이름 바꾸기
				String oriFileName = upload_file.getOriginalFilename();
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				String randomFileName = uuidName + "_" + currentTime + ext;

				// 날짜별 폴더 자동 생성...
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				String uploadFolderName = "C:/upload_files/" + newFolderName;
				File folder = new File(uploadFolderName);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String productboardImageFileLocation = uploadFolderName + "/" + randomFileName;

				try {
					upload_file.transferTo(new File(productboardImageFileLocation));
				} catch (Exception e) {
					e.printStackTrace();
				}

				ProductImageVO productImageVO = new ProductImageVO();
				productImageVO.setProductimage_location(newFolderName + "/" + randomFileName);
				productImageVO.setProductimage_orifilename(oriFileName);
				productImageList.add(productImageVO);
			}
		}
		// productVO
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();

		// ArrayList 생성
		ArrayList<ProductDetailVO> productDetailList = new ArrayList<ProductDetailVO>();
		ArrayList<ProductWarehouseVO> productWarehouseList = new ArrayList<ProductWarehouseVO>();

		try {
			for (int i = 0; i < productdetail_option.length; i++) {
				ProductDetailVO productDetailVO = new ProductDetailVO();
				productDetailVO.setProduct_no(productVO.getProduct_no());
				productDetailVO.setProductdetail_option(productdetail_option[i]);
				productDetailVO.setProductdetail_price(productdetail_price[i]);
				productDetailList.add(productDetailVO);
				System.out.println("option" + productdetail_option[i]);
				System.out.println("price" + productdetail_price[i]);

				ProductWarehouseVO productWarehouseVO = new ProductWarehouseVO();
				productWarehouseVO.setProductdetail_no(productDetailVO.getProductdetail_no());
				productWarehouseVO.setProductwarehouse_pluscount(productwarehouse_pluscount[i]);
				productWarehouseList.add(productWarehouseVO);
				System.out.println("plustcount" + productwarehouse_pluscount[i]);
			}

			productService.writeProductContent(productVO, productImageList, productDetailList, productWarehouseList);

		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("ArrayIndexOutOfBoundsException e 예외처리하였습니다.");
		}

	}

	// 등록한 상품목록 --판매자별
	   @RequestMapping("getProductListBySellerNo.do")
	   public HashMap<String, Object> getProductListBySellerNo(HttpSession session, Model model,
	         HttpServletRequest request, ProductVO productVO, @RequestParam(defaultValue = "1")int page_num) {
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
	      int seller_no = sellerVO.getSeller_no();
	      // 상품 목록
	      ArrayList<HashMap<String, Object>> productList = productService.getProductListBySellerNo(seller_no, session);
	      ArrayList<HashMap<String, Object>> onlyProductList = productService.getOnlyProductList(seller_no, page_num);
	      productVO.setSeller_no(seller_no);
	      int product_no = productVO.getProduct_no();
	      ArrayList<HashMap<String, Object>> getOptionList = productService.getOptionList(product_no);
	      map.put("getOptionList", getOptionList);
	      map.put("onlyProductList", onlyProductList);
	      
	      //0608페이징 관련 수정
	      //등록한 상품개수   
	        int totalCount = productService.getMyProductCount(seller_no);
	        System.out.println("토탈카운트 프로덕트:"+totalCount);
	      
	      //페이징처리--검색전
	      int totalPageCount=(int)Math.ceil(totalCount/7.0);
	      int currentPage=page_num;
	      map.put("totalPageCount", totalPageCount);
	      map.put("currentPage", currentPage);
	   
	      //뭘까............흠 긁어오기 ㅎ
	      int totalBeginPage=((currentPage-1)/7)*7+1;
	      int totalEndPage=((currentPage-1)/7+1)*(7);
	      if(totalEndPage>totalPageCount) {
	         totalEndPage=totalPageCount;
	         //
	         System.out.println("비긴페이지:"+totalBeginPage);
	         // 
	         System.out.println("엔드페이지:"+totalEndPage);
	         // 
	         System.out.println("토탈페이지:"+totalPageCount);
	         // 
	      }
	      map.put("totalBeginPage", totalBeginPage);
	      map.put("totalEndPage", totalEndPage);
	      map.put("totalCount", totalCount);
	      map.put("getOptionList", getOptionList);
	      map.put("productList", productList);
	       return map;
	   }

	// 상품옵션추가등록
	@RequestMapping("insertOptionProcess.do")
	public void insertOption(ProductDetailVO productDetailVO, ProductWarehouseVO productWarehouseVO,
			HttpServletRequest request) {
		int product_no = (Integer.parseInt(request.getParameter("product_no")));
		productDetailVO.setProduct_no(product_no);
		productDetailVO.setProductdetail_option(request.getParameter("productdetail_option"));
		productDetailVO.setProductdetail_price((Integer.parseInt(request.getParameter("productdetail_price"))));
		productWarehouseVO
				.setProductwarehouse_pluscount((Integer.parseInt(request.getParameter("productwarehouse_pluscount"))));
		System.out.println("pno:" + request.getParameter("product_no"));
		System.out.println("pdo:" + request.getParameter("productdetail_option"));
		System.out.println("pdp:" + request.getParameter("productdetail_price"));
		System.out.println("pwc:" + request.getParameter("productwarehouse_pluscount"));

		productService.insertOption(productDetailVO, productWarehouseVO);
	}

	// 옵션삭제
	@RequestMapping("deleteOptionProcess.do")
	public void deleteOptionProcess(HttpServletRequest request,
			@RequestParam(value = "productdetail_no", required = true) List<String> pdnoList) {
		for (String value : pdnoList) {
			System.out.println("들어온 value값들은:" + value);
			int productdetail_no = (Integer.parseInt(value));
			System.out.println("들어온 pdno값들은:" + productdetail_no);
			productService.deleteOption(productdetail_no);
		}

		System.out.println("들어온 길이는:" + pdnoList.size());

	}

	// 옵션리스트
	@RequestMapping("getOptionList.do")
	public HashMap<String, Object> getOptionList(int product_no, HttpServletRequest request, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		product_no = (Integer.parseInt(request.getParameter("product_no")));
		ArrayList<HashMap<String, Object>> getOptionList = productService.getOptionList(product_no);
		map.put("getOptionList", getOptionList);
		model.addAttribute("getOptionList", getOptionList);
		return map;
	}

	// 옵션수정
	@RequestMapping("updateCategoryDetailByNo.do")
	public HashMap<String, Object> updateCategoryDetailByNo(int category_no, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> categoryDetailList = productService
				.getCategoryDetailByCategoryNo(category_no);
		map.put("categoryDetailList", categoryDetailList);
		return map;
	}

	// 글내용불러오기
	@RequestMapping("getProductDetail.do")
	public HashMap<String, Object> getProductDetail(HttpSession session, HttpServletRequest request, Model model) {
		int product_no = (Integer.parseInt(request.getParameter("product_no")));
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> productContent = productService.getProductContent(session, product_no, false);
		ArrayList<HashMap<String, Object>> productDetail = productService.getProductDetailList(product_no);
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		int category_no = Integer.parseInt(request.getParameter("category_no"));
		ArrayList<HashMap<String, Object>> categoryDetailList = productService
				.getCategoryDetailByCategoryNo(category_no);
		ArrayList<HashMap<String, Object>> deliveryCompany = productService.getDeliveryCompany();
		map.put("productContent", productContent);
		map.put("productDetail", productDetail);
		map.put("categoryList", categoryList);
		map.put("categoryDetailList", categoryDetailList);
		map.put("deliveryCompany", deliveryCompany);
		return map;

	}

	// 상품등록 수정하기
	@RequestMapping("updateProduct.do")
	public void updateProduct(ProductVO productVO, HttpSession session, MultipartFile[] upload_files,
			int[] productdetail_no, String[] productdetail_option, int[] productdetail_price,
			int[] productwarehouse_pluscount) {
		// 상품이미지 업로드
		ArrayList<ProductImageVO> productImageList = new ArrayList<ProductImageVO>();
		if (upload_files != null) {
			for (MultipartFile upload_file : upload_files) {
				if (upload_file.isEmpty()) {
					continue;
				}
				// 파일이름 바꾸기
				String oriFileName = upload_file.getOriginalFilename();
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				String randomFileName = uuidName + "_" + currentTime + ext;

				// 날짜별 폴더 자동 생성...
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				String uploadFolderName = "C:/upload_files/" + newFolderName;
				File folder = new File(uploadFolderName);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String productboardImageFileLocation = uploadFolderName + "/" + randomFileName;

				try {
					upload_file.transferTo(new File(productboardImageFileLocation));
				} catch (Exception e) {
					e.printStackTrace();
				}

				ProductImageVO productImageVO = new ProductImageVO();
				productImageVO.setProductimage_location(newFolderName + "/" + randomFileName);
				productImageVO.setProductimage_orifilename(oriFileName);
				productImageList.add(productImageVO);
			}
		}
		// productVO
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();

		// ArrayList 생성
		ArrayList<ProductDetailVO> productDetailList = new ArrayList<ProductDetailVO>();
		ArrayList<ProductWarehouseVO> productWarehouseList = new ArrayList<ProductWarehouseVO>();

		try {
			for (int i = 0; i < productdetail_option.length; i++) {
				// productDetail정보 리스트에 담아서 service에 전달
				ProductDetailVO productDetailVO = new ProductDetailVO();
				productDetailVO.setProductdetail_no(productdetail_no[i]);
				productDetailVO.setProduct_no(productVO.getProduct_no());
				productDetailVO.setProductdetail_option(productdetail_option[i]);
				productDetailVO.setProductdetail_price(productdetail_price[i]);
				System.out.println("옵션" + productdetail_option[i]);
				System.out.println("가격" + productdetail_price[i]);
				productDetailList.add(productDetailVO);

				// 창고 정보 리스트에 담기 good!!!^_^bb
				ProductWarehouseVO productWarehouseVO = new ProductWarehouseVO();
				productWarehouseVO.setProductdetail_no(productDetailVO.getProductdetail_no());
				productWarehouseVO.setProductwarehouse_pluscount(productwarehouse_pluscount[i]);
				System.out.println("수량" + productwarehouse_pluscount[i]);
				productWarehouseList.add(productWarehouseVO);
			}

			productService.updateProductContent(productVO, productImageList, productDetailList, productWarehouseList);

		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("ArrayIndexOutOfBoundsException e 예외처리하였습니다.");
		}

	}

	// 상품삭제하기
	@RequestMapping("deleteProductByProductNo.do")
	public void deleteProductByProductNo(HttpServletRequest request) {
		int product_no = Integer.parseInt(request.getParameter("product_no"));
		// System.out.println("ajax넘어간 pno값은?" + product_no);
		productService.deleteProduct(product_no);
	}

	// 재고추가
	@RequestMapping("updateWarehousePluscount.do")
	public void updateWarehousePluscount(int productdetail_no, int add_pluscount) {
		// System.out.println("pdno값은?" + productdetail_no);
		// System.out.println("add값은?" + add_pluscount);
		productService.updateProductWarehousePluscount(productdetail_no, add_pluscount);
		customerService.insertAlarm(productdetail_no);
	}

	// 할인등록하기전 물품내역
	@RequestMapping("writeDiscount.do")
	public HashMap<String, Object> writeDiscount(HttpSession session) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> sellerProductListN = productService.getSellerProductListN(seller_no, session);
		ArrayList<HashMap<String, Object>> sellerProductListY = productService.getSellerProductListY(seller_no, session);

		map.put("sellerProductListN", sellerProductListN);
		map.put("sellerProductListY", sellerProductListY);
		
		/*
		 * //0608페이징 관련 수정 //등록한 상품옵션개수 int totalCount =
		 * productService.getMyProductDetailCount(seller_no);
		 * System.out.println("토탈카운트 프로덕트:"+totalCount);
		 * 
		 * //페이징처리--검색전 int totalPageCount=(int)Math.ceil(totalCount/7.0); int
		 * currentPage=page_num; map.put("totalPageCount", totalPageCount);
		 * map.put("currentPage", currentPage);
		 * 
		 * //뭘까............흠 긁어오기 ㅎ int totalBeginPage=((currentPage-1)/7)*7+1; int
		 * totalEndPage=((currentPage-1)/7+1)*(7); if(totalEndPage>totalPageCount) {
		 * totalEndPage=totalPageCount; // System.out.println("비긴페이지:"+totalBeginPage);
		 * // System.out.println("엔드페이지:"+totalEndPage); //
		 * System.out.println("토탈페이지:"+totalPageCount); // } map.put("totalBeginPage",
		 * totalBeginPage); map.put("totalEndPage", totalEndPage); map.put("totalCount",
		 * totalCount);
		 */
	      
		return map;
	}

	// 할인 인설트
	@RequestMapping("insertDiscount.do")
	public void insertDiscount(DiscountVO discountVO, HttpServletRequest request) throws ParseException {
		int productdetail_no = Integer.parseInt(request.getParameter("productdetail_no"));
		int discount_rate = Integer.parseInt(request.getParameter("discount_rate"));
		int productdetail_price = Integer.parseInt(request.getParameter("productdetail_price"));
		Date discount_begindate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("discount_begindate"));
		Date discount_enddate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("discount_enddate"));
		System.out.println("pdno:" + productdetail_no);
		System.out.println("pdp:" + productdetail_price);
		System.out.println("dr:" + discount_rate);
		System.out.println("dbd:" + discount_begindate);
		System.out.println("ded:" + discount_enddate);
		double percent = (double) (productdetail_price * (discount_rate * 0.01));
		System.out.println("차감될 가격" + percent);
		int discount_price = (int) (productdetail_price - percent);
		System.out.println("적용될 가격 :" + discount_price);

		discountVO.setProductdetail_no(productdetail_no);
		discountVO.setDiscount_price(discount_price);
		discountVO.setDiscount_begindate(discount_begindate);
		discountVO.setDiscount_enddate(discount_enddate);
		discountVO.setDiscount_rate(discount_rate);

		productService.insertProductDiscount(discountVO);

	}

	// 할인 삭제
	@RequestMapping("deleteDiscount.do")
	public void deleteDiscount(HttpServletRequest request) {
		int productdetail_no = Integer.parseInt(request.getParameter("productdetail_no"));
		productService.deleteDiscountProduct(productdetail_no);
	}

	// 할인 업데이트
	@RequestMapping("updateDiscount.do")
	public void updateDiscount(HttpServletRequest request) throws ParseException {
		int productdetail_no = Integer.parseInt(request.getParameter("productdetail_no"));
		int discount_rate = Integer.parseInt(request.getParameter("discount_rate"));
		int discount_price = Integer.parseInt(request.getParameter("discount_price"));
		Date discount_enddate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("discount_enddate"));
		System.out.println("pdno:" + productdetail_no);
		System.out.println("discountPrice:" + discount_price);
		System.out.println("dr:" + discount_rate);
		System.out.println("ded:" + discount_enddate);

		DiscountVO discountVO = new DiscountVO();
		discountVO.setProductdetail_no(productdetail_no);
		discountVO.setDiscount_enddate(discount_enddate);
		discountVO.setDiscount_price(discount_price);
		discountVO.setDiscount_rate(discount_rate);

		productService.updateDiscountInfo(discountVO);

	}

	// 제품 후기 작성
	@RequestMapping("writeComment.do")
	public void writeComment(HttpSession session, ProductCommentVO productcommentVO) {

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		productcommentVO.setCustomer_no(customerVO.getCustomer_no());

		productService.writeProductComment(productcommentVO);
	}

	// 제품 후기 삭제
	@RequestMapping("deleteComment.do")
	public void deleteComment(int productcomment_no) {
		productService.deleteProductComment(productcomment_no);
	}

	// 제품 후기 불러오기
	@RequestMapping("getCommentList.do")
	public ArrayList<HashMap<String, Object>> getCommentList(int product_no) {

		return productService.getProductCommentList(product_no);
	}
	
	//제품 후기 수정
	@RequestMapping("rewriteComment.do")
	public void rewriteComment(HttpSession session, ProductCommentVO productcommentVO) {
		
		CustomerVO customerVO = (CustomerVO)session.getAttribute("sessionCustomer");
		productcommentVO.setCustomer_no(customerVO.getCustomer_no());
		
		productService.updateProductComment(productcommentVO);
	}
	
	// 카테고리 리스트 불러오기
	@RequestMapping("getCategoryListBox.do")
	public ArrayList<HashMap<String, Object>> getCategoryListBox(String category_name) {

		return productService.getCategoryListByName(category_name);
	}

	// 쿠폰 입력
	@RequestMapping("insertCoupon.do")
	public void insertCoupon(HttpSession session, MyCouponVO myCouponVO) {

		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		myCouponVO.setCustomer_no(customerVO.getCustomer_no());

		productService.insertCoupon(myCouponVO);
	}

	// bestPage에서 category선택시 해당 상품으로 업데이트
	@RequestMapping("updateBestProductsByCategory.do")
	public ArrayList<HashMap<String, Object>> updateBestProductsByCategory(int category_no, int categorydetail_no) {

		return productService.updateBestProductsByCategory(category_no, categorydetail_no);
	}

	// searchPage에서 category선택시 해당 상품으로 업데이트
	@RequestMapping("updateSearchListByCategory.do")
	public ArrayList<HashMap<String, Object>> updateSearchListByCategory(String search_type, String search_word,
			int category_no, int categorydetail_no) {

		return productService.updateSearchListByCategory(search_type, search_word, category_no, categorydetail_no);
	}

	// 채팅
	// 0601 수정채팅
	@RequestMapping("main")
	public HashMap<String, Object> mainPage(HttpSession session, Model model, int chat_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");
		String fromMember = sessionCustomer.getCustomer_id();
		ChatChannelVO chatChannelVO = customerService.getChannelByCustomer_id(fromMember);
		int channel_no = chatChannelVO.getChannel_no();
		ArrayList<ChatVO> chatList = customerService.getChatList(channel_no);

		ArrayList<ChatVO> addChatList = customerService.getAddChatList(channel_no, chat_no);
		int count = customerService.getNextChat(channel_no, chat_no);
		System.out.println("그 이후 채팅수" + count);
		// 그다음값이 있는지여부
		if (customerService.getNextChat(channel_no, chat_no) == 0) {
			map.put("chatChannelVO", chatChannelVO);
			map.put("addChatList", addChatList);

			return map;
		} else {
			map.put("chatChannelVO", chatChannelVO);
			map.put("addChatList", addChatList);

			return map;
		}
	}

	// 0601수정!!
	@RequestMapping("insertChatLogProcessToAdmin.do")
	public void insertChatLogProcessToAdmin(HttpServletRequest request) {
		String message = request.getParameter("message");
		String fromMember = request.getParameter("customer_id");
		//System.out.println(message);
		//System.out.println(fromMember);
		int result = customerService.selectChatChannel(fromMember);
		//System.out.println("result:" + result);

		ChatChannelVO chatChannelVO = customerService.getChannelByCustomer_id(fromMember);
		int channel_no = chatChannelVO.getChannel_no();
		//System.out.println("channel_no:" + channel_no);
		customerService.insertChatLogProcessToAdmin(message, fromMember, channel_no);

	}

	// 상품정보가져오기(추가 0526)
	@RequestMapping("getProductDetailVO.do")
	public HashMap<String, Object> getProductDetailVO(int product_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> detailList = productService.getProductDetailVO(product_no);
		map.put("detailList", detailList);
		return map;
	}

	// 통계데이터 가져오기
	@RequestMapping("getOrderGenderChartData.do")
	public HashMap<String, Object> getOrderGenderChartData(int product_no) {
		HashMap<String, Object> ChartData = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> genderData = orderService.getOrderGenderChartData(product_no);
		ArrayList<HashMap<String, Object>> ageData = orderService.getOrderAgeChartData(product_no);
		/*
		ArrayList<HashMap<String, Object>> ageDataBF = orderService.getOrderAgeChartData(product_no);
		ArrayList<HashMap<String, Object>> ageData = new ArrayList<HashMap<String,Object>>();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		
		int order10th = 0;
		int order20th = 0;
		int order30th = 0;
		int order40th = 0;
		int order50th = 0;
		int order60th = 0;
		
		for (int i = 0; i < ageDataBF.size(); i++) {
			
			Date birth = (Date) ageDataBF.get(i).get("CUSTOMER_BIRTH");
			int thisYear = Integer.parseInt(sdf.format(date));
			int customerBirthYear = Integer.parseInt(sdf.format(birth));
			int age = thisYear-customerBirthYear+1;
			
			if (0 <= age && age < 20) {
				order10th = order10th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			} else if (20 <= age && age < 30) {
				order20th = order20th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			} else if (30 <= age && age < 40) {
				order30th = order30th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			} else if (40 <= age && age < 50) {
				order40th = order40th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			} else if (50 <= age && age < 60) {
				order50th = order50th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			} else {
				order60th = order60th + Integer.parseInt(String.valueOf(ageDataBF.get(i).get("ORDERCNT")));
			}
			
		}
		
		
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("CUSTOMER_BIRTH", "10 대");
		map1.put("ORDERCNT", order10th);
		ageData.add(map1);
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("CUSTOMER_BIRTH", "20 대");
		map2.put("ORDERCNT", order20th);
		ageData.add(map2);
		HashMap<String, Object> map3 = new HashMap<String, Object>();
		map3.put("CUSTOMER_BIRTH", "30 대");
		map3.put("ORDERCNT", order30th);
		ageData.add(map3);
		HashMap<String, Object> map4 = new HashMap<String, Object>();
		map4.put("CUSTOMER_BIRTH", "40 대");
		map4.put("ORDERCNT", order40th);
		ageData.add(map4);
		HashMap<String, Object> map5 = new HashMap<String, Object>();
		map5.put("CUSTOMER_BIRTH", "50 대");
		map5.put("ORDERCNT", order50th);
		ageData.add(map5);
		HashMap<String, Object> map6 = new HashMap<String, Object>();
		map6.put("CUSTOMER_BIRTH", "60 세 이상");
		map6.put("ORDERCNT", order60th);
		ageData.add(map6);
		
		ChartData.put("ageData", ageData);
		*/
		
		ChartData.put("genderData", genderData);
		ChartData.put("ageData", ageData);
		System.out.println(ageData);
		
		return ChartData;
	}
	
	// 마감일 이후 할인종료
	@RequestMapping("deleteDiscountForTime.do")
	public void deleteDiscountForTime(
			@RequestParam(value = "productdetail_no", required = true) List<String> pdnoList) {
		for (String value : pdnoList) {
			System.out.println("들어온 value값들은:" + value);
			int productdetail_no = (Integer.parseInt(value));
			System.out.println("들어온 pdno값들은:" + productdetail_no);
			productService.deleteDiscountProduct(productdetail_no);

		}
		// System.out.println("들어온 길이는:" + pdnoList.size());
	}
	
	// PDNO 개별로 가져오기(모달 전용)
	@RequestMapping("writeDiscountForModal.do")
	public HashMap<String, Object> writeDiscountForModal(int productdetail_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(productdetail_no);
		HashMap<String, Object> sellerProductListYByPdno = productService.getSellerProductListYByPdno(productdetail_no);
		map.put("sellerProductListYByPdno", sellerProductListYByPdno);
		return map;
	}

}
