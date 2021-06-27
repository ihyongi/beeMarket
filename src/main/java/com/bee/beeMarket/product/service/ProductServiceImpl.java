package com.bee.beeMarket.product.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.customer.mapper.CustomerSQLMapper;
import com.bee.beeMarket.product.mapper.ProductSQLMapper;
import com.bee.beeMarket.seller.mapper.SellerSQLMapper;
import com.bee.beeMarket.vo.CategoryDetailVO;
import com.bee.beeMarket.vo.CategoryVO;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.CustomerVO;
import com.bee.beeMarket.vo.DeliveryVO;
import com.bee.beeMarket.vo.DiscountVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.ProductCommentVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.ProductWarehouseVO;
import com.bee.beeMarket.vo.SellerVO;

@Service
public class ProductServiceImpl {

	@Autowired
	private ProductSQLMapper productSQLMapper;

	@Autowired
	private SellerSQLMapper sellerSQLMapper;

	@Autowired
	private CustomerSQLMapper customerSQLMapper;

	// 상품등록페이지
	public int getProductNoCreateKey() {
		return productSQLMapper.createProductKey();
	}

	public int getProductDetailNoCreateKey() {
		return productSQLMapper.createProductDetailKey();
	}

	// 상품등록페이지
	public void writeProductContent(ProductVO productVO, ArrayList<ProductImageVO> productImageList,
			ArrayList<ProductDetailVO> productDetailList, ArrayList<ProductWarehouseVO> productWarehouseList) {

		// productVO insert
		int product_no = productSQLMapper.createProductKey();
		productVO.setProduct_no(product_no);
		productSQLMapper.insertProduct(productVO);

		// 상품이미지 등록
		for (ProductImageVO productImageVO : productImageList) {
			int productimage_no = productSQLMapper.createProductImageKey();
			productImageVO.setProductimage_no(productimage_no);
			productImageVO.setProduct_no(productVO.getProduct_no());
			productSQLMapper.insertProductImage(productImageVO);
		}

		// 상품 디테일 요소(옵션(색상, 사이즈)) --행복하다....
		for (int i = 0; i < productDetailList.size(); i++) {
			ProductDetailVO productDetailVO = productDetailList.get(i);
			int productdetail_no = productSQLMapper.createProductDetailKey();
			productDetailVO.setProductdetail_no(productdetail_no);
			productDetailVO.setProduct_no(product_no);
			productSQLMapper.insertProductDetail(productDetailVO);

			ProductWarehouseVO productWarehouseVO = productWarehouseList.get(i);
			int productwarehouse_no = productSQLMapper.createProductWarehouseKey();
			productWarehouseVO.setProductwarehouse_no(productwarehouse_no);
			productWarehouseVO.setProductdetail_no(productdetail_no);
			productSQLMapper.insertProductwarehouse(productWarehouseVO);
		}

	}

	// 카테고리 리스트 (대분류)
	public ArrayList<HashMap<String, Object>> getCategoryList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<CategoryVO> CategoryList = productSQLMapper.getCategoryList();
		for (CategoryVO categoryVO : CategoryList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryVO", categoryVO);
			result.add(map);
		}
		return result;
	}

	// 카테고리 디테일 리스트 (중분류)
	public ArrayList<HashMap<String, Object>> getCategoryDetailList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<CategoryDetailVO> CategoryDetailList = productSQLMapper.getCategoryDetailList();
		for (CategoryDetailVO categoryDetailVO : CategoryDetailList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryDetailVO", categoryDetailVO);
			result.add(map);
		}
		return result;
	}

	// 택배회사 지정--필요한거 delivery_no
	public ArrayList<HashMap<String, Object>> getDeliveryCompany() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<DeliveryVO> list = productSQLMapper.getDeliveryCompany();
		for (DeliveryVO deliveryVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("deliveryVO", deliveryVO);
			result.add(map);
		}
		return result;
	}

	// 상품 목록페이지 -- 글 여러개(상품별로)
	public ArrayList<HashMap<String, Object>> getProductListBySellerNo1(int seller_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();

		ArrayList<ProductVO> productList = productSQLMapper.getProductBySellerNo(seller_no);
		for (ProductVO productVO : productList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("productVO", productVO);

			result.add(map);
		}

		return result;

	}

	// 상품 목록페이지 -- 글 여러개(옵션별로 )
	public ArrayList<HashMap<String, Object>> getProductListBySellerNo(int seller_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();

		ArrayList<ProductVO> productList = productSQLMapper.getProductBySellerNo(seller_no);
		for (ProductVO productVO : productList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int delivery_no = productVO.getDelivery_no();
			int product_no = productVO.getProduct_no();
			int category_no = productSQLMapper.getProductCategory(product_no);
			CategoryVO categoryVO = new CategoryVO();
			categoryVO.setCategory_no(category_no);
			CategoryDetailVO categoryDetailVO = new CategoryDetailVO();
			categoryDetailVO.setCategory_no(category_no);

			ArrayList<ProductImageVO> productImageVO = productSQLMapper.selectProductImageByProductNo(product_no);
			ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
			for (ProductDetailVO productDetailVO : productDetailList) {
				productDetailVO.setProduct_no(product_no);
				int productdetail_no = productDetailVO.getProductdetail_no();
				ProductWarehouseVO productWarehouseVO = productSQLMapper
						.selectWarehouseByProductDetailNo(productdetail_no);
				DeliveryVO deliveryVO = new DeliveryVO();
				deliveryVO = productSQLMapper.getDeliveryCompanyName(product_no);
				map = new HashMap<String, Object>();
				map.put("productVO", productVO);
				map.put("sellerVO", sellerVO);
				map.put("deliveryVO", deliveryVO);
				map.put("productImageVO", productImageVO);
				map.put("productDetailVO", productDetailVO);
				map.put("productWarehouseVO", productWarehouseVO);
				map.put("productList", productList);
				map.put("productDetailList", productDetailList);
				map.put("categoryVO", categoryVO);
				map.put("categoryDetailVO", categoryDetailVO);

				ArrayList<DiscountVO> discountList = productSQLMapper.getDiscountByDetailNo(productdetail_no);
				for (DiscountVO discountVO : discountList) {
					map.put("discountVO", discountVO);
				}

				result.add(map);

			}
		}
		return result;

	}

	// 상품상세페이지 productWarehouseVO, productDetailVO, productWarehouseList,
	// productDetailList --list 글 하나씩 읽기
	public ArrayList<HashMap<String, Object>> getProductDetailList(int product_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
		for (ProductDetailVO productDetailVO : productDetailList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			productDetailVO.setProduct_no(product_no);
			System.out.println("product_no:" + product_no);
			int productdetail_no = productDetailVO.getProductdetail_no();
			System.out.println("productdetail_no:" + productdetail_no);
			map.put("productDetailList", productDetailList);

			ProductWarehouseVO productWarehouseVO = productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
			productWarehouseVO.setProductdetail_no(productdetail_no);
			System.out.println("productwarehouse_no:" + productWarehouseVO.getProductwarehouse_no());

			map = new HashMap<String, Object>();
			map.put("productWarehouseVO", productWarehouseVO);
			map.put("productDetailVO", productDetailVO);
			map.put("productWarehouseVO", productWarehouseVO);
			result.add(map);
		}
		return result;
	}

	// productVO, sellerVO, productImageList --data
	public HashMap<String, Object> getProductContent(HttpSession session, int product_no, boolean isEscapeHtml) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sessionSeller.getSeller_no();
		ProductVO productVO = productSQLMapper.readProduct(product_no);
		productVO.setSeller_no(seller_no);
		SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);
		DeliveryVO deliveryVO = productSQLMapper.getDeliveryCompanyName(productVO.getProduct_no());
		int category_no = productSQLMapper.getProductCategory(product_no);
		CategoryVO categoryVO = new CategoryVO();
		categoryVO.setCategory_no(category_no);
		CategoryDetailVO categoryDetailVO = new CategoryDetailVO();
		categoryDetailVO.setCategory_no(category_no);

		ArrayList<ProductImageVO> productImageList = productSQLMapper.selectProductImageByProductNo(product_no);

		// enter처리
		if (isEscapeHtml) {
			String content = productVO.getProduct_content();
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			productVO.setProduct_content(content);
		}

		map.put("productVO", productVO);
		map.put("deliveryVO", deliveryVO);
		map.put("categoryVO", categoryVO);
		map.put("categoryDetailVO", categoryDetailVO);
		map.put("sellerVO", sellerVO);
		map.put("productImageList", productImageList);

		return map;
	}

	// 조회수 증가
	public void increaseReadcount(int product_no) {
		productSQLMapper.increaseReadcount(product_no);
	}

	// 상품 수정
	public void updateProductContent(ProductVO productVO, ArrayList<ProductImageVO> productImageList,
			ArrayList<ProductDetailVO> productDetailList, ArrayList<ProductWarehouseVO> productWarehouseList) {
		
		// product table에 productVO update
		productSQLMapper.updateProduct(productVO);

		// 상품이미지 update
		for (ProductImageVO productImageVO : productImageList) {
			int product_no = productVO.getProduct_no();
			productImageVO.setProduct_no(product_no);
			productSQLMapper.updateProductImage(productImageVO);
			System.out.println("수정하기에서 오는 pno값:" + product_no);
		}

		// 상품 디테일 요소(옵션(색상, 사이즈))
		for (int i = 0; i < productDetailList.size(); i++) {
			int product_no = productVO.getProduct_no();
			ProductDetailVO productDetailVO = productDetailList.get(i);
			System.out.println(productDetailList.get(i).getProductdetail_no());
			productDetailVO.setProduct_no(product_no);
			productDetailVO.setProductdetail_no(productDetailList.get(i).getProductdetail_no());
			productSQLMapper.updateProductDetail(productDetailVO);

			ProductWarehouseVO productWarehouseVO = productWarehouseList.get(i);
			productWarehouseVO.setProductdetail_no(productDetailVO.getProductdetail_no());
			productSQLMapper.updateProductwarehouse(productWarehouseVO);
		}

	}

	// 메인화면 상품 게시글 가져오기(상품 판매 목록)
	public ArrayList<HashMap<String, Object>> getProductList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<CategoryVO> categoryVOList = productSQLMapper.getCategoryList();
		for (CategoryVO categoryVO : categoryVOList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			ArrayList<ProductVO> productVOList = productSQLMapper
					.getProductListByCategoryNo(categoryVO.getCategory_no());

			ArrayList<HashMap<String, Object>> innerList = new ArrayList<HashMap<String, Object>>();
			for (ProductVO productVO : productVOList) {
				HashMap<String, Object> innerMap = new HashMap<String, Object>();
				int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(productVO.getProduct_no());
				ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(productVO.getProduct_no());
				int category_no = productVO.getCategorydetail_no();
				String categoryDetailName = productSQLMapper.getCategoryDetailNameByCategoryDetailNo(category_no);

				innerMap.put("productVO", productVO);
				innerMap.put("minimumPrice", minimumPrice);
				innerMap.put("productImageVO", productImageVO);
				innerMap.put("categoryDetailName", categoryDetailName);

				innerList.add(innerMap);
			}

			map.put("categoryVO", categoryVO);
			map.put("mainPageProductInfoList", innerList);

			result.add(map);
		}

		return result;
	}

	// 검색화면 상품 게시글 가져오기(검색목록)
	public ArrayList<HashMap<String, Object>> getProductSearchList(String search_type, String search_word) {

		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductVO> productList = productSQLMapper.selectProductList(search_type, search_word);

		for (ProductVO productVO : productList) {

			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			int product_no = productVO.getProduct_no();
			ArrayList<ProductImageVO> productImageVO = productSQLMapper.selectProductImageByProductNo(product_no);
			int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(product_no);

			int categorydetail_no = productVO.getCategorydetail_no();
			CategoryDetailVO categoryDetailVO = productSQLMapper.getCategoryDetailByNo(categorydetail_no);

			int category_no = categoryDetailVO.getCategory_no();
			String category_name = productSQLMapper.getCategoryNameByNo(category_no);

			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);
			resultMap.put("minimumPrice", minimumPrice);
			resultMap.put("categoryDetailVO", categoryDetailVO);
			resultMap.put("category_name", category_name);
			resultMap.put("category_no", category_no);

			resultList.add(resultMap);

		}

		return resultList;

	}

	// 판매자의 상품판매목록 --할인적용 N
	public ArrayList<HashMap<String, Object>> getSellerProductListN(int seller_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();

		ArrayList<ProductVO> getProductList = productSQLMapper.getProductBySellerNo(seller_no);
		for (ProductVO productVO : getProductList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int product_no = productVO.getProduct_no();
			System.out.println("pno:" + product_no);

			ArrayList<ProductDetailVO> productDetailVOList = productSQLMapper.getNProductDetailByNo(product_no);
			for (ProductDetailVO productDetailVO : productDetailVOList) {
				productDetailVO.setProduct_no(product_no);
				int productdetail_no = productDetailVO.getProductdetail_no();
				productDetailVO.setProductdetail_no(productdetail_no);
				int productdetail_price = productDetailVO.getProductdetail_price();
				productDetailVO.setProductdetail_price(productdetail_price);
				String productdetail_option = productDetailVO.getProductdetail_option();
				productDetailVO.setProductdetail_option(productdetail_option);

				map = new HashMap<String, Object>();
				map.put("productVO", productVO);
				map.put("productDetailVO", productDetailVO);

				result.add(map);
			}
		}

		return result;
	}

	
	// 판매자의 상품판매목록 --할인적용 Y
	public ArrayList<HashMap<String, Object>> getSellerProductListY(int seller_no, HttpSession session) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		seller_no = sellerVO.getSeller_no();

		ArrayList<ProductVO> getProductList = productSQLMapper.getProductBySellerNo(seller_no);
		for (ProductVO productVO : getProductList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int product_no = productVO.getProduct_no();
			System.out.println("pno:" + product_no);

			ArrayList<ProductDetailVO> productDetailVOList = productSQLMapper.getYProductDetailByNo(product_no);
			for (ProductDetailVO productDetailVO : productDetailVOList) {
				productDetailVO.setProduct_no(product_no);
				int productdetail_no = productDetailVO.getProductdetail_no();
				productDetailVO.setProductdetail_no(productdetail_no);
				int productdetail_price = productDetailVO.getProductdetail_price();
				productDetailVO.setProductdetail_price(productdetail_price);
				String productdetail_option = productDetailVO.getProductdetail_option();
				productDetailVO.setProductdetail_option(productdetail_option);

				ArrayList<DiscountVO> discountVOList = productSQLMapper.getDiscountByDetailNo(productdetail_no);
				for (DiscountVO discountVO : discountVOList) {
					discountVO.setProductdetail_no(productdetail_no);

					map = new HashMap<String, Object>();
					map.put("productVO", productVO);
					map.put("productDetailVO", productDetailVO);
					map.put("discountVO", discountVO);

					result.add(map);
				}
			}
		}
		return result;
	}

	// 상품할인등록
	public void insertProductDiscount(DiscountVO discountVO) {
		productSQLMapper.insertProductDiscount(discountVO);
		int productdetail_no = discountVO.getProductdetail_no();
		productSQLMapper.updateDiscountStatus(productdetail_no);

	}

	// 할인정보 수정
	public void updateDiscountInfo(DiscountVO discountVO) {
		productSQLMapper.updateDiscountInfo(discountVO);
	}

	// rest용...
	// 상품옵션등록
	public void insertOption(ProductDetailVO productDetailVO, ProductWarehouseVO productWarehouseVO) {
		int productdetail_no = productSQLMapper.createProductDetailKey();
		productDetailVO.setProductdetail_no(productdetail_no);
		int productwarehouse_no = productSQLMapper.createProductWarehouseKey();
		productWarehouseVO.setProductdetail_no(productdetail_no);
		productWarehouseVO.setProductwarehouse_no(productwarehouse_no);
		productSQLMapper.insertProductDetail(productDetailVO);
		productSQLMapper.insertProductwarehouse(productWarehouseVO);
	}

	// 상품옵션수정
	public void updateOption(ProductDetailVO productDetailVO) {
		productSQLMapper.updateProductDetail(productDetailVO);
	}

	// 상품옵션삭제
	public void deleteOption(int productdetail_no) {
		productSQLMapper.deleteProductDetailByNo(productdetail_no);
		productSQLMapper.deleteProductWarehouseByNo(productdetail_no);
	}

	// 재고추가하기
	public void updateProductWarehousePluscount(int add_pluscount, int productdetail_no) {
		productSQLMapper.updateProductWarehousePluscount(add_pluscount, productdetail_no);
	}

	// 상품옵션목록 가져오기
	public ArrayList<HashMap<String, Object>> getOptionList(int product_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
		for (ProductDetailVO productDetailVO : productDetailList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			productDetailVO.setProduct_no(product_no);
			System.out.println("product_no:" + product_no);
			int productdetail_no = productDetailVO.getProductdetail_no();
			System.out.println("productdetail_no:" + productdetail_no);
			map.put("productDetailList", productDetailList);

			ProductWarehouseVO productWarehouseVO = productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
			productWarehouseVO.setProductdetail_no(productdetail_no);
			System.out.println("productwarehouse_no:" + productWarehouseVO.getProductwarehouse_no());
			map = new HashMap<String, Object>();
			map.put("productWarehouseVO", productWarehouseVO);
			map.put("productDetailVO", productDetailVO);
			result.add(map);

		}
		return result;
	}

	// 프러덕트, 카테고리, 딜리버리 불러오기
	public ArrayList<HashMap<String, Object>> getOnlyProductList(int seller_no, int page_num) {
	      ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
	      ArrayList<ProductVO> OnlyProductList = productSQLMapper.getProductBySellerNoPaging(seller_no,page_num);
	      for (ProductVO productVO : OnlyProductList) {
	         HashMap<String, Object> map = new HashMap<String, Object>();
	         map.put("productVO", productVO);
	         int product_no = productVO.getProduct_no();
	         int categorydetail_no = productVO.getCategorydetail_no();
	         CategoryDetailVO categoryDetailVO = productSQLMapper.getCategoryDetailByNo(categorydetail_no);
	         categoryDetailVO.setCategorydetail_no(categorydetail_no);
	         int category_no = categoryDetailVO.getCategory_no();
	         CategoryVO categoryVO = new CategoryVO();
	         categoryVO.setCategory_no(category_no);
	         System.out.println(category_no);
	         map.put("categoryDetailVO", categoryDetailVO);
	         map.put("categoryVO", categoryVO);
	         int delivery_no = productVO.getDelivery_no();
	         DeliveryVO deliveryVO = productSQLMapper.getDeliveryCompanyName(product_no);
	         deliveryVO.setDelivery_no(delivery_no);
	         map.put("deliveryVO", deliveryVO);
	         result.add(map);
	      }
	      return result;
	   }

	// 상품 상세정보 불러오기
	public HashMap<String, Object> getProductDetail(int product_no) {
		ProductVO productVO = (ProductVO) productSQLMapper.selectProductByNo(product_no);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int categorydetail_no = productVO.getCategorydetail_no();
		CategoryDetailVO categoryDetailVO = (CategoryDetailVO) productSQLMapper
				.getCategoryDetailByNo(categorydetail_no);
		int category_no = categoryDetailVO.getCategory_no();
		String category_name = productSQLMapper.getCategoryNameByNo(category_no);
		int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(product_no);

		ArrayList<ProductImageVO> productImageList = productSQLMapper.selectProductImageByProductNo(product_no);
		ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
		for (ProductDetailVO productDetailVO : productDetailList) {

			int productdetail_no = productDetailVO.getProductdetail_no();
			map.put("productVO", productVO);
			map.put("productDetailVO", productDetailVO);
			map.put("productImageList", productImageList);
			map.put("productDetailList", productDetailList);
			map.put("minimumPrice", minimumPrice);
			map.put("categoryDetailVO", categoryDetailVO);
			map.put("category_name", category_name);

			ArrayList<DiscountVO> productDiscountList = productSQLMapper.getDiscountByDetailNo(productdetail_no);
			for (DiscountVO discountVO : productDiscountList) {
				map.put("discountVO", discountVO);
				map.put("productDiscountList", productDiscountList);

			}
		}
		return map;
	}

	public ArrayList<HashMap<String, Object>> getCategoryDetailByCategoryNo(int category_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<CategoryDetailVO> getCategoryDetailByNo = productSQLMapper.getCategoryDetailByCategoryNo(category_no);
		for (CategoryDetailVO categoryDetailVO : getCategoryDetailByNo) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryDetailVO", categoryDetailVO);
			result.add(map);
		}
		return result;
	}

	// 상품 삭제 ajax
	public void deleteProduct(int product_no) {
		productSQLMapper.deleteProduct(product_no);
		ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
		for (ProductDetailVO productDetailVO : productDetailList) {
			productSQLMapper.deleteProductDetail(product_no);
			int productdetail_no = productDetailVO.getProductdetail_no();
			productSQLMapper.deleteProductWarehouse(productdetail_no);
			productSQLMapper.deleteDiscountProduct(productdetail_no);
		}

	}

	// 할인 상품 삭제 ajax
	public void deleteDiscountProduct(int productdetail_no) {
		productSQLMapper.deleteDiscountProduct(productdetail_no);
		productSQLMapper.updateUnDiscountStatus(productdetail_no);

	}

	// 제품 후기 관련(작성, 삭제, 리스트)
	public void writeProductComment(ProductCommentVO productcommentVO) {
		productSQLMapper.insertProductComment(productcommentVO);
	}

	public void deleteProductComment(int productcomment_no) {
		productSQLMapper.deleteProductComment(productcomment_no);

	}

	public ArrayList<HashMap<String, Object>> getProductCommentList(int product_no) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<ProductCommentVO> commentList = productSQLMapper.selectCommentByProductNo(product_no);

		for (ProductCommentVO productCommentVO : commentList) {
			CustomerVO customerVO = customerSQLMapper.selectByNo(productCommentVO.getCustomer_no());

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("customerVO", customerVO);
			map.put("productCommentVO", productCommentVO);
			list.add(map);
		}
		return list;
	}
	
	public void updateProductComment(ProductCommentVO productcommentVO) {
		productSQLMapper.updateProductComment(productcommentVO);
	}
	
	public ArrayList<HashMap<String, Object>> getCategoryListByName(String category_name) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		int category_no = productSQLMapper.getCategoryNoByName(category_name);
		ArrayList<ProductVO> productVOList = productSQLMapper.getProductListByCategoryNo(category_no);
		for (ProductVO productVO : productVOList) {
			HashMap<String, Object> Map = new HashMap<String, Object>();
			int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(productVO.getProduct_no());
			ProductImageVO productImageVO = productSQLMapper.getMainImageByProductNo(productVO.getProduct_no());
			int categorydetail_no = productVO.getCategorydetail_no();
			String categoryDetailName = productSQLMapper.getCategoryDetailNameByCategoryDetailNo(categorydetail_no);

			Map.put("productVO", productVO);
			Map.put("minimumPrice", minimumPrice);
			Map.put("productImageVO", productImageVO);
			Map.put("categoryDetailName", categoryDetailName);

			result.add(Map);
		}

		return result;
	}

	// 쿠폰 리스트 가져오기
	public ArrayList<HashMap<String, Object>> getCouponlist() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<CouponVO> couponVOList = productSQLMapper.getCouponList();

		for (CouponVO couponVO : couponVOList) {
			HashMap<String, Object> Map = new HashMap<String, Object>();

			Map.put("couponVO", couponVO);

			result.add(Map);

		}
		return result;

	}

	public void insertCoupon(MyCouponVO myCouponVO) {
		productSQLMapper.insertCoupon(myCouponVO);

	}
	
	public ArrayList<HashMap<String, Object>> getProductDetailVO(int product_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductDetailVO> detailList = productSQLMapper.getProductDetailByProductNo(product_no);
		for (ProductDetailVO productDetailVO : detailList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("productDetailVO", productDetailVO);
			int productdetail_no = productDetailVO.getProductdetail_no();
			ProductWarehouseVO productWarehouseVO = productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
			map.put("productWarehouseVO", productWarehouseVO);

			ArrayList<DiscountVO> discountList = productSQLMapper.getDiscountByDetailNo(productdetail_no);
			for (DiscountVO discountVO : discountList) {
				map.put("discountVO", discountVO);
			}

			result.add(map);
		}
		return result;
	}

	public ArrayList<HashMap<String, Object>> getProductOrderByBestOrdered() {

		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductVO> bestProductList = productSQLMapper.getProductOrderByBestOrdered();

		for (ProductVO productVO : bestProductList) {

			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			int product_no = productVO.getProduct_no();
			ArrayList<ProductImageVO> productImageVO = productSQLMapper.selectProductImageByProductNo(product_no);
			int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(product_no);

			int categorydetail_no = productVO.getCategorydetail_no();
			CategoryDetailVO categoryDetailVO = productSQLMapper.getCategoryDetailByNo(categorydetail_no);

			int category_no = categoryDetailVO.getCategory_no();
			String category_name = productSQLMapper.getCategoryNameByNo(category_no);

			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);
			resultMap.put("minimumPrice", minimumPrice);
			resultMap.put("categoryDetailVO", categoryDetailVO);
			resultMap.put("category_name", category_name);
			resultMap.put("category_no", category_no);

			resultList.add(resultMap);

		}

		return resultList;
	}

	public ArrayList<HashMap<String, Object>> updateBestProductsByCategory(int category_no, int categorydetail_no) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductVO> bestProductList = productSQLMapper.updateBestProductsByCategory(category_no,
				categorydetail_no);

		for (ProductVO productVO : bestProductList) {

			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			int product_no = productVO.getProduct_no();
			ArrayList<ProductImageVO> productImageVO = productSQLMapper.selectProductImageByProductNo(product_no);

			int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(product_no);

			int categorydetailNo = productVO.getCategorydetail_no();
			CategoryDetailVO categoryDetailVO = productSQLMapper.getCategoryDetailByNo(categorydetailNo);

			int categoryNo = categoryDetailVO.getCategory_no();
			String category_name = productSQLMapper.getCategoryNameByNo(categoryNo);

			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);
			resultMap.put("minimumPrice", minimumPrice);
			resultMap.put("categoryDetailVO", categoryDetailVO);
			resultMap.put("category_name", category_name);
			resultMap.put("category_no", categoryNo);

			resultList.add(resultMap);

		}

		return resultList;
	}

	public ArrayList<HashMap<String, Object>> updateSearchListByCategory(String search_type, String search_word,
			int category_no, int categorydetail_no) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductVO> bestProductList = productSQLMapper.updateSearchListByCategory(search_type, search_word,
				category_no, categorydetail_no);

		for (ProductVO productVO : bestProductList) {

			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			int product_no = productVO.getProduct_no();
			ArrayList<ProductImageVO> productImageVO = productSQLMapper.selectProductImageByProductNo(product_no);

			int minimumPrice = productSQLMapper.getMinimumPriceByProductNo(product_no);

			int categorydetailNo = productVO.getCategorydetail_no();
			CategoryDetailVO categoryDetailVO = productSQLMapper.getCategoryDetailByNo(categorydetailNo);

			int categoryNo = categoryDetailVO.getCategory_no();
			String category_name = productSQLMapper.getCategoryNameByNo(categoryNo);

			resultMap.put("productVO", productVO);
			resultMap.put("productImageVO", productImageVO);
			resultMap.put("minimumPrice", minimumPrice);
			resultMap.put("categoryDetailVO", categoryDetailVO);
			resultMap.put("category_name", category_name);
			resultMap.put("category_no", categoryNo);

			resultList.add(resultMap);

		}

		return resultList;
	}

	// 0529
	public void reducePluscount(int productdetail_no, int order_count) {
		productSQLMapper.reduceProductWarehousePluscount(productdetail_no, order_count);
	}

	public int getMyProductCount(int seller_no) {
		return productSQLMapper.getMyProductCount(seller_no);
	}
	
	public ArrayList<HashMap<String, Object>> getProductDetail2(int product_no) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<ProductDetailVO> productDetailList = productSQLMapper.selectDetailByProductNO(product_no);
		for (ProductDetailVO productDetailVO : productDetailList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int productdetail_no = productDetailVO.getProductdetail_no();
			ProductWarehouseVO productWarehouseVO = productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
			DiscountVO discountVO = productSQLMapper.getDiscountByDetailNo1(productdetail_no);

			map.put("productDetailVO", productDetailVO);
			map.put("productWarehouseVO", productWarehouseVO);
			map.put("discountVO", discountVO);
			result.add(map);
		}
		return result;
	}

	public ProductWarehouseVO getWarehouseVO(int productdetail_no) {
		return productSQLMapper.selectWarehouseByProductDetailNo(productdetail_no);
	}

	public HashMap<String, Object> getSellerProductListYByPdno(int productdetail_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		DiscountVO discountVO = productSQLMapper.getSellerProductListYByPdno(productdetail_no);
		ProductDetailVO productDetailVO = productSQLMapper.getProductDetailByNo(productdetail_no);
		map.put("discountVO", discountVO);
		map.put("productDetailVO", productDetailVO);

		return map;
	}

	public int getMyProductDetailCount(int seller_no) {
		return productSQLMapper.getMyProductDetailCount(seller_no);
	}
	
	
}
