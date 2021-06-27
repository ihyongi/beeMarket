package com.bee.beeMarket.seller.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.commons.util.MessageDigestUtil;
import com.bee.beeMarket.product.service.ProductServiceImpl;
import com.bee.beeMarket.seller.service.SellerServiceImpl;
import com.bee.beeMarket.vo.SellerImageVO;
import com.bee.beeMarket.vo.SellerQnAImageVO;
import com.bee.beeMarket.vo.SellerQnAVO;
import com.bee.beeMarket.vo.SellerVO;

@Controller
@RequestMapping("seller/*")
public class SellerController {

	@Autowired
	private SellerServiceImpl sellerService;
	
	@Autowired
	private ProductServiceImpl productService;

	@Autowired
	private JavaMailSender mailSender;

	// 판매자--회원가입
	@RequestMapping("joinSellerPage.do")
	public String joinSellerPage(Model model) {

		// 은행목록
		ArrayList<HashMap<String, Object>> bankList = sellerService.getBankList();
		model.addAttribute("bankList", bankList);
		return "seller/joinSellerPage";
	}

	@RequestMapping("joinSellerProcess.do")
	public String joinSellerProcess(SellerVO sellerVO, MultipartFile[] upload_files) {

		// 이메일 인증키 만들기
		UUID emailUuid = UUID.randomUUID();
		String authKey = emailUuid.toString();

		// 메일보내기
		MailSendThread mailSendThread = new MailSendThread(mailSender, sellerVO.getSeller_email(), authKey);
		mailSendThread.start();

		// 판매자 프로필이미지 삽입--파일업로드
		ArrayList<SellerImageVO> sellerImageList = new ArrayList<SellerImageVO>();
		if (upload_files != null) {
			for (MultipartFile file : upload_files) {
				if (file.isEmpty()) {
					continue;
				}
				String oriFileName = file.getOriginalFilename();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));

				// 파일명 변경
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String randomFileName = uuidName + "_" + currentTime + ext;

				// 날짜별 폴더 자동생성
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				String uploadFolderName = "C:/upload_files/" + newFolderName;

				// 폴더만들기
				File folder = new File(uploadFolderName);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String sellerImageFileLocation = uploadFolderName + "/" + randomFileName;
				try {
					file.transferTo(new File(sellerImageFileLocation));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				SellerImageVO sellerImageVO = new SellerImageVO();
				sellerImageVO.setSellerimage_location(newFolderName + "/" + randomFileName);
				sellerImageVO.setSellerimage_orifilename(oriFileName);

				sellerImageList.add(sellerImageVO);
			}
		}

		sellerService.joinSeller(sellerVO, authKey, sellerImageList);
		return "seller/joinSellerSuccess";
	}

	// Seller_Email 테이블에서 Y로 바꾸기
	@RequestMapping("updateSellerEmailComplete.do")
	public String updateSellerEmailComplete(String authKey) {
		sellerService.updateSellerEmailComplete(authKey);
		return "seller/authMailComplete";
	}

	// 로그인
	@RequestMapping("loginSellerPage.do")
	public String loginSellerPage() {
		return "seller/loginSellerPage";
	}

	@RequestMapping("loginSellerProcess.do")
	public String loginSellerProcess(SellerVO sellerVO, HttpSession session) {
		SellerVO sessionSeller = sellerService.loginProcess(sellerVO);
		if (sessionSeller != null) {
			session.setAttribute("sessionSeller", sessionSeller);
			return "redirect:./sellerPage.do";
		} else {
			return "seller/loginSellerFail";
		}
	}

	// 판매자 관리메인페이지
	@RequestMapping("sellerPage.do")
	public String sellerPage(HttpSession session, Model model) {
		SellerVO sellerVO = (SellerVO) session.getAttribute("sessionSeller");
		int seller_no = sellerVO.getSeller_no();
		HashMap<String, Object> sellerData = sellerService.getSellerVOBySellerNo(seller_no);
		model.addAttribute("sellerData", sellerData);
		HashMap<String, Object> sellerWallet = sellerService.getSellerWallet(seller_no);
		model.addAttribute("sellerWallet", sellerWallet);
		// 0529수정
		int count = productService.getMyProductCount(seller_no);
		model.addAttribute("count", count);

		return "seller/sellerPage";
	}

	// 로그아웃
	@RequestMapping("logoutSellerProcess.do")
	public String logoutSellerProcess(HttpSession session) {
		session.invalidate();
		return "redirect:../product/productMainPage.do";
	}

	// 비밀번호 찾기위해 아이디, 이메일 확인하는 페이지로 이동
	@RequestMapping("findSellerPwPage.do")
	public String findSellerPwPage() {
		return "seller/findSellerPwPage";
	}

	// 비밀번호 찾기 - 아이디 이메일 일치여부 확인
	@RequestMapping("findSellerPwProcess.do")
	public String findSellerPwProcess(String seller_id, String seller_email) {
		SellerVO sellerVO = sellerService.selectSellerIdAndEmail(seller_id, seller_email);
		if (sellerVO != null) {
			// 일치하면 이메일 보냄
			sellerService.sendUpdatePwEmail(sellerVO);
			return "redirect:./loginSellerPage.do";
		}
		return "redirect:./findSellerPwFail.do";
	}

	// 비밀번호 변경하는 페이지 매핑
	@RequestMapping("updatePasswordPage.do")
	public String updatePasswordPage() {
		return "seller/updatePasswordPage";
	}

	// 비밀번호 변경 프로세스 - 변경시 아이디 입력받아서 확인하고,
	// 해당 아이디와 일치하는 값이 있으면 비번 변경
	@RequestMapping("updatePasswordProcess.do")
	public String updatePasswordProcess(String seller_id, String seller_pw) {
		SellerVO sellerVO = sellerService.getSellerVOBySellerId(seller_id);
		if (sellerVO != null) {
			// 비밀번호 암호화필요
			seller_pw = MessageDigestUtil.getPasswordHashing(seller_pw);
			sellerService.updateSellerPw(seller_id, seller_pw);
			return "redirect:./loginSellerPage.do";
		}
		return "redirect:./findSellerPwFail.do";

	}

	// QnA 문의내역 확인 페이지
	@RequestMapping("readQnAPage.do")
	public String readQnAPage(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page_num) {

		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		if (sessionSeller != null) {
			int sellerNo = sessionSeller.getSeller_no();
			// QnA 리스트
			ArrayList<HashMap<String, Object>> sellerQnAList = sellerService.getSellerQnAList(sellerNo, page_num);

			// QnA 카테고리
			ArrayList<HashMap<String, Object>> sellerQnACategoryList = sellerService.getSellerQnACategory();

			int count = sellerService.getContentCount();

			int totalPageCount = (int) Math.ceil(count / 10.0);
			int currentPage = page_num;
			int beginPage = ((currentPage - 1) / 5) * 5 + 1;
			int endPage = ((currentPage - 1) / 5 + 1) * (5);

			if (endPage > totalPageCount) {
				endPage = totalPageCount;
			}
			model.addAttribute("beginPage", beginPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("totalPageCount", totalPageCount);
			model.addAttribute("sellerQnAList", sellerQnAList);
			model.addAttribute("sellerQnACategoryList", sellerQnACategoryList);
			model.addAttribute("contentCount", count);

			return "seller/readQnAPage";
		} else {
			return "redirect:./loginSellerPage.do";
		}
	}

	// qna게시판 글쓰기 페이지
	@RequestMapping("writeQnAPage.do")
	public String writeQnAPage(Model model) {
		ArrayList<HashMap<String, Object>> sellerQnACategory = sellerService.getSellerQnACategory();
		model.addAttribute("sellerQnACategory", sellerQnACategory);
		return "seller/writeQnAPage";
	}

	// qna 내용 쓰기
	@RequestMapping("qnaWriteContentProcess.do")
	public String qnaWriteContentProcess(MultipartFile[] upload_files, SellerQnAVO sellerQnAVO, HttpSession session) {
		//세션 seller
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		int sessionSellerNo = sessionSeller.getSeller_no();
		sellerQnAVO.setSeller_no(sessionSellerNo);
		
		// 파일업로드
				ArrayList<SellerQnAImageVO> sellerQnAImageList = new ArrayList<SellerQnAImageVO>();
				if (upload_files != null) {
					for (MultipartFile file : upload_files) {
						if (file.isEmpty()) {
							continue;
						}
						
						// 파일명 변경
						String oriFileName = file.getOriginalFilename();
						String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
						long currentTime = System.currentTimeMillis();
						UUID uuid = UUID.randomUUID();
						String uuidName = uuid.toString();
						String randomFileName = uuidName + "_" + currentTime + ext;

						// 날짜별 폴더 자동생성
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
						String newFolderName = sdf.format(date);
						String uploadFolderName = "C:/upload_files/" + newFolderName;

						// 폴더만들기
						File folder = new File(uploadFolderName);
						if (!folder.exists()) {
							folder.mkdirs();
						}
						String sellerQnAImageFileLocation = uploadFolderName + "/" + randomFileName;
						try {
							file.transferTo(new File(sellerQnAImageFileLocation));
						} catch (IllegalStateException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						SellerQnAImageVO sellerQnAImageVO = new SellerQnAImageVO();
						sellerQnAImageVO.setSellerqnaimage_location(newFolderName + "/" + randomFileName);
						sellerQnAImageVO.setSellerqnaimage_orifilename(oriFileName);
						sellerQnAImageList.add(sellerQnAImageVO);
					}
				} // 업로드 끝

		sellerService.writeContent(sellerQnAVO, sellerQnAImageList);
		return "redirect:./readQnAPage.do";
	}


	@RequestMapping("sellerInformation.do")
	public String sellerInfomation(HttpSession session, Model model) {
		// 은행목록
		ArrayList<HashMap<String, Object>> bankList = sellerService.getBankList();
		model.addAttribute("bankList", bankList);

		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		String seller_id = sessionSeller.getSeller_id();
		SellerVO sellerVO = sellerService.getSellerVOBySellerId(seller_id);
		model.addAttribute("sellerVO", sellerVO);

		return "seller/sellerInformation";
	}

	@RequestMapping("confirmSellerInformation")
	public String confirmSellerInformation() {
		return "seller/confirmSellerInformation";
	}

	@RequestMapping("sellerInfoPwCheck.do")
	public String sellerInfoPwCheck(HttpServletRequest request, HttpSession session) {
		SellerVO sessionSeller = (SellerVO) session.getAttribute("sessionSeller");
		String seller_id = sessionSeller.getSeller_id();
		String seller_pw = request.getParameter("seller_pw");
		System.out.println(seller_id);
		System.out.println(seller_pw);
		int result = sellerService.checkSellerInfo(seller_id, seller_pw);
		System.out.println(result);
		if (result == 0) {
			return "redirect:./confirmSellerInformation?error=pwError";
		} else {
			return "seller/sellerInformation";
		}

	}



@RequestMapping("statisticsSellerPage.do")
public String statisticsSellerPage() {
   
   return "seller/statisticsSellerPage";
}

}


// 이메일 인증 메일스레드
class MailSendThread extends Thread {

	private JavaMailSender mailSender;
	private String mailAddress;
	private String authKey;

	public MailSendThread(JavaMailSender mailSender, String mailAddress, String authKey) {
		super();
		this.mailSender = mailSender;
		this.mailAddress = mailAddress;
		this.authKey = authKey;
	}

	@Override
	public void run() {
		// 메일 api활용
		MimeMessage message = null;
		MimeMessageHelper messageHelper = null;
		message = mailSender.createMimeMessage();
		try {
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setSubject("[이메일 인증하기]안녕하세요 이메일 인증을 위한 메일입니다.");
			String text = "<a href='http://localhost:8181/beeMarket/seller/updateSellerEmailComplete.do?authKey="
					+ authKey + "'>";
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
