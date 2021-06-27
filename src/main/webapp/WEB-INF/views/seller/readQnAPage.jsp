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

function showContent(no){
	
	//alert(no);
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
		    var obj = JSON.parse(xmlhttp.responseText);
			//console.log(obj);
			
			var info2Box = document.getElementById("info2");
			info2Box.innerHTML = "";
			
			var titleBox = document.createElement("div");
			titleBox.innerText = "제목 : " + obj.data.sellerQnAVO.sellerQnA_title;
			
			info2Box.appendChild(titleBox);
			
			var hrBox = document.createElement("hr");
			info2Box.appendChild(hrBox);
			
			var contentBox = document.createElement("div");
			contentBox.innerText = "내용 : " + obj.data.sellerQnAVO.sellerQnA_content;
			info2Box.appendChild(contentBox);
			
			
			
			
			var info3Box = document.getElementById("info3");
			info3Box.innerHTML = "";
			
			var titleBox = document.createElement("div");
			titleBox.innerText = "문의 제목 : " + obj.data.sellerQnAVO.sellerQnA_title + "에 대한 답변입니다." ;
			
			info3Box.appendChild(titleBox);
			
			var hrBox = document.createElement("hr");
			info3Box.appendChild(hrBox);
			
			var cList = obj.commentlist;
			
			for(cl of cList){
				var contentBox = document.createElement("div");
					contentBox.innerText = "내용 : " + cl.sellerQnAAnswerVO.sellerqnaanswer_content;
					info3Box.appendChild(contentBox);
			
			}
		
		}
	};
	
	xmlhttp.open("get","./getQnAContent.do?no=" + no , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();	
	
	
};

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
				<div class="row"
					style="color: #5b5b5b; max-height: 40px; height: 40px; font-size: 25px; font-weight: bold; text-align: center;">
					문의글 확인</div>
				<br>
				<div class="row">
					<div class="col">
						<div style="max-height: 250px; height: 250px;">
							<div id="info2">
								<td>${data.sellerQnAVO.sellerQnA_title }</td>
								<hr>
									${data.sellerQnAVO.sellerQnA_content }
									
								제목을 누르면 내용을 표시합니다.
							</div>
						</div>

						<div class="row">
							<div class="col">
								<div style="max-height: 250px; height: 250px;">
									<div id="info3">
										<td>${data.sellerQnAVO.sellerQnA_title }</td>
										<hr>
										<c:forEach items="${ cList }" var="list">
									 	${list.sellerQnAAnswerVO.sellerqnaanswer_content }
									 	</c:forEach>
										제목을 클릭하면 답변 내용을 볼수 있습니다.
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col">
							<div id="info">
									문의 목록<hr>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성일</th>
									<th scope="col">답변상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${sellerQnAList }" var="data">
									<tr>
										<th scope="row">${data.sellerQnAVO.sellerQnA_no } </th>
										<td onclick="showContent(${data.sellerQnAVO.customerQnA_no })">${data.sellerQnAVO.sellerQnA_title }</td>
											<td>${data.sellerQnAVO.sellerQnA_writedate }</td>
											<td>${data.sellerQnAVO.sellerQnA_status }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						</div>
					</div>
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