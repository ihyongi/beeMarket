<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<meta charset="UTF-8">
<title>My Bee</title>
</head>
<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#container{
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
#main{float:left; width:80%; height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
	margin-left:0;
	width: 960px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    padding-left: 70px;
    padding-right: 70px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:90%;
 }
table{text-align: center;}
h2{float:left;}
#arrayPage{float:right; width:90px;}
</style>
<script type="text/javascript">
function statusChange(order_status_no, order_no){
	alert(order_status_no);
	var order_status_no = order_status_no;
	var order_no = order_no;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
			/* productdetail_option.value="";
			productwarehouse_pluscount.value="";
			productdetail_price.value=""; */

		}
	};	
	xmlhttp.open("get","./updateOrderStatus.do?order_status_no="+order_status_no+"&order_no="+order_no , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();
}


</script>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
	<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<div id="wrapper">
			<h2>주문조회</h2>
         <br>
         <br>
         <select id="searchOption">
         	<option>상품명</option>
         	<option>상품옵션</option>
         </select>
         <input placeholder="검색해주세요."><button type="button" class="btn btn-primary">검색</button>
			<select id="arrayPage" onchange="location.href=this.value" class="form-control">
         	<option value="./orderList.do?seller_no=${sessionSeller.seller_no}" selected>주문내역</option>
         	<option value="./prepareDeliveryList.do?seller_no=${sessionSeller.seller_no}">배송대기</option>
         	<option value="./deliverySuccess.do?seller_no=${sessionSeller.seller_no }" >배송완료</option>
         	<option value="./refundList.do?seller_no=${sessionSeller.seller_no }">취소내역</option>
         </select>
			<hr>
			<table class="table table-hover">
				<tr>
					<td>주문번호</td>
					<td>구매자ID</td>
					<td>상품명</td>
					<td>상품옵션</td>
					<td>주문개수</td>
					<td>주문일</td>
					<td>주문상태</td>
				</tr>
				<c:forEach items="${orderList}" var="data">
				<tr>
					<td onclick="orderDetail(${data.orderVO.order_no},${data.customerVO.customer_no})">${data.orderVO.order_no}</td>
					<td>${data.customerVO.customer_id}</td>
					<td>${data.productVO.product_name}</td>
					<td>${data.productDetailVO.productdetail_option}</td>
					<td>${data.orderVO.order_count}</td>
					<td><fmt:formatDate value="${data.orderVO.order_orderdate}" pattern="yyyy/MM/dd"/></td>
					<td style="color:blue; font-weight: bold;">${data.orderStatusVO.order_status_name}</td>				
				</tr>
				</c:forEach>
			</table>
			      <!-- 제품 정보 Modal -->
		         <div class="modal fade" id="orderDetailModal" tabindex="-1" 
		            aria-labelledby="exampleModalLabel" aria-hidden="true">
		            <div class="modal-dialog modal-dialog-centered">
		               <div class="modal-content">
		                  <div class="modal-header">
		                     <h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
		                        주문정보 조회
		                     </h5>
		                     <button type="button" class="btn-close"
		                        onclick="orderDetailModal.hide();"></button>
		                  </div>
		                  <div class="modal-body">
		                  <div style="margin: 0px; padding: 0px;">
		                     <div class="row" style="margin: 20px;">
		                     <h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">구매자 정보</h4>
		                     <table class="table">
		                        <tbody>
		                           <tr>
		                              <th scope="row">이름</th>
		                              <td id="customerName">박소영</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">이메일</th>
		                              <td id="customerEmail">이메일</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">휴대폰 번호</th>
		                              <td id="customerPhone">휴대폰 번호</td>
		                           </tr>
		                        </tbody>
		                     </table>
		                     </div>
		                  <hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
		                  <div class="row" style="margin: 20px;">
		                  <h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">수령자 정보</h4>
		                     <table class="table">
		                        <tbody>
		                           <tr>
		                              <th scope="row">이름</th>
		                              <td id="customer_name">수령자 이름</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">배송주소</th>
		                              <td>
		                                 <div id="address_number">우편번호란</div>
		                                 <div id="address_location" style="width: 300px;">상세주소란</div>
		                              </td>
		                           </tr>
		                           <tr>
		                              <th scope="row">연락처</th>
		                              <td id="customer_phone">연락처</td>
		                           </tr>
		                        </tbody>
		                     </table>
		                  </div>
		                  <hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
		                  <div class="row" style="margin: 20px;">
		                  <h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">주문상품</h4>
		                     <table class="table">
		                        <tbody>
		                           <tr>
		                              <th scope="row">상품옵션이름</th>
		                              <th scope="row">개당가격</th>
		                              <th scope="row">주문개수</th>
		                              <th scope="row">총 가격</th>
		                           </tr>
		                           <tr>
		                              <td id="detail_option">옵션</td>
		                              <td id="detail_price">원</td>
		                              <td id="order_count">개</td>
		                              <td id="order_price">총 원</td>
		                           </tr>
		                        </tbody>
		                     </table>
		                  </div>
		                  <hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
		                  <div class="row" style="margin: 20px;">
		                     <h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">결제정보</h4>
		                     <table class="table">
		                        <tbody>
		                           <tr>
		                              <th scope="row">배송비</th>
		                              <td>2500원</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">할인쿠폰</th>
		                              <td id="couponName">쿠폰을 사용하지 않았습니다.</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">총 결제금액</th>
		                              <td id="orderPrice">총 결제 금액</td>
		                           </tr>
		                           <tr>
		                              <th scope="row">결제방법</th>
		                              <td id="orderPayment">카드나 로얄젤리</td>
		                           </tr>
		                        </tbody>
		                     </table>
		                  </div>
		                  </div>
		               </div>
		                  <!-- <div class="modal-footer">
		                     <button type="button" class="btn btn-warning"
		                        data-bs-dismiss="modal">확인</button>
		                  </div> -->
		               </div>
		            </div>
		         </div>
<script type="text/javascript">		           
var orderDetailModal = null;
function orderDetail(order_no, customer_no){
	var orderNO = order_no;
	var customerNo = customer_no;
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
		    var obj = JSON.parse(xmlhttp.responseText);
		    var customerName = document.getElementById("customerName");
		    var customerEmail = document.getElementById("customerEmail");
		    var customerPhone = document.getElementById("customerPhone");
		    
		    var customer_name = document.getElementById("customer_name");
		    var address_number = document.getElementById("address_number");
		    var address_location = document.getElementById("address_location");
		    var customer_phone = document.getElementById("customer_phone");
		    
		    var detail_option = document.getElementById("detail_option");
		    var detail_price = document.getElementById("detail_price");
		    var order_count = document.getElementById("order_count");
		    var order_price = document.getElementById("order_price");
		    
		    var couponName = document.getElementById("couponName");
		    var orderPrice = document.getElementById("orderPrice");
		    var orderPayment = document.getElementById("orderPayment");
		    
		    var data=obj.OrderDetailData;
		    	customerName.innerText=data.customerVO.customer_name;
		    	customerEmail.innerText=data.customerVO.customer_email;
		    	customerPhone.innerText=data.customerVO.customer_phone;
		    	
		    	customer_name.innerText=data.customerVO.customer_name;
		    	address_number.innerText=data.addressListVO.address_number;
		    	address_location.innerText=data.addressListVO.address_location;
		    	customer_phone.innerText=data.customerVO.customer_phone;
		    	
		    	detail_option.innerText=data.productDetailVO.productdetail_option;
		    	detail_price.innerText=data.productDetailVO.productdetail_price+'원';
		    	order_count.innerText=data.orderVO.order_count+'개';
		    	order_price.innerText=data.orderVO.order_price+'원';
		    	if(data.couponVO != null){
		    	couponName.innerText=data.couponVO.coupon_name+'쿠폰';
		    	}
		    	orderPrice.innerText=data.orderVO.order_price+'원';
		    	if(data.orderVO.orderpayment_no == 1){
		    		orderPayment.innerText="카드결제";
		    	}else{
		    		orderPayment.innerText="포인트결제";
		    	}
		    	
		    
			orderDetailModal.show(); 
		}
	};
	
	xmlhttp.open("post","../customer/getOrderDetail.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("order_no="+orderNO+"&customer_no="+customerNo);
}
orderDetailModal = new bootstrap.Modal(document.getElementById('orderDetailModal')); 
</script>			
		</div>
	</div>
</div>
</body>
</html>