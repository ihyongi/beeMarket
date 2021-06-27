<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"href="${ pageContext.request.contextPath }/resources/css/login.css">
</head>
<body>

	<div id="wrap">
		
		<div class="Logo_area">
			<a href="../product/productMainPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE SELLER</a>
		</div>
		
		<div class="login_area">
			<form action="${ pageContext.request.contextPath }/seller/loginSellerProcess.do" method="post">
				
				<div class="input_area">
					<span class="formStyle">아이디</span> 
					<input class="idBox" type="text" name="seller_id">
					
					<span class="formStyle">비밀번호</span>
					<input class="pwBox"  type="password" name="seller_pw">
				</div>
				
				<div>
					<button class="btn_login" type="submit" style="margin-bottom: 5px;">로그인</button>
					<button class="btn_login" type="button" onclick="location.href='./joinSellerPage.do'">회원가입</button>
				</div>
			</form>
		</div>
		
	</div>
	
	
</body>
</html>