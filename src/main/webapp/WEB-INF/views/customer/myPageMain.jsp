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
	color: #BDB76B;
}

a:hover{
	text-decoration: blink !important;
	color: #fcc92f;
}

.card{
	border: none;
}
.star-rating{
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
}

.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}
.box {
    /* width: 179px; */
    height: 100px; 
    overflow: hidden;
    margin: 0 0 0 0;
    position: relative;
    text-align:center;

}
.profile {
    width: 60px;
    height: 60px;
    object-fit: cover;
	top: 22px;
	opacity: 0.3;
	cursor: pointer;
}
.profile:hover {
    width: 60px;
    height: 60px;
    object-fit: cover;
	top: 22px;
	opacity: 1;
}

.rightArrow {
    width: 30px;
    height: 30px;
    padding-top: 15px;
    object-fit: cover;
	top: 22px;
}
.swal-button {
  
  background-color: #fff58c;
  font-size: 12px;
  border: 1px solid #gold;
}
.imageBox{
	width: 220px;
}

</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	
	var myModal = null;
	var orderDetailModal = null;
	
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
	
	function writeCommentButton(product_no){
		var productNO = product_no;
		var customer_no = ${sessionCustomer.customer_no};
		var buttonBox = document.getElementById("modalButton");
		buttonBox.innerHTML="";
		var okButton = document.createElement("button");
		okButton.setAttribute("type","button");
		okButton.setAttribute("onclick",'writeComment('+productNO+')');
		okButton.setAttribute("class","btn btn-warning");
		okButton.innerHTML="후기작성";
		buttonBox.appendChild(okButton);
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    if(obj.productCommentVO == null){
					myModal.show();
					
			    }else{
			    	swal("Notice","이미 작성한 후기입니다.\n 수정은 구매후기 페이지에서 가능합니다.");
			    }
			    
				
			}
		};
		
		xmlhttp.open("post","../customer/getComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("product_no="+productNO+"&customer_no="+customer_no);
	}
		
	function writeComment(product_no){
		
		var commentValue = document.getElementById("commentInput").value;
		var starValue = document.querySelector('input[name="rating"]:checked').value;
		var productNo = product_no;
		
		if(commentValue == ""){
			swal("Notice","후기 내용을 작성해 주세요!");
			return;
		}
		
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
			    swal("Notice","후기 작성이 완료되었습니다~ \n작성한 후기는 구매후기페이지에서 수정 가능합니다.","success");				
				myModal.hide();
			}
		};
		
		xmlhttp.open("post","../product/writeComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("product_no=" + productNo + "&productcomment_content=" + commentValue + "&productcomment_star=" + starValue);
	}
	
	function confirmButton(order_no){
	      var orderNo=order_no;
	      
	      //AJAX 호출.....
	      var xmlhttp = new XMLHttpRequest();
	      
	      //호출 후 값을 받았을때... 처리 로직....
	      xmlhttp.onreadystatechange = function(){
	         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	             //var obj = JSON.parse(xmlhttp.responseText);
	            swal("Notice","구매확정 되었습니다^^\n감사합니다~","success",{timer : 1500});
	             setTimeout(reload(), 1500);
	         }
	      };
	      
	      xmlhttp.open("get","../order/updateConfrimdate.do?order_no="+orderNo , true);
	      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	      xmlhttp.send();
	   }
	   
	function reload(){
		window.location.reload();
	}
	
	var selectedElement = null;
	
	function over_img_area_boxes_event(e){
		e.children[0].style.opacity = "1";
	}

	function out_img_area_boxes_event(e){
		if(e == selectedElement) return;
		e.children[0].style.opacity = "0.3";
	}
	
	function click_img_area_boxes_event(e){
	      
	      if(selectedElement != null){
	         selectedElement.children[0].style.opacity = "0.3";
	      }
	      
	      if(selectedElement == null || selectedElement != e){
	         e.children[0].style.opacity = "1";
	         sortList(e);
	      }
	      
	      if(selectedElement == e){
	         selectedElement = null;
	      }else{
	         selectedElement = e;
	         sortList(e);
	      }
	      
	   }
	
	
	function sortList(e){
		
		var orderStatusNo = e.getAttribute("value");
		var customer_no = ${sessionCustomer.customer_no};
		
		var sortNameBox = document.getElementById('sortName'+orderStatusNo);
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
 				var OrderProductBox = document.getElementById("orderList");
 				
 				
 				OrderProductBox.innerHTML = "";
 				
			    for(data of obj.sortOrderData){
			    	
			    	var AllBox = document.createElement("div");
			    	AllBox.setAttribute("class","row mb-3");
			    	AllBox.setAttribute("style","width: 880px; padding-left: 20px;");
			    	
			    	var col1Box = document.createElement("div");
			    	col1Box.setAttribute("class","col");
			    	AllBox.appendChild(col1Box);
			    	
			    	var row1Box = document.createElement("div");
			    	row1Box.setAttribute("class","row");
			    	row1Box.setAttribute("style","border: 2px solid #f2f2f2; border-radius: 10px;");
			    	col1Box.appendChild(row1Box);
			    	
			    	var col2Box = document.createElement("div");
			    	col2Box.setAttribute("class","col");
			    	row1Box.appendChild(col2Box);
			    	
			    	var row2Box = document.createElement("div");
			    	row2Box.setAttribute("class","row");
			    	row2Box.setAttribute("style","height: 166px;");
			    	col2Box.appendChild(row2Box);
			    	
			    	var col3Box = document.createElement("div");
			    	col3Box.setAttribute("class","card col");
			    	col3Box.setAttribute("style","margin-bottom:10px; margin-top: 10px; border: 0px;");
			    	row2Box.appendChild(col3Box);
			    	
			    	var row3Box = document.createElement("div");
			    	row3Box.setAttribute("class","row g-0");
			    	col3Box.appendChild(row3Box);
			    	
			    	var col4Box = document.createElement("div");
			    	col4Box.setAttribute("class","col-2 md-4 img-thumbnail");
			    	col4Box.setAttribute("style","background-image: url('/upload_files/" + data.productImageVO.productimage_location +"'); background-repeat: no-repeat; background-size: cover; background-position: center; border:0px; height:145px;");
			    	row3Box.appendChild(col4Box);
			    	
			    	var col5Box = document.createElement("div");
			    	col5Box.setAttribute("class","col md-6");
			    	row3Box.appendChild(col5Box);
			    	
			    	var row4Box = document.createElement("div");
			    	row4Box.setAttribute("class","row");
			    	row4Box.setAttribute("style","color: #5b5b5b; font-size: 18px; font-weight: bold; text-align: left; padding-left: 30px;");
			    	row4Box.innerText = data.productVO.product_name;
			    	col5Box.appendChild(row4Box);
			    	
			    	var hrBox = document.createElement("hr");
			    	hrBox.setAttribute("class","one");
			    	hrBox.setAttribute("style","margin-bottom: 10px; margin-top: 10px; color: #fcc92f;");
			    	col5Box.appendChild(hrBox);
			    	
			    	var row5Box = document.createElement("div");
			    	row5Box.setAttribute("class","row");
			    	col5Box.appendChild(row5Box);
			    	
			    	var col6Box = document.createElement("div");
			    	col6Box.setAttribute("class","col");
			    	row5Box.appendChild(col6Box);
			    	
			    	var row6Box = document.createElement("div");
			    	row6Box.setAttribute("class","row");	
			    	row6Box.setAttribute("style","padding-left: 21px;");
			    	row6Box.setAttribute("onclick",'orderDetail('+data.orderVO.order_no+')');
			    	col6Box.appendChild(row6Box);
			    	
			    	var p1Box = document.createElement("p");
			    	p1Box.setAttribute("style","padding-bottom: 7px; margin-bottom: 0px;");
			    	p1Box.innerText="주문번호";
			    	row6Box.appendChild(p1Box);
			    	
			    	var small1Box = document.createElement("small");
			    	small1Box.setAttribute("class","text-muted");
			    	small1Box.innerText= data.orderVO.order_no;
			    	p1Box.appendChild(small1Box);
			    	
			    	var p2Box = document.createElement("p");
			    	p2Box.setAttribute("style","padding-bottom: 7px; margin-bottom: 0px;");
			    	p2Box.innerText="결제금액";
			    	row6Box.appendChild(p2Box);
			    	
			    	var small2Box = document.createElement("small");
			    	small2Box.setAttribute("class","text-muted");
			    	small2Box.innerText= data.orderVO.order_price +'원';
			    	p2Box.appendChild(small2Box);
			    	
			    	var p3Box = document.createElement("p");
			    	p3Box.setAttribute("style","padding-bottom: 7px; margin-bottom: 0px;");
			    	p3Box.innerText="주문상태";
			    	row6Box.appendChild(p3Box);
			    	
			    	var small3Box = document.createElement("small");
			    	small3Box.setAttribute("class","text-muted");
			    	small3Box.innerText= data.orderStatusVO.order_status_name;
			    	p3Box.appendChild(small3Box);
			    	
			    	var col7Box = document.createElement("div");
			    	col7Box.setAttribute("class","col-5");
			    	col7Box.setAttribute("style","text-align: right");
			    	row5Box.appendChild(col7Box);
			    	
			    	var cardBodyBox = document.createElement("div");
			    	cardBodyBox.setAttribute("class","card-body");
			    	col7Box.appendChild(cardBodyBox);
			    	
			    	var row7Box = document.createElement("div");
			    	row7Box.setAttribute("class","row");
			    	cardBodyBox.appendChild(row7Box);
			    	
			    	var button1Box = document.createElement("button");
			    	button1Box.setAttribute("class","btn btn-outline-warning");
			    	button1Box.setAttribute("style","width: 100px; height: 40px; display: inline;");
			    	button1Box.innerText="1:1 문의";
			    	row7Box.appendChild(button1Box);
			    	
			    	if(data.orderVO.order_status_no == 5){
			    		var button2Box = document.createElement("button");
			    		button2Box.setAttribute("class","btn btn-outline-warning");
			    		button2Box.setAttribute("id","writeCommentButton");
			    		button2Box.setAttribute("onclick",'writeCommentButton('+data.productDetailVO.product_no+')');
			    		button2Box.setAttribute("style","width: 100px; height: 40px; display: inline; margin-left: 20px;");
			    		button2Box.innerText="후기쓰기";
				    	row7Box.appendChild(button2Box);
			    	}
			    	
			    	var row8Box = document.createElement("div");
			    	row8Box.setAttribute("class","row mt-2");
			    	cardBodyBox.appendChild(row8Box);
			    	
			    	if(data.orderVO.order_status_no == 4){
			    		var button3Box = document.createElement("button");
			    		button3Box.setAttribute("class","btn btn-outline-warning");
			    		button3Box.setAttribute("onclick","confirmButton(${data.orderVO.order_no})");
			    		button3Box.setAttribute("style","width: 100px; height: 40px; display: inline;");
			    		button3Box.innerText="구매확정";
			    		row8Box.appendChild(button3Box);
			    	}
			    
			    	OrderProductBox.appendChild(AllBox);
			    	
			    }
			}
		};
		
		xmlhttp.open("post","../customer/orderList.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_status_no="+orderStatusNo+"&customer_no="+customer_no);
	}
	
	function sortAllList(){
		window.location.reload();
	}
	
	function orderDetail(order_no){
		var orderNO = order_no;
		var customer_no = ${sessionCustomer.customer_no};
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
		xmlhttp.send("order_no="+orderNO+"&customer_no="+customer_no);
	}
		
	
	function init(){
		
		getSessionCustomerNo();
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
		orderDetailModal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
		
		var images = document.getElementsByClassName("image");
		
		for(x of images){
			x.setAttribute("onclick" , "click_img_area_boxes_event(this)");
			x.setAttribute("onmouseover" , "over_img_area_boxes_event(this)");
			x.setAttribute("onmouseout" , "out_img_area_boxes_event(this)");
		}
		
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
			<div class="row mt-3 mb-3">
				<div class="col-2" style="color: #5b5b5b; font-size: 20px; font-weight: bold; text-align: left;">주문내역</div>
				<div class="col"></div>
				<div class="col border-warning" style="height: 45px; width: 140px;">
					<div style="float: right;">
						<button class="btn btn-outline-warning" onclick="sortAllList()" style="width: 100px; height: 40px; display: inline;">전체보기</button>
					</div>
				</div>
			</div>
			<div class="row mb-4" style="text-align: center;">
			
				<div class="col imageBox">
					<div class="row" style="margin: 0px;">
						<div class="box image" value="1">
							<img class="profile" src="${ pageContext.request.contextPath }/resources/img/buyProduct.png" style="position: relative;">				
						</div>
					</div>
					<div class="row" id="sortName1">
						<div class="col" style="color: #5b5b5b; font-size: 17px; text-align:center;">결제완료</div>
					</div>
				</div>
				<div class="col-1">
					<img class="rightArrow" src="${ pageContext.request.contextPath }/resources/img/right-arrow.png" style="position: relative;">
				</div>
				<div class="col imageBox">
					<div class="row" style="margin: 0px;">
						<div class="box image" value="2">
							<img class="profile" src="${ pageContext.request.contextPath }/resources/img/loading.png" style="position: relative;">				
						</div>
					</div>
					<div class="row" id="sortName2">
						<div class="col" style="color: #5b5b5b; font-size: 17px; text-align:center;">배송준비중</div>
					</div>
				</div>
				<div class="col-1">
					<img class="rightArrow" src="${ pageContext.request.contextPath }/resources/img/right-arrow.png" style="position: relative;">
				</div>
				<div class="col imageBox">
					<div class="row" style="margin: 0px;">
						<div class="box image" value="3">
							<img class="profile" src="${ pageContext.request.contextPath }/resources/img/delivering.png" style="position: relative;">				
						</div>
					</div>
					<div class="row" id="sortName3">
						<div class="col" style="color: #5b5b5b; font-size: 17px; text-align:center;">배송중</div>
					</div>
				</div>
				<div class="col-1">
					<img class="rightArrow" src="${ pageContext.request.contextPath }/resources/img/right-arrow.png" style="position: relative;">
				</div>
				<div class="col imageBox">
					<div class="row" style="margin: 0px;">
						<div class="box image" value="4">
							<img class="profile" src="${ pageContext.request.contextPath }/resources/img/deliveryComplete.png" style="position: relative;">				
						</div>
					</div>
					<div class="row" id="sortName4">
						<div class="col" style="color: #5b5b5b; font-size: 17px; text-align:center;">배송완료</div>
					</div>
				</div>
				<div class="col-1">
					<img class="rightArrow" src="${ pageContext.request.contextPath }/resources/img/right-arrow.png" style="position: relative;">
				</div>
				<div class="col imageBox">
					<div class="row" style="margin: 0px;">
						<div class="box image" value="5">
							<img class="profile" src="${ pageContext.request.contextPath }/resources/img/buyOk.png" style="position: relative;">				
						</div>
					</div>
					<div class="row" id="sortName5">
						<div class="col" style="color: #5b5b5b; font-size: 17px; text-align:center;">구매확정</div>
					</div>
				</div>
			
			</div>
			<div id="orderList">
			<!-- 주문상품 리스트 출력 -->
			<c:forEach items="${ myPageData }" var="data">
			<div class="row mb-3" style="width: 880px; padding-left: 20px;">
				<div class="col">
					<div class="row" style="border: 2px solid #f2f2f2; border-radius: 10px;">
						<div class="col">
							
							<div class="row" style="height: 166px;">
								<div class="card col" style="margin-bottom:10px; margin-top: 10px; border: 0px;">
									<div class="row g-0">
										<div class="col-2 md-4 img-thumbnail" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'" 
											style="background-image: url('/upload_files/${ data.productImageVO.productimage_location }'); background-repeat: no-repeat; background-size: cover; background-position: center; border:0px; height:145px;">
										</div>
										<div class="col md-6">
											<div class="row" style="color: #5b5b5b; font-size: 18px; font-weight: bold; text-align: left; padding-left: 30px;" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'">
												${data.productVO.product_name }	
											</div>
											<hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
											<div class="row">
											<div class="col">
												<div class="row" onclick="orderDetail(${data.orderVO.order_no })" style="padding-left: 21px;">
													<p style="padding-bottom: 7px; margin-bottom: 0px;">주문번호 <small class="text-muted">${data.orderVO.order_no }</small></p>
													<p style="padding-bottom: 7px; margin-bottom: 0px;">결제금액 <small class="text-muted">${data.orderVO.order_price }원</small></p>
													<p style="padding-bottom: 7px; margin-bottom: 0px;">주문상태 <small class="text-muted">${data.orderStatusVO.order_status_name }</small></p>
												</div>
											</div>
										
											<div class="col-5" style="text-align: right">
												<div class="card-body">
													<div class="row">
														<button class="btn btn-outline-warning" style="width: 100px; height: 40px; display: inline;">1:1 문의</button>
														<c:choose>
															<c:when test="${data.orderVO.order_status_no == 5}">
																<button class="btn btn-outline-warning" id="writeCommentButton" onclick="writeCommentButton(${data.productDetailVO.product_no})" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">후기쓰기</button>
															</c:when>
															<c:when test="${data.orderVO.order_status_no == 4}">
																<button class="btn btn-outline-warning" onclick="confirmButton(${data.orderVO.order_no})" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">구매확정</button>
															</c:when>
															<c:otherwise>
															</c:otherwise>
														</c:choose>
													</div>
													<div class="row mt-2">
														
													</div>
												</div>
											</div>
										</div>												
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			
			
			
			
			</div>
		</div>
		
		
		</div>
	<!-- 콘테이너 끝 -->
	<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
								상품 후기 작성
							</h5>
							<button type="button" class="btn-close"
								onclick="myModal.hide();"></button>
						</div>
						<div class="modal-body">
								<div class="star-rating space-x-4 mx-auto mb-3">
									<input type="radio" id="5-stars" name="rating" value="5" v-model="rating"/>
									<label for="5-stars" class="star pr-4">★</label>
									<input type="radio" id="4-stars" name="rating" value="4" v-model="rating"/>
									<label for="4-stars" class="star pr-4">★</label>
									<input type="radio" id="3-stars" name="rating" value="3" v-model="rating"/>
									<label for="3-stars" class="star pr-4">★</label>
									<input type="radio" id="2-stars" name="rating" value="2" v-model="rating"/>
									<label for="2-stars" class="star pr-4">★</label>
									<input type="radio" id="1-stars" name="rating" value="1" v-model="rating"/>
									<label for="1-stars" class="star pr-4">★</label>

								</div>
								<form>
									<textarea id="commentInput" class="form-control" rows="3" cols="30" style="resize: none; border: 1px solid #fcc92f;"></textarea>
								</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">나중에 작성</button>
								<div id="modalButton"></div>
						</div>
					</div>
				</div>
			</div>
			
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
						<div class="modal-footer">
							<button type="button" class="btn btn-warning"
								data-bs-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>	
			
			
			
			
			
			
		
	
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