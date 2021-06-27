<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function formSubmit(){
		var form1=document.getElementById("xxx");
		form1.submit();
		
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
		//비밀번호 유효성검사
		var pwBox=document.getElementById("sellerPw");
		if(pwBox.value==""){
			alert("비밀번호를 입력해주세요!");
			pwBox.focus();
			return;
		}
		//비밀번호확인 유효성검사
		var pwConfirmBox=document.getElementById("sellerConfirmPw");
		if(pwConfirmBox.value!=pwBox.value){
			alert("비밀번호를 다시 확인해주세요!");
			pwBox.value="";
			pwConfirmBox.value="";
			pwBox.focus();
			return;
		}
	}
</script>
</head>
<body>
	<form id="xxx" action="./updatePasswordProcess.do" method="post">
		id: <input type="text" name="seller_id"><br>
		사용하시던 아이디를 입력해주세요<br>
		new PW: <input id="sellerPw" type="password" name="seller_pw"><br>
		new confirm PW:<input id="sellerConfirmPw" type="password"><br>
		<input type="button" value="변경하기" onclick="formSubmit();">
	</form>
</body>
</html>