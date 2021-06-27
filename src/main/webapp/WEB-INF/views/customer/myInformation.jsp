<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
.container{
	width : 1200px;
	max-width: none !important;
}

a{
	text-decoration: none !important;
	margin: 0 !important; 
	padding: 0 !important;
}

a:hover{
	text-decoration: blink !important;
}
#wrapper{
	width: 800px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    padding-left: 80px;
    padding-right: 80px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:100%;
 }
 #infoSection{height:100%;}
 #key_value_section{
 position:relative;
 }
#key_section{text-align: center; font-weight: bold; background-color: #dcdcdc;}
#key_value_section #key_section {
    position: absolute;
    width: 170px;
    height: 70px;
    line-height: 70px;
    font-size: 14px;
    font-family: NanumGothicBold;
    border: 1px solid #bebebe;
}
#key_value_section #value_section {
    padding-left: 180px;
    height:70px;
    border: 1px solid #bebebe;
    padding-top: 20px;
}

#info{
    width: 100%;
    box-sizing: border-box;
    height: 70px;
    border-radius: 4px;
    border: none;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 0px;
    padding-right: 0px;
}

/* input:focus{outline:none;} */
#customer_pw:hover{border-bottom:1px solid black;}
#button{text-align: center;}
#buttonBox{text-align: center; margin-top:20px;}
#ment{margin-top:10px; font-size: 12px;}
#nick{color:#FFC81E; font-weight: bold;}
#valueSectionWrapper{border:1px solid #bebebe;}
#warning{color:red;}
#bottomSection{padding-top:0px; text-align:right;}
#button{text-align: center;}
input:disabled {
    background-color: -internal-light-dark(rgba(239, 239, 239, 0.3), rgba(59, 59, 59, 0.3));
    border-color: rgba(118, 118, 118, 0.3);
    }

</style>

<script type="text/javascript">
	var sessionCustomer = null;
	
	
	var myModal = null;
	
	function getSessionCustomerNo(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionCustomerNo = obj.customer_no;
			}
		};
		
		xmlhttp.open("get","../customer/getSessionCustomerNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//비밀번호 변경
	function changePw(){
		
		var newPW = document.getElementById("newPW");
		var confirmNewPW = document.getElementById("confirmNewPW");
		var pwAlert = document.getElementById("pwAlert");
		
		if(newPW.value == ""){
			pwAlert.setAttribute("style","color : red;");
			pwAlert.innerText = "변경하실 비밀번호를 입력해 주세요.";
			newPW.focus();
		}else{
			pwAlert.innerText = "";
		}
		
		if(confirmNewPW.value != newPW.value){
			alert("변경하실 비밀번호가 일치하지 않습니다.");
			newPW.value="";
			confirmNewPW.value="";
			newPW.focus();
		}else{
			pwAlert.innerText = "";
		}
		
		if(confirmNewPW.value == new PW.value){
			changePassword();
		}
		return;

	}
	function changePassword(){
		
		var newPW = document.getElementById("newPW").value;
		var confirmNewPW = document.getElementById("confirmNewPW").value;
		var pwAlert = document.getElementById("pwAlert");
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				alert("비밀번호가 변경되었습니다.");
				newPW="";
				confirmNewPW="";
				pwAlert.setAttribute("style","color : green;");
				pwAlert.innerText = "비밀번호가 성공적으로 변경되었습니다.";
				newPW.focus();
			}
		};
		
		xmlhttp.open("post","../customer/updateCustomerPw.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	}
	
	//전화번호 변경
	function changePhone(){
		
		var newPhone = document.getElementById("newPW"); 
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				alert("전화번호가 변경되었습니다.");
			}
		};
		
		xmlhttp.open("get","../customer/getSessionCustomerNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//회원 탈퇴
	function withdrawal(){
		
	}
	
	
	function init(){
		getSessionCustomerNo();

	}
	
	
</script>

</head>
<body onload="init()">

<div class="container">
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>

	<jsp:include page="/WEB-INF/views/commons/headerForCustomer.jsp"></jsp:include>
	<div class="row">
		<!-- 좌측네비바 -->
		<jsp:include page="/WEB-INF/views/commons/headerForCustomer+left.jsp"></jsp:include>
		
		<!-- 여기서부터는 마이페이지 내부의 여러 기능을 한페이지에서 구현 -->
		<div class="col" id="mainContainer">
		<!-- 개인정보수정 -->
		<div class="information">
			<div class="row mb-5">
				<div class="col-7" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">회원정보수정</div>
				<hr>
			<form>
			<div id="infoSection">
				<div id="key_value_section">
					<div id="key_section">회원명</div>
					<div id="value_section"><input type="text" id="customer_name" style="height:45px; width:440px;" value="${sessionCustomer.customer_name}" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">회원생일</div>
					<div id="value_section"><input type="text" id="customer_birth" style="height:45px; width:440px;" value="<fmt:formatDate value="${sessionCustomer.customer_birth}" pattern="yyyy년MM월dd일"></fmt:formatDate>" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">회원ID</div>
					<div id="value_section"><input type="text" id="customer_id" name="customer_id" style="height:45px; width:440px;" value="${sessionCustomer.customer_id}" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">회원PW</div>
					<div id="value_section"><input type="password" id="newPW" name="newPw" style="height:45px; width:440px;" placeholder="바꾸실 비밀번호를 입력해주세요.">
						<div id="pwAlert"></div>
					</div>
					<div id="key_section"></div>
					<div id="value_section"><input type="password" id="confirmNewPW" style="height:45px; width:440px;" placeholder="바꾸실 비밀번호를 한 번 더 입력해주세요."><button type="button" class="btn btn-warning" onclick="changePw()">비밀번호변경</button></div>
				</div>
				<br>
				<div id="key_value_section">
					<div id="key_section">회원E-mail</div>
					<div id="value_section"><input type="text" style="height:45px; width:440px;" value="${sessionCustomer.customer_email}" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">휴대폰번호</div>
					<div id="value_section"><input type="text" style="height:45px; width:440px;" value="${sessionCustomer.customer_phone}" disabled><button class="btn btn-warning btn-sm" onclick="changePhone()">번호변경</button></div>
				</div>
			</div>
				<div id="bottomSection">
					<p>탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.</p><button type="button" class="btn btn-dark btn-sm" onclick="withdrawal()">회원탈퇴</button>
				</div>
				<div id="button">
				<button type="button" onclick="location.href='${pageContext.request.contextPath }/customer/myPageMain.do'" class="btn btn-warning">마이페이지 메인으로 돌아가기</button>
				</div>
			</form>
			
			</div>
		</div>	
	</div>
	<!-- 콘테이너 끝 -->
	
	
</div>

<div class="row" style="height: 100px;"></div>
</div>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>