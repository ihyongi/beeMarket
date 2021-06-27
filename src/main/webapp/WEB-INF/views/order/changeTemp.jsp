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
    height:95%;
    overflow:scroll;
 }
#alreadyWarning{color:red;}
#key-value_section{height:50px; display: inline-block;}
#key_section{width:100px; height:100%; float:left; padding-top:5px; padding-right:20px;}
#value_section{width:600px; height:100%; float:left;}
#buttonBox{width:100%; text-align: center;}
</style>
<script type="text/javascript">
function updateDate(order_no){
   var order_no=order_no;
   var change_addCost=document.getElementById("change_addCost").value;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
         setTimeout(retrieving, 5000, order_no);//10초뒤 교환진행->상품회수중(교환)
         alert("doesnt work?");
      }
   };
   
   var con = confirm("교환을 승인하시겠습니까?");
   if(con==true){
   xmlhttp.open("get","./updateChangeAuthDate.do?order_no="+order_no+"&change_addCost="+change_addCost , true); //교환신청->교환진행
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();      
      
   }else{
      return;
   }
}

//상품회수중
function retrieving(order_no){
   var orderNo=order_no;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
         setTimeout(retrieved, 5000, orderNo);
         alert("회수중입니다.");
      }
   };
   xmlhttp.open("get","./changeRetrieveing.do?order_no="+orderNo , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

//상품회수완료
function retrieved(order_no){
   var orderNo=order_no;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
    	  setTimeout(preparingProduct, 5000, orderNo);
    	  alert("상품회수가 완료되었습니다.");
      }
   };
   xmlhttp.open("get","./completeRetrieved.do?order_no="+orderNo , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

//배송준비중
function preparingProduct(order_no){
   var orderNo=order_no;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
    	 alert("배송 준비가 들어갔습니다.");
      }
   };
   xmlhttp.open("get","./preparingProduct.do?order_no="+orderNo , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

</script>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
      <div id="wrapper">
         <h2>교환신청내역</h2>
         <hr>
         <div id="key-value_section">
            <div id="key_section">주문번호</div><!-- 주문번호에 a링크 달아서 해당 오더 조회 가지게 -->
            <div id=value_section><input class="form-control" id="order_no" name="order_no" value="${changeOrder.changeVO.order_no}" readOnly></div>
         </div><br>
         <div id="key-value_section">
            <div id="key_section">구매자ID</div>
            <div id=value_section><input class="form-control" id="customer_id" name="customer_id" value="${changeOrder.customerVO.customer_id}" readOnly></div>
         </div><br>
         <div id="key-value_section">
            <div id="key_section">상품명</div><!-- 주문번호에 a링크 달아서 해당 상품 디테일 가지게 -->
            <div id=value_section><input class="form-control" id="product_name" name="product_name" value="${changeOrder.productVO.product_name}" readOnly></div>
         </div><br>
         <div id="key-value_section">
            <div id="key_section">기존옵션</div>
            <div id=value_section>
            <%-- <select><!-- 상품옵션목록 선택창 -->
               <c:forEach items="${changeOrder.productdetailList}" var="list">
               <option>${list.productdetail_option}</option>
               </c:forEach>
            </select> --%>
            <input class="form-control" id="productdetail_option" name="productdetail_option" value="${changeOrder.productDetailVO.productdetail_option}" readOnly>
            </div>
         </div><br>
         <div id="key-value_section">
            <div id="key_section">변경옵션</div>
            <div id=value_section>
            <input class="form-control" id="productdetail_option" name="productdetail_option" value="${changeOrder.changeProductDetailVO.productdetail_option}" readOnly>
            </div>
         </div><br>   
         <div id="key-value_section">
            <div id="key_section">구매수량</div><!-- 구매수량안에서도 교환할 개수 세부적인거 수정하기 -->
            <div id=value_section><input class="form-control" id="order_count" name="order_count" value="${changeOrder.orderVO.order_count}" readOnly></div>
         </div><br>
         교환사유<br>
         <textarea class="form-control" id="change_description" name="change_description" style="width:100%; height:300px;" disabled>${changeOrder.changeVO.change_description}</textarea><br>
         추가 배송비부담비용<br><!-- 고민해보기 -->
         <c:if test="${changeOrder.changeVO.change_addCost eq 999}" >
         <select class="form-control" id="change_addCost" name="change_addCost">
            <option value="0">0</option>
            <option value="5000">5000</option>
         </select><br>
         </c:if>
         <c:if test="${changeOrder.changeVO.change_addCost eq 0 || changeOrder.changeVO.change_addCost eq 5000}" >
            <input class="form-control" id="change_addCost" name="change_addCost" value="${changeOrder.changeVO.change_addCost}" readOnly><br>
         </c:if>
         신청일<br>
         <input class="form-control" id="change_applyDate" name="change_applyDate" value="<fmt:formatDate value="${changeOrder.changeVO.change_applyDate}" pattern="yyyy/MM/dd HH:mm:ss"/>" readOnly><br>
         승인날짜
         <input class="form-control" id="change_authDate" name="change_authDate" value="<fmt:formatDate value="${changeOrder.changeVO.change_authDate}" pattern="yyyy/MM/dd HH:mm:ss"/>" readOnly><br><br>
         <div id="buttonBox">
         <c:choose>
         <c:when test="${empty changeOrder.changeVO.change_authDate}">
         <button class="btn btn-danger" onclick="updateDate(${changeOrder.changeVO.order_no})">승인하기</button>
         <button class="btn btn-primary" onclick="location.href='refundList.do?seller_no=${sessionSeller.seller_no}'">뒤로가기</button>
         </c:when>
         <c:otherwise>
         <button class="btn btn-danger" onclick="updateDate(${changeOrder.changeVO.order_no})" disabled>승인하기</button>
         <button class="btn btn-primary" onclick="location.href='refundList.do?seller_no=${sessionSeller.seller_no}'">뒤로가기</button>
         <br><p id="alreadyWarning">이미 승인하였습니다.</p>
         </c:otherwise>
         </c:choose>
         </div>
      </div>
   </div>
</div>
</body>
</html>