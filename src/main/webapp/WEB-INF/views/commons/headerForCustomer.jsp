<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	function getSessionInformation(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var customerGrade = ${sessionCustomer.customergrade_no};
				var delivery = obj.myDeliveryCount;
				var coupon = obj.myCouponCount;
				var jelly = obj.myJelly;
				
				
				
				if (customerGrade == 3){
					var Grade = "VVIP";
				}else if(customerGrade == 2){
					var Grade = "VIP";
				}else{
					var Grade = "일반회원";
				}
				
				var informBox = document.getElementById("informTable");
				
				var tableBox = document.createElement("table");
				tableBox.setAttribute("class","table");
				informBox.appendChild(tableBox);
				
				var thead = document.createElement("thead");
				tableBox.appendChild(thead);
				
				var tr = document.createElement("tr");
				thead.appendChild(tr);
				
				var th1 = document.createElement("th");
				th1.setAttribute("scope","col");
				th1.innerHTML="회원등급";
				tr.appendChild(th1);
				
				var th2 = document.createElement("th");
				th2.setAttribute("scope","col");
				th2.innerHTML="배송중";
				tr.appendChild(th2);
				
				var th3 = document.createElement("th");
				th3.setAttribute("scope","col");
				th3.innerHTML="보유쿠폰";
				tr.appendChild(th3);
				
				var th4 = document.createElement("th");
				th4.setAttribute("scope","col");
				th4.innerHTML="로얄젤리";
				tr.appendChild(th4);
				
				var tbody = document.createElement("tbody");
				tableBox.appendChild(tbody);
				
				var tr2 = document.createElement("tr");
				tbody.appendChild(tr2);
				
				var td1 = document.createElement("td");
				td1.innerHTML = Grade;
				tr2.appendChild(td1);
				
				var td2 = document.createElement("td");
				td2.innerHTML = delivery+'개';
				tr2.appendChild(td2);
				
				var td3 = document.createElement("td");
				td3.innerHTML = coupon+'개';
				tr2.appendChild(td3);
				
				var td4 = document.createElement("td");
				td4.innerHTML = jelly+'젤리';
				tr2.appendChild(td4);
	
				
			}
		};
		
		xmlhttp.open("get","../customer/getSessionInformation.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	
	
	
	function initCustomerHeader(){
		getSessionCustomerNo();
		getSessionInformation();
		
	}
	
	window.addEventListener('DOMContentLoaded',initCustomerHeader);
	
</script>

	
	<div class="row" style="height: 50px; line-height:48px; background-color: #fcc92f;"></div>
	<div class="row">
		<div class="col-3" style="padding: 0; position: relative; top: -5px; text-align: left; padding-left: 60px;">
			<a href="../customer/myPageMain.do" style="font-size: 40px; line-height:98px; font-weight: bold; color: #fcc92f; text-decoration: none;">MYBEE</a>
		</div>
		<div class="col" id="informTable">
			<%-- <table class="table">
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
			    	<td>
						<c:if test="${sessionCustomer.customergrade_no == 1}">
							일반회원
						</c:if>
						<c:if test="${sessionCustomer.customergrade_no == 2}">
							VIP회원
						</c:if>
						<c:if test="${sessionCustomer.customergrade_no == 3}">
							VVIP회원
						</c:if>
					</td>
			    	<td>${myDeliveryCount} 개</td>
			    	<td>${myCouponCount} 개</td>
			    	<td>${myJelly} 젤리</td>
			    </tr>
			  </tbody>
			</table> --%>
		</div>
	</div>

