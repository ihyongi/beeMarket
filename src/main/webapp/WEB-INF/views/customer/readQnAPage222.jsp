<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>My Bee</title>


<script>





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
			titleBox.innerText = "제목 : " + obj.data.customerQnAVO.customerQnA_title;
			
			info2Box.appendChild(titleBox);
			
			var hrBox = document.createElement("hr");
			info2Box.appendChild(hrBox);
			
			var contentBox = document.createElement("div");
			contentBox.innerText = "내용 : " + obj.data.customerQnAVO.customerQnA_content;
			info2Box.appendChild(contentBox);
			
			
			
			
			var info3Box = document.getElementById("info3");
			info3Box.innerHTML = "";
			
			var titleBox = document.createElement("div");
			titleBox.innerText = "문의 제목 : " + obj.data.customerQnAVO.customerQnA_title + "에 대한 답변입니다." ;
			
			info3Box.appendChild(titleBox);
			
			var hrBox = document.createElement("hr");
			info3Box.appendChild(hrBox);
			
			var cList = obj.commentlist;
			
			for(cl of cList){
				var contentBox = document.createElement("div");
				if(cl != null){
					contentBox.innerText = "내용 : " + cl.customerQnAAnswerVO.customerqnaanswer_content;
					info3Box.appendChild(contentBox);
				}else{
					contentBox.innerText = "답변이 없어 이쒸!!!!";
					info3Box.appendChild(contentBox);
				}
			}
			
		}
			
		
	};
	
	xmlhttp.open("get","./getQnAContent.do?no=" + no , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();	
	
	
}

</script>



</head>



<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#header{width:100%; min-height:180px;}
#head{height:54px;background-color: #FFC81E;}
#h-info{height:126px;}
#mybee{text-align:center; width:20%; height:60%; background-color:#dcdcdc; float:left; border:1px solid #dcdcdc;}
#top{text-align:center; width:20%; height:30%; float:left; background-color: #FFEB5A; border:1px solid #dcdcdc;}
#bottom{text-align:center; width:20%; height:30%; float:left; border:1px solid #dcdcdc;}
#top-span{margin-left:30px;}
#container{width:100%; height:100%; border:1px solid #dcdcdc;}
ul{list-style:none; padding-left:0px;}
#sidebar{float:left; width:20%; height:100%; background-color:#F4FFFF; border:1px solid #F4FFFF;}
#side-menu{margin-top:50px; margin-left:10px;}
#side-list{margin-top:20px; margin-bottom:30px;}
#main{float:left; width:80%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
	width: 800px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    margin: 0 auto;
    padding-left: 80px;
    padding-right: 80px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:90%;
 }
 
 
 
 #infoSection{height:100%;}
 #infoSection2{height:50%;}
 #key_value_section{
 position:relative;
 margin-top:10px;
 }
#key_section{text-align: center; background-color: }
#key_value_section #key_section {
    position: absolute;
    width: 300px;
    height: 400px;
    line-height: 50px;
    font-size: 16px;
    font-family: NanumGothicBold;
}

#key_value_section #value_section {
    padding-left: 0px;
}




#qna menu{
	width:100%;
	box-sizing: boerder-box;
	height: 30px;
	border-radius: 4px;
	border: 1px solid #e1e1e1;
}



#info{
    width: 100%;
    box-sizing: border-box;
    height: 400px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
input:disabled {
    background-color: -internal-light-dark(rgba(239, 239, 239, 0.3), rgba(59, 59, 59, 0.3));
    border-color: rgba(118, 118, 118, 0.3);
}
#info1{
    width: 100%;
    box-sizing: border-box;
    height: 90px;
    border-radius: 4px;
    border: 1px solid #F6F643;
    background-color: #F6F643;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}

#info2{
    width: 100%;
    box-sizing: border-box;
    height: 150px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
#info3{
    width: 100%;
    box-sizing: border-box;
    height: 250px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
input2:disabled {
    background-color: -internal-light-dark(rgba(239, 239, 239, 0.3), rgba(59, 59, 59, 0.3));
    border-color: rgba(118, 118, 118, 0.3);
}
#bottomSection{padding-top:00px; text-align:center;}
#button{text-align: center;}
#QnAMenuSection{padding-top:50px; text-align:left;}
#button1{text-align: left;}
</style>
<body>

<div class="container">

	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>
<div id="header">
	<div id="head"></div>
	<div id="h-info">
		<div id="mybee"><h1>My Bee</h1></div>
		<div id="top">회원등급</div>
		<div id="top">배송중</div>
		<div id="top">할인쿠폰</div>
		<div id="top">로얄젤리<span id="top-span">원</span></div>
		<div id="bottom">VIP</div>
		<div id="bottom">0개</div>
		<div id="bottom">0개</div>
		<div id="bottom">내가 받은 혜택<span id="top-span">원</span></div>
	</div>
</div>
<div id="container">
	<div id="sidebar">
		<div id="side-menu">
			<h3>My shopping</h3>
			<div id="side-list">
				<ul>
					<li><a href="#">주문내역조회/배송조회</a></li>
					<li><a href="#">취소/반품/교환/환불내역</a></li>
				</ul>
			</div>
		</div>	
		<div id="side-menu">
			<h3>My benefits</h3>
			<div id="side-list">
				<ul>
					<li><a href="#">할인 쿠폰</a></li>
					<li><a href="#">로얄젤리 관리</a></li>
				</ul>
			</div>
		</div>	
		<div id="side-menu">
			<h3>My activities</h3>
			<div id="side-list">
				<ul>
					<li><a href="${pageContext.request.contextPath }/customer/writeQnAPage.do">문의하기</a></li>
					<li><a href="${pageContext.request.contextPath }/customer/readQnAPage.do">문의내역 확인</a></li>
					<li><a href="#">구매후기</a></li>
					<li><a href="#">찜리스트</a></li>
				</ul>
			</div >
		</div>	
		<div id="side-menu">
			<h3>My information</h3>
			<div id="side-list">
				<ul>
					<li><a href="#">개인정보 확인/수정</a></li>
					<li><a href="#">배송지관리</a></li>
				</ul>
			</div>	
		</div>	
	</div>
	<div id="main">
		<div id="wrapper">
			<h2>
				<div class="btn-group btn-group-lg" role="group" aria-label="">
  					<button type="button" class="btn btn-default" onclick="">판매자 관련 문의</button>
  					<button type="button" class="btn btn-default" onclick="">사이트 관련 문의</button>
 					 <button type="button" class="btn btn-default" onclick="">문의한 내역확인</button>
				</div>
				</h2>
			<hr>
			<form action="./readQnAPage.do" method="get">
			<div id="infoSection">
				<div id="key_value_section">
					<div id="info1">
					<div style="font-size: 20px;">현금거래 유도관련 문의2 :<br></div><br>판매자와 현금 거래유도 관련 문의는 고객센터 000-0000으로 신고부탁드립ㄴ디</div>
				</div>
			</div>
			<div id="infoSection">
				<div class="btn-group" role="group" aria-label="">
  					<button type="button" class="btn btn-default" onclick="">판매자 문의 내역</button>
  					<button type="button" class="btn btn-default" onclick="">사이트 문의 내역</button>
 					 
				</div>
			</div>
						<div class="row">
						<div class="col"id="infoSection">
							<div id="key_value_section">
								<div id="value_section">
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
								<c:forEach items="${customerQnAList }" var="data">
									<tr>
										<th scope="row">${data.customerQnAVO.customerQnA_no }</th>
										<td onclick="showContent(${data.customerQnAVO.customerQnA_no })">${data.customerQnAVO.customerQnA_title }</td>
										<td><fmt:formatDate value="${data.customerQnAVO.customerQnA_writedate }" pattern="yyyy.MM.dd"/>   </td>
										<td>${data.customerQnAVO.customerQnA_status }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						
								</div>
							</div>
						</div>
						<div class="col">
						<div class="row" id="infoSection2">
							<div id="key_value_section">
								<div id="value_section">
									<div id="info2">
									<td>${data.customerQnAVO.customerQnA_title }</td>
										<hr>
										<c:if test="${data.customerQnAVO.customerQnA_content != null}">
									${data.customerQnAVO.customerQnA_content }
									</c:if>
									제목을 누르면 내용을 표시합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="col">
						<div class="row" id="infoSection2">
							<div id="key_value_section">
								<div id="value_section">
									<div id="info3">
									<td>${data.customerQnAVO.customerQnA_title }</td>
									 <hr>
									<c:choose>
									<c:when test="${list.customerQnAAnswerVO.customerqnaanswer != list.customerQnAAnswerVO.customerqnaanswer}">
										<c:forEach items="${ cList }" var="list">
									 	${list.customerQnAAnswerVO.customerqnaanswer_content }
									 	</c:forEach>
									</c:when>
									<c:otherwise>
										
									</c:otherwise>
									</c:choose>
									제목을 클릭하면 답변 내용을 볼수 있습니다.
									 
									</div>
								</div>
							</div>
							</div>
						</div>
						</div>
						</div>
						
						<div id="bottomSection"></div>
						<nav>
							<ul class="pagination">
								<li><a href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</form>
		</div>
	</div>
</div>
</div>
</body>
</html>