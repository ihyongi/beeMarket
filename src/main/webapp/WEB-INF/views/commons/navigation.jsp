<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 네비게이션.. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<style type="text/css">
*{
	margin: 0;
	padding: 0;
	border: 0;
}
body{
	overflow: scroll;
}
/* input:focus{color : none} */
.inputAppearance:focus{
   outline:0px !important;
   -webkit-appearance:none;
   box-shadow: none !important;
}
select:focus{
	border: none;
	outline:0px !important;
	/* -webkit-appearance:none; */
	box-shadow: none !important;
}
.container{
	width: 1200px;
	max-width: none !important;
}
.menu{
	text-decoration: none; 
	color: #5b5b5b; 
	font-size: 20px; 
	font-weight: bold;
}
.menu:hover{
	color: #5b5b5b; 
	border-bottom: 5px solid #fccc0c;
}
.sellerMenu{
	text-decoration: none; 
	color: #fccc0c; 
	font-size: 20px; 
	font-weight: bold;
}
.sellerMenu:hover{
	color: #5b5b5b; 
}
</style>
</head>
<body>
<div class="container">
	<div class="row mt-5"></div>
	
	<div class="row mt-3" style="height: 50px; line-height:50px;">
		<div class="col-1">
			<img src="${pageContext.request.contextPath }/resources/img/list.svg" alt="Bootstrap" width="45" height="45" style="margin-right: 30px; position: relative; top: -5px; left: -5px;">
		</div>
		<div class="col-1" style="padding: 0; position: relative; top: -5px;">
			<a href="../product/productMainPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE</a>
		</div>
		<div class="col">
			<div class="row">
				<nav id="nav" style="word-spacing: 20px">
					<c:choose>
				       	<c:when test="${!empty sessionCustomer }">
					          <a class="menu" href="${pageContext.request.contextPath }/customer/myFleePageMain.do">마이페이지</a>
					          <a class="menu" href="${pageContext.request.contextPath }/fleeorder/fleeCartPage.do">장바구니</a>
					          <a class="menu" href="${pageContext.request.contextPath }/fleemarket/readFleeMarketContentPage.do">공동구매</a>					        
				        </c:when>
				        <c:when test="${!empty sessionSeller }">
					          <a class="menu" href="${pageContext.request.contextPath }/fleemarket/sellerMainPage.do">공동구매</a>
					          <a class="menu" href="${pageContext.request.contextPath }/fleemarket/writeFleeMarketPage.do">상품판매</a>
				        </c:when>
			        </c:choose>
				</nav>
			</div>
		</div>
		
		<div class="col" style="text-align:right;"><a href="${pageContext.request.contextPath }/customer/joinCustomerPage.do" class="btn btn-black py-3 px-5 mr-2">회원가입</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<c:choose>
				<c:when test="${!empty sessionCustomer }">
					<a href="${pageContext.request.contextPath }/customer/logoutCustomerProcess.do" class="btn btn-black py-3 px-5 mr-2">로그아웃</a>
				</c:when>
				
				<c:otherwise>
					<a href="${pageContext.request.contextPath }/customer/loginCustomerPage.do" class="btn btn-black py-3 px-5 mr-2">로그인</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="row">
		<div class="col-5">
			<div class="row border border-5 border-warning rounded-pill" style="height: 45px;">
				<form class="d-flex" action="../product/productSearchList.do">
					<div class="col-1" style="margin: 0 30px 0 10px;  height:45px; line-height: 45px;">
						<select name="search_type" style="margin:0; padding:0; border: none; position: relative; top:-5px;">
							<option value="product">상품명</option>
							<option value="seller">판매자</option>
						</select>
					</div>
					<div class="col">
						<input class="form-control me-2 inputAppearance" 
						type="search" name="search_word"
						placeholder="Search" aria-label="Search" style="margin:0; padding:0; border: none; position: relative; top:6px;">
					</div>
					<div class="col-1" style="text-align: right; height:45px; line-height: 16px;">
					<button class="btn bi bi-search" type="submit" style="font-size: 23px; color: #fcc92f; padding: 0; margin: 0 0 0 10px;"></button>
					</div>
				</form>
			</div>
		</div>
		<div class="col"></div>
		<div id="nav" class="col-2" style="text-align: right;"><a href="../seller/loginSellerPage.do" class="sellerMenu">BEE SELLER</a></div>
	</div>
</div>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
</body>
</html>