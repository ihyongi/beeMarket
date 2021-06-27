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
#container{
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
#main{float:left; width:80%; height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
   margin-left: 0;
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
    overflow:scroll;
 }
table{text-align: center;}
#wareBtn{margin-top:13px;}
</style>
<script type="text/javascript">
function openModal(product_no, e){
	var product_no = product_no;
	var size= document.getElementsByName("stockModalBtn").length;
	for(var i=0; i<size; i++){
	var button = document.getElementsByName("stockModalBtn");		
	}
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			var obj = JSON.parse(xmlhttp.responseText);
			var modalbody=document.getElementById("mBody");
			
			//테이블
			var tableBox = document.getElementById("tableBox");
			 	tableBox.innerHTML = "";
			var setTable = document.createElement("table");
	          setTable.setAttribute("class","table table-hover");
	          var tr1 = document.createElement("tr");
	          setTable.appendChild(tr1);
	             var td2 = document.createElement("td");
	             td2.innerText="상품옵션";
	             tr1.appendChild(td2);
	             var td3 = document.createElement("td");
	             td3.innerText="판매가";
	             tr1.appendChild(td3);
	             var td4 = document.createElement("td");
	             td4.innerText="할인여부";
	             tr1.appendChild(td4);
	             var td5 = document.createElement("td");
	             td5.innerText="재고";
	             tr1.appendChild(td5);
	             var td6 = document.createElement("td");
	             td6.innerText="재고추가";
	             tr1.appendChild(td6);
	             var td7 = document.createElement("td");
	             td7.innerText="버튼";
	             tr1.appendChild(td7);
	             
	         for(var detailList of obj.detailList){
	        	 var tr2 = document.createElement("tr");
	             setTable.appendChild(tr2);
	                    var std2 = document.createElement("td");
	                    std2.setAttribute("id","product_option");
	                    std2.innerText=detailList.productDetailVO.productdetail_option;
	                    tr2.appendChild(std2);
	                    var std3 = document.createElement("td");
	                    std3.setAttribute("id","productdetail_price");
	                    if(detailList.productDetailVO.discount_status =='N'){
	                    std3.innerText=detailList.productDetailVO.productdetail_price;
	                    }else{
	                    std3.innerText=detailList.discountVO.discount_price;
	                    }
	                    tr2.appendChild(std3);
	                    var std4 = document.createElement("td");
	                    std4.setAttribute("id","discount_status");
	                    std4.innerText=detailList.productDetailVO.discount_status;
	                    tr2.appendChild(std4);
	                    var std5 = document.createElement("td");
	                    std5.setAttribute("id","productwarehouse_pluscount");
	                    std5.innerText=detailList.productWarehouseVO.productwarehouse_pluscount;                    
	                    tr2.appendChild(std5);
	                    var std6 = document.createElement("td");
	                    var std6Input  = document.createElement("input");
	                    std6Input.setAttribute("type","text");
	                    std6Input.setAttribute("id","add_pluscount");
	                    std6Input.setAttribute("name","add_pluscount");
	                    std6Input.setAttribute("class","form-control add_pluscount");
	                    std6.appendChild(std6Input);
	                    tr2.appendChild(std6);
	                    var std7 = document.createElement("button");
	                    std7.setAttribute("type","submit");
	                    std7.setAttribute("id","wareBtn");
	                    std7.setAttribute("class","btn btn-warning");
	                    std7.innerText="입고";
	                    std7.setAttribute("onclick","addWare("+detailList.productDetailVO.productdetail_no+",this)");
	                    tr2.appendChild(std7);
	         }
	         			tableBox.appendChild(setTable);
	                    modalbody.appendChild(tableBox);
	         
		}
	}
		xmlhttp.open("get","./getProductDetailVO.do?product_no="+product_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();			

}

function addWare(productdetail_no,e){
	   var productdetail_no= productdetail_no
	   var add_pluscount=e.closest("tr").querySelector(".add_pluscount");
	   var add_pluscountValue=parseInt(add_pluscount.value);
	   var productNo= document.getElementById("product_no").value;
	   
	   //AJAX 호출.....
	   var xmlhttp = new XMLHttpRequest();
	   
	   //호출 후 값을 받았을때... 처리 로직....
	   xmlhttp.onreadystatechange = function(){
	      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	          //var obj = JSON.parse(xmlhttp.responseText);
	          alert("입고가 완료되었습니다.");
	          openModal(productNo);
	      }
	   };
	   
	   
	   xmlhttp.open("get","./updateWarehousePluscount.do?productdetail_no="+productdetail_no+"&add_pluscount="+add_pluscountValue , true);
	   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	   xmlhttp.send();      
	}

function init(){
	myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
}
</script>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
	      <div id="wrapper">
	      	<div class="col" style="color: #6b6b6b; font-size: 25px; font-weight: bold; text-align: left;">입고 관리</div>
			   <hr>
			   	<table class="table table-hover">
				      <tr>
				         <td>상품번호</td>
				         <td>상품명</td>
				         <td>등록일</td>
				         <td>버튼</td>
				      </tr>
			      		
			      <c:forEach items="${productList1}" var="productList">
				       <tr>
				           <td><input name="product_no" class="form-control" id="product_no" type="hidden" value="${productList.productVO.product_no}">${productList.productVO.product_no}</td> 
				           <td><input name="product_name" class="form-control" id="product_name" type="hidden" value="${productList.productVO.product_name}">${productList.productVO.product_name}</td> 
				           <td><fmt:formatDate value="${productList.productVO.product_writedate}" pattern="yyyy-MM-dd"/></td>
				           <td><button type="submit" class="btn btn-primary" style="color:white;" id="stockModalBtn" name="stockModalBtn" data-toggle="modal" data-target="#stockModal" onclick="openModal(${productList.productVO.product_no}, this)">상세보기</button></td>
				      </tr>
				            <input type="hidden" name="seller_no" id="seller_no" value="${sessionSeller.seller_no}">
			      </c:forEach>           
			  	 </table>
				            <!-- Modal -->
                                    <div class="modal fade" id="stockModal" tabindex="-1"
                                       aria-labelledby="exampleModalLabel" aria-hidden="true">
                                       <div class="modal-dialog modal-dialog-centered modal-dialog modal-lg">
                                          <div class="modal-content">
                                             <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
                                                   상품 입고
                                                </h5>
                                                <button type="button" class="btn-close"
                                                   data-dismiss="modal"></button>
                                             </div>
                                             <div class="modal-body" id="mBody">
                                             	<div id="tableBox"></div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
		</div>
	</div>
</div>
</body>
</html>