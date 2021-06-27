<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="mx-auto text-center"><h1>리뷰 글 수정</h1></div>
	<form action="${pageContext.request.contextPath }/review/updateReviewProcess.do" method="post">
		제목  <input type="text" value="${data.reviewVO.review_title }" name="review_title"><br>
		작성자  ${sessionCustomer.customer_name}<br>
		<div class="col d-flex justify-content-end">
		<textarea rows="3" class="form-control" placeholder="글을 입력해 주세요" name="review_content">${data.reviewVO.review_content}</textarea>
		&nbsp;&nbsp;<input type="submit" value="글수정">
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