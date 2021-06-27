<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CartListPage</title>
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/orderPage.css">
<script>
	
	function updatecount(val , e) {

		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				e.parentElement.getElementsByClassName("numberForm")[1].innerText = obj.cartVO.productdetail_count;
				var updatePriceArea = e.closest("#tableRow");
				updatePriceArea.children[3].innerText = obj.updateTotalPrice + " 원";
				
			}
		};
		
		xmlhttp.open("post", "./updateCartCount.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("cart_no="+val);
		
		/*
		var countVal = new Array();
		var countArea = document.getElementsByName("count");
		
		for (var i = 0; i < countArea.length; i++) {
			alert(countArea[i].getAttribute("value"));
			countVal.push(countArea[i].getAttribute("value"));
		}
		
		for (var i = 0; i < countVal.length; i++) {
			
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
	
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					
					var obj = JSON.parse(xmlhttp.responseText);
					var countAreaList = document.getElementsByName("count");
					countAreaList[i].innerText = "";
					countAreaList[i].innerText = obj.cartVO.productdetail_count;
					
					
				}
			};
			
			xmlhttp.open("post", "./updateCartCount.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("cart_no="+countVal[i]);
		
		}
		*/
	}
	
	function plusCount(val , e) {
		
		var cart_no = val;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				updatecount(val , e);
			}
		};
		
		xmlhttp.open("post", "./plusCartCount.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("cart_no="+cart_no);
	}
	
	function minusCount(val , e) {
		
		var cart_no = val;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				updatecount(val , e);
			}
		};
		
		xmlhttp.open("post", "./minusCartCount.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("cart_no="+cart_no);
	}
	
	var productDetailPriceList = [];
	var total = 0;
	
	function addOrder(box) {
		if (box.checked == true) {
			var obj = JSON.parse(box.value);
			productDetailPriceList.push(obj.productDetailPrice);
			plusTotal(obj.productDetailPrice);
			
		} else {
			var obj = JSON.parse(box.value);
			productDetailPriceList.pop(obj.productDetailPrice);
			minusTotal(obj.productDetailPrice);
		}
	}

	function plusTotal(price) {
		if (productDetailPriceList.length == 0) {
			total = 0;
		} else {
			total = total + parseInt(price, 10) + 2500;
		}

		var totalText = document.getElementById('totalText');
		totalText.innerText = total+" 원";
	}

	function minusTotal(price) {
		if (productDetailPriceList.length == 0) {
			total = 0;
		} else {
			total = total - parseInt(price, 10) - 2500;
		}

		var totalText = document.getElementById('totalText');
		totalText.innerText = total+" 원";
	}
	
	var productDetailNoList = [];
	var productDetailCountList = [];
	var cartNoList = [];
	
	function updateOrder() {
		
		var chList = document.getElementsByClassName("checked");
		var hidForm = document.getElementById("hiddenForm");
		var checkedCondition = [];
		
		for(chk of chList){
			
			if(chk.checked == false){
				continue;
			}
			
			var data = JSON.parse(chk.value);
			productDetailNoList.push(data.productdetail_no);
			productDetailCountList.push(data.productdetail_count);
			cartNoList.push(data.cart_no);
			checkedCondition.push(data.productdetail_no);
			
		}
		
		if (checkedCondition.length == 0) {
			alert("구매할 상품을 선택하여 주십시오");
			return;
		}
		
		var param ="";
		param += "productdetail_no="+productDetailNoList[0];
		param += "&productdetail_count="+productDetailCountList[0];
		
		for (var i = 1; i < productDetailNoList.length; i++) {
			param += "&productdetail_no="+productDetailNoList[i];
			param += "&productdetail_count="+productDetailCountList[i];
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				var orderArea = document.getElementById("orderArea");
				var cartProductArea = document.getElementById("cartProductArea");
				cartProductArea.innerHTML = "";
				
					
					var cartbarDiv = document.createElement("div");
					cartbarDiv.setAttribute("class","row cartbar pb-2");
					cartbarDiv.setAttribute("style","border-bottom: 2px solid #5b5b5b;");
				orderArea.appendChild(cartbarDiv);
					
					var cartbarSubdiv1 = document.createElement("div");
					cartbarSubdiv1.setAttribute("class","col-4");
					cartbarSubdiv1.innerText = "주문/결제";
					cartbarDiv.appendChild(cartbarSubdiv1);
					
					var cartbarSubdiv2 = document.createElement("div");
					cartbarSubdiv2.setAttribute("class","col");
					cartbarSubdiv2.setAttribute("style","text-align: right");
					cartbarDiv.appendChild(cartbarSubdiv2);
					cartbarSubdiv2.innerHTML = "01 장바구니 > ";
					cartbarSubdiv2.innerHTML += "<span style='color: #fccc0c;'>02 주문/결제</span>";
					cartbarSubdiv2.innerHTML += " > 03 결제완료";
					
					
					
					var rowMarginDiv = document.createElement("div");
					rowMarginDiv.setAttribute("class","row rowMargin");
				orderArea.appendChild(rowMarginDiv);
				
					var rowMarginSubdiv1 = document.createElement("div");
					rowMarginSubdiv1.setAttribute("class","col semiTitle");
					var length = obj.orderData.length;
					if ( length == 1) {
						rowMarginSubdiv1.innerText = '"'+obj.orderData[0].productVO.product_name+'" 상품을 주문합니다';
					}else {
						rowMarginSubdiv1.innerText = '"'+obj.orderData[0].productVO.product_name+'"외 '+(parseInt(length,10)-1)+'개 상품을 주문합니다';
					}
					rowMarginDiv.appendChild(rowMarginSubdiv1);
					
					/* 상품을 주문합니다 끝 */
					
					
					
					var row1 = document.createElement("div");
					row1.setAttribute("class","row");
				orderArea.appendChild(row1);
				
					var col1 = document.createElement("div");
					col1.setAttribute("class","col tableTitle");
					col1.innerText = "구매자 정보";
					row1.appendChild(col1);
					
					var row2 = document.createElement("div");
					row2.setAttribute("class","row rowMargin");
				orderArea.appendChild(row2);
				
					var col2 = document.createElement("div");
					col2.setAttribute("class","col");
					row2.appendChild(col2);
					
					var innerRow1 = document.createElement("div");
					innerRow1.setAttribute("class","row");
					col2.appendChild(innerRow1);
					
						var innerCol1 = document.createElement("div");
						innerCol1.setAttribute("class","col-4 thStyle");
						innerCol1.innerText = "이름"
						innerRow1.appendChild(innerCol1);
						
						var innerCol2 = document.createElement("div");
						innerCol2.setAttribute("class","col tdStyle");
						innerCol2.innerText = "${ sessionCustomer.customer_name }"
						innerRow1.appendChild(innerCol2);
						
						
					var innerRow2 = document.createElement("div");
					innerRow2.setAttribute("class","row");
					col2.appendChild(innerRow2);
					
						var innerCol3 = document.createElement("div");
						innerCol3.setAttribute("class","col-4 thStyle");
						innerCol3.innerText = "이메일";
						innerRow2.appendChild(innerCol3);
						
						var innerCol4 = document.createElement("div");
						innerCol4.setAttribute("class","col tdStyle");
						innerCol4.innerText = "${ sessionCustomer.customer_email }";
						innerRow2.appendChild(innerCol4);
					
						
					var innerRow3 = document.createElement("div");
					innerRow3.setAttribute("class","row");
					col2.appendChild(innerRow3);
					
						var innerCol5 = document.createElement("div");
						innerCol5.setAttribute("class","col-4 thStyle");
						innerCol5.innerText = "휴대폰 번호";
						innerRow3.appendChild(innerCol5);
						
						var innerCol6 = document.createElement("div");
						innerCol6.setAttribute("class","col tdStyle");
						innerCol6.innerText = "${ sessionCustomer.customer_phone }";
						innerRow3.appendChild(innerCol6);
					
						
					var innerRow4 = document.createElement("div");
					innerRow4.setAttribute("class","row");
					col2.appendChild(innerRow4);
					
						var innerCol7 = document.createElement("div");
						innerCol7.setAttribute("class","col-4 thStyle");
						innerRow4.appendChild(innerCol7);
							var lowerRow1 = document.createElement("div");
							innerCol7.appendChild(lowerRow1);
								var lowerCol1 = document.createElement("div");
								lowerRow1.appendChild(lowerCol1);
								lowerCol1.innerText="배송주소";
									var modalbtn1 = document.createElement("div");
									modalbtn1.setAttribute("class","modalbtnStyle");
									modalbtn1.setAttribute("data-bs-toggle","modal");
									modalbtn1.setAttribute("data-bs-target","#deliveryModal");
									modalbtn1.setAttribute("onclick","delivery()");
									modalbtn1.innerText="배송지선택"
									lowerCol1.appendChild(modalbtn1);
									 
						var innerCol8 = document.createElement("div");
						innerCol8.setAttribute("class","col tdStyle");
						innerRow4.appendChild(innerCol8);
							var hiddenInput1 = document.createElement("input");
							hiddenInput1.setAttribute("type","hidden");
							hiddenInput1.setAttribute("name","cus_address");
							hiddenInput1.setAttribute("id","cus_address");
							hiddenInput1.setAttribute("value","");
							innerCol8.appendChild(hiddenInput1);
							var checkAddress = document.createElement("div");
							checkAddress.setAttribute("id","putCheckedAddress");
							innerCol8.appendChild(checkAddress);
				/* 구매자 정보 끝 */
				
				
				
				/* 구매상품 테이블 */
						var row3 = document.createElement("div");
						row3.setAttribute("class","row");
					orderArea.appendChild(row3);
							var innerCol9 = document.createElement("div");
							innerCol9.setAttribute("class","col tableTitle");
							innerCol9.innerText="주문상품";
							row3.appendChild(innerCol9);
							
						var row4 = document.createElement("div");
						row4.setAttribute("class","row mb-5");
					orderArea.appendChild(row4);		
						var innerCol10 = document.createElement("div");
						innerCol10.setAttribute("class","col");
						row4.appendChild(innerCol10);
						
							var tableBox1 = document.createElement("table");
							tableBox1.setAttribute("class","table");
							innerCol10.appendChild(tableBox1);
							
								var tbodyBox = document.createElement("tbody");
								tableBox1.appendChild(tbodyBox);
								
									var tr1 = document.createElement("tr");
									tbodyBox.appendChild(tr1);
									
										var th1 = document.createElement("th");
										th1.setAttribute("scope","row");
										tr1.appendChild(th1);	
										var th2 = document.createElement("th");
										th2.setAttribute("scope","row");
										th2.innerText="상품이름";
										tr1.appendChild(th2);
										var th3 = document.createElement("th");
										th3.setAttribute("scope","row");
										th3.innerText="개당가격";
										tr1.appendChild(th3);
										var th4 = document.createElement("th");
										th4.setAttribute("scope","row");
										th4.innerText="주문개수";
										tr1.appendChild(th4);
										var th5 = document.createElement("th");
										th5.setAttribute("scope","row");
										th5.innerText="총 가격";
										tr1.appendChild(th5);
										
									var hiddenForm = document.createElement("div");
									orderArea.appendChild(hiddenForm);
									
									var the_total_price = 0;
									var the_delivery_price = 0;
									var the_final_price = 0;
									
							for(orderData of obj.orderData){
								
								var tr2 = document.createElement("tr");
								tr2.setAttribute("id", "orderproductList");
								tbodyBox.appendChild(tr2);
								
								var td1 = document.createElement("td");
								td1.setAttribute("class", "tdStyle");
								td1.setAttribute("style", "width:200px;");
								tr2.appendChild(td1);
								
								var productDetailImg = document.createElement("img");
								productDetailImg.setAttribute("class", "productImagePrev");
								productDetailImg.setAttribute("src", "/upload_files/"+orderData.productImageVO.productimage_location);
								td1.appendChild(productDetailImg);
								
								var td2 = document.createElement("td");
								td2.setAttribute("class", "tdStyle");
								tr2.appendChild(td2);
								
								var tableInnerRow1 = document.createElement("div");
								tableInnerRow1.setAttribute("class", "row product_name");
								tableInnerRow1.innerText = orderData.productVO.product_name;
								td2.appendChild(tableInnerRow1);
								
								var tableInnerRow2 = document.createElement("div");
								tableInnerRow2.setAttribute("class", "row");
								tableInnerRow2.innerText = "선택옵션 - "+orderData.productDetailVO.productdetail_option;
								td2.appendChild(tableInnerRow2);
								
								
								if (orderData.productDetailVO.discount_status == 'Y') {
									var td3 = document.createElement("td");
									td3.setAttribute("class", "tdCenterStyle");
									td3.innerText = orderData.discountVO.discount_price+" 원";
									tr2.appendChild(td3);
								} else {
									var td3 = document.createElement("td");
									td3.setAttribute("class", "tdCenterStyle");
									td3.innerText = orderData.productDetailVO.productdetail_price+" 원";
									tr2.appendChild(td3);
								}
								
								var td4 = document.createElement("td");
								td4.setAttribute("class", "tdCenterStyle");
								td4.innerText = orderData.productDetailCount+" 개";
								tr2.appendChild(td4);
								
								var td5 = document.createElement("td");
								td5.setAttribute("class", "tdCenterStyle");
								td5.innerText = orderData.total_price+" 원";
								tr2.appendChild(td5);
								
								var input1 = document.createElement("input");
								input1.setAttribute("class","ttt1");
								input1.setAttribute("type","hidden");
								input1.setAttribute("name","productdetail_no");
								input1.value = orderData.productDetailVO.productdetail_no;
								hiddenForm.appendChild(input1);
								
								var input2 = document.createElement("input");
								input1.setAttribute("class","ttt2");
								input2.setAttribute("type","hidden");
								input2.setAttribute("name","productdetail_count");
								input2.value = orderData.productDetailCount;
								hiddenForm.appendChild(input2);
								
								the_total_price = the_total_price + orderData.total_price;
								the_delivery_price = the_delivery_price + 2500;
								the_final_price = the_final_price + orderData.delivery_price;
								
							}
									
				/* 구매상품 테이블 */					
										
										
				var row5 = document.createElement("div");
				row5.setAttribute("class", "row");
				orderArea.appendChild(row5);
				
				var col3 = document.createElement("div");
				col3.setAttribute("class", "col tableTitle");
				col3.innerText = "결제 정보";
				row5.appendChild(col3);
				
				var row6 = document.createElement("div");
				row6.setAttribute("class", "row rowMargin");
				orderArea.appendChild(row6);
				
				var col4 = document.createElement("div");
				col4.setAttribute("class", "col");
				row6.appendChild(col4);
				
				var lastRow1 = document.createElement("div");
				lastRow1.setAttribute("class", "row");				
				col4.appendChild(lastRow1);	
				var lastCol1 = document.createElement("div");
				lastCol1.setAttribute("class", "col-4 thStyle");
				lastCol1.innerText = "주문상품 합계"
				lastRow1.appendChild(lastCol1);	
				var lastCol2 = document.createElement("div");
				lastCol2.setAttribute("class", "col tdStyle");
				lastCol2.innerText = the_total_price+" 원"
				lastRow1.appendChild(lastCol2);
				
									
				var lastRow2 = document.createElement("div");
				lastRow2.setAttribute("class", "row");				
				col4.appendChild(lastRow2);
				var lastCol3 = document.createElement("div");
				lastCol3.setAttribute("class", "col-4 thStyle");
				lastCol3.innerText = "배송비"
				lastRow2.appendChild(lastCol3);	
				var lastCol4 = document.createElement("div");
				lastCol4.setAttribute("class", "col tdStyle");
				lastCol4.innerText = the_delivery_price+" 원"
				lastRow2.appendChild(lastCol4);
						
				
				var lastRow3 = document.createElement("div");
				lastRow3.setAttribute("class", "row");				
				col4.appendChild(lastRow3);
				var lastCol5 = document.createElement("div");
				lastCol5.setAttribute("class", "col-4 thStyle");
				lastRow3.appendChild(lastCol5);	
				var lastInnerRow1 = document.createElement("div");
				lastInnerRow1.setAttribute("class", "row");
				lastCol5.appendChild(lastInnerRow1);
				var lastInnerCol1 = document.createElement("div");
				lastInnerCol1.setAttribute("class", "col");
				lastInnerRow1.appendChild(lastInnerCol1);
				lastInnerCol1.innerHTML = "쿠폰적용";
				var couponModalBtn = document.createElement("div");
				couponModalBtn.setAttribute("class", "modalbtnStyle");
				couponModalBtn.setAttribute("data-bs-toggle", "modal");
				couponModalBtn.setAttribute("data-bs-target", "#couponModal");
				couponModalBtn.setAttribute("onclick", "coupon()");
				couponModalBtn.innerText = "보유쿠폰 확인";
				lastInnerCol1.appendChild(couponModalBtn);
				var lastCol6 = document.createElement("div");
				lastCol6.setAttribute("class", "col tdStyle");
				lastRow3.appendChild(lastCol6);
				var couponArea = document.createElement("div");
				couponArea.setAttribute("id", "mycoupon_area");
				lastCol6.appendChild(couponArea);
				
				
				var lastRow4 = document.createElement("div");
				lastRow4.setAttribute("class", "row");				
				col4.appendChild(lastRow4);	
				var lastCol7 = document.createElement("div");
				lastCol7.setAttribute("class", "col-4 thStyle");
				lastCol7.innerText = "로얄젤리"
				lastRow4.appendChild(lastCol7);	
				var lastCol8 = document.createElement("div");
				lastCol8.setAttribute("class", "col tdStyle");
				lastCol8.innerText = "100 RJ"
				lastRow4.appendChild(lastCol8);
				
				
				var lastRow5 = document.createElement("div");
				lastRow5.setAttribute("class", "row");				
				col4.appendChild(lastRow5);
				var lastCol9 = document.createElement("div");
				lastCol9.setAttribute("class", "col-4 thStyle");
				lastCol9.innerText = "결제금액";
				lastRow5.appendChild(lastCol9);	
				var lastCol10 = document.createElement("div");
				lastCol10.setAttribute("class", "col tdStyle");
				lastCol10.innerText = the_final_price;
				lastRow5.appendChild(lastCol10);
				
				
				var lastRow6 = document.createElement("div");
				lastRow6.setAttribute("class", "row");				
				col4.appendChild(lastRow6);
				var lastCol11 = document.createElement("div");
				lastCol11.setAttribute("class", "col-4 thStyle");
				lastCol11.innerText = "결제방법 선택하기";
				lastRow6.appendChild(lastCol11);	
				var lastCol12 = document.createElement("div");
				lastCol12.setAttribute("class", "col tdStyle");
				lastRow6.appendChild(lastCol12);
				var paymentSelect = document.createElement("select");
				paymentSelect.setAttribute("id", "orderpayment_no");
				lastCol12.appendChild(paymentSelect);
				var paymentOption1 = document.createElement("option");
				paymentOption1.setAttribute("name", "orderpayment_no");
				paymentOption1.setAttribute("value", "1");
				paymentOption1.innerText = "카드";
				paymentSelect.appendChild(paymentOption1);
				var paymentOption2 = document.createElement("option");
				paymentOption2.setAttribute("name", "orderpayment_no");
				paymentOption2.setAttribute("value", "2");
				paymentOption2.innerText = "로얄젤리";
				paymentSelect.appendChild(paymentOption2);
					
				
				var row6 = document.createElement("div");
				row6.setAttribute("class", "row");
				orderArea.appendChild(row6);
				
				var purchaseCol = document.createElement("div");
				purchaseCol.setAttribute("class", "col");
				purchaseCol.setAttribute("style", "text-align: right;");
				row6.appendChild(purchaseCol);
				
				var purchaseBtn = document.createElement("button");
				purchaseBtn.setAttribute("type", "button");
				purchaseBtn.setAttribute("class", "button");
				purchaseBtn.setAttribute("style", "background-color: #fccc0c !important; border: none;");
				purchaseBtn.setAttribute("data-bs-toggle", "modal");
				purchaseBtn.setAttribute("data-bs-target", "#exampleModal");
				purchaseBtn.setAttribute("onclick", "purchaseForm()");
				purchaseBtn.innerText = "결제하기";
				purchaseCol.appendChild(purchaseBtn);
				
			}
		};
		
		xmlhttp.open("post", "./orderDataLoarding.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(param);
		
	}
	
	function purchaseForm() {
		
		var adressArea = document.getElementById("address_no");
		
		if (adressArea == undefined) {
			alert("배송지 선택은 필수 입력사항입니다.");
			return;
		}
		
		var orderpayment_no= document.getElementById("orderpayment_no").value;
		var address_no = document.getElementById("address_no").getAttribute("value");
		var mycoupon_no = document.getElementById("mycoupon_area").getAttribute("value");
		
		if(mycoupon_no == null){
			mycoupon_no=parseInt(0);
		}else{
			mycoupon_no = document.getElementById("mycoupon_area").getAttribute("value");
		}
		
		var param2 ="";
		param2 += "productdetail_no="+productDetailNoList[0];
		param2 += "&orderpayment_no="+orderpayment_no; 
		param2 += "&order_count="+productDetailCountList[0];
		param2 += "&address_no=" +address_no;
		param2 += "&mycoupon_no=" +mycoupon_no;
		param2 += "&cart_no=" +cartNoList[0];
		
		for (var i = 1; i < productDetailNoList.length; i++) {
			param2 += "&productdetail_no="+productDetailNoList[i];
			param2 += "&orderpayment_no="+orderpayment_no;
			param2 += "&order_count="+productDetailCountList[i];
			param2 += "&address_no=" +address_no;
			param2 += "&mycoupon_no=" +mycoupon_no;
			param2 += "&cart_no=" +cartNoList[i];
		}
			
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
			}
		};

		xmlhttp.open("post", "./purchaseProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(param2);
		

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
	
	function coupon() {
		
		var customer_no = ${sessionCustomer.customer_no};
		var couponBox = document.getElementById("couponBox");
		
		couponBox.innerHTML = "";
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				for(couponData of obj.couponData){
					
					var div = document.createElement("div");
					div.setAttribute("class", "row");
					couponBox.appendChild(div);
					
					var div1 = document.createElement("div");
					div1.setAttribute("class", "col-3");
					div1.innerText = couponData.couponVO.coupon_name;
					div.appendChild(div1);
					
					/* var div2 = document.createElement("div");
					div2.setAttribute("class", "col");
					div2.innerText = couponData.addressListVO.address_location;
					div.appendChild(div2); */
					
					var div3 = document.createElement("div");
					div3.setAttribute("class", "col-1");
					div.appendChild(div3);
					
					var checkBox = document.createElement("input");
					checkBox.setAttribute("type", "checkbox");
					checkBox.setAttribute("name", "checkbox");
					checkBox.setAttribute("onclick", "selectMyCoupon(this)");
					checkBox.setAttribute("value", couponData.myCouponVO.mycoupon_no);
					div3.appendChild(checkBox);
					
				}
				
			}
		};

		xmlhttp.open("post", "./getCustomerCouponListProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("customer_no="+customer_no);
	}
	
	function selectMyCoupon(check) {
		
		if(check.checked == true){
			
			var chkval = check.value;
			var mycoupon_area = document.getElementById("mycoupon_area");
			
			mycoupon_area.innerHTML = "";
			
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
		
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					
					var obj = JSON.parse(xmlhttp.responseText);
					
					var add = document.createElement("div");
					add.setAttribute("id", "mycoupon_no");
					add.setAttribute("name", "mycoupon_no");
					add.setAttribute("value", chkval);
					add.innerText = obj.couponVO.coupon_name;
					mycoupon_area.appendChild(add);
					
				}
			};
		
			xmlhttp.open("post", "./getCouponVOByMyCouponNo.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("mycoupon_no="+chkval);
		}
		
	}
	
</script>
</head>
<body>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
</div>

<div class="container" id="cartProductArea">
	<div class="row cartbar">
		<div class="col-4">총 ${ cartCount }개의 상품이 담겨있습니다.</div>
		<div class="col" style="text-align: right"> <span style="color: #fccc0c">01 장바구니</span> > 02 주문/결제 > 03 결제완료</div>
	</div>
	
	<div id="cartArea">
		<c:set var = "total" value = "0" />	
		<table class="table">
			<thead>
				<tr style="border-top: 2px solid #5b5b5b;">
					<th scope="col"></th>
					<th scope="col"></th>
					<th scope="col">상품정보</th>
					<th scope="col" class="priceLine">상품금액</th>
					<th scope="col" class="deliveryLine">배송비</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${ cartDataList }" var="data">
				<tr id="tableRow">
					<c:if test="${ data.productdetailVO.discount_status == 'N' }">
						<th scope="row" class="align-middle align_left checkboxLine">
							<input type="checkbox" class="checked"
							value= '{"productDetailPrice" : "${ (data.productdetailVO.productdetail_price) * (data.cartVO.productdetail_count) }" ,
							"productdetail_no" : "${ data.productdetailVO.productdetail_no }",
							"productdetail_count" : "${ data.cartVO.productdetail_count }",
							"cart_no" : "${ data.cartVO.cart_no }"}'
							onclick="addOrder(this)">
						</th>
					</c:if>
					<c:if test="${ data.productdetailVO.discount_status == 'Y' }">
						<th scope="row" class="align-middle align_left checkboxLine">
							<input type="checkbox" class="checked"
							value= '{"productDetailPrice" : "${ (data.discountVO.discount_price) * (data.cartVO.productdetail_count) }" ,
							"productdetail_no" : "${ data.productdetailVO.productdetail_no }",
							"productdetail_count" : "${ data.cartVO.productdetail_count }",
							"cart_no" : "${ data.cartVO.cart_no }"}'
							onclick="addOrder(this)">
						</th>
					</c:if>
					<td class="align-middle" style="width:180px;">
						<div style="height: 150px; width:150px; background-image: url('/upload_files/${ data.productImageVO.productimage_location }'); background-repeat: no-repeat; background-size: cover; <%-- background-position: center; --%>"></div>
					</td>
					<td class="align-middle align_left">
						<div class="row">
							<div class="col" style="padding-left: 20px;">
								<div class="row mb-2">
									<div class="col product_name">${ data.productVO.product_name }</div>
								</div>
								<div class="row">
									<div class="col" style="line-height: 30px;">선택 옵션 - ${ data.productdetailVO.productdetail_option }</div>
									<div class="col-2">
										<div class="row">
											<div class="col numberForm numberHover" onclick="minusCount('${ data.cartVO.cart_no }' , this)">
												<i class="bi bi-dash-circle" style="font-size: 25px; padding: 0; margin: 0; position: relative; top: -2px;"></i>
											</div>
											<div name="count" class="col numberForm" value="${ data.cartVO.cart_no }">${ data.cartVO.productdetail_count }</div>
											<div class="col numberForm numberHover" onclick="plusCount('${ data.cartVO.cart_no }' , this)">
												<i class="bi bi-plus-circle" style="font-size: 25px; padding: 0; margin: 0; position: relative; top: -2px;"></i>
											</div>
										</div>
									</div>
									<div class="col-2 iconBtnStyle" onclick="location.href='${pageContext.request.contextPath}/order/deleteCartProcess.do?cart_no=${ data.cartVO.cart_no }'" >
										<i class="bi bi-x-circle" style="font-size: 25px; padding: 0; margin: 0; position: relative; top: -4px;"></i>
									</div>
								</div>
							</div>
						</div>
					</td>
					<c:if test="${ data.productdetailVO.discount_status == 'N' }">
						<td class="align-middle priceLine">${ (data.productdetailVO.productdetail_price) * (data.cartVO.productdetail_count) } 원</td>
					</c:if>
					<c:if test="${ data.productdetailVO.discount_status == 'Y' }">
						<td class="align-middle priceLine">${ (data.discountVO.discount_price) * (data.cartVO.productdetail_count) } 원</td>
					</c:if>
					<td class="align-middle deliveryLine">2500원</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<c:set var= "total" value="${total + (data.productdetailVO.productdetail_price) * (data.cartVO.productdetail_count)}"/>
		
	</div><!-- id = cartArea -->
	
	<div class="row mb-5">
		<div class="col-8">
			상품 총 합계 : <span id="totalText">0 원</span><%-- <c:out value="${total}"/> --%>
		</div>
			
		<div class="col-4" style="text-align: right;">
			<form id="hiddenForm" action="./orderDataLoarding.do" method="post"></form>
			<button type="button" class="btn btn-warning" id="submitOrder" onclick="updateOrder()">주문하기</button>
		</div>
	</div>
	
</div><!-- container -->




<div class="container" id="orderArea"></div>
<div class="row" style="height: 100px;"></div>
<!-- 콘테이너 끝 -->

<!-- Modal Area -->
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
				<button type="button" class="btn btn-secondary" onclick="location.href='../product/productMainPage.do'">메인페이지로 돌아가기</button>
				<button type="button" class="btn btn-warning" onclick="location.href='../customer/myPageMain.do'">주문내역 확인하기</button>
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
<!-- Modal Area - 끝 --> 



<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>