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
table{text-align: center;}
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
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
<div id="container">
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <div id="wrapper">
         <h2>주문조회</h2>
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
               <td>${data.orderVO.order_no}</td>
               <td>${data.customerVO.customer_id}</td>
               <td>${data.productVO.product_name}</td>
               <td>${data.productDetailVO.productdetail_option}</td>
               <td>${data.orderVO.order_count}</td>
               <td><fmt:formatDate value="${data.orderVO.order_orderdate}" pattern="yyyy/MM/dd"/></td>
               <td style="color:blue; font-weight: bold;">${data.orderStatusVO.order_status_name}</td>            
            </tr>
            </c:forEach>
         </table>
      </div>
   </div>
</div>
</body>
</html>