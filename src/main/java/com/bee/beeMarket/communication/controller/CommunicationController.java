package com.bee.beeMarket.communication.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.bee.beeMarket.communication.service.CommunicationServiceImpl;
import com.bee.beeMarket.vo.CommentVO;
import com.bee.beeMarket.vo.CommunicationImageVO;
import com.bee.beeMarket.vo.CommunicationVO;
import com.bee.beeMarket.vo.CustomerVO;


@Controller
@RequestMapping("/communication/*")
public class CommunicationController {
	
	@Autowired
	private CommunicationServiceImpl communicationService; 
	
	@RequestMapping("test.do")
	public String test(){
		
		return "communication/test";
	}
	
	@RequestMapping("mainCommunicationPage.do")
	public String mainCommunicationPage(Model model) {
		//글 갯수 불러오기
		
		int count = communicationService.getContentCount();//서비스 부분으로 가기위한 코드이다.
		
		model.addAttribute("count", count);//모델 어트리뷰트로 출력하기 위한 코드이다.
		
		//-----------
		//댓글 갯수 불러오기
		
		//----------
		
		ArrayList<HashMap<String, Object>> communicationList = communicationService.getCommunicationList();//커뮤니케이션 목록을 불러오기 위한 코드의 시작이다.
		
		
		
		
		
		model.addAttribute("communicationList", communicationList);//모델 어트리뷰트로 해서 커뮤니케이션 목록을 출력하는 코드이다.
		
	 return "communication/mainCommunicationPage";
	}
	
	@RequestMapping("writeCommunicationPage.do")
	public String writeCommunicationPage() {
		
		
		return "communication/writeCommunicationPage";
	}
	
	@RequestMapping("writeCommunicationProcess.do")
	public String writeCommunicationProcess(MultipartFile [] upload_files , CommunicationVO communicationVO , HttpSession session) {
		
		int communication_no = communicationService.createCommunicationNo();
		
		ArrayList<CommunicationImageVO> communicationImageVOList = 
				new ArrayList<CommunicationImageVO>();
		
		//파일 업로드..
		if(upload_files !=null) {
			for(MultipartFile upload_file : upload_files) {
				
				if(upload_file.isEmpty()) {
					continue;
				}
				
				String oriFileName = upload_file.getOriginalFilename();
				
				long currentTime = System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName = uuid.toString();
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				
				String randomFileName = uuidName + "_" + currentTime + ext;
				
				//날짜별 폴더 자동 생성...
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String newFolderName = sdf.format(date);
				
				String uploadFolderName = "c:/upload_files/" + newFolderName;
				
				File folder = new File(uploadFolderName);
				
				if(!folder.exists()) {
					folder.mkdirs();
				}
				
				String communicationImageFileLocation = uploadFolderName + "/" + randomFileName;
				
				try {
					upload_file.transferTo(new File(communicationImageFileLocation));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				CommunicationImageVO communicationImageVO = new CommunicationImageVO();
				
				communicationImageVO.setCommunication_no(communication_no);
				communicationImageVO.setImage_location(newFolderName + "/" + randomFileName);
				communicationImageVO.setImage_original_filename(oriFileName);
				
				communicationImageVOList.add(communicationImageVO);
				
			}
		}
		
		//-----------------------------------------------------------------------
		
		
		
		CustomerVO sessionCustomer=(CustomerVO)session.getAttribute("sessionCustomer");//수정
		
		
		int sessionNO = sessionCustomer.getCustomer_no();//로그인 안하게 되면 여기에 문제가 생겨서 널 포인트 익셉션이 생긴다.//수정
		
		communicationVO.setCustomer_no(sessionNO);//이 다음부터 작성자 변수가 작동되게 된다.//수정
		
		communicationVO.setCommunication_no(communication_no);//여기 이후에 커뮤니케이션 글 번호가 찍힌다.
		
		communicationService.writeCommunicationContent(communicationVO , communicationImageVOList);//글쓰기 작성후에 여기로 오게 된다.
		
		
		return "redirect:./mainCommunicationPage.do";
	}
	
	@RequestMapping("readCommunicationPage.do")
	public String readCommunicationPage(HttpSession session, Model model , int communication_no) {
		//추천수 출력
		CustomerVO sessionCustomer=(CustomerVO)session.getAttribute("sessionCustomer");//수정
		
		if(sessionCustomer !=null) {//수정
			int customer_no = sessionCustomer.getCustomer_no();//수정
			int myRecommendCount = communicationService.getMyRecommendCount(communication_no, customer_no);//수정
			model.addAttribute("myRecommendCount", myRecommendCount);
		}
		//조회수
		communicationService.increaseReadCount(communication_no);
		
	
		//커뮤니케이션 내용 불러오기
		HashMap<String, Object> map = communicationService.getCommunicationContent(communication_no,true);
		
		
		int recommendCount = communicationService.getRecommendCount(communication_no);
		model.addAttribute("data", map);//map 안에 회원정보, 커뮤니케이션 내용을 model.addAttribute에 담음 화면에 넘겨주기 위해서
		
		
		//커뮤니케이션 댓글 목록 불러오기-- 댓글목록을 불러오려면 댓글 불러오길 원하는 페이지에 해당하는 곳에 ArrayList에 담아온것을  뿌려야 한다...
		
		ArrayList<HashMap<String, Object>> commentList =
				 communicationService.getCommentList(communication_no);//댓글목록을 불러오기 위한 것의 시작이다.
		
		model.addAttribute("commentList" , commentList);//댓글목록을 출력하기 위한것이다.
		
		model.addAttribute("recommendCount", recommendCount);
		return "communication/readCommunicationPage";
	}
	
	@RequestMapping("deleteCommunicationProcess.do")
	public String deleteCommunicationProcess(int communication_no) {
		
		communicationService.deleteCommunicationContent(communication_no);//서비스 부분을 가기위한 코드이다.
		
		return "redirect:./mainCommunicationPage.do";
	}
	
	@RequestMapping("updateCommunicationPage.do")
	public String updateCommunicationPage(Model model , int communication_no) {
		
		HashMap<String, Object> map = communicationService.getCommunicationContent(communication_no,false);//서비스 부분을 가기위한 코드이다.
		
		model.addAttribute("data", map);//수정된내용을 불러오기 위해 필요한 코드이다.
		
		return "communication/updateCommunicationPage";
	}
	
	@RequestMapping("updateCommunicationProcess.do")
	public String updateCommunicationProcess(CommunicationVO communicationVO) {
		
		communicationService.updateCommunicationContent(communicationVO);//서비스 부분에 가기위한 코드이다.
		
		return "redirect:./mainCommunicationPage.do";
	}
	
	//댓글
	@RequestMapping("writeCommentPage.do")
	public String writeCommentPage() {
	
		return "communication/readCommunicationPage";
	}
	
	 @RequestMapping("writeCommentProcess.do")
	 public String writeCommentProcess(CommentVO commentVO , HttpSession session , int communication_no) {

		 CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");//수정
	
		 
		
		 int sessionNO = sessionCustomer.getCustomer_no();//작성자의 정보를 가져오기 위한 코드이다.
		
		 commentVO.setCustomer_no(sessionNO);//작성자의 정보를 셋팅하기 위한 코드이다.
		
		 communicationService.writeComment(commentVO);//서비스단 부분으로 가기위한 코드이다.
		
		 return "redirect:./readCommunicationPage.do?communication_no="+ communication_no;
	 }
	 
		/*이렇게 불러오는 것은 안된다.
		 * //이건 뭔가 이상하다...
		 * 
		 * @RequestMapping("readCommentPage.do") public String mainCommentPage(Model
		 * model, @RequestParam(defaultValue = "1") int communication_no) {
		 * 
		 * ArrayList<HashMap<String, Object>> commentList =
		 * communicationService.getCommentList(communication_no);
		 * 
		 * model.addAttribute("commentList", commentList);
		 * 
		 * return "communication/readCommunicationPage"; }
		 */
	 
	 
	 @RequestMapping("updateCommentPage.do")
	 public String updateCommentPage(int communication_no, Model model , int comment_no) {
		
		 HashMap<String, Object> map = communicationService.getComment(comment_no,communication_no);//서비스 부분으로 가기 위한 코드이다.
		 
		 CommentVO commentVO = (CommentVO) map.get("commentVO");//댓글에 대한 정보를 가져오기 위한 코드이다.
		 
		
		 
		 model.addAttribute("comment_no", comment_no);//모델 어트리뷰트로 출력하기 위한 코드이다.
		 model.addAttribute("comment_content", commentVO.getComment_content());//모델 어트리뷰트로 출력하기 위한 코드이다.
		 model.addAttribute("communication_no", communication_no);//모델 어트리뷰트로 출력하기위한 코드이다.
		 return "communication/updateCommentPage";
	 }
	 
	 //댓글 수정하기
	 @RequestMapping("updateCommentProcess.do")
	 public String updateCommentProcess(CommentVO commentVO , int communication_no) {
		
		 communicationService.updateComment(commentVO);//서비스 부분으로 가기위한 코드이다.
		
		 
		 return "redirect:./readCommunicationPage.do?communication_no="+ communication_no;
	 }
	 //댓글 삭제
	 @RequestMapping("deleteCommentProcess.do")
	 public String deleteCommentProcess(CommentVO commentVO , int communication_no) {
		 
		 communicationService.deleteComment(commentVO);
		 
		 return "redirect:./readCommunicationPage.do?communication_no="+ communication_no;
	 }
	 
	 //추천프로세서
	 @RequestMapping("recommendProcess.do")
	 public String recommendProcess(HttpSession session , int communication_no) {
		 
		 CustomerVO sessionCustomer = (CustomerVO) session.getAttribute("sessionCustomer");//수정
		 int customer_no = sessionCustomer.getCustomer_no();//수정
		 
		 communicationService.recommend(communication_no, customer_no);//수정
		 
		 return "redirect:./readCommunicationPage.do?communication_no=" + communication_no;
	 }
}











