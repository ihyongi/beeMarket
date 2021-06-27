<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>myCommentPage</title>
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
}

a:hover{
	text-decoration: blink !important;
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
.swal-button {
  
  background-color: #fff58c;
  font-size: 12px;
  border: 1px solid #gold;
}

</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	var myModal = null;
	
	function getSessionCustomerNo(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionCustomerNo = obj.customer_no;
			}
		};
		
		xmlhttp.open("get","../customer/getSessionCustomerNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	function changeComment(comment_no,comment_content,comment_star){
		
		var commentNO = comment_no;
		var commentContent = comment_content;
		var commentStar = comment_star;

		
		var starBox = document.getElementById(commentStar+'-stars');
		starBox.checked=true;
		var buttonBox = document.getElementById("modalButton");
		var okButton = document.createElement("button");
		
		var commentBox = document.getElementById("commentInput");
		commentBox.innerText=commentContent;
		
		okButton.setAttribute("type","button");
		okButton.setAttribute("onclick",'rewriteComment('+commentNO+')');
		okButton.setAttribute("class","btn btn-warning");
		okButton.innerHTML="후기작성";
		buttonBox.appendChild(okButton);
		
		myModal.show();
	}
	
	function rewriteComment(comment_no){
		
		var commentNO = comment_no;
		var commentValue = document.getElementById("commentInput").value;
		var starValue = document.querySelector('input[name="rating"]:checked').value;
		
		if(commentValue == ""){
			swal("Notice","후기 내용을 작성해 주세요!");
			return;
		}
		
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
			    swal("Notice","후기 수정이 완료되었습니다~","success",{timer : 6000});
			    myModal.hide();
			    setTimeout(reload(), 6000);

			}
		};
		
		xmlhttp.open("post","../product/rewriteComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("productcomment_no=" + commentNO + "&productcomment_content=" + commentValue + "&productcomment_star=" + starValue);
	}
	function reload(){
		window.location.reload();
	}
	
	function init(){
		getSessionCustomerNo();
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
		
	}
	
	
</script>

</head>
<body onload="init()">

<div class="container">
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>

	<jsp:include page="/WEB-INF/views/commons/headerForCustomer.jsp"></jsp:include>
	
	<div class="row">
		<!-- 좌측네비바 -->
		<jsp:include page="/WEB-INF/views/commons/headerForCustomer+left.jsp"></jsp:include>
		
		<!-- 여기서부터는 마이페이지 내부의 여러 기능을 한페이지에서 구현 -->
		<div class="col" id="mainContainer">
		
		<!-- 내가 남긴 상품 후기 -->
		<div class="couponList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mt-3 mb-3">
				<div class="col-3" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
					내가 남긴 후기 <span style="color: #fcc92f; font-size: 25px; font-weight: bold; text-align: left;">${myCouponCount }</span>
				</div>
				<div class="col"></div>
			</div>
			<!-- 내가 남긴 후기리스트 출력파트 table 형식-->
			<div class="row mb-5">
				<table class="table table-sm">
					<colgroup>
						<col style="width:17.6%">
						<col style="width:*">
						<col style="width:12.6%">
						<col style="width:15.3%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr style="text-align: center;">
							<th scope="col">제품명</th>
							<th scope="col">후기내용</th>
							<th scope="col">별점</th>
							<th scope="col">작성일</th>
							<th scope="col">&nbsp;</th>
						</tr>
					</thead>
					
					

					<tbody>
						<c:forEach items="${myCommentData}" var="data">
						<tr>
							<td>${data.productVO.product_name}</td>
							<td class="left">
								${data.productCommentVO.productcomment_content }</td>
							<td>
								<div class="star-ratings-fill space-x-2 text-lg">
									<c:forEach begin="1" end="${data.productCommentVO.productcomment_star}" step="1">
										<span style="color: #fccd11;">★</span>
									</c:forEach>
								</div>
							</td>
							<td><fmt:formatDate value="${data.productCommentVO.productcomment_writedate }" pattern="yy년MM월dd일"></fmt:formatDate></td>
							<td>
								<button type="button" class="btn w100 btn-sm btn-default" onclick="changeComment(${data.productCommentVO.productcomment_no },'${data.productCommentVO.productcomment_content }',${data.productCommentVO.productcomment_star})">
									수정
								</button>
							</td>
						</tr>
						<!-- Modal -->
							<div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
												후기 수정
											</h5>
											<button type="button" class="btn-close"
												onclick="myModal.hide();"></button>
										</div>
										<div class="modal-body">
											<div class="star-rating space-x-4 mx-auto mb-3">
												<input type="radio" id="5-stars" name="rating" value="5" v-model="rating"/>
												<label for="5-stars" class="star pr-4">★</label>
												<input type="radio" id="4-stars" name="rating" value="4" v-model="rating"/>
												<label for="4-stars" class="star pr-4">★</label>
												<input type="radio" id="3-stars" name="rating" value="3" v-model="rating"/>
												<label for="3-stars" class="star pr-4">★</label>
												<input type="radio" id="2-stars" name="rating" value="2" v-model="rating"/>
												<label for="2-stars" class="star pr-4">★</label>
												<input type="radio" id="1-stars" name="rating" value="1" v-model="rating"/>
												<label for="1-stars" class="star pr-4">★</label>

											</div>
											<form id="commentBox">
												<textarea id="commentInput" class="form-control" rows="3" cols="30" style="resize: none; border: 1px solid #fcc92f;"></textarea>
											</form>
										</div>
										<div class="modal-footer" id="modalButton">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">나중에 작성</button>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</tbody>
				</table>
		
			</div>
		
			</div>
		</div>
	<!-- 콘테이너 끝 -->
	
	
</div>

<div class="row" style="height: 100px;"></div>
</div>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>