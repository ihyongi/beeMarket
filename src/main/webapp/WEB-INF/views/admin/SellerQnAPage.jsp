<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body>


	<div class="container mt-4">
		<div class="row">
			<!-- 나머지.. -->
			<div class="col"></div>
			<div class="col-10">
				
				<form action="./SellerQnAPage.do" method="get">
				<div class="row mt-3">
					
					
					<!-- 검색            날짜로 검색 추출 , 답변상태로 검색 추출 --> 
					<div class="col">
						<select name="search_type" class="form-control">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="statue">답변상태</option>
							<option value="date">날짜</option>
						</select>
					</div>
					<div class="col-8">
						<input name="search_word" type="text" class="form-control">
					</div>
					<div class="col d-grid">
						<input type="submit" value="검색" class="btn btn-primary">
					</div>
				</div>
				</form>
				
				<div class="row mt-2">
					<div class="col">총 ${contentCount }개의 글이 있습니다</div>
				</div>
				<div class="row mt-1">
					<!-- 테이블 -->
					<div class="col">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">글 번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">답변상태</th>
									<th scope="col">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${sellerQnAList }" var="data">
									<tr>
										<th scope="row">${data.sellerQnAVO.sellerQnA_no }</th>
										<td><a href="${pageContext.request.contextPath }/admin/readSellerQnAPage.do?sellerQnA_no=${data.sellerQnAVO.sellerQnA_no }">${data.sellerQnAVO.sellerQnA_title }</a></td>
										<td>${data.sellerVO.seller_id }</td>
										<td>${data.sellerQnAVO.sellerQnA_statue }</td>
										<td><fmt:formatDate value="${data.sellerQnAVO.sellerQnA_writedate }" pattern="yyyy.MM.dd"/>   </td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row mt-2">
					<!-- 맨 하단 버튼들... -->
					<div class="col">
						<!-- page.. -->
						<nav aria-label="...">
						  <ul class="pagination mb-0">
						  	<c:choose>
						  		<c:when test="${beginPage <= 1 }">
								    <li class="page-item disabled">
								      <a class="page-link" href="./SellerQnAPage.do?page_num=${beginPage - 1}">Previous</a>
								    </li>
						  		</c:when>
						  		<c:otherwise>
								    <li class="page-item">
								      <a class="page-link" href="./SellerQnAPage.do?page_num=${beginPage - 1}">Previous</a>
								    </li>
						  		</c:otherwise>
						  	</c:choose>
						  
						    <c:forEach begin="${beginPage }" end="${endPage}" var="ppp">	
						    	<c:choose>
						    		<c:when test="${ppp == currentPage}">
								    	<li class="page-item active">
								    		<a class="page-link" href="./SellerQnAPage.do?page_num=${ppp }">${ppp }</a>
								    	</li>
						    		</c:when>
						    		<c:otherwise>
								    	<li class="page-item">
								    		<a class="page-link" href="./SellerQnAPage.do?page_num=${ppp }">${ppp }</a>
								    	</li>
						    		</c:otherwise>
						    	</c:choose>
						    </c:forEach>
						    <c:choose>
						    	<c:when test="${endPage >= totalPageCount }">
								    <li class="page-item disabled">
								      <a class="page-link" href="./SellerQnAPage.do?page_num=${endPage + 1 }">Next</a>
								    </li>
						    	</c:when>
						    	<c:otherwise>
								    <li class="page-item">
								      <a class="page-link" href="./SellerQnAPage.do?page_num=${endPage + 1 }">Next</a>
								    </li>
						    	</c:otherwise>
						    </c:choose>
						    
						  </ul>
						</nav>						
					</div>
				</div>

			</div>
			<div class="col"></div>
		</div>
	</div>

	












	<pre>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</pre>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>
</html>









