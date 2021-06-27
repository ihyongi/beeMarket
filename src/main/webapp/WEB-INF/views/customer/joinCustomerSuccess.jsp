<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
.container1{
	width : 1500px;
	max-width: none !important;
	height: 700px;
	max-height:700px;
	padding-left: 80px;
    padding-right: 80px;
    box-sizing: border-box;
    padding-top: 20px;
    padding-bottom: 80px;
}
.container2{
	width : 1000px;
	max-width: none !important;
	height: 800px;
	max-height:800px;
}
.container3{
	width : 800px;
	max-width: none !important;
	height: 100px;
	max-height:100px;
	}

</style>
</head>
<body><div class="container1">
<div class="contatiner2">
<div class="row" style="font-size: 20px; color:black;"> 회원가입 성공!!!
	<div class="row" style="height: 50px; line-height:50px; background-color: #fcc92f;"></div><br><br><br>
<center>
<div class="row" style="height: 300px; width:400px;"> 
<img src="${pageContext.request.contextPath }/resources/img/bee2.PNG" class="d-block" alt="행복쓰" height="300" width="400">
</div></center>
<div class="row" style="font-size: 30px; color:black; text-align: center">
회원가입을 진심으로 환영합니다! </div><br>
<div class="row" style="font-size: 15px; color:black; text-align: center">이메일 인증을 하시면 <br>홈페이지에 접속해<br>다양한 상품을 구매할 수 있습니다.</div>

</div><div class="row" style="padding: 0; position: relative; top: -5px; text-align: center"><br><br>
<a href="./loginCustomerPage.do" style="font-size: 60px; font-weight: bold; color: #fcc92f; text-decoration: none;">로그인하기</a>
</div>
</div>
</div>
<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8">
<br><br><br>
<div class="row" style="font-size: 9px; position: relative; margin-left: 105px; text-align:left">
대표전화 02-1234-3456 고객불편 상담 02-1111-1111 <br> 서울시 강남구  3022-12번지 중앙정보학원 6층 101호 3번쨰줄 <br> copyright 2021-2021 
</div>

</div>
<div class="col-md-2"></div>
</div>

</body>
</html>