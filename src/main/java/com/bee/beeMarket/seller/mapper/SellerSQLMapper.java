package com.bee.beeMarket.seller.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.bee.beeMarket.vo.BankVO;
import com.bee.beeMarket.vo.SellerImageVO;
import com.bee.beeMarket.vo.SellerQnACategoryVO;
import com.bee.beeMarket.vo.SellerQnAImageVO;
import com.bee.beeMarket.vo.SellerQnAVO;
import com.bee.beeMarket.vo.SellerEmailVO;
import com.bee.beeMarket.vo.SellerGradeVO;
import com.bee.beeMarket.vo.SellerVO;
import com.bee.beeMarket.vo.SellerWalletVO;
import com.bee.beeMarket.vo.SellerWithdrawVO;

public interface SellerSQLMapper {

	/* 회원가입 */

	// <seller_no createKey>
	public int createSellerKey();

	// 회원가입 인서트
	public void insertSeller(SellerVO sellerVO);

	// 은행목록
	public ArrayList<BankVO> getBankList();

	// 판매자 프로필사진 삽입
	public void insertSellerImage(SellerImageVO sellerImageVO);

	// 판매자 프로필사진 가져오기
	public ArrayList<SellerImageVO> selectSellerImageByNo(int seller_no);

	// 이메일 인증
	public void insertSellerEmailAuth(SellerEmailVO sellerMailVO);

	public void updateSellerEmailComplete(String authKey);

	// 아이디 존재 여부 확인..숫자
	public int selectById2(String id);

	/* 로그인 */

	// id, pw로 로그인
	public SellerVO selectByIdAndPw(@Param("seller_id") String seller_id, @Param("seller_pw") String seller_pw);

	// seller_no로 sellervo정보 찾기
	public SellerVO selectBySellerNo(int seller_no);

	/* 비밀번호 찾기 */

	// 아이디랑 회원가입시 입력했던 이메일로 seller_no찾고 이메일 보냄
	public SellerVO selectByIdAndEmail(@Param("seller_id") String seller_id,
			@Param("seller_email") String seller_email);

	// seller_no로 seller정보찾기
	public SellerVO selectByNo(int seller_no);

	// seller_id로 seller정보찾기
	public SellerVO selectById(String seller_id);

	// 메일인증 후 비밀번호 변경
	public void updateSellerPassword(@Param("seller_id") String seller_id, @Param("seller_pw") String seller_pw);

	// 0523 추가작업

	public int createSellerWalletKey();

	public void insertSellerWallet(SellerWalletVO sellerWalletVO);

	public void updateSellerVO(@Param("seller_address") String seller_address,
			@Param("seller_email") String seller_email, @Param("bank_no") int bank_no,
			@Param("seller_account") String seller_account, @Param("seller_no") int seller_no);

	public SellerWalletVO getSellerWallet(int seller_no);

	public BankVO getBankVO(int bank_no);

	// 출금
	public void insertWithdraw(SellerWithdrawVO sellerWithdrawVO);

	// 0529
	// 구매확정시 판매자 지갑에 캐시적립
	public void earnWallet(@Param("order_price") int order_price, @Param("seller_no") int seller_no);

	public int createSellerImageKey();

	public SellerGradeVO getSellerGradeRate(int sellergrade_no);

	// 0531
	public void updateWalletMinus(@Param("totalMinus") int totalMinus, @Param("seller_no") int seller_no);

	public void updateWalletPlus(@Param("order_price") int order_price, @Param("seller_no") int seller_no);

	public void updateWallet(@Param("withdraw_amount") int withdraw_amount, @Param("seller_no") int seller_no);

	public ArrayList<SellerWithdrawVO> getWithdrawList(int wallet_no);
	
	public int getTotalWithdrawCount(int wallet_no);

	/* qna 판매자용 */

	// 키입력
	public int createSellerQnAkey();

	// qna 인서트
	public void insertqna(SellerQnAVO sellerQnAVO);

	// qna 게시글 가져오기
	public SellerQnAVO selectByQnANo(int sellerQnA_no);

	// qna 게시글 내용 리스트에 저장!
	public ArrayList<SellerQnAVO> selectSellerQnAContent(@Param("sellerNo") int sellerNo,
			@Param("pageNum") int pageNum);

	// 글갯수
	public int selectContentCount();

	// qna 이미지
	public int createSellerQnAImagekey();

	// qna 이미지 삽입
	public void insertSellerQnAImage(SellerQnAImageVO sellerQnAImageVO);

	// qna 이미지 가져오기
	public ArrayList<SellerQnAImageVO> selectSellerQnAImageByQnANo(int sellerQnA_no);

	// qna 카테고리 리스트
	public ArrayList<SellerQnACategoryVO> getSellerQnACategory();

	// qna 카테고리 이름
	public SellerQnACategoryVO getSellerQnACategoryName(int sellerQnA_no);
	
	//qna 끝
	
	public int checkSellerInfo(@Param("seller_id") String seller_id, @Param("sellerPw") String sellerPw);

	// 0602
	// 클릭수 조회
	public ArrayList<HashMap<String, Object>> getClickData(int seller_no);

	// 판매상품 아이템랭킹
	public ArrayList<HashMap<String, Object>> getRankingData(int seller_no);

	// 날짜별
	public ArrayList<HashMap<String, Object>> getDateData(@Param("seller_no") int seller_no,
			@Param("order_orderdate") String order_orderdate);

}
