<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<title>이메일인증 완료</title>
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
<body>

<div class="container1">
<div class="contatiner2">
<div class="row" style="font-size: 20px; color:black;"> 이메일 인증 완료!!!
	<div class="row" style="height: 50px; line-height:50px; background-color: #fcc92f;"></div>
<img src="${pageContext.request.contextPath }/resources/img/congratulations2.jpg" class="d-block" alt="회원가입 완료" height="500" width="200">
<div class="row" style="padding: 0; position: relative; top: -5px;">
<a href="./loginCustomerPage.do"" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none; text-align: center;">로그인하기</a>
</div>
</div>
</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>