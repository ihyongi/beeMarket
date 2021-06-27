package com.bee.beeMarket.seller.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.bee.beeMarket.commons.util.MessageDigestUtil;
import com.bee.beeMarket.seller.mapper.SellerSQLMapper;
import com.bee.beeMarket.vo.BankVO;
import com.bee.beeMarket.vo.SellerEmailVO;
import com.bee.beeMarket.vo.SellerGradeVO;
import com.bee.beeMarket.vo.SellerImageVO;
import com.bee.beeMarket.vo.SellerQnACategoryVO;
import com.bee.beeMarket.vo.SellerQnAImageVO;
import com.bee.beeMarket.vo.SellerQnAVO;
import com.bee.beeMarket.vo.SellerVO;
import com.bee.beeMarket.vo.SellerWalletVO;
import com.bee.beeMarket.vo.SellerWithdrawVO;

@Service
public class SellerServiceImpl {

	@Autowired
	private SellerSQLMapper sellerSQLMapper;

	@Autowired
	private JavaMailSender mailSender;

	// 0529 조금수정
	// 회원가입
	public void joinSeller(SellerVO sellerVO, String authKey, ArrayList<SellerImageVO> sellerImageList) {

		// pk만들기
		int sellerPk = sellerSQLMapper.createSellerKey();
		sellerVO.setSeller_no(sellerPk);
		int sellerImagePk = sellerSQLMapper.createSellerImageKey();

		// 비밀번호 암호화
		String password = sellerVO.getSeller_pw();
		password = MessageDigestUtil.getPasswordHashing(password);
		sellerVO.setSeller_pw(password);
		sellerSQLMapper.insertSeller(sellerVO);

		// 이메일인증(insert)
		SellerEmailVO sellerEmailVO = new SellerEmailVO();
		sellerEmailVO.setSeller_no(sellerPk);
		sellerEmailVO.setSelleremail_auth_key(authKey);
		sellerSQLMapper.insertSellerEmailAuth(sellerEmailVO);

		// 0530
		// 판매자 프로필사진
		for (SellerImageVO sellerImageVO : sellerImageList) {
			sellerImageVO.setSellerimage_no(sellerImagePk);
			sellerImageVO.setSeller_no(sellerVO.getSeller_no());
			sellerSQLMapper.insertSellerImage(sellerImageVO);
			System.out.println("sino:" + sellerImagePk);
		}

		// 0529
		// 판매자 지갑만들기
		SellerWalletVO sellerWalletVO = new SellerWalletVO();
		int wallet_no = sellerSQLMapper.createSellerWalletKey();
		sellerWalletVO.setSeller_no(sellerPk);
		sellerWalletVO.setWallet_no(wallet_no);
		sellerWalletVO.setCash_amount(0);
		sellerSQLMapper.insertSellerWallet(sellerWalletVO);
	}

	// 은행목록
	public ArrayList<HashMap<String, Object>> getBankList() {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<BankVO> list = sellerSQLMapper.getBankList();
		for (BankVO bankVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("bankVO", bankVO);
			result.add(map);
		}
		return result;
	}

	// 로그인
	public SellerVO loginProcess(SellerVO sellerVO) {
		String password = sellerVO.getSeller_pw();
		password = MessageDigestUtil.getPasswordHashing(password);
		SellerVO result = sellerSQLMapper.selectByIdAndPw(sellerVO.getSeller_id(), password);
		return result;
	}

	public int checkSellerInfo(String seller_id, String seller_pw) {
		String sellerPw = MessageDigestUtil.getPasswordHashing(seller_pw);
		int result = sellerSQLMapper.checkSellerInfo(seller_id, sellerPw);

		return result;
	}

	/* 비밀번호 재설정 */
	// 이메일 인증 상태 N에서 Y로 업데이트
	public void updateSellerEmailComplete(String authKey) {
		sellerSQLMapper.updateSellerEmailComplete(authKey);
	}

	// 판매자 id로 판매자 정보 가져오기
	public SellerVO getSellerVOBySellerId(String seller_id) {
		return sellerSQLMapper.selectById(seller_id);
	}

	// 판매자 id와 email로 판매자 정보 가져오기 - 아이디, 이메일 일치 여부 확인
	public SellerVO selectSellerIdAndEmail(String seller_id, String seller_email) {
		return sellerSQLMapper.selectByIdAndEmail(seller_id, seller_email);
	}

	// 비밀번호 변경하는 페이지 이메일로 링크 보내주기
	public void sendUpdatePwEmail(SellerVO sellerVO) {
		MailSendThread mailSendThread = new MailSendThread(mailSender, sellerVO.getSeller_email());
		mailSendThread.start();
	}

	// 비밀번호 변경하는 코드 - 실질적으로 비번 수정하는 코드
	public void updateSellerPw(String seller_id, String seller_pw) {
		String sellerPw = MessageDigestUtil.getPasswordHashing(seller_pw);
		sellerSQLMapper.updateSellerPassword(seller_id, sellerPw);
	}

	public boolean existId(String id) {
		int count = sellerSQLMapper.selectById2(id);

		if (count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	// 0528 효은
	public HashMap<String, Object> getSellerVOBySellerNo(int seller_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);

		map.put("sellerVO", sellerVO);
		return map;
	}

	public void updateSellerVO(String seller_address, String seller_email, int bank_no, String seller_account,
			int seller_no) {
		sellerSQLMapper.updateSellerVO(seller_address, seller_email, bank_no, seller_account, seller_no);
	}

	public HashMap<String, Object> getSellerWallet(int seller_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);
		int sellergrade_no=sellerVO.getSellergrade_no();
		SellerGradeVO sellerGradeVO=sellerSQLMapper.getSellerGradeRate(sellergrade_no);
		int bank_no = sellerVO.getBank_no();
		BankVO bankVO = sellerSQLMapper.getBankVO(bank_no);
		SellerWalletVO sellerWalletVO = sellerSQLMapper.getSellerWallet(seller_no);
		map.put("sellerVO", sellerVO);
		map.put("sellerGradeVO", sellerGradeVO);
		map.put("bankVO", bankVO);
		map.put("sellerWalletVO", sellerWalletVO);
		return map;
	}

	public SellerWalletVO getWalletVO(int seller_no) {
		SellerWalletVO sellerWalletVO = sellerSQLMapper.getSellerWallet(seller_no);
		return sellerWalletVO;
	}

	public void insertWithdraw(SellerWithdrawVO sellerWithdrawVO) {
		sellerSQLMapper.insertWithdraw(sellerWithdrawVO);

	}

	public void updateWalletMinus(int totalMinus, int seller_no) {
		sellerSQLMapper.updateWalletMinus(totalMinus, seller_no);

	}

	public void updateWalletPlus(int order_price, int seller_no) {
		sellerSQLMapper.updateWalletPlus(order_price, seller_no);

	}

	public SellerGradeVO getSellerGradeRate(int sellergrade_no) {
		return sellerSQLMapper.getSellerGradeRate(sellergrade_no);
	}

	public ArrayList<HashMap<String, Object>> getWithdrawListByWno(int wallet_no, int page_num) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<SellerWithdrawVO> withdrawList = sellerSQLMapper.getWithdrawList(wallet_no);
		for (SellerWithdrawVO sellerWithdrawVO : withdrawList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("sellerWithdrawVO", sellerWithdrawVO);
			int bank_no = sellerWithdrawVO.getBank_no();
			BankVO bankVO = sellerSQLMapper.getBankVO(bank_no);
			map.put("bankVO", bankVO);
			result.add(map);
		}
		return result;
	}
	
	public int getTotalWithdrawCount(int wallet_no) {
	      return sellerSQLMapper.getTotalWithdrawCount(wallet_no);
	   }

	// 0528 효은

	// 현지훈....
	// qna 게시판 글쓰기 + 이미지
	public void writeContent(SellerQnAVO sellerQnAVO,ArrayList<SellerQnAImageVO> sellerQnAImageList) {

		int sellerQnA_no = sellerSQLMapper.createSellerQnAkey();
		sellerQnAVO.setSellerQnA_no(sellerQnA_no);

		sellerSQLMapper.insertqna(sellerQnAVO);
		// qna 이미지 삽입
		for (SellerQnAImageVO sellerQnAImageVO : sellerQnAImageList) {
			sellerQnAImageVO.setSellerQnA_no(sellerQnA_no);
			sellerSQLMapper.insertSellerQnAImage(sellerQnAImageVO);
		}

	}

	
	// qna 게시글내용 
			public HashMap<String, Object> getContent(int sellerQnA_no, boolean isEscapeHtml) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				SellerQnAVO sellerQnAVO = sellerSQLMapper.selectByQnANo(sellerQnA_no);
				int seller_no = sellerQnAVO.getSeller_no();
				SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);
				sellerQnAVO.setSeller_no(seller_no);
				//qna 카테고리 
				SellerQnACategoryVO sellerQnACategoryVO = sellerSQLMapper.getSellerQnACategoryName(sellerQnA_no);
				
				ArrayList<SellerQnAImageVO> sellerQnAImageList=sellerSQLMapper.selectSellerQnAImageByQnANo(sellerQnA_no);
				
				// enter키
				if (isEscapeHtml) {
					String content = sellerQnAVO.getSellerQnA_content();

					content = StringEscapeUtils.escapeHtml4(content);
					content = content.replaceAll("\n", "<br>");

					sellerQnAVO.setSellerQnA_content(content);
				}
				map.put("sellerQnACategoryVO", sellerQnACategoryVO);
				map.put("sellerQnAImageList", sellerQnAImageList);
				map.put("sellerVO", sellerVO);
				map.put("sellerQnAVO", sellerQnAVO);
				return map;
			}

			
	// qna 리스트
	public ArrayList<HashMap<String, Object>> getSellerQnAList(int sellerNo, int pageNum) {

		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();

		ArrayList<SellerQnAVO> sellerQnAList = sellerSQLMapper.selectSellerQnAContent(sellerNo, pageNum);

		for (SellerQnAVO sellerQnAVO : sellerQnAList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int seller_no = sellerQnAVO.getSeller_no();
			SellerVO sellerVO = sellerSQLMapper.selectByNo(seller_no);
			
		int sellerqnacategory_no = sellerQnAVO.getSellerqnacategory_no();
			SellerQnACategoryVO sellerQnACategoryVO = new SellerQnACategoryVO();
			sellerQnACategoryVO = sellerSQLMapper.getSellerQnACategoryName(sellerqnacategory_no);
			
			ArrayList<SellerQnAImageVO> sellerQnAImageVO=sellerSQLMapper.selectSellerQnAImageByQnANo(sellerNo);
			
			map.put("sellerQnACategoryVO", sellerQnACategoryVO);
			map.put("sellerQnAImageVO", sellerQnAImageVO);
			map.put("sellerVO", sellerVO);
			map.put("sellerQnAVO", sellerQnAVO);

			result.add(map);
		}
		return result;
	}

	
	// qna 글갯수 가져오기
	public int getContentCount() {
		int count = sellerSQLMapper.selectContentCount();
		return count;
	}
	
	// QnA 카테고리 리스트
		public ArrayList<HashMap<String, Object>> getSellerQnACategory() {
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
			ArrayList<SellerQnACategoryVO> sellerQnACategoryList = sellerSQLMapper.getSellerQnACategory();
			for (SellerQnACategoryVO sellerQnACategoryVO: sellerQnACategoryList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("sellerQnACategoryVO", sellerQnACategoryVO);
				result.add(map);
			}
			return result;
		}

	// 0602
	public ArrayList<HashMap<String, Object>> getClickData(int seller_no) {
		// TODO Auto-generated method stub
		return sellerSQLMapper.getClickData(seller_no);
	}

	public ArrayList<HashMap<String, Object>> getRankingData(int seller_no) {
		// TODO Auto-generated method stub
		return sellerSQLMapper.getRankingData(seller_no);
	}

	public ArrayList<HashMap<String, Object>> getDateData(int seller_no, String order_orderdate) {
		// TODO Auto-generated method stub
		return sellerSQLMapper.getDateData(seller_no, order_orderdate);
	}

}

// 비밀번호 변경 메일스레드
class MailSendThread extends Thread {

	private JavaMailSender mailSender;
	private String mailAddress;

	public MailSendThread(JavaMailSender mailSender, String mailAddress) {
		super();
		this.mailSender = mailSender;
		this.mailAddress = mailAddress;
	}

	@Override
	public void run() {
		// 메일 api활용
		MimeMessage message = null;
		MimeMessageHelper messageHelper = null;
		message = mailSender.createMimeMessage();
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setSubject("[비밀번호 변경하기]안녕하세요 비밀번호 변경을 위한 메일입니다.");
			String text = "<a href='http://localhost:8181/beeMarket/seller/updatePasswordPage.do'>";
			text += "메일 인증하기";
			text += "</a>";

			messageHelper.setText(text, true);
			messageHelper.setFrom("admin", "관리자");
			messageHelper.setTo(mailAddress);
			mailSender.send(message);

		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
