<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품장바구니 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript">
function fnCalCount(type, ths){//수량 증가 감소 하는 부분 ths = this
    var $input = $(ths).parents("td").find("input[name='quantity']");
    var tCount = Number($input.val());
    //var tEqCount = Number($(ths).parents("tr").find("td.bseq_ea").html());
    
    if(type=='p'){
        /* if(tCount < tEqCount) */ 
        $input.val(Number(tCount)+1);
        $('#totquantity').val(Number($('#totquantity').val())+1);	//장바구니 리스트들의 총 수량의합계 더해주는 부분
    }else{
        if(tCount > 0) $input.val(Number(tCount)-1);    
        $('#totquantity').val(Number($('#totquantity').val())-1);
    }
    
    var now_price = $(ths).parents("tr").find("input[name='org_price']").val();		//해당 물품의 개당 가격 가져오기
    
    console.log("now_price : " + now_price);
    
    var new_quantity = $(ths).parents("tr").find("input[name='quantity']").val();	//장바구니에서 바꾼 수량가져오기
    
    console.log("new_quantity : " + new_quantity);
    
    var new_price = Number(now_price) *  Number(new_quantity);	//물품 개당 가격 * 증가 또는 감소시킨 수 60000 -> 80000
    
    var toAddPrice = new_price - $(ths).parents("tr").find("input[name='sumprice']").val();	//수량변경으로 증가된 금액 - 기존 금액 = 차액 금
    
    console.log("sumprice1 : " + $(ths).parents("tr").find("input[name='sumprice']").val());
    
    
    $(ths).parents("tr").find("input[name='sumprice']").val(new_price);  	//합계금액에 재계산된 금액 넣어주기
    
    console.log("sumprice2 : " + $(ths).parents("tr").find("input[name='sumprice']").val());
    
    var new_totsumprice = Number($('#totsumprice').val()) + Number(toAddPrice);	//장바구니 리스트들의 총 합산금액 
    
    $('#totsumprice').val(new_totsumprice);	//장바구니 리스트들의 총 합산금액 넣어주기
    
}

var fleemarketPriceList = [];
var total = 0;

function addOrder(box) {
	if (box.checked == true) {
		var obj = JSON.parse(box.value);
		fleemarketPriceList.push(obj.fleemarketPrice);
		plusTotal(obj.fleemarketPrice);
		
	} else {
		var obj = JSON.parse(box.value);
		fleemarketPriceList.pop(obj.fleemarketPrice);
		minusTotal(obj.fleemarketPrice);
	}
}

	function plusTotal(price){
			if(fleemarketPriceList.length == 0 ){
				total = 0;
			} else{
				total = total + parseInt(price, 10);
			}
			
			var totalText = document.getElementById('totalText');
			totalText.innerText = total+" 원";
		}
		
	function minusTotal(price){
			if (fleemarketPriceList.length ==0){
				total = 0;
			}else{
				total = total - parseInt(price, 10);
			}
			
			var totalText = document.getElementById('totalText');
			totalText.innerText = total+" 원";
		}
		
			var fleemarketNoList = [];
			var fleemarketCountList = [];
		
	function updateOrder(){
			
			var chList = document.getElementsByClassName("checked");
			var hidForm = document.getElementById("hiddenForm");
			
			for(chk of chList){
				if(chk.checked == false){
					continue;
				}
				
				var data = JSON.parse(chk.value);
				fleemarketNoList.push(data.fleemarketdetail_no);
				fleemarketCountList.push(data.fleemarketdetail_count);
				
			}
			
			
		
		
			var param = "";
			param += "fleemarketdetail_no="+fleemarketNoList[0];
			param += "&fleemarketdetail_count="+fleemarketCountList[0];
			
			for (var i= 1; i< fleemarketNoList.length; i++){
				param += "&fleemarketdetail_no="+fleemarketNoList[i];
				param += "&fleemarketdetail_count="+fleemarketCountList[i];
			}
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var obj = JSON.parse(xmlhttp.responseText);
				
				var orderfleemarketList = document.getElementById("orderFleeMarketList");
				var hiddenForm = document.getElementById("hidden");
				
				for(orderData of obj.orderData){
					var tr = document.createElement("tr");
					orderfleemarketList.appendChild(tr);
					
					var td1 = document.createElement("td");
					td1.innerText = orderData.fleeMarketDetailVO.fleemarketdetail_option;
					tr.appendChild(td1);
					
					var td2 = document.createElement("td");
					td2.innerText = orderData.fleeMarketVO.fleemarket_price;
					tr.appendChild(td2);
					
					var td3 = document.createElement("td");
					td3.innerText = orderData.fleemarketCount;
					tr.appendChild(td3);
					
					var td4 = document.createElement("td");
					td4.innerText = orderData.total_price;
					tr.appendChild(td4);
					
					var input1 = document.createElement("input");
					input1.setAttribute("class","ttt1");
					input1.setAttribute("type","hidden");
					input1.setAttribute("name","fleemarketdetail_no");
					input1.value = orderData.fleeMarketDetailVO.fleemarketdetail_no;
					hiddenForm.appendChild(input1);
					
					var input2 = document.createElement("input");
					input1.setAttribute("class","ttt2");
					input2.setAttribute("type","hidden");
					input2.setAttribute("name","fleemarketdetail_count");
					input2.value = orderData.fleemarketCount;
					hiddenForm.appendChild(input2);
					
				}
			}
		};
		
		xmlhttp.open("post", "${pageContext.request.contextPath}/fleeorder/orderDataLoarding.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(param);
		
	}
	
	
	
	
	
	function purchaseForm() {
		
	var of = document.getElementById("orderForm");
		of.action = "${pageContext.request.contextPath}/customer/myFleeMainPage.do";
		of.submit();
	
	}







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

		xmlhttp.open("post", "${pageContext.request.contextPath}/fleeorder/getCustomerDeliveryProcess.do", true);
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
		
			xmlhttp.open("post", "${pageContext.request.contextPath}/fleeorder/getAddressVOByAddNo.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("address_no="+chkval);
		}
		
	}
	
	
	
	
	
	
	
 
</script>

<style type="text/css">
.cartbar{
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 15px;
}
.button{
	height: 20px;
	width: 40px;
	font-size: 12px;
	background-color: #ffffff;
	color: #afafaf;
	border: 1px solid #afafaf;
	border-radius: 2px;
	text-align: center;
	line-height: 4px;
}

.table{
	text-align: center;
}

.align_left{
	text-align: left;
}

.checkboxLine{
	width: 50px;
}

.priceLine{
	width: 200px;
}

.quantityLine{
	width: 150px;
}

.sumPriceLine{
	width: 150px;
}

.selectLine{
	width: 200px;
}

thead th{
	font-size: 1.1em;
	font-weight: bold;
}
.fleemarket_name{
	font-size: 1.1em;
	font-weight: bold;
	color: #4c4c4c;
}
.numberForm{
	font-size: 23px;
	padding: 0 !important;
	margin: 0 !important;
	width: 30px;
	height: 30px;
	text-align: center;
	border: 1px solid #fccc0c;
	cursor: pointer;
	line-height:23px;
}
.numberHover:hover{
	background-color: #fccc0c;
	color: #ffffff;
}
#count{
	font-size: 1em;
	border-left: none;
	border-right: none;
	line-height:30px;
	cursor: default;
}

.cartdetail{
	width: 50px !important;
    text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
    white-space: nowrap;    /* 줄바꿈을 하지 않습니다. */
    overflow: hidden;    /* 내용이 길면 감춤니다 */
}


</style>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
   crossorigin="anonymous">
</head>
<body>
   <header>
      <!-- 네비게이션.. -->
      <jsp:include page="/WEB-INF/views/commons/navigation.jsp"></jsp:include>
   </header>
   
 <br>

<div class="container">
	<div class="row cartbar">
		<div class="col-4">총 ${	fleeCartCount }개의 상품이 담겨있습니다.</div>
		<div class="col" style="text-align: right"> <span style="color: #fccc0c">01 장바구니</span> > 02 주문/결제 > 03 결제완료</div>
	</div>
	
	<div id="cartArea">
		<c:set var = "total" value = "0" />	
		<table class="table">
			<thead>
				<tr style="border-top: 2px solid #000000;">
					<th scope="col"></th>
					<th scope="col">product</th>
					<th scope="col"></th>
					<th scope="col" class="priceLine">Price</th>
					<th scope="col" class="quantityLine">Quantity</th>
					<th scope="col" class="sumPriceLine">합계</th>
					<th scope="col" class="selectLine">선택</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${fleeCartList }" var="data">
				<tr class="fleeList">
					<th scope="row" class="align-middle align_left checkboxLine">
					<input type="checkbox" class="checked"
						value= '{"fleemarketPrice" : "${data.fleeMarketVO.fleemarket_price}" , "fleemarketdetail_no" : "${data.fleeMarketDetailVO.fleemarketdetail_no }", "fleemarketdetail_count" : "${ data.fleeMarketCartVO.fleemarketdetail_count }"}'
						onclick="addOrder(this)">
					</th>
					<td class="align-middle" style="width:180px;">
						<div style="height: 150px; width:150px; background-image: url('/upload_files/${ data.fleeMarketImageVO.fleemarketimage_location }'); background-repeat: no-repeat; background-size: cover; <%-- background-position: center; --%>"></div>
					</td>
					<td class="align-middle align_left">
						<div class="row">
							<div class="col" style="padding-left: 20px;">
								<div class="row">
									<div class="col fleemarket_name">${data.fleeMarketVO.fleemarket_name }</div>
								</div>
								<div class="row">
										<div class="col" style="line-height: 30px;">${data.fleeMarketDetailVO.fleemarketdetail_option }</div>
							</div>
							<div class="row" style="line-height: 30px;">
								<div class="col cartdetail">${data.fleeMarketVO.fleemarket_content }</div>
							</div>
						</div>
						</div>
						
					</td>
					<td class="align-middle priceLine">
					<input size="8" type="text" id="org_price" name="org_price" value="${data.fleeMarketVO.fleemarket_price }" readonly="readonly" style="text-align:center;">원
					</td>
					
					<td class="align-middle quantityLine">
						<button type="button" onclick="fnCalCount('m', this);">-</button>
				        	<input size="6" type="text" id = "quantity" name="quantity" value="${data.fleeMarketCartVO.fleemarketdetail_count }" readonly="readonly" style="text-align:center;"/>
				        <button type ="button" onclick="fnCalCount('p',this);">+</button>
					</td>
					
					<td class="align-middle sumPriceLine">
					<input size = "8" type="text" id = "sumprice" name="sumprice" value="${data.fleeMarketVO.fleemarket_price * data.fleeMarketCartVO.fleemarketdetail_count }" readonly="readonly" style="text-align:center;"/>원
					</td>

					<td class="align-middle selectLine">
						<c:if test="${!empty sessionCustomer && sessionCustomer.customer_no == data.customerVO.customer_no }">
						<button type="button" onclick="location.href='${pageContext.request.contextPath}/fleeorder/deleteFleeCartProcess.do?fleemarketcart_no='+${data.fleeMarketCartVO.fleemarketcart_no}">삭제</button>	
						</c:if>

					</td>
				</tr>
				</c:forEach>
				</tbody>
				
			</table>
		<%-- <c:set var= "total" value="${total + (data.fleeMarketVO.fleemarket_price) * (data.fleeMarketCartVO.fleemarketdetail_count)}"/> --%>
		
		<%-- 	<c:set var="total" value="${total + (data.fleeMarketVO.fleemarket_price) * (data.fleeMarketCartVO.fleemarketdetail_count}"/> --%>
	
		</div><!-- id = cartArea -->
	
	<div class="row mb-5">
			
		<div class="col-8">
		상품 총 합계 : <div id="totalText"></div>
		
		상품 총 합계 : <input size="8" type="text" id="totsumprice" value="${totalMap.TOTPRICE }" readonly="readonly" style="text-align:left;"/>원<br>
		</div>
		<div class="col-4" style="text-align: right;">
		<form id="hiddenForm" action="./orderDataLoarding.do" method="post"></form>
			<button type="button" class="btn btn-warning" id="submitOrder" onclick="updateOrder()">주문하기</button>
		</div>
	</div>
	</div>
	
<!-- container -->

<div class="container">
	<form id="orderForm">
	<div class="row mt-5 cartbar">
		<div class="col-4">주문/결제</div>
		<div class="col" style="text-align: right">01 장바구니 > <span style="color: #fccc0c">02 주문/결제</span> > 03 결제완료</div>
	</div>
	
	<div class="row">
		<div class="col pt-3" style="border-top: 2px solid #000000;">
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
	</div>
	
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	
	<div class="row">
		<div class="col">
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
	</div>
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	<div class="row">
		<div class="col">
			주문상품
			<table class="table">
				<tbody>
					<tr>
						<th scope="row">상품옵션이름</th>
						<th scope="row">개당가격</th>
						<th scope="row">주문개수</th>
						<th scope="row">총 가격</th>
					</tr>
				</tbody>
				<tbody id="orderFleeMarketList"></tbody>
			</table>
			<div id="hidden"></div>
		</div>
	</div>
	<div class="row">
		<hr style="border-top-width: 1px; border-top-color: #fccc0c; border-top-style: solid; border-bottom-width: 1px; border-bottom-color: #fccc0c; border-bottom-style: solid; margin: 15px;">
	</div>
	<div class="row">
		<div class="col">
			결제정보 <input type="hidden" id="orderForm">
			<table class="table">
				<tbody>
					<tr>
						<th scope="row">총상품가격</th>
						<td>${orderData.total_price} ₩</td>
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
		</div>
		<!-- <form action="./orderProcess.do" method="post" id="hiddenForm"></form> -->
	</div>

	<!-- Button trigger modal -->
	<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" onclick="purchaseForm()">결제하기</button>

	
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
	
	<div class="row" style="height: 100px;"></div>
</form>
</div><!-- container 끝 -->

<div class="row">
	<div style="background-color: #efefef; height:100px;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>