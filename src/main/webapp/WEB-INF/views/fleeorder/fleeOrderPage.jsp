<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<title>orderPage</title>
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
</style>
<script type="text/javascript">


function delivery() {
	
	var customer_no = ${sessionCustomer.customer_no};
	var deliveryBox = document.getElementById("deliveryBox");
	
	deliveryBox.innerHTML = "";
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
			var obj = JSON.parse(xmlhttp.responseText);
			
			for(addressData of obj.addressData){
				
				var div = document.createElement("div");
				div.setAttribute("class", "row");
				deliveryBox.appendChild(div);
				
				var div1 = document.createElement("div");
				div1.setAttribute("class", "col-3");
				div1.innerText = addressData.addressListVO.address_number;
				div.appendChild(div1);
				
				var div2 = document.createElement("div");
				div2.setAttribute("class", "col");
				div2.innerText = addressData.addressListVO.address_location;
				div.appendChild(div2);
				
				var div3 = document.createElement("div");
				div3.setAttribute("class", "col-1");
				div.appendChild(div3);
				
				var checkBox = document.createElement("input");
				checkBox.setAttribute("type", "checkbox");
				checkBox.setAttribute("name", "checkbox");
				checkBox.setAttribute("onclick", "selectAddress(this)");
				checkBox.setAttribute("value", addressData.addressListVO.address_no);
				div3.appendChild(checkBox);
				
			}
			
		}
	};

	xmlhttp.open("post", "./getCustomerDeliveryProcess.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("customer_no="+customer_no);
}

function selectAddress(check) {
	
	if(check.checked == true){
		
		var chkval = check.value;
		var putCheckedAddress = document.getElementById("putCheckedAddress");
		
		putCheckedAddress.innerHTML = "";
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
	
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				var add = document.createElement("div");
				add.setAttribute("id", "address_no");
				add.setAttribute("name", "address_no");
				add.setAttribute("value", chkval);
				add.innerText = obj.addressVO.address_location;
				putCheckedAddress.appendChild(add);
				
			}
		};
	
		xmlhttp.open("post", "./getAddressVOByAddNo.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("address_no="+chkval);
	}
	
}


function purchaseForm() {
	
	var fleemarketdetail_no = ${orderData.fleemarketDetailVO.fleemarketdetail_no};
	var mycoupon_no = document.getElementById("mycoupon_no").getAttribute("value");
	var address_no = document.getElementById("address_no").getAttribute("value");
	var orderpayment_no= document.getElementById("orderpayment_no").value;
	var fleemarketdetail_count = ${orderData.fleemarketCount};
	
	var param ="";
	param += "fleemarketdetail_no="+fleemarketdetail_no;
	param += "&mycoupon_no="+mycoupon_no;
	param += "&address_no="+address_no;
	param += "&orderpayment_no="+orderpayment_no; 
	param += "&orderflee_count="+fleemarketdetail_count;
	
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
		}
	};

	xmlhttp.open("post", "./orderProcess.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(param);

}

</script>
<style type="text/css">
	.orderbar{
		font-size: 18px;
		font-weight: bold;
		margin-bottom: 15px;
	}
</style>
</head>
<body>

<div class="row">
	<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
</div>

<div class="container">
	
	<div class="row mt-5 orderbar">
		<div class="col-4">주문/결제</div>
	</div>
	
	<div class="row">
		구매자 정보
		<table class="table">
			<tbody>
				<tr>
					<th scope="row">이름</th>
					<td>${ sessionCustomer.customer_name }</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td>${ sessionCustomer.customer_email }</td>
				</tr>
				<tr>
					<th scope="row">휴대폰 번호</th>
					<td>${ sessionCustomer.customer_phone }</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	
	<div class="row">
		수령자 정보
		<table class="table">
			<tbody>
				<tr>
					<th scope="row">이름</th>
					<td><!-- <input type="text" name="delivery_name"
						id="delivery_name" value=""> -->
						${ sessionCustomer.customer_name }</td>
				</tr>
				<tr>
					<th scope="row">배송주소
						<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-toggle="modal" data-bs-target="#deliveryModal" onclick="delivery()">배송지확인</button>
					</th>
					<td>
						<input type="hidden" name="cus_address" id="cus_address" value="">
						<!-- <input type="text" name="delivery_address" id="delivery_address" value=""> -->
						<div id="putCheckedAddress"></div>
					</td>
				</tr>
				<tr>
					<th scope="row">연락처</th>
					<td>
						<!-- <input type="text" name="delivery_phone" id="delivery_phone" value=""> -->
						${ sessionCustomer.customer_phone }
					</td>
				</tr>
				<tr>
					<th scope="row">배송 요청사항</th>
					<td><input type="text" name="delivery_req" id="delivery_req" value="요청사항 입력란"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	<div class="row">
		주문상품
		
		
		<table class="table">
			<tbody>
				<tr>
					<th scope="row">상품옵션이름</th>
					<th scope="row">개당가격</th>
					<th scope="row">주문개수</th>
					<th scope="row">총 가격</th>
				</tr>
				<tr>
					<td>${ orderData.fleeMarketDetailVO.productdetail_option }</td>
					<td>${ orderData.fleeMarketVO.fleemarekt_price }</td>
					<td>${ orderData.fleemarketCount }</td>
					<td>${ orderData.total_price }
						<input class="ttt1" type="hidden" value="${ orderData.fleeMarketCartVO.fleemarketdetail_no }">
						<input class="ttt2" type="hidden" value="${ orderData.fleemarketCount }">
					</td>
				</tr>
			</tbody>
		</table>
		<div id="hidden"></div>
	</div>
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	<div class="row">
		결제정보 <input type="hidden" id="orderForm">
		<table class="table">
			<tbody>
				<tr>
					<th scope="row">총상품가격</th>
					<td>${orderData.total_price} ₩</td>
				</tr>
				<tr>
					<th scope="row">배송비</th>
					<td>2500원</td>
				</tr>
				<tr>
					<th scope="row">할인쿠폰</th>
					<td>
						<div id="mycoupon_area"></div>
						<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-toggle="modal" data-bs-target="#couponModal" onclick="coupon()">보유쿠폰확인</button>
					</td>
				</tr>
				<tr>
					<th scope="row">로얄젤리</th>
					<td>100 RJ</td>
				</tr>
				<tr>
					<th scope="row">총 결제금액</th>
					<td>${orderData.total_price}</td>
				</tr>
				<tr>
					<th scope="row">결제방법</th>
					<td>
						<select id="orderpayment_no">
							<option name="orderpayment_no" value="1">카드</option>
							<option name="orderpayment_no" value="2">로얄젤리</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- <form action="./orderProcess.do" method="post" id="hiddenForm"></form> -->
	</div>

	<!-- Button trigger modal -->
	<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="purchaseForm()">결제하기</button>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">주문완료</h5>
					<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
				</div>
				<div class="modal-body">상품 주문이 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" onclick="location.href='../fleemarket/customerFleeMarketPage.do'">메인페이지로 돌아가기</button>
					<button type="button" class="btn btn-primary" onclick="location.href='../customer/myPageMain.do'">주문내역 확인하기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Scrollable modal -->
	<div class="modal fade" id="deliveryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지관리</h5>
					<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
				</div>
				<div class="modal-body col">
					<div class="row mb-3 text-center" style="padding-left: 12px; text-align: center;">배송지목록</div>
					<div  id="deliveryBox" class="row mb-5" style="padding-left: 12px;"></div>
					<div class="row mt-5" onclick="addAddress()" style="width: 466px; margin: 0 auto; padding: 0;">
						<p class="col text-center" style="text-align: center; border: 1px solid #fccc0c; color: #fccc0c; font-size: 20px; font-weight: bold; cursor: pointer; padding: 7px 0 7px 0;">
							배송지 추가
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-dismiss="modal" aria-label="Close">배송지선택완료</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 쿠폰적용 모달 -->
	<!-- Scrollable modal -->
	<div class="modal fade" id="couponModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">보유 쿠폰 관리</h5>
					<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
				</div>
				<div class="modal-body col">
					<div class="row mb-3 text-center" style="padding-left: 12px; text-align: center;">보유쿠폰목록</div>
					<div  id="couponBox" class="row mb-5" style="padding-left: 12px;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-dismiss="modal" aria-label="Close">쿠폰선택완료</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="height: 100px;"></div>
</div>
<!-- 콘테이너 끝 -->

<div class="row">
	<div style="background-color: #efefef; height:100px;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>