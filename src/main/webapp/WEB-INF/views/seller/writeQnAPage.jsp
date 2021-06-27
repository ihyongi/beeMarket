<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
.container{
	width : 1200px;
	max-width: none !important;
}

a{
	text-decoration: none !important;
	margin: 0 !important; 
	padding: 0 !important;
	color: #BDB76B;
}

a:hover{
	text-decoration: blink !important;
	color: #fcc92f;
}

.card{
	border: none;
}
.star-rating{
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
}

.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}
.box {
    /* width: 179px; */
    height: 100px; 
    overflow: hidden;
    margin: 0 0 0 0;
    position: relative;
    text-align:center;

}
.profile {
    width: 60px;
    height: 60px;
    object-fit: cover;
	top: 22px;
	opacity: 0.3;
	cursor: pointer;
}
.profile:hover {
    width: 60px;
    height: 60px;
    object-fit: cover;
	top: 22px;
	opacity: 1;
}

.rightArrow {
    width: 30px;
    height: 30px;
    padding-top: 15px;
    object-fit: cover;
	top: 22px;
}
.swal-button {
  
  background-color: #fff58c;
  font-size: 12px;
  border: 1px solid #gold;
}
.imageBox{
	width: 220px;
}

</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
</script>

</head>
<body>
<div class="container">

	<jsp:include page="/WEB-INF/views/commons/headerForSeller+head.jsp"></jsp:include>
	<div class="row">
		<!-- 좌측네비바 -->
		<jsp:include page="/WEB-INF/views/commons/sidebar.jsp"></jsp:include>
		
		<!-- 여기서부터는 마이페이지 내부의 여러 기능을 한페이지에서 구현 -->
		<div class="col-9" id="mainContainer">
		<div class="row" style="color: #5b5b5b; max-height: 40px; height:40px; font-size: 25px; font-weight: bold; text-align: center; ">
				문의글 작성
				</div>
				<br>
				<div class="row">
						<div
							style="font-size: 20px; background-color: #fcc92f; height: 140px; max-height: 140; margin-left: 0px; padding-left : -6px; padding-right:-6px;">
							현금거래 유도관련 문의2 :<br> <br>판매자와 현금 거래유도 관련 문의는 고객센터
							000-0000으로 신고부탁드립니다.
						</div>
				</div>

				<form
					action="${pageContext.request.contextPath }/seller/qnaWriteContentProcess.do"
					method="post" enctype="multipart/form-data">

					<div class="row">
						<div class="col" style="max-height: 50px; height: 50px; border: 1px solid gray; border-bottom: 0px solid white; border-right: opx solid white;">
							<div id="QnAdropdown" >
								<select name="customerqnacategory_no" style="max-height: 48px; height: 48px; max-width:174px; width:174px;" >
									<option value="1">결제 및 주문관련</option>
									<option value="2">취소 및 환불관련</option>
									<option value="3">포인트 관련</option>
									<option value="4">사이트 관련</option>
									<option value="5">기타</option>
								</select>
							</div>
						</div>
						<div class="col" style="max-height: 50px; height: 50px; border: 1px solid gray; border-bottom: 0px solid white;">
							<input type="text" id="QnAtitle" name="sellerQnA_title" value="제목을 입력해주세요" style="max-height: 48px; height: 48px; width: 980px; max-width:980px;">
						</div>
					</div>
					<div class="row"
						style="max-height: 400px; height: 400px; border: 1px solid gray; border-bottom: 0px solid white;">
						<input type="text" id="QnAcontent" name="sellerQnA_content"	value="내용을 입력해주세요">
					</div>
					<div class="row"
						style="max-height: 200px; height: 200px; border: 1px solid gray; ">
						<div class="row" style="font-size:15px">
						이미지 첨부20Mb이내 / jpg, png, bmp, gif 만 가능<br>
						이미지 내 개인정보가 포함되지 않도록 주의 (주민번호, 전화번호 등)
						<input type="file" accept="image/*" multiple name="upload_files"
							style="background-color:#F7F6DB; max-height:100px; height: 100px; padding: 5px 0px 0px 10px;"><br>
					</div></div>
					
					


					<div class="row"
						style="max-height: 40px; height: 40px; float: right;">
						<div class="btn-group btn-group-lg" role="group" aria-label="..."
							style="margin-left: 30px;">
							<button type="submit" class="writebtn"
								style="background-color: #fcc92f;">문의글 작성</button>
		
		
		
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="writebtn"
								style="background-color: #fcc92f;">문의 목록 확인</button>
						</div>
					</div>
				</form>
		
		</div>
		</div>
		</div>
	<!-- 콘테이너 끝 -->
	


<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>