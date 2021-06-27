<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div class="row border border-primary">
	<div class="col">
	<h1 class = "text-center">리뷰쓰기</h1>
	
	<form action="${pageContext.request.contextPath }/review/writeReviewProcess.do" method="post"enctype="multipart/form-data">
		
		<select name="product_category_name">
			<c:forEach items="${productCategoryList}" var="data">
				<option value="${data.product_category_name}"> ${data.product_category_name }</option>
			</c:forEach>
			</select>
		<br>
		작성자  ${sessionCustomer.customer_name}<br>
		제목 <input type="text" name="review_title">
		<select name="review_score" value="${data.ReviewVO.lecture_score }">
			<option value='' selected>별점을 입력해주세요</option>
			    <option value='5'>★★★★★</option>
			    <option value='4'>★★★★☆</option>
			    <option value='3'>★★★☆☆</option>
			    <option value='2'>★★☆☆☆</option>
			    <option value='1'>★☆☆☆☆</option>
		</select><br>
		<input type="file" accept="image/*" multiple name="upload_files">
		<div class="col d-flex justify-content-end">
		<textarea rows="3" class="form-control" name="review_content" placeholder="글을 입력해 주세요"></textarea>
		<input type="submit" value="글 작성">
		</div>
	</form>
	</div>
	</div>
	</div>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	
</body>
</html>