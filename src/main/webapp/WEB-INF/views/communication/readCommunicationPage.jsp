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

	<div class="mx-auto bg-warning text-center" style="width: 500px;"><h1>커뮤니티게시판 글 읽기</h1></div>
	<br>
	<!-- 수정전 -->
	<!-- 수정전 -->
	<!-- 수정후 -->
	
	<div class="container">
  <div class="row align-items-center bg-warning">
    <div class="col-7 text-center" >
      	${data.communicationVO.communication_title }
    </div>
     <div class="col text-center">
      	${data.customerVO.customer_name }
    </div>
     <div class="col text-center">
      	조회수(${data.communicationVO.communication_readcount })<br>
      	추천수(${recommendCount })
    </div>
     <div class="col text-center">
      	<fmt:formatDate value="${data.communicationVO.communication_writedate }" pattern="yyyy.MM.dd"/>
    </div>
    <div class="col text-center">
      	<c:if test="${!empty myRecommendCount}">
		<c:choose>
			<c:when test="${myRecommendCount == 0}">
				<span><a href="${pageContext.request.contextPath }/communication/recommendProcess.do?communication_no=${data.communicationVO.communication_no}">추천</a></span> 
			</c:when>
			<c:otherwise>
				<span><a href="${pageContext.request.contextPath }/communication/recommendProcess.do?communication_no=${data.communicationVO.communication_no}">추천 해제</a></span> 
			</c:otherwise>		
		</c:choose>
	</c:if>
	
    </div>
    
    
  </div>
</div>
<div class="container">
<div class="row">
<div class="col test-center border border-dark" style="height : 500px;">
      내용 : ${data.communicationVO.communication_content }
      <br><br>
    <c:forEach items="${data.communicationImageVOList }" var="communicationImageVO">
	 <img src="/upload_files/${communicationImageVO.image_location }" style="width: 200px; height:200px;">
	</c:forEach>
      
    </div>
    </div>
    </div>
<!-- 수정후 -->
	
	 
	 <br>
	 <div class="container">
	 <div class="row">
	 <div class="col-7 text-center d-grid gap-2 d-md-flex justify-content-md-end">
	 <a class="btn d-grid  gap-2 col-3 col-md-auto d-md-flex justify-content-md-end " style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/mainCommunicationPage.do" role="button">목록으로 이동</a>
	 </div>
	 <div class="col text-end d-grid gap-2 d-md-flex justify-content-md-end">
	 <c:if test="${!empty sessionCustomer && sessionCustomer.customer_no == data.customerVO.customer_no}">
	  	<a class="btn me-md-3" style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/deleteCommunicationProcess.do?communication_no=${data.communicationVO.communication_no}" role="button">삭제</a>
	 	<a class="btn "  style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/updateCommunicationPage.do?communication_no=${data.communicationVO.communication_no}" role="button">수정</a>
	 </c:if>
	 </div>
	 </div>
	 </div>
	
	 
	 <br>
	 <div class="container">
	 <div class="row border border-primary">
	 <div class="col">
	  <div class="mx-auto text-center"><h1>댓글쓰기</h1></div>
	 <form action="${pageContext.request.contextPath }/communication/writeCommentProcess.do?communication_no=${data.communicationVO.communication_no}" method="post">
	 <div class="col d-flex justify-content-end">
	 <textarea rows="3" class="form-control" placeholder="댓글 입력 창입니다."name="comment_content" ></textarea>
	 &nbsp;&nbsp;<input type="submit" value="완료">
	 </div>
	 </form>
	 </div>
	 </div>
	 </div>
	 
	 
	 <br>
	 <div class="container">
	<table class="table table-hover" style="background-color:#ffdf80;">
	<thead>
	 	<tr><td>작성자</td><td>내용</td><td>작성일</td><td></td></tr>
	 </thead>
	 <tbody>
	 	<c:forEach items="${commentList}" var="data">
	 		<tr>
	 			<td class="col-md-1">${data.customerVO.customer_name }</td>
	 			<td class="col-md-3">${data.commentVO.comment_content }</td>
	 			<td class="col-md-1"><fmt:formatDate value="${data.commentVO.comment_writedate }" pattern="yyyy.MM.dd" />
	 			<td class="col-md-2 text-end">
	 			<c:if test="${!empty sessionCustomer && sessionCustomer.customer_no == data.customerVO.customer_no}">
	 			&nbsp;&nbsp;&nbsp;&nbsp;<a class = "btn " style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/updateCommentPage.do?communication_no=${data.commentVO.communication_no}&comment_no=${data.commentVO.comment_no}" role="button">수정</a>
	 			&nbsp;&nbsp;&nbsp;&nbsp;<a class = "btn " style="background-color:#ffdf80; border : 1px solid #fbdf1a;" href="${pageContext.request.contextPath }/communication/deleteCommentProcess.do?communication_no=${data.commentVO.communication_no}&comment_no=${data.commentVO.comment_no}" role="button">삭제</a>
	 			</c:if> 
	 			</td>
	 			
	 		</tr>
	 </c:forEach>
	</tbody>
	</table>
	</div>
	 <br>
	 
	 <br><br>
	 
	 <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	 
</body>
</html>