<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}
#container {
	margin: 0 auto;
	width: 1200px;
	max-width: none !important;
}

.box {
	width: 300px;
	height: 300px;
	border: 1px solid #efefef;
}

.title {
	padding: 7px 0px 7px 0px;
	text-align: center;
	color: #ffffff;
	font-weight: bold;
	background-color: #fccc0c;
}
.iconBox{
	margin: 0 auto;
	height: 160px;
	width: 120px;
	line-height: 80px;
	padding: 30px;
	text-align: center;
}
img {
	display:inline;
	height: 60px;
	width: 60px;
}
img.shop {
	display:inline;
	height: 70px;
	width: 75px;
}
.nameBox{
	margin: 0 auto;
	width: 360px;
	height: 35px;
	line-height:35px;
	text-align: center;
	color:#5e5e5e;
	border: 1px solid #efefef;
	border-radius: 5px;	
}
.nameBox a{
	margin: 0 auto;
	text-decoration: none;
	color:#5e5e5e;
}
.nameBox a:hover{
	margin: 0 auto;
	text-decoration: none;
	color:#fccc0c;
}
.leftArea,.rightArea{width: 150px; float:left; height:80px;}
.rightArea{padding-left:40px;}
#info{padding-top: 30px;}
#qna,#reply{padding-top: 40px;}
#shop{width: 80px;height:80px;}
#highlight{color: red;}
</style>
</head>
<body>
<div class="container">
	<div class="row mb-5">
		<jsp:include page="../commons/headerForSeller.jsp" flush="true"/>
	</div>
</div>
<div class="row" style="background-color:#efefef;">
	<div id="container">
		<div class="col">
			<div class="row">
				<div class="col-2">
					<div class="row">
						<!-- <img alt="sellerProfileImg" src="/upload_files/" class="img-fluid"/"> -->
					</div>
				</div>
				<div class="col" id="info">
					<div id="shop"><img class="shop" alt="" src="${pageContext.request.contextPath }/resources/img/shop.png"></div>
					<div class="leftArea" align="left">
						판매자 아이디<br>
						판매등급<br>
					</div>
					<div class="rightArea">
						${sellerData.sellerVO.seller_id }<br>
						lv.${sellerData.sellerVO.sellergrade_no}<br>
					</div>
				</div>
				<div class="col">
					<div id="qna">
					상품Q&A >더보기
					<hr>
					</div>
					<div>
					<ul>
						<li>흥정 안 될까요?</li>
						<li>사이즈 문의드립니다.</li>
						<li>배송 관련 문의드립니다.</li>
					</ul>
					</div>
				</div>
				<div class="col">
					<div id="reply">
					상품후기 >더보기
					<hr>
					</div>
					<div>
					<ul>
						<li>우리 아이가 너무 좋아해요~!</li>
						<li>별이 다섯개!</li>
						<li>배송 너무 빨라요~</li>
					</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="container">
	<div class="row" style="margin-top: 70px;">
		<div class="col box" style="padding: 0; margin-right: 10px; margin-bottom: 20px; height:320px;">
			<div class="title" style="">상품관리 현황</div>
			<div class="iconBox"><img alt="" src="${pageContext.request.contextPath }/resources/img/게시판아이콘.jpg"></div>
			<div class="nameBox">등록상품 &nbsp;<span id="highlight">${count }건</span></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/product/writeProductContentPage.do?seller_no=${sessionSeller.seller_no }">상품등록</a></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/product/writeProductContentPage.do?seller_no=${sessionSeller.seller_no }">프로모션 참여</a></div>
		</div>
		<div class="col box" style="padding: 0; margin: 0 10px 0 10px; margin-bottom: 20px; height:320px;">
			<div class="title">판매관리 현황</div>
			<div class="iconBox"><img alt="" src="${pageContext.request.contextPath }/resources/img/컴퓨터아이콘.jpg"></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/order/orderList.do?seller_no=${sessionSeller.seller_no }">주문현황</a></div>	
			<div class="nameBox"><a href="${pageContext.request.contextPath}/product/productList2.do?seller_no=${sessionSeller.seller_no }">입고관리</a></div>	
			<div class="nameBox"><a href="${pageContext.request.contextPath}/product/writeDiscountProductPage.do">할인등록</a></div>
		</div>
	</div>
	<div class="row" style="margin-bottom: 100px;">
		<div class="col box" style="padding: 0; margin-right: 10px; height:320px;">
			<div class="title">정산관리 현황</div>
			<div class="iconBox"><img alt="" src="${pageContext.request.contextPath }/resources/img/아이콘2.jpg"></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/order/totalIncomeList.do"><span id="highlight">${sellerWallet.sellerWalletVO.cash_amount} &nbsp;Jelly</span></a></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/order/withdrawPage.do?seller_no=${sessionSeller.seller_no}">출금하기</a></div>	
			<div class="nameBox"><a href="${pageContext.request.contextPath}/order/withdrawList.do">출금내역</a></div>	
		</div>
		<div class="col box" style="padding: 0; margin-left: 10px; height:320px;">
			<div class="title">판매자 마이페이지</div>
			<div class="iconBox"><img alt="" src="${pageContext.request.contextPath }/resources/img/아이콘3.jpg"></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/seller/statisticsSellerPage.do?seller_no=${sessionSeller.seller_no}">매출통계</a></div>	
			<div class="nameBox"><a href="${pageContext.request.contextPath}/seller/readQnAPage.do?seller_no=${sessionSeller.seller_no}">상품Q&A</a></div>
			<div class="nameBox"><a href="${pageContext.request.contextPath}/seller/confirmSellerInformation">회원정보수정</a></div>	
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>
</html>