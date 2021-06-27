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
	<div class="col-3">
	총${count }개의 글이 있습니다.
	</div>
	<div class="col"></div>
	<div class="col-1">
	<select name="search_type" class="form-control">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="nick">작성자</option>
	</select>
	</div>
	<div class="col-2">
		<input name="search_word" type="text" class="form-control">
	</div>
	<div class="col-1 text-end">
		<input type="submit" style="background-color:#ffdf80; border : 1px solid #fbdf1a;" value="검색" class="btn">
	</div>
	</div>
	</div>
	<div class="container mt-2">
	<table class="table table-hover" style="background-color:#ffdf80;">
	<thead>
	<tr><th>제목</th><th>작성자</th><th>조회수</th><th>평점</th><th>작성일</th></tr>
	</thead>
	<tbody>
	<c:forEach items="${reviewList }" var="data">
		<tr>
			
			<td><a href="${pageContext.request.contextPath }/review/readReviewPage.do?review_no=${data.reviewVO.review_no}">(${data.reviewVO.product_category_name })${data.reviewVO.review_title}</a></td>
			<td>${data.customerVO.customer_name }</td>
			<td>${data.reviewVO.review_readcount }</td>
			<td>${data.reviewVO.review_score }</td>
			<td><fmt:formatDate value="${data.reviewVO.review_writedate }" pattern="yyyy.MM.dd"/></td>
			
		</tr>
	</c:forEach>
	</tbody>
	</table>
	</div>
	
	<div class="container">
	<div class="row">
					<!-- 맨 하단 버튼들... -->
					 <div class="col">
				    </div>
					<div class="col">
						<!-- page.. -->
						<nav aria-label="...">
						  <ul class="pagination mb-0">
						  	<c:choose>
						  		<c:when test="${beginPage <= 1 }">
								    <li class="page-item disabled">
								      <a class="page-link" href="./mainReviewPage.do?page_num=${beginPage - 1}">Previous</a>
								    </li>
						  		</c:when>
						  		<c:otherwise>
								    <li class="page-item">
								      <a class="page-link" href="./mainReviewPage.do?page_num=${beginPage - 1}">Previous</a>
								    </li>
						  		</c:otherwise>
						  	</c:choose>
						  
						    <c:forEach begin="${beginPage }" end="${endPage}" var="ppp">	
						    	<c:choose>
						    		<c:when test="${ppp == currentPage}">
								    	<li class="page-item active">
								    		<a class="page-link" href="./mainReviewPage.do?page_num=${ppp }">${ppp }</a>
								    	</li>
						    		</c:when>
						    		<c:otherwise>
								    	<li class="page-item">
								    		<a class="page-link" href="./mainReviewPage.do?page_num=${ppp }">${ppp }</a>
								    	</li>
						    		</c:otherwise>
						    	</c:choose>
						    </c:forEach>
						    
						    <c:choose>
						    	<c:when test="${endPage >= totalPageCount }">
								    <li class="page-item disabled">
								      <a class="page-link" href="./mainReviewPage.do?page_num=${endPage + 1 }">Next</a>
								    </li>
						    	</c:when>
						    	<c:otherwise>
								    <li class="page-item">
								      <a class="page-link" href="./mainReviewPage.do?page_num=${endPage + 1 }">Next</a>
								    </li>
						    	</c:otherwise>
						    </c:choose>
						    
						  </ul>
						</nav>						
					</div>
					 <div class="col text-end">
					 <c:if test="${!empty sessionCustomer }">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btn" style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/review/writeReviewPage.do" role="button">글쓰기</a>
					</c:if>
				    </div>
					</div>
					</div>
	
	
	
	
	
	
	
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
		
</body>
</html>