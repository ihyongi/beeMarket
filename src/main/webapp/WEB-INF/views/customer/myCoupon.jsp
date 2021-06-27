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
<title>myCoupon</title>
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

.card{
	border: none;
}

</style>

<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	
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
	
	function sortList(){

		
		var sortVal = document.getElementsByName("myCouponFilter").length;
		  
        for (var i=0; i<sortVal; i++) {
            if (document.getElementsByName("myCouponFilter")[i].checked == true) {
                var sortName = document.getElementsByName("myCouponFilter")[i].value;
            }
        }
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
			
			}
		};
		
		xmlhttp.open("get","../customer/getCouponSortList.do" , true);
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
		<div class="col" id="mainContainer mt-3">
		
		<!-- 할인쿠폰 -->
		<div class="couponList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mt-3 mb-3">
				<div class="col-3" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
				쿠폰 <span style="color: #fcc92f; font-size: 25px; font-weight: bold; text-align: left;">${myCouponCount }</span>
				</div>
				<div class="col">
				</div>
				
						<div class="col border-warning" style="height: 45px; width: 140px;">
							<div class="radioSort" style="float: right;">
								<input type="radio" class="btn-check" id="myCouponFilter0" name="myCouponFilter" value="coupon_date" checked autocomplete="off" onclick="sortAll();">
								<label class="btn btn-outline-warning" for="myCouponFilter0">전체쿠폰</label>
								<input type="radio" class="btn-check" id="myCouponFilter1" name="myCouponFilter" value="coupon_usable" autocomplete="off" onclick="sortList();">
								<label class="btn btn-outline-warning" for="myCouponFilter1">사용가능</label>
							</div>
						</div>
					
			</div>
			
			<!-- 쿠폰 리스트 출력파트 table 형식-->
			<div class="row mb-5">
				<table class="table table-sm" style="text-align: center;">
					<colgroup>
						<col style="width:10%">
						<col style="width:*">
						<col style="width:12.6%">
						<col style="width:12.6%">
						<col style="width:20%">
						<col style="width:11%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">쿠폰번호</th>
							<th scope="col">쿠폰명</th>
							<th scope="col">할인금액</th>
							<th scope="col">적용 범위</th>
							<th scope="col">유효기간</th>
							<th scope="col">&nbsp;</th>
						</tr>
					</thead>
					
					

					<tbody>
						<jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
						<fmt:parseNumber value="${today.time/(1000*60*60*24)}" var="now" integerOnly="true" />
						<c:forEach items="${myCouponData}" var="data">
						<tr>
							<td>${data.myCouponVO.mycoupon_no}</td>
							<td class="left">
								<strong class="txt-primary">[브랜드전용]</strong>
								"${data.couponVO.coupon_name }"</td>
							<td>
								<c:choose>
									<c:when test="${data.couponVO.coupon_discountprice == 0}">
										${data.couponVO.coupon_discountrate} %
									</c:when>
									<c:otherwise>
										${data.couponVO.coupon_discountprice } ₩
									</c:otherwise>
								</c:choose>
							</td>
							<td>적용범위</td>
							<td style="text-align: center;">
								"<fmt:formatDate value="${data.couponVO.coupon_begindate }" pattern="yy.MM.dd"></fmt:formatDate>" ~ "<fmt:formatDate value="${data.couponVO.coupon_enddate }" pattern="yy.MM.dd"></fmt:formatDate>"
								<br>
						     	<fmt:parseNumber value="${data.couponVO.coupon_begindate.time/(1000*60*60*24)}" var="startdate" integerOnly="true" />
						     	<fmt:parseNumber value="${data.couponVO.coupon_enddate.time/(1000*60*60*24)}" var="enddate" integerOnly="true" />
						     	<c:choose>
							     	<c:when test="${startdate - now > 0 }">
							     		<span>${startdate - now}일 후 사용가능</span>
							     	</c:when>
						     		<c:when test="${enddate - now > 0 }" >
						     			<span>${enddate - now}일 남음</span>
						     		</c:when>
						     		<c:otherwise>
										<span>사용 불가 쿠폰</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<button type="button" class="btn w100 btn-sm btn-default" onclick="">
									적용상품 보기
								</button>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
		
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