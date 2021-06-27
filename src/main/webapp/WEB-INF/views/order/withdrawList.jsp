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
table{text-align: center;}
h2{float:left;}
#arrayPage{float:right; width:90px;}
</style>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
	<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<div id="wrapper">
			<h2>출금내역</h2>
         <br>
         <br>
         <!-- <select id="searchOption">
         	<option></option>
         	<option>상품옵션</option>
         </select>
         <input placeholder="검색해주세요."><button type="button" class="btn btn-primary">검색</button> -->
			<hr>
			<table class="table table-hover">
				<tr>
					<td>번호</td>
					<td>은행</td>
					<td>계좌번호</td>
					<td>출금금액</td>
					<td>수수료</td>
					<td>출금일</td>
				</tr>
				<c:forEach items="${withdrawList}" var="data">
				<tr>
					<td>${data.sellerWithdrawVO.withdraw_no}</td>
					<td>${data.bankVO.bank_name}</td>
					<td>${data.sellerWithdrawVO.seller_account}</td>
					<td>${data.sellerWithdrawVO.withdraw_amount}</td>
					<td>${data.sellerWithdrawVO.withdraw_commission}</td>
					<td><fmt:formatDate value="${data.sellerWithdrawVO.withdraw_updatedate}" pattern="yyyy/MM/dd"/></td>		
				</tr>
				</c:forEach>
			</table>
			 <!-- pagination -->
      <div id="buttons">
      <!-- 페이지 검색 전 -->
      <div id="col1" align="center">
      	<!-- 이전 -->
    	  <c:choose>
		  <c:when test="${totalBeginPage <=1}">
      		<td>◀&nbsp;</td>
		  </c:when>
		  <c:otherwise>
	 		<td><a class="page-link" href="./withdrawList.do?page_num=${totalBeginPage-1 }">◀&nbsp;</a></td>
	 	 </c:otherwise>               
		 </c:choose>
		  <!-- 1 2 3 이렇게 출력.. -->
  	    <c:forEach begin="${totalBeginPage}" end="${totalEndPage}" var="ppp">
  	    <c:choose>	  	 	    
		  		<c:when test="${ppp !=currentPage}">
		 			<td><a href="./withdrawList.do?page_num=${ppp}">${ppp}</a>&nbsp;</td>
		  		</c:when>
		 		<c:otherwise>
	 	  			<td><a href="./withdrawList.do?page_num=${ppp}">[${ppp}]</a>&nbsp;</td>
	  	  		</c:otherwise>
	 	 </c:choose>
	 	 </c:forEach>
	 	
	 	 <!-- 다음 -->
	 	<c:choose>
	  		<c:when test="${totalEndPage>=totalPageCount }">
	  			<td>&nbsp;▶</td>
	  		</c:when>
	  		<c:otherwise>
	  			<td><a class="page-link" href="./withdrawList.do?page_num=${totalEndPage+1 }">▶</a></td>
	  		</c:otherwise>               
	 	 </c:choose>
     	 </div>
		</div>
	</div>
</div>
</body>
</html>