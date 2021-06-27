<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트 스트랩 -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
   crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/board.css">
</head>
<body>
   <header>
      <!-- 네비게이션.. -->
      <jsp:include page="/WEB-INF/views/commons/headerForSeller.jsp"></jsp:include>
   </header>
   <div class="container">
               <!-- 이미지 출력하기 -->
               <div class="row">
               <div class="col-5">
                  <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
					  <div class="carousel-indicators">
					  <c:forEach items="${data.fleeMarketImageList }" var="fleeMarketImageList" varStatus="status">
						  <c:choose>
							  <c:when test="${status.first }">
							 	 	<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
							  </c:when>
							  <c:otherwise>
									<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="${status.index }" aria-label="Slide 2"></button>
							  </c:otherwise>
					  	  </c:choose>
					   </c:forEach>		  
 					</div>
					  <div class="carousel-inner">
					  <c:forEach items="${data.fleeMarketImageList }" var="fleeMarketImageList" varStatus="status">
					    <c:choose>
					    <c:when test="${status.first }">
					    <div class="carousel-item active" data-bs-interval="10000">
					      <img src="/upload_files/${fleeMarketImageList.fleemarketimage_location }" class="imagePrev imageHover" style="height: 500px; width: 500px;" class="d-block w-100" alt="...">
					      <div class="carousel-caption d-none d-md-block">
					      </div>
					    </div>
					    </c:when>
					    <c:otherwise>
					    <div class="carousel-item" data-bs-interval="">
					      <img src="/upload_files/${fleeMarketImageList.fleemarketimage_location }" class="imagePrev imageHover" style="height: 500px; width: 500px;" class="d-block w-100" alt="...">
					      <div class="carousel-caption d-none d-md-block">
					      </div>
					    </div>
					    </c:otherwise>
					    </c:choose>
					    </c:forEach>
					  </div>
					  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Prev</span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </button>
					</div>
               </div>
               <div class="col-5">
			        <h2 class="text-center">${ data.fleeMarketVO.fleemarket_title }</h2><hr>
			        <font>${ data.sellerVO.seller_name }</font><hr>
			       	<font>추천수  ${allApplicantCount }</font><hr>
			       	<font>${data.fleeMarketVO.fleemarket_content}</font><hr>
			       	<font>${data.fleeMarketVO.fleemarket_price}원</font><hr>
			       	<font><fmt:formatDate value="${ data.fleeMarketVO.fleemarket_writedate }" pattern="yyyy.MM.dd a HH:mm" /></font><hr>
	</div>
         <div class="row mt-5"></div>
         <div class="row mb-5">
            <!-- 추천 -->
            <jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
      		<fmt:parseNumber value="${today.time/(1000*60*60*24)}" var="now" integerOnly="true" />
      		<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_startdate.time/(1000*60*60*24)}" var="startdate" integerOnly="true" />
        	<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_enddate.time/(1000*60*60*24)}" var="enddate" integerOnly="true" />	
            <div class="col" style="text-align: right;">
                  <c:if test="${ !empty sessionSeller }">
                  	<c:choose>
                  		<c:when test="${startdate - now > 0}">
                  			 <!-- 수정 -->
		                     <a href="${pageContext.request.contextPath}/fleemarket/updateFleeMarketPage.do?fleemarket_no=${ data.fleeMarketVO.fleemarket_no }">수정</a>
		                     <!-- 삭제 -->
		                     <a href="${pageContext.request.contextPath}/fleemarket/deleteFleeMarketProcess.do?fleemarket_no=${ data.fleeMarketVO.fleemarket_no }">삭제</a>
                  		</c:when>
                  		<c:when test="${enddate - now < 0}">
                  			<h2>마감된 상품은 수정 , 삭제 할수없습니다</h2>
                  		</c:when>
                  		<c:otherwise>
                  			<h2>진행중인 상품은 수정 , 삭제를 할수없습니다</h2>
                  		</c:otherwise>
                  	</c:choose>
                  <button type="button" class="btn btn-warning btn-yellow" onclick="location.href='./sellerMainPage.do'">목록으로</button>
                  </c:if>
            </div>
         </div>

         
      
         
            
            <c:forEach items="${ commentList }" var="comment">
               <div class="row m-0">
                  <div class="col-2" style="min-height: 60px; line-height: 60px;">${ comment.customerVO.customer_name }</div>
                  <div class="col-4" style="min-height: 60px; line-height: 60px;">${ comment.fleeMarketCommentVO.comment_content }</div>
                  <div class="col-4" style="min-height: 60px; line-height: 60px;">
                     <fmt:formatDate value="${ comment.fleeMarketCommentVO.comment_date }" pattern="yyyy.MM.dd hh:mm" />
                  </div>
                  <c:if test="${ !empty sessionCustomer && sessionCustomer.customer_no==fleeMarketCommentVO.customer_no }">
                  <div class="col"></div>
                  <div class="col-2" style="min-height: 60px; line-height: 60px; text-align: right;">
                     <!-- 댓글수정 -->
                     <button type="button" class="btn btn-warning btn-yellow"
                        onclick="location.href='${ pageContext.request.contextPath }/fleemarket/updateCommentPage.do?fleemarket_no=${ comment.fleeMarketCommentVO.fleemarket_no }&comment_no=${ comment.fleeMarketCommentVO.comment_no }'">
                        수정
                     </button>
                     <!-- 댓글삭제 -->
                     <button type="button" class="btn btn-warning btn-yellow"
                        onclick="location.href='${ pageContext.request.contextPath }/fleemarket/deleteCommentProcess.do?fleemarket_no=${ comment.fleeMarketCommentVO.fleemarket_no }&comment_no=${ comment.fleeMarketCommentVO.comment_no }'">
                        삭제
                     </button>
                  </div>
                  </c:if>
               </div>
            </c:forEach>
            <div class="row mb-5"></div>
         </div>
      </div>
      
      <div class="col-2"></div>
      
   
   <div class="row mt-5 mb-5"></div> <%-- 페이지 밑쪽 여백 --%>
   
<!--    <footer>
      <div class="row footer" style="width: auto; margin: 0;">
         <p>"Bee Lecture" hompage is powered by Bee / Designed by Beeeeee</p>
      </div>
   </footer>
 -->   
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
      crossorigin="anonymous"></script>
</body>
</html>