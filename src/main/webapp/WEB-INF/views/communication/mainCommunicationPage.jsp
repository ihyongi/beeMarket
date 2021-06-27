<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/mainPage.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/bestProductPage.css">
</head>
<body>

	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>
	<div class="container">
	<div class="row">
	<div class="col">
	총${count }개의 글이 있습니다.
	</div>
	</div>
	</div>
	<br>
	<div class="container">
	<table class="table table-hover" style="background-color:#ffdf80;">
		<thead>
		<tr><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${communicationList}" var="data">
			<tr>
				<td><a href="${pageContext.request.contextPath }/communication/readCommunicationPage.do?communication_no=${data.communicationVO.communication_no }">${data.communicationVO.communication_title }</a></td>
				<td>${data.customerVO.customer_name }</td>
				<td>${data.communicationVO.communication_readcount }</td>
				<td><fmt:formatDate value="${data.communicationVO.communication_writedate }" pattern="yyyy.MM.dd"/></td>				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	<div class="mx-auto" style="width: 200px;">
	<c:if test="${!empty sessionCustomer }">
		<a class="btn" style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/writeCommunicationPage.do" role="button">글쓰기</a>
	</c:if>
	</div>
	
	
	
		<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	
</body>
</html>