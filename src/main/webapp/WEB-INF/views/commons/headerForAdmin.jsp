<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	text-decoration: none;
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
.aTagHoverStyle:hover{
	text-decoration: none;
	color: #5b5b5b; 
}
a{text-decoration:none }
a:link {color:black; text-decoration: none;}
a:visited {color:black; text-decoration: none;}
a:hover {color:black; text-decoration: underline;}
</style>
</head>
<body>
<div class="container">
	<div class="row mt-5">
		<div class="col"></div>
		<div class="col" style="text-align:right;">
			<span> ${ sessionAdmin.admin_name }님 환영합니다&nbsp;|&nbsp;</span>
			<a class="aTagHoverStyle" href="${pageContext.request.contextPath }/admin/logoutAdminProcess.do">로그아웃</a>
		</div>
	</div>
	
	<div class="row mt-3" style="height: 50px; line-height:50px;">
		<div class="col-1">
			<img src="${pageContext.request.contextPath }/resources/img/list.svg" alt="Bootstrap" width="45" height="45" style="margin-right: 30px; position: relative; top: -5px; left: -5px;">
		</div>
		<div class="col-1" style="padding: 0; position: relative; top: -5px;">
			<a href="../seller/sellerPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE</a>
		</div>
		<div class="col">
			<div class="col">
				<nav id="nav" style="word-spacing: 20px">
					<a href="#" class="menu">
					멤버관리</a>
					<a href="#" class="menu">
					고객QNA</a>
					<a href="#" class="menu">
               		판매자QNA</a>
					<a href="${pageContext.request.contextPath }/admin/tempChatviewPage.do" class="menu">
					실시간상담</a>
				</nav>
			</div>
		</div>
		<div id="nav" class="col-2" style="text-align: right;"></div>
	</div>
</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
</body>
</html>