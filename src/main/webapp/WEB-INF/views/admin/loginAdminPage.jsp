<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/login.css">
<script type="text/javascript">
	function formSubmit(){
		//alert("실행 된다!!!");
		var form2 = document.getElementById("xxx2");
		//유효성 검사...
		var idBox = document.getElementById("loginId");
		
		if(idBox.value == ""){
			alert("아이디를 입력해주세요");
			idBox.focus();
			return;
		}
		var pwBox = document.getElementById("loginPw");
		if(pwBox.value == ""){
			alert("비밀번호를 입력해주세요");
			pwBox.focus();
			return;
		}
		
		form2.submit();
	}
</script>

</head>
<body>

	<div id="wrap">
		
		<div class="Logo_area">
			<a href="../product/productMainPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE Admin</a>
		</div>
		
		<div class="login_area">
			<form id="xxx2" action="${pageContext.request.contextPath }/admin/loginAdminProcess.do" method="post">
				
				<div class="input_area">
					<span class="formStyle">아이디</span> 
					<input id="loginId" class="idBox" type="text" name="admin_id">
					
					<span class="formStyle">비밀번호</span>
					<input id="loginPw" class="pwBox"  type="password" name="admin_pw">
				</div>
				
				<div>
					<button class="btn_login" type="button" onclick="formSubmit()" style="margin-bottom: 5px;">로그인</button>
					<button class="btn_login" type="button" onclick="location.href='./joinAdminPage.do'">회원가입</button>
				</div>
			</form>
		</div>
		
	</div>

</body>
</html>