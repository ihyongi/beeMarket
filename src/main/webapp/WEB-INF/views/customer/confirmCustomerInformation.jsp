<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	color: #fcc92f;
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
    padding-top: 10px;
}

#info{
    width: 100%;
    box-sizing: border-box;
    height: 70px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
/* input {
    height:45px;
    width:440px;
} */
/* input:focus{outline:none;} */
#customer_pw:hover{border-bottom:1px solid black;}
#button{text-align: center;}
#buttonBox{text-align: center; margin-top:20px;}
#ment{margin-top:10px; font-size: 12px;}
#nick{color:#FFC81E; font-weight: bold;}
#valueSectionWrapper{border:1px solid #bebebe;}
#warning{color:red;}
</style>

<script type="text/javascript">
	var sessionCustomer = null;

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
		<!-- 주문 내역 조회 -->
		<div class="orderList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mb-5 mt-3">
				<div class="col-7" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">회원정보확인</div>
				<div class="col-5"></div>
			</div>
			
			<div id="wrapper">
			<h2>회원정보확인</h2>
			<p id="ment"><span id="nick">${sessionCustomer.customer_name }</span>님의 정보를 안전하게 보호하기 위해 비밀번호를 한 번 더 입력해주세요.</p>
			<c:if test="${!empty param.error}">
				<p id="warning">암호를 다시 확인해주세요.</p>
			</c:if>
			<form method="post" action="${pageContext.request.contextPath }/customer/customerInfoPwCheck.do">
				<div id="infoSection">
					<div id="valueSectionWrapper">
						<div id="key_value_section">
							<div id="key_section">아이디</div>
							<div id="value_section"><input type="text" id="customer_id" name="customer_id" style="height:45px; width:440px;" value="${sessionCustomer.customer_id}" readonly></div>
						</div>
						<div id="key_value_section">
							<div id="key_section">비밀번호</div>
							<div id="value_section"><input type="password" id="customer_pw" name="customer_pw" style="height:45px; placeholder="암호를 입력해주세요."></div>
						</div>
					</div>	
						<div id="buttonBox">
							<button type="submit" class="btn btn-warning">확인</button>
						</div>
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