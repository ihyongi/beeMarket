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
	<h1 class = "text-center">글작성</h1>
	
	<form action="${pageContext.request.contextPath }/communication/writeCommunicationProcess.do" method="post" enctype="multipart/form-data">
		작성자  ${sessionCustomer.customer_name}<br>
		제목  <input type="text" name="communication_title"><br>
		<input type="file" accept="image/*" multiple name="upload_files"><br>
		<div class="col d-flex justify-content-end">
		<textarea rows="3" class="form-control" name="communication_content" placeholder="글을 입력해 주세요"></textarea>
		<br>
		<input class="align-middle" type="submit" value="글 작성">
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