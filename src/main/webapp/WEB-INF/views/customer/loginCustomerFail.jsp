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
	height: 600px;
	max-height:600px;
}

</style>
</head>
<body><div class="container1">
<div class="contatiner2">
<div class="row" style="font-size: 20px; color:black;"> 로그인 실패
	<div class="row" style="height: 50px; line-height:50px; background-color: #fcc92f;"></div><br><br><br>
<center>
<div class="row" style="height: 300px; width:400px;"> 
<img src="${pageContext.request.contextPath }/resources/img/bee1.PNG" class="d-block" alt="화남쓰" height="300" width="400">
</div></center>
<div class="row" style="font-size: 30px; color:black; text-align: center">
 로그인에 실패했습니다. </div><br><br>
<div class="row" style="font-size: 15px; color:black; text-align: center">아이디, 비밀번호를 확인하거나 이메일 인증을 해주세요 </div>
<div class="row" style="padding: 0; position: relative; top: -5px; text-align:center;"><br><br></div>
<a href="./loginCustomerPage.do"" style="font-size: 30px; font-weight: bold; color: #fcc92f; text-decoration: none; text-align: right;">로그인하기</a>
</div>
</div>
</div>

</body>
</html>