<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트 스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
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
   width: 1200px;
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
    overflow:scroll;
 }
#wrapper::-webkit-scrollbar {display: none; /* Chrome, Safari, Opera*/}
table{text-align: center;}
</style>
<script type="text/javascript">
function addWare(productdetail_no,e){
	var productdetail_no= productdetail_no
	var add_pluscount=e.closest("tr").querySelector(".add_pluscount");
	var add_pluscountValue=parseInt(add_pluscount.value);
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
		}
	};
	
	xmlhttp.open("get","./updateWarehousePluscount.do?productdetail_no="+productdetail_no+"&add_pluscount="+add_pluscountValue , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();		
}
</script>
<body>
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
<div id="container">
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
	      <div id="wrapper">
	      	<div class="col" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">입고 관리</div>
			   <hr>
			   <%-- <form action="${pageContext.request.contextPath}/product/updateWarehousePluscount.do?productdetail_no=${productList.productDetailVO.productdetail_no}" method="post"> --%>
				   <table class="table table-hover">
				      <tr>
				         <td>번호</td>
				         <td>상품명</td>
				         <td>상품옵션</td>
				         <td>판매가</td>
				         <td>할인여부</td>
				         <td>재고</td>
				         <td>재고 추가</td>
				         <td>버튼</td>
				      </tr>
			      		<c:forEach items="${productList}" var="productList">
				            <tr>
				               <td><input name="product_no" class="form-control" id="product_no" type="hidden" value="${productList.productVO.product_no}">${productList.productVO.product_no}</td> 
				               <td><input name="product_name" class="form-control" id="product_name" type="hidden"><a href="${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${productList.productVO.product_no}">${productList.productVO.product_name}</a></td>
				               <td><input name="productdetail_option" class="form-control" id="productdetail_option" type="hidden">${productList.productDetailVO.productdetail_option}</td>
				               <!-- 판매가 -->
				               <td>
				                  <c:choose>
				                  <c:when test="${productList.productDetailVO.discount_status eq 'N'}">
				                  <input type="hidden"  name="productdetail_price" id="productdetail_price" value="${productList.productDetailVO.productdetail_price}">${productList.productDetailVO.productdetail_price}
				                  </c:when>
				                  <c:otherwise>
				                  <c:forEach items="${sellerProductListY}" var="sellerProductListY">
				                  <input type="hidden" name="discount_price" id="discount_price" value="${sellerProductListY.discountVO.discount_price}">${sellerProductListY.discountVO.discount_price}
				                  </c:forEach>
				                  </c:otherwise>
				                  </c:choose>
				               </td>
				               <td><input name="discount_status" class="form-control" id="discount_status" type="hidden" value="${productList.productDetailVO.discount_status}">${productList.productDetailVO.discount_status}</td> 
				               <td><input name="productwarehouse_pluscount" class="form-control" id="productwarehouse_pluscount" type="hidden" value="${productList.productWarehouseVO.productwarehouse_pluscount}">${productList.productWarehouseVO.productwarehouse_pluscount}</td> 
				               <td><input name="add_pluscount" class="form-control add_pluscount" id="add_pluscount" type="text"></td> 
				               <td><button type="submit" class="btn btn-warning" onclick="addWare(${productList.productDetailVO.productdetail_no},this)">입고</button></td>
				            </tr>
				            <input type="hidden" class="productdetail_no" id="productdetail_no" value="${productList.productDetailVO.productdetail_no}">
				            <input type="hidden" name="seller_no" id="seller_no" value="${sessionSeller.seller_no}">
			      		</c:forEach>
			  	 </table>
			 <!--  </form> -->
		</div>
	</div>
</div>
</body>
</html>