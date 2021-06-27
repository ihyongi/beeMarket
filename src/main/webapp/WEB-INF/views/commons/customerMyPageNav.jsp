<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	text-decoration: none;
	margin: 0 !important; 
	padding: 0 !important;
	color: #BDB76B;
}

a:hover{
	text-decoration: blink !important;
	color: #fcc92f;
}

.card{
	border: none;
}
</style>

<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	
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
	
	<div class="row" style="height: 50px; line-height:50px; background-color: #fcc92f;"></div>
	<div class="row">
		<div class="col-2" style="padding: 0; position: relative; top: -5px;">
			<a href="../customer/myPageMain.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">MY BEE</a>
		</div>
		<div class="col">
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">회원등급</th>
			      <th scope="col">배송중</th>
			      <th scope="col">보유쿠폰</th>
			      <th scope="col">로얄젤리</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>VIP</td>
			      <td>0 개</td>
			      <td>0 개</td>
			      <td>0 Jelly</td>
			    </tr>
			  </tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<!-- 좌측네비바 -->
		<div class="col-3">
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">MY SHOPPING</div>
			<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
				<a href="${pageContext.request.contextPath }/customer/myPageMain.do">주문내역조회/배송조회</a>
			</div>
			<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
				<a href="${pageContext.request.contextPath }/customer/exchangeMyPage.do">취소/반품/교환</a>
			</div>
				
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">MY BENEFITS</div>
				<div class="col mb-5">
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">마이쿠폰</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">로얄젤리</a>
					</div>
				</div>
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">MY ACTIVITIES</div>
				<div class="col mb-5">
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">문의하기</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">구매후기</a>
					</div>
				</div>
			<!-- 마이쇼핑 -->
			<div class="row mt-5" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">MY INFORMATION</div>
				<div class="col mb-5">
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">개인정보확인/수정</a>
					</div>
					<div class="row" style="color: #BDB76B; font-size: 19px; font-weight: bold; text-align: left;">
						<a href="">배송지 관리</a>
					</div>
				</div>
		</div>
	</div>

<div class="row" style="height: 100px;"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>