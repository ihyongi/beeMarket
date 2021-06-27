package com.bee.beeMarket.product.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.CategoryDetailVO;
import com.bee.beeMarket.vo.CategoryVO;
import com.bee.beeMarket.vo.CouponVO;
import com.bee.beeMarket.vo.DeliveryVO;
import com.bee.beeMarket.vo.DiscountVO;
import com.bee.beeMarket.vo.MyCouponVO;
import com.bee.beeMarket.vo.ProductCommentVO;
import com.bee.beeMarket.vo.ProductDetailVO;
import com.bee.beeMarket.vo.ProductImageVO;
import com.bee.beeMarket.vo.ProductVO;
import com.bee.beeMarket.vo.ProductWarehouseVO;

public interface ProductSQLMapper {

	// product_no createKey
	public int createProductKey();

	public int createProductDetailKey();

	public int createProductWarehouseKey();

	public int createProductImageKey();

	// 상품등록
	public void insertProduct(ProductVO productVO);

	// 상품이미지 삽입
	public void insertProductImage(ProductImageVO productImageVO);

	// 상품이미지가져오기
	public ArrayList<ProductImageVO> selectProductImageByProductNo(int product_no);

	// 대분류 카테고리
	public ArrayList<CategoryVO> getCategoryList();

	// 중분류 카테고리
	public ArrayList<CategoryDetailVO> getCategoryDetailList();

	// 이상품의 카테고리번호를 가져오자
	public int getProductCategory(int product_no);

	// 대분류번호로 중분류 가져오자
	public ArrayList<CategoryDetailVO> getCategoryDetailByCategoryNo(int category_no);

	// 택배회사목록
	public ArrayList<DeliveryVO> getDeliveryCompany();

	public DeliveryVO getDeliveryCompanyName(int product_no);

	// 옵션 등록
	public void insertProductDetail(ProductDetailVO productDetailVO);

	// product_no로 디테일 VO 조회
	public ArrayList<ProductDetailVO> selectDetailByProductNO(int product_no);

	// 창고 등록
	public void insertProductwarehouse(ProductWarehouseVO productWarehouseVO);

	// 제품상세등록
	public void insert(ProductDetailVO detailVO);

	// 상품 게시글 가져오기
	public ArrayList<ProductVO> getProductList();

	// 상품세부페이지

	// 상품별 세부페이지
	public ProductVO readProduct(int product_no);

	// 상품수정
	public void updateProduct(ProductVO productVO);

	public void updateProductImage(ProductImageVO productImageVO);

	public void updateProductDetail(ProductDetailVO productDetailVO);

	public void updateProductwarehouse(ProductWarehouseVO productWarehouseVO);

	// 상품옵션삭제......하~~~~~~~~할맛안나용
	public void deleteProductDetailByNo(int productdetail_no);

	public void deleteProductWarehouseByNo(int productdetail_no);

	// 조회수
	public void increaseReadcount(int product_no);

	// 검색
	public ArrayList<ProductVO> selectProductList(
			@Param("searchType") String search_type,
			@Param("searchWord") String search_word);

	// ....
	public ArrayList<ProductVO> getProductListByCategoryNo(int no);

	public int getMinimumPriceByProductNo(int no);

	public ProductImageVO getMainImageByProductNo(int no);

	public String getCategoryDetailNameByCategoryDetailNo(int categoryDetailNo);

	// 상품할인 등록
	public void insertProductDiscount(DiscountVO discountVO);

	// 할인 정보
	public void updateDiscountInfo(DiscountVO discountVO);

	// 디테일넘으로 창고 조회
	public ProductWarehouseVO selectWarehouseByProductDetailNo(int productdetail_no);

	// seller_no로 상품목록 가져오기
	public ArrayList<ProductVO> getProductBySellerNo(int seller_no);

	// product_no로 상품목록 빼오기-할인적용N(product,productdetail)
	public ArrayList<ProductDetailVO> getNProductDetailByNo(@Param("product_no")int product_no);

	// product_no로 상품목록 빼오기-할인적용Y(product,productdetail,discount)
	public ArrayList<ProductDetailVO> getYProductDetailByNo(@Param("product_no")int product_no);

	// discount_status update
	public void updateDiscountStatus(int productdetail_no);

	// 디테일넘으로 디스카운트 조회
	public ArrayList<DiscountVO> getDiscountByDetailNo(int productdetail_no);

	// 상품 상세정보 페이지
	public ProductVO selectProductByNo(int product_no);

	// 상품 정보(product_no로 받아오기)
	public ProductVO getProductByNo(int product_no);

	// 상품 상세정보(productdetail_no로 받아오기)
	public ProductDetailVO getProductDetailByNo(int productdetail_no);

	// ajax삭제파트
	public void deleteProduct(int product_no);

	public void deleteProductDetail(int product_no);

	public void deleteProductWarehouse(int productdetail_no);

	// 할인 삭제
	public void deleteDiscountProduct(int productdetail_no);

	// 프러덕트 디테일 할인 미적용 status로 다시 전환
	public void updateUnDiscountStatus(int productdetail_no);

	// 재고추가
	public void updateProductWarehousePluscount(@Param("productdetail_no") int productdetail_no, @Param("add_pluscount") int add_pluscount);

	// 삼품 카테고리 가져오기
	public CategoryDetailVO getCategoryDetailByNo(int categorydetail_no);

	public String getCategoryNameByNo(int category_no);

	// 상품 후기 관련(입력, 삭제, 리스트)
	public void insertProductComment(ProductCommentVO productcommentVO);

	public void deleteProductComment(int productcomment_no);

	public ArrayList<ProductCommentVO> selectCommentByProductNo(int product_no);
	//후기 업데이트
	public void updateProductComment(ProductCommentVO productcommentVO);
	
	// 카테고리이름으로 카테고리 항목 조회
	public int getCategoryNoByName(String category_name);

	// 전체 쿠폰 리스트 받아오기
	public ArrayList<CouponVO> getCouponList();

	// 쿠폰 발급
	public void insertCoupon(MyCouponVO myCouponVO);
	
	//쿠폰 이름 가져오기
	public CouponVO getCouponByNo(int coupon_no);
	
	// 베스트 상품
	public ArrayList<ProductVO> getProductOrderByBestOrdered();
	
	// 베스트 상품 카테고리로 업데이트
	public ArrayList<ProductVO> updateBestProductsByCategory(
				@Param("category_no") int category_no,
				@Param("categorydetail_no") int categorydetail_no
			);
	// 검색어 select 리스트 카테고리로 업데이트
	public ArrayList<ProductVO> updateSearchListByCategory(
			@Param("searchType") String search_type, 
			@Param("searchWord") String search_word, 
			@Param("category_no") int category_no,
			@Param("categorydetail_no") int categorydetail_no);
	
	public ArrayList<ProductDetailVO> getProductDetailByProductNo(int product_no);
	
	// 0529
	// 구매시 재고감소
	public void reduceProductWarehousePluscount(@Param("productdetail_no") int productdetail_no,
			@Param("order_count") int order_count);

	// 판매중인 상품개수
	public int getMyProductCount(int seller_no);

	//0530
	public DiscountVO getDiscountByDetailNo1(int productdetail_no);

	public DiscountVO getSellerProductListYByPdno(@Param("productdetail_no") int productdetail_no);

	public ArrayList<ProductVO> getProductBySellerNoPaging(@Param("seller_no")int seller_no, @Param("page_num")int page_num);

	public int getMyProductDetailCount(int seller_no);

}
