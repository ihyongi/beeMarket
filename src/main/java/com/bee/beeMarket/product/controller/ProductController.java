package com.bee.beeMarket.product.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.customer.service.CustomerServiceImpl;
import com.bee.beeMarket.product.service.ProductServiceImpl;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.DiscountVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.ProductWarehouseVO;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("product/*")
public class ProductController {

	@Autowired
	private ProductServiceImpl productService;

	@Autowired
	private CustomerServiceImpl customerService;

	// 상품등록 페이지
	   @RequestMapping("writeProductContentPage.do")
	   public String writeProductContentPage(Model model, HttpSession session,@RequestParam(defaultValue = "1")int page_num) {
	      // 카테고리목록(categorydetail_no)
	      ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
	      model.addAttribute("categoryList", categoryList);

	      ArrayList<HashMap<String, Object>> categoryDetailList = productService.getCategoryDetailList();
	      model.addAttribute("categoryDetailList", categoryDetailList);

	      // 택배사목록(delivery_no)
	      ArrayList<HashMap<String, Object>> deliveryCompany = productService.getDeliveryCompany();
	      model.addAttribute("deliveryCompany", deliveryCompany);
	      
	      //0608페이징 관련 수정
	      SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
	      int seller_no = sellerVO.getSeller_no();
	            //등록한 상품개수   
	              int totalCount = productService.getMyProductCount(seller_no);
	              System.out.println("토탈카운트 프로덕트:"+totalCount);
	            
	            //페이징처리--검색전
	            int totalPageCount=(int)Math.ceil(totalCount/7.0);
	            int currentPage=page_num;
	            model.addAttribute("totalPageCount", totalPageCount);
	            model.addAttribute("currentPage", currentPage);
	         
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
	             model.addAttribute("totalBeginPage", totalBeginPage);
	             model.addAttribute("totalEndPage", totalEndPage);
	             model.addAttribute("totalCount", totalCount);
	      
	      return "product/writeProductContentPage";
	   }

	// 상품등록
	@RequestMapping("writeProductContentProcess.do")
	public String writeProductContentProcess(MultipartFile[] upload_files, ProductVO productVO, HttpSession session,
			HttpServletRequest request) {

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
		} /* if(upload_files != null) 끝 */

		// seller_no해결
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		int sessionNo = sessionSeller.getSeller_no();
		productVO.setSeller_no(sessionNo);

		// 인풋(네임 productdetail_option)개수 받아오기
		String[] option = request.getParameterValues("productdetail_option");
		String[] price = request.getParameterValues("productdetail_price");
		String[] plusCount = request.getParameterValues("productwarehouse_pluscount");

		// 받아온 값만큼 for문돌려서 삽입..흠.............
		ArrayList<ProductDetailVO> productDetailList = new ArrayList<>();
		ArrayList<ProductWarehouseVO> productWarehouseList = new ArrayList<ProductWarehouseVO>();

		for (int i = 0; i < option.length; i++) {
			// productDetail정보 리스트에 담아서 service에 전달
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO.setProductdetail_option(option[i]);
			productDetailVO.setProductdetail_price((Integer.parseInt(price[i])));
			System.out.println("상품번호" + productVO.getProduct_no());
			System.out.println("옵션" + option[i]);
			System.out.println("가격" + price[i]);
			productDetailList.add(productDetailVO);

			// 창고 정보 리스트에 담기 good!!!^_^bb
			ProductWarehouseVO productWarehouseVO = new ProductWarehouseVO();
			productWarehouseVO.setProductwarehouse_pluscount((Integer.parseInt(plusCount[i])));
			productWarehouseList.add(productWarehouseVO);
			System.out.println("수량" + plusCount[i]);
		}

		productService.writeProductContent(productVO, productImageList, productDetailList, productWarehouseList);

		return "redirect:../seller/sellerPage.do";

	}

	// 판매자가 작성한 본인상품 목록
	@RequestMapping("productList.do")
	public String productList(Model model, int seller_no, HttpSession session) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();
		System.out.println(seller_no);
		// 상품 목록
		ArrayList<HashMap<String, Object>> productList = productService.getProductListBySellerNo(seller_no, session);
		model.addAttribute("productList", productList);

		// 할인적용목록
		ArrayList<HashMap<String, Object>> sellerProductListY = productService.getSellerProductListY(seller_no, session);
		model.addAttribute("sellerProductListY", sellerProductListY);

		return "product/productList";
	}

	@RequestMapping("productList2.do")
	public String productList2(Model model, int seller_no, HttpSession session) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();
		System.out.println(seller_no);

		// 상품 목록(옵션별)
		ArrayList<HashMap<String, Object>> productList = productService.getProductListBySellerNo(seller_no, session);
		model.addAttribute("productList", productList);

		// 상품 목록(상품별)
		ArrayList<HashMap<String, Object>> productList1 = productService.getProductListBySellerNo1(seller_no, session);
		model.addAttribute("productList1", productList1);

		// 할인적용목록
		ArrayList<HashMap<String, Object>> sellerProductListY = productService.getSellerProductListY(seller_no, session);
		model.addAttribute("sellerProductListY", sellerProductListY);

		return "product/productList2";
	}

	// 상품수정하기
	// 작성한 내용가져오기
	@RequestMapping("updateProductContentPage.do")
	public String updateProductContentPage(HttpSession session, Model model, int product_no) {
		// 카테고리목록(category_no)
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);

		// 카테고리목록(categorydetail_no)
		ArrayList<HashMap<String, Object>> categoryDetailList = productService.getCategoryDetailList();
		model.addAttribute("categoryDetailList", categoryDetailList);

		// 택배사목록(delivery_no)
		ArrayList<HashMap<String, Object>> deliveryCompany = productService.getDeliveryCompany();
		model.addAttribute("deliveryCompany", deliveryCompany);

		// 상품상세내용
		HashMap<String, Object> map = productService.getProductContent(session, product_no, true);
		ArrayList<HashMap<String, Object>> list = productService.getProductDetailList(product_no);
		model.addAttribute("data", map); // productVO, sellerVO, productImageList ,deliveryVO, categoryVO,
											// categoryDetailVO
		model.addAttribute("list", list); // productWarehouseVO, productDetailVO, productWarehouseList,
											// productDetailList
		ArrayList<HashMap<String, Object>> getOptionList = productService.getOptionList(product_no);
		model.addAttribute("getOptionList", getOptionList);

		return "product/updateProductContentPage";
	}

	@RequestMapping("updateProductContentProcess.do")
	public String updateProductContentProcess(ProductVO productVO, HttpSession session, MultipartFile[] upload_files,
			HttpServletRequest request) {
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
		} /* if(upload_files != null) 끝 */

		// seller_no해결
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		int sessionNo = sessionSeller.getSeller_no();
		productVO.setSeller_no(sessionNo);

		// poroduct_no값 미리 셋팅
		int product_no = (Integer.parseInt(request.getParameter("product_no")));
		productVO.setProduct_no(product_no);

		// 인풋(네임 productdetail_option)개수 받아오기
		String[] no = request.getParameterValues("productdetail_no");
		String[] option = request.getParameterValues("productdetail_option");
		String[] price = request.getParameterValues("productdetail_price");
		String[] plusCount = request.getParameterValues("productwarehouse_pluscount");

		// 받아온 값만큼 for문돌려서 삽입..흠.............
		ArrayList<ProductDetailVO> productDetailList = new ArrayList<ProductDetailVO>();
		ArrayList<ProductWarehouseVO> productWarehouseList = new ArrayList<ProductWarehouseVO>();
		// System.out.println("렝스:"+option.length);
		try {
			for (int i = 0; i < option.length; i++) {
				// productDetail정보 리스트에 담아서 service에 전달
				ProductDetailVO productDetailVO = new ProductDetailVO();

				productDetailVO.setProductdetail_no(Integer.parseInt(no[i]));
				productDetailVO.setProduct_no(product_no);
				productDetailVO.setProductdetail_option(option[i]);
				productDetailVO.setProductdetail_price((Integer.parseInt(price[i])));
				System.out.println("상품번호" + request.getParameter("product_no"));
				System.out.println("옵션" + option[i]);
				System.out.println("가격" + price[i]);
				productDetailList.add(productDetailVO);

				// 창고 정보 리스트에 담기 good!!!^_^bb
				ProductWarehouseVO productWarehouseVO = new ProductWarehouseVO();
				productWarehouseVO.setProductdetail_no(Integer.parseInt(no[i]));
				productWarehouseVO.setProductwarehouse_pluscount((Integer.parseInt(plusCount[i])));
				System.out.println("수량" + plusCount[i]);
				productWarehouseList.add(productWarehouseVO);
			}

			productService.updateProductContent(productVO, productImageList, productDetailList, productWarehouseList);

		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("ArrayIndexOutOfBoundsException e 예외처리하였습니다.");
		}

		return "redirect:../seller/sellerPage.do";
	}
	
	// 메인페이지
	@RequestMapping("productMainPage.do")
	public String productMainPage(Model model) {
		
		ArrayList<HashMap<String, Object>> allDataList = productService.getProductList();
		model.addAttribute("allDataList", allDataList);
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		ArrayList<HashMap<String, Object>> bestProductDataList = productService.getProductOrderByBestOrdered();
		model.addAttribute("bestProductDataList", bestProductDataList);
		
		return "product/productMainPage";
	}
	
	
	// 검색 페이지
	@RequestMapping("productSearchList.do")
	public String productSearchList(Model model, String search_type, String search_word) {
		ArrayList<HashMap<String, Object>> productList = productService.getProductSearchList(search_type, search_word);
		model.addAttribute("productList", productList);
		model.addAttribute("search_word", search_word);
		model.addAttribute("search_type", search_type);
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		ArrayList<HashMap<String, Object>> getCategoryList = productService.getCategoryList();
		model.addAttribute("getCategoryList", getCategoryList);
		return "product/productSearchList";
	}

	// 0531
	// 상품 상세 페이지
	@RequestMapping("productDetailPage.do")
	public String productDetailPage(HttpSession session, Model model, int product_no) {
		
		CustomerVO customerVO = (CustomerVO) session.getAttribute("sessionCustomer");
		if (customerVO != null) {
			int customer_no = customerVO.getCustomer_no();
			int myLikeCount = customerService.getMyLikeCount(customer_no, product_no);
			model.addAttribute("myLikeCount", myLikeCount);
		}
		
		HashMap<String, Object> allDataList = productService.getProductDetail(product_no);
		ArrayList<HashMap<String, Object>> allDataList2 = productService.getProductDetail2(product_no);
		model.addAttribute("allDataList", allDataList);
		model.addAttribute("allDataList2", allDataList2);
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		// 조회수증가
		productService.increaseReadcount(product_no);
		return "product/productDetailPage";
	}

	// Best 상품 페이지
	@RequestMapping("productBestPage.do")
	public String productBestPage(Model model) {
		ArrayList<HashMap<String, Object>> bestProductDataList = productService.getProductOrderByBestOrdered();
		model.addAttribute("bestProductDataList", bestProductDataList);
		ArrayList<HashMap<String, Object>> getCategoryList = productService.getCategoryList();
		model.addAttribute("getCategoryList", getCategoryList);
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		return "product/productBestPage";
	}

	// 상품 할인 등록페이지 ->판매자 본인이 판매하는 목록들 나오고...... product_no로 여러개 들어갈 수있음....
	@RequestMapping("writeDiscountProductPage.do")
	public String writeDiscountProductPage(Model model, @RequestParam(defaultValue = "1")int page_num, HttpSession session) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		ArrayList<HashMap<String, Object>> sellerProductListN = productService.getSellerProductListN(seller_no, session);
		ArrayList<HashMap<String, Object>> sellerProductListY = productService.getSellerProductListY(seller_no, session);
		// 할인적용N
		model.addAttribute("sellerProductListN", sellerProductListN);
		// 할인적용Y
		model.addAttribute("sellerProductListY", sellerProductListY);
		
		//0608페이징 관련 수정
	            //등록한 상품개수   
	              int totalCount = productService.getMyProductDetailCount(seller_no);
	              System.out.println("토탈카운트 프로덕트:"+totalCount);
	            
	            //페이징처리--검색전
	            int totalPageCount=(int)Math.ceil(totalCount/7.0);
	            int currentPage=page_num;
	            model.addAttribute("totalPageCount", totalPageCount);
	            model.addAttribute("currentPage", currentPage);
	         
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
	             model.addAttribute("totalBeginPage", totalBeginPage);
	             model.addAttribute("totalEndPage", totalEndPage);
	             model.addAttribute("totalCount", totalCount);
	      

		return "product/writeDiscountProductPage";
	}

	@RequestMapping("writeDiscountProductProcess.do")
	public String writeDiscountProductProcess(Model model, DiscountVO discountVO, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int discount_rate = (Integer.parseInt(request.getParameter("discount_rate")));
		int productdetail_price = (Integer.parseInt(request.getParameter("productdetail_price")));
		/*
		System.out.println("할인률" + discount_rate);
		System.out.println("본가격" + productdetail_price)
		*/;
		double percent = (double) (productdetail_price * (discount_rate * 0.01));
		/*
		System.out.println("할인률 적용된 가격" + percent);
		*/
		int discount_price = (int) (productdetail_price - percent);
		/*
		System.out.println("적용될 가격 :" + discount_price);
		*/
		discountVO.setDiscount_price(discount_price);

		// insert하면서 update
		productService.insertProductDiscount(discountVO);
		return "redirect:./writeDiscountProductPage.do";
	}

	@RequestMapping("updateDiscountProductProcess.do")
	public String updateDiscountProductProcess(HttpServletRequest request, DiscountVO discountVO) throws Exception {
		HttpSession session = request.getSession();
		// 세션에 no값 없으면 수정 불가
		if (session.getAttribute("seller_no") != null) {
			productService.updateDiscountInfo(discountVO);

			int productdetail_no = (Integer.parseInt(request.getParameter("productdetail_no")));
			discountVO.setProductdetail_no(productdetail_no);
			Date discount_enddate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("discount_enddate"));
			discountVO.setDiscount_enddate(discount_enddate);
			int discount_rate = (Integer.parseInt(request.getParameter("discount_rate")));
			discountVO.setDiscount_rate(discount_rate);
			int discount_price = (Integer.parseInt(request.getParameter("discount_price")));
			discountVO.setDiscount_price(discount_price);
			
			/*
			System.out.println(productdetail_no);
			System.out.println(discount_enddate);
			System.out.println(discount_rate);
			System.out.println(discount_price);

			System.out.println(productdetail_no);
			System.out.println("디테일 넘:" + request.getParameter("productdetail_no"));
			System.out.println("변경할 마감일:" + request.getParameter("discount_enddate"));
			System.out.println("변경할 할인율:" + request.getParameter("discount_rate") + "%");
			System.out.println("최종 적용될 할인가:" + request.getParameter("discount_price"));
			*/
		}

		return "redirect:./writeDiscountProductPage.do";
	}

	// 쿠폰 이벤트 페이지
	@RequestMapping("CouponEventPage.do")
	public String CouponEventPage(HttpSession session, Model model) {
		
		ArrayList<HashMap<String, Object>> categoryList = productService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		ArrayList<HashMap<String, Object>> allCouponList = productService.getCouponlist();
		model.addAttribute("allCouponList", allCouponList);

		return "product/CouponEvent";
	}

	// 메인페이지 채팅
	@RequestMapping("tempChat.do")
	public String tempChat() {
		return "product/tempChat";
	}

	@RequestMapping("Chat.do")
	public String Chat() {
		return "product/Chat";
	}

	// 채팅 테스트 5.26
	@RequestMapping("main2")
	public String main2() {
		return "product/tempChatTEST";
	}

}
