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
 #deliveryName{width: 120px; font-size: 13px;}
 #customerId{font-size: 14px;}
 #orderNo{width: 76px;}
table{text-align: center;}
h2{float:left;}
#arrayPage{float:right; width:90px;}
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
         if(order_status_no==3){
         setTimeout(updateSuccess, 10000, order_no);        	 
         }
      }
   };   
   xmlhttp.open("get","./updateOrderStatus.do?order_status_no="+order_status_no+"&order_no="+order_no, true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();
}

//배송중->배송완료
function updateSuccess(order_no){
   var orderNo=order_no;
      
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
         refreshForm();
         tableBox.innerHTML="";
         
      }
   };   
   xmlhttp.open("get","./updateDeliverySuccess.do?order_no="+order_no, true);
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
             td4.innerText="택배사";
             tr1.appendChild(td4);
             var td5 = document.createElement("td");
             td5.innerText="송장번호";
             tr1.appendChild(td5);
             var td6 = document.createElement("td");
             td6.innerText="발송일";
             tr1.appendChild(td6);
             var td7 = document.createElement("td");
             td7.innerText="주문상태";
             tr1.appendChild(td7);
             
         for(var orderList of obj.orderList){
         if(orderList.orderVO.order_status_no==1 || orderList.orderVO.order_status_no ==2 || orderList.orderVO.order_status_no ==3){
         var tr2 = document.createElement("tr");
         setTable.appendChild(tr2);
                var std1 = document.createElement("td");
                std1.setAttribute("id","orderNo");
                std1.innerText=orderList.orderVO.order_no;
                tr2.appendChild(std1);
                var std2 = document.createElement("td");
                std2.setAttribute("id","customerNo");
                std2.innerText=orderList.customerVO.customer_id;
                tr2.appendChild(std2);
                var std3 = document.createElement("td");
                std3.setAttribute("id","orderDate");
                var std3_date = document.createElement("fmt:formatDate");
                std3_date.setAttribute("value", orderList.orderVO.order_orderdate);
                std3_date.setAttribute("pattern","yyyy/MM/dd");
                std3_date.innerText=orderList.orderVO.order_orderdate;
                std3.appendChild(std3_date);
                tr2.appendChild(std3);
                 var std4 = document.createElement("td");
                 std4.setAttribute("id","deliveryName");
                std4.innerText=orderList.deliveryVO.delivery_name;
                tr2.appendChild(std4);
                 var std5 = document.createElement("td");
                 if(orderList.orderVO.order_status_no == 3){
                std5.innerText=orderList.orderDeliveryVO.orderdelivery_invoiceNumber;                    
                 }else{
                 std5.innerText="";   
                 }
                tr2.appendChild(std5);
                tableBox.appendChild(setTable); 
                 var std6 = document.createElement("td");
                 if(orderList.orderVO.order_status_no == 3){
                  std6.innerText=orderList.orderDeliveryVO.orderdelivery_sendDate;                    
                }else{
                    std6.innerText="";   
                }
                tr2.appendChild(std6);
                tableBox.appendChild(setTable); 
                
                var std7 = document.createElement("td");
               
                  var std7Select = document.createElement("select");
                  std7Select.setAttribute("id", "statusChange");
                  std7Select.setAttribute("onchange", "statusChange(value, "+orderList.orderVO.order_no+")");                  
                  
               
                  for(orderStatusList of obj.orderStatusList){  
                  var std7Option = document.createElement("option");
                  std7Option.setAttribute("value", orderStatusList.orderStatusVO.order_status_no);
                  if(std7Option.value==orderList.orderVO.order_status_no){
                     std7Option.setAttribute("selected", "selected");
                   }
                  std7Option.innerText=orderStatusList.orderStatusVO.order_status_name;
                std7Select.appendChild(std7Option);
                }
                 
                std7.appendChild(std7Select);
                tr2.appendChild(std7);
                tableBox.appendChild(setTable); 
                }
                
             }
      }
   };   
   xmlhttp.open("get","./prepareList.do?seller_no="+seller_no, true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();
}
</script>
<body onload="refreshForm()">
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
      <div id="wrapper">
         <h2>배송대기</h2><!-- 상품준비중상태.. -->
         <br>
         <br>
         <select id="searchOption">
         	<option>상품명</option>
         	<option>상품옵션</option>
         </select>
         <input placeholder="검색해주세요."><button type="button" class="btn btn-primary">검색</button>
         <select id="arrayPage" onchange="location.href=this.value" class="form-control">
         	<option value="./orderList.do?seller_no=${sessionSeller.seller_no}">주문내역</option>
         	<option value="./prepareDeliveryList.do?seller_no=${sessionSeller.seller_no}" selected>배송대기</option>
         	<option value="./deliverySuccess.do?seller_no=${sessionSeller.seller_no }">배송완료</option>
         	<option value="./refundList.do?seller_no=${sessionSeller.seller_no }">취소내역</option>
         </select>
         <hr>
         <div id="tableBox"></div>
      </div>
   </div>
</div>
</body>
</html>