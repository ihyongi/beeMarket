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
#container{width:100%; height:100%;}
#main{float:left; width:80%; height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
	margin-left:10%;
	width: 1000px;
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
 #deliveryName{width: 120px; font-size: 13px;}
 #customerId{font-size: 14px;}
 #orderNo{width: 76px;}
table{text-align: center;}
</style>
<script type="text/javascript">
function statusChange(order_status_no, order_no){

	var order_status_no = order_status_no;
	var order_no = order_no;
	var tableBox = document.getElementById("tableBox");
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			refreshForm();
			tableBox.innerHTML="";
		}
	};	
	xmlhttp.open("get","./updateOrderStatus.do?order_status_no="+order_status_no+"&orderflee_no="+orderflee_no, true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();
}
function refreshForm(){
	var seller_no = document.getElementById("seller_no").value;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			var obj = JSON.parse(xmlhttp.responseText);
			
			
			var tableBox = document.getElementById("tableBox");
		    tableBox.innerHTML = "";
		    
		    var setTable = document.createElement("table");
		    setTable.setAttribute("class","table table-hover");
		    var tr1 = document.createElement("tr");
		    setTable.appendChild(tr1);
			    var td1 = document.createElement("td");
			    td1.setAttribute("id","orderNo");
			    td1.innerText="번호";
			    tr1.appendChild(td1);
			    var td2 = document.createElement("td");
			    td2.setAttribute("id","customerNo");
			    td2.innerText="구매자ID";
			    tr1.appendChild(td2);
			    var td3 = document.createElement("td");
			    td3.innerText="주문일";
			    tr1.appendChild(td3);
			    var td4 = document.createElement("td");
			    td4.innerText="구매확정일";
			    tr1.appendChild(td4);
			   
			    var td7 = document.createElement("td");
			    td7.innerText="구매금액";
			    tr1.appendChild(td7);
			    
			for(var orderList of obj.orderList){
			if(orderList.orderVO.order_status_no==5){
			var tr2 = document.createElement("tr");
			setTable.appendChild(tr2);
				    var std1 = document.createElement("td");
				    std1.setAttribute("id","orderNo");
				    std1.innerText=orderList.orderFleeMarketVO.order_no;
				    tr2.appendChild(std1);
				    var std2 = document.createElement("td");
				    std2.setAttribute("id","customerNo");
				    std2.innerText=orderList.customerVO.customer_id;
				    tr2.appendChild(std2);
				    var std3 = document.createElement("td");
				    std3.setAttribute("id","orderDate");
				    var std3_date = document.createElement("fmt:formatDate");
				    std3_date.setAttribute("value", orderList.orderFleeMarketVO.orderflee_orderdate);
				    std3_date.setAttribute("pattern","yyyy/MM/dd");
				    std3_date.innerText=orderList.orderFleeMarketVO.orderflee_orderdate;
				    std3.appendChild(std3_date);
				    tr2.appendChild(std3);
				    var std4 = document.createElement("td");
				    std4.setAttribute("id","orderDate");
				    var std4_date = document.createElement("fmt:formatDate");
				    //std4_date.setAttribute("value", );
				    //std4_date.setAttribute("pattern","yyyy/MM/dd");
				    std4_date.innerText="구매확정일";
				    std4.appendChild(std4_date);
				    tr2.appendChild(std4);
		 		     
				    var std7 = document.createElement("td");
				    std7.setAttribute("id","price");
				    std7.setAttribute("name","price");
				    std7.setAttribute("value",orderList.orderFleeMarketVO.order_price);
				    std7.innerText=orderList.orderVO.order_price;  
				    tr2.appendChild(std7);
				    tableBox.appendChild(setTable); 
				    }
			    	
			    }
			var incomeDiv = document.createElement("div");
			var totalIncomeInput = document.createElement("input");
			var size = document.getElementsByName("price").length;
			var totalIncome = (Number('0'));
			//var totalIncome2 = Integer.parseInt(totalIncome);
			for(var i=0; i<size; i++){
			var income = document.getElementsByName("price")[i].innerText;
			var income2=Number(income);
				totalIncome+= income2;
			}
			totalIncomeInput.setAttribute("value", totalIncome);
			incomeDiv.appendChild(totalIncomeInput);
			tableBox.appendChild(incomeDiv);
		}
	};	
	xmlhttp.open("get","./refundListRest.do?seller_no="+seller_no, true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();
}
</script>
<body onload="refreshForm()">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
<div id="container">
	<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
		<div id="wrapper">
			<h2>정산금액</h2><!-- 상품준비중상태.. -->
			<hr>
			<div id="tableBox"></div>
			<%--< table class="table table-hover">
				<tr>
					<td id="order_no">번호</td>
					<td id="customer_id">구매자ID</td>
					<td>주문일</td>
					<td>택배사</td>
					<td>송장번호</td> <!-- uuid로 발급 -->
					<td>발송일</td> <!-- 오늘날짜로 찍히게..? -->
					<td>주문상태</td> <!-- 배송중으로 update.. 여기 페이지에서는 2(배송준비중),3(배송중)만 상태가 보여야지 -->
				</tr>
				<c:forEach items="${orderList}" var="data">
				<c:if test="${data.orderVO.order_status_no eq 2 || data.orderVO.order_status_no eq 3}">
				<tr>
					<td>${data.orderVO.order_no}</td>
					<td>${data.customerVO.customer_id}</td>
					<td><fmt:formatDate value="${data.orderVO.order_orderdate}" pattern="yyyy/MM/dd"/></td>
					<td id="delivery_name">${data.deliveryVO.delivery_name}</td>
					<c:choose>
					<c:when test="${data.orderVO.order_status_no eq 3}">
						<td>${data.orderDeliveryVO.orderdelivery_invoiceNumber}</td>
						<td><fmt:formatDate value="${data.orderDeliveryVO.orderdelivery_sendDate}" pattern="yyyy/MM/dd"/> </td>
					</c:when>
					<c:otherwise>
						<td></td><!-- 생각해보니..굳이 필요없네? ; -->
						<td></td>
					</c:otherwise>
					</c:choose>
					<td>
						<select name="" id="statusChange" onchange="statusChange(value, ${data.orderVO.order_no})">
							<option>${data.orderStatusVO.order_status_name}</option>						
							<c:forEach items="${orderStatusList }" var="data2">
							<option value="${data2.orderStatusVO.order_status_no}">${data2.orderStatusVO.order_status_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				</c:if>
				</c:forEach>
			</table> --%>
		</div>
	</div>
</div>
</body>
</html>