<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function formSubmit(){
		var form=document.getElementById("xxx");
		form.submit();
		
		//아이디 정규표현식
		var idReg=/^[a-z]+[a-z0-9]{3,19}$/g;
		
		//아이디 유효성검사
		var idBox=document.getElementById("sellerId");
		if(!idReg.test(idBox.value)){
			alert("아이디는 영문자로 시작하는 4~20자 영문자 또는 숫자이어야합니다.");
			idBox.value="";
			idBox.focus();
			return; //submit되면 안되니까
		}
	}
</script>
</head>
<body>
	<form id="xxx" action="./findSellerPwProcess.do" method="post">
	ID : <input id="sellerId" type="text" name="seller_id"><br>
	email : <input type="text" name="seller_email"><br>
	<input type="button" value="비밀번호 찾기" onclick="formSubmit();">
	</form>
</body>
</html>