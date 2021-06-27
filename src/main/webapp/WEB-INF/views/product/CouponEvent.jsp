<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/mainPage.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/bestProductPage.css">
	
<title>CouponEvent</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}

a:hover{
	text-decoration: blink !important; 
}

.container{
	width : 1200px;
	max-width: none !important;
}
.category_area{
	color: #333333;
	text-decoration: none;
	text-align: center;
	padding: 7px 0px 7px 0px;
	
}
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
	
	var myModal = null;
	
	//쿠폰 발급 버튼 눌렀을때 EVENT
	function insertCoupon(coupon_no) {
		
		var couponNo=coupon_no;
		
		if(sessionCustomerNo == null){
			alert("로그인을 하셔야 쿠폰을 발급받을 수 있습니다.");
			return;
		}
		//var coupon_no = document.getElementById("coupon_no").innerHTML;

		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				myModal.show();
			}
		};
		
		xmlhttp.open("post","../product/insertCoupon.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("coupon_no="+couponNo);
	}
	
	function init(){
		getSessionCustomerNo();
		
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'))
	}
	
</script>
</head>
<body onload="init()">

<div class="container">

	<!-- 헤더 -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>
	
	<!-- 본문 -->
	<div class="container">
		이벤트나 행사 배너
	</div>
	
	<div class="row mb-5">
		<div class="col Event" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">Event</div>
	</div>
	
	<!-- nav 진행/종료 이벤트 -->
	<div class="row">
		<div class="d-flex align-items-start">
  			<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
				<button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">진행중인 이벤트</button>
				<button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">종료된 이벤트</button>
			</div>
  			<div class="tab-content" id="v-pills-tabContent">
		    	<div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
				
					<div class="card" style="width: 18rem;">
						<img src="${pageContext.request.contextPath }/resources/img/Event1.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<p class="card-text">게릴라 타임 이벤트입니다.</p>
						</div>
					</div>
					
					<div class="card" style="width: 18rem;">
						<img src="${pageContext.request.contextPath }/resources/img/Event2.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<p class="card-text">10분어택 이벤트입니다.</p>
						</div>
					</div>
					
				</div>
		    	<div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
		    	
		    		<div class="card" style="width: 18rem;">
						<img src="${pageContext.request.contextPath }/resources/img/Event3.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<p class="card-text">공유 타임 이벤트입니다.</p>
						</div>
					</div>
		    	
		    	</div>
  			</div>
		</div>
	</div>
	
	<!-- 쿠폰 -->
	<div class="row mb-5">
		<div class="col Event" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">Coupon</div>
	</div>
	
	<div class="row">
		
		<c:forEach items="${ allCouponList }" var="coupon">
			<div class="card w-30" style="width: 18rem;">
			<div class="card-body">
				<img src="${pageContext.request.contextPath }/resources/img/Coupon.png" class="card-img-top" alt="...">
				<div>${ coupon.couponVO.coupon_name }</div>
				<div id="coupon_no" style="display: none;">${ coupon.couponVO.coupon_no }</div>
				<a onclick="insertCoupon(${ coupon.couponVO.coupon_no })" class="btn btn-warning">쿠폰발급받기</a>
			</div>
		</div>
		</c:forEach>
		
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">
							Coupon
						</h5>
						<button type="button" class="btn-close"
							onclick="myModal.hide();"></button>
					</div>
					<div class="modal-body">쿠폰이 발급되었습니다. 마이페이지>마이쿠폰 에서 확인가능합니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">확인</button>
						<button type="button" onclick="location.href='${pageContext.request.contextPath }/customer/myCoupon.do'" class="btn btn-primary">마이쿠폰으로 이동</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
	
	</div>
	
	
	
	
	
	
	
	
	
</div>

<div class="row">
	<div style="background-color: #efefef; height:100px;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>