<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function formSubmit(){
		//alert("실행 된다!!!");
		var form1 = document.getElementById("xxx1");
		
		//유효성 검사...
		var idBox = document.getElementById("inputId");
		
		var idReg = /^[a-z]+[a-z0-9]{3,19}$/g;		
		
		if(!idReg.test(idBox.value)){
			alert("아이디는 영문자로 시작하는 4~20자 영문자 또는 숫자이어야 합니다.");
			idBox.focus();
			return;
		}
		
		var pwBox = document.getElementById("inputPw");
		
		if(pwBox.value == ""){
			alert("비밀번호를 입력해 주세요!");
			pwBox.focus();
			return;
		}
		
		var inputConfirmPw = document.getElementById("inputConfirmPw");
		
		if(inputConfirmPw.value != pwBox.value){
			alert("비밀번호 확인을 해주세요!");
			
			pwBox.value = "";
			inputConfirmPw.value = "";
			
			pwBox.focus();
			
			return;
		}
	
		var nameBox = document.getElementById("inputName");
		
		if(nameBox.value == ""){
			alert("이름을 입력해 주세요!");
			nameBox.focus();
			return;
		}
		
		form1.submit();
	}

</script>
</head>
<body>
	<h1>회원가입</h1>
	<form id="xxx1" action="./joinAdminProcess.do" method="post">
	ID(영문자로 시작하는 4~20자) : <input id ="inputId" type="text" name="admin_id"><br>
	PW(필수) : <input id ="inputPw" type="password" name="admin_pw"><br>
	confirm PW : <input id="inputConfirmPw" type="password"><br>
	name(필수) : <input id="inputName"type="text" name="admin_name"><br>
	
	
	<input type="button" value="회원가입" onclick="formSubmit()">
	</form>
</body>
</html>