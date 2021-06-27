 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<title>Flee Market</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
a:hover{
	text-decoration: blink !important; 
}

.container{
	width : 1200px;
	max-width: none !important;
}
.name {
	width: 200px !important;
   text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
     white-space: nowrap;    /* 줄바꿈을 하지 않습니다. */
     overflow: hidden;    /* 내용이 길면 감춤니다 */
}
</style>
</head>
<body>

	<%-- <header>
		<!-- 네비게이션.. -->
		<jsp:include page="/WEB-INF/views/commons/navigation.jsp"></jsp:include>
	</header> --%>
<div class="container">
	
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/headerflee.jsp"></jsp:include>
	</div>
	
	<div class="row mt-1 mb-5" style="width:1176px; padding: 0; margin: 0;">
		<div class="col upperbanner" style="width:1176px; padding: 0; margin: 0;">
			<div class="row upperbanner" id="upperbanner" style="width:1176px; padding: 0; margin: 0;">
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="width:1176px; padding: 0; margin: 0;">
					<div class="carousel-indicators" style="width:1176px; padding: 0; margin: 0;">
				    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>
					<div class="carousel-inner" style="width:1176px; padding: 0; margin: 0;">
						<div class="carousel-item active" data-bs-interval="10000">
							<img src="${pageContext.request.contextPath }/resources/img/banner1.jpg" class="d-block" alt="상단 배너 1">
					    </div>
					    <div class="carousel-item" data-bs-interval="2000">
					    	<img src="${pageContext.request.contextPath }/resources/img/banner2.jpg" class="d-block" alt="상단 배너2">
					    </div>
					    <div class="carousel-item">
					    	<img src="${pageContext.request.contextPath }/resources/img/banner3.jpg" class="d-block" alt="상단 배너3">
					    </div>
					</div>
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true" style="padding:0;"></span>
					 	<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true" style="padding:0;"></span>
					    <span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>	
		
		</div>
	</div>
	
	<!-- test -->
	<div class="row bt-5 mb-3">
		<div class="col" style="font-size: 25px; font-weight: bold; color: #5b5b5b;">BEST FLEEMARKET PRODUCT</div>
	</div>

	<div class="row mt-1 mb-5" style="width:1176px; height:280px; padding: 0; margin: 0;">
		<div class="col upperbanner" style="width:1176px; height:280px; background-color: #efefef; padding: 0; margin: 0;">
		
			<div class="row upperbanner" id="upperbanner">
				<div id="bestFleeMarketCa" class="carousel slide" data-bs-ride="carousel">
					<div class="carousel-indicators" style="margin-bottom: 3px;">
						<c:forEach items="${bestFleeMarketList }" var="bestFleeMarket" varStatus="status">
						<c:choose>
							<c:when test="${status.first }">
				    			<button type="button" style="color: #fccc0c;" data-bs-target="#bestFleeMarketCa" data-bs-slide-to="0"  class="active" aria-current="true" aria-label="Slide 1"></button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" style="" data-bs-target="#bestFleeMarketCa" data-bs-slide-to="${status.index }" aria-label="Slide 2"></button>
				    		</c:otherwise>
						</c:choose>
				    	</c:forEach>
				    	
					</div>
					<div class="carousel-inner" >
						<div class="carousel-inner" style="border: 1px; height: 280px;">
						<c:forEach items="${ bestFleeMarketList }" var="bestFleeMarket" varStatus="status">
						<c:choose>
							<c:when test="${ status.first }">
								<div class="carousel-item active text-left" data-bs-interval="10000">
									<div class="row" style="height: 226px; margin-top: 27px;">
										<div class="col-3"></div>
										<div class="col-6" style="background-color: #ffffff; height: 226px; border-radius: 5px;">
											<div class="row">
												<div class="col-5" style="height: 226px; padding-top: 12px; padding-bottom: 12px; text-align: center;">
													<a href="${ pageContext.request.contextPath }/fleemarket/readFleeMarketContentPage.do?fleemarket_no=${bestFleeMarket.fleeMarketVO1.fleemarket_no }">
														<img src="/upload_files/${ bestFleeMarket.fleeMarketImageVO1[0].fleemarketimage_location }" style="height: 202px; width: 202px; border-radius: 5px;" class="" alt="상단 배너 1">
													</a>
												</div>
												<div class="col" style="height: 226px;">
													<div class="row mt-3 mb-1" style="height: 74px; font-size: 25px; color: #fccc0c; font-weight: bold">
														<div class="col">
															<i class="bi bi-box-seam"></i> ${bestFleeMarket.fleeMarketVO1.fleemarket_title } 
														</div>
													</div>
													<div class="row mb-1" style="">
														<div class="col" style="font-size: 25px; font-weight: bold; color: #5b5b5b"><i class="bi bi-bootstrap" style="color: #ffde40"></i> ${ bestFleeMarket.fleeMarketVO1.fleemarket_price } 원</div>
													</div>
													<div class="row mb-2">
														<div class="col">
															<img style="heigth: 25px; width: 25px;"src="${pageContext.request.contextPath }/resources/img/BeeSeller.png"> ${ bestFleeMarket.sellerVO.seller_name }
														</div>
													</div>
													
													<div class="row px-2">
														<div class="col progress px-0">
														<div class="progress-bar bg-warning" role="progressbar" style="width: ${(bestFleeMarket.orderCount)/(bestFleeMarket.fleeMarketVO1.fleemarket_itemqty)*100}%;"  aria-valuenow="${fleeMarket.orderCount }" aria-valuemin="0" aria-valuemax="100"> ${(bestFleeMarket.orderCount)/(bestFleeMarket.fleeMarketVO1.fleemarket_itemqty)*100}%</div>
														</div>
													</div>
													<div class="row">
														<div class="col-6" style="color: #ffc107;" align="left">0%</div>
														<div class="col-6 text-end" style="color: #ffc107;">100%</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-3"></div>
									</div>	
						   		</div>
							</c:when>
							<c:otherwise>
								<div class="carousel-item text-left" data-bs-interval="2000">
									<div class="row" style="height: 226px; margin-top: 27px;">
										<div class="col-3"></div>
										<div class="col-6" style="background-color: #ffffff; height: 226px; border-radius: 5px;">
											<div class="row">
												<div class="col-5" style="height: 226px; padding-top: 12px; padding-bottom: 12px; text-align: center;">
													<a href="${ pageContext.request.contextPath }/fleemarket/readFleeMarketContentPage.do?fleemarket_no=${bestFleeMarket.fleeMarketVO1.fleemarket_no }">
														<img src="/upload_files/${ bestFleeMarket.fleeMarketImageVO1[0].fleemarketimage_location }" style="height: 202px; width: 202px; border-radius: 5px;" class="" alt="상단 배너 1">
													</a>
												</div>
												<div class="col" style="height: 226px;">
													<div class="row mt-3 mb-1" style="height: 74px; font-size: 25px; color: #fccc0c; font-weight: bold">
														<div class="col">
															<i class="bi bi-box-seam"></i> ${ bestFleeMarket.fleeMarketVO1.fleemarket_title }
														</div>
													</div>
													<div class="row mb-1" style="">
														<div class="col" style="font-size: 25px; font-weight: bold; color: #5b5b5b"><i class="bi bi-bootstrap" style="color: #ffde40"></i> ${ bestFleeMarket.fleeMarketVO1.fleemarket_price }원</div>
													</div>
													<div class="row mb-2">
														<div class="col">
															<img style="heigth: 25px; width: 25px;"src="${pageContext.request.contextPath }/resources/img/BeeSeller.png"> ${ bestFleeMarket.sellerVO.seller_name }
														</div>
													</div>
													
													<div class="row px-2">
														<div class="col progress px-0">
														<div class="progress-bar bg-warning" role="progressbar" style="width: ${(bestFleeMarket.orderCount)/(bestFleeMarket.fleeMarketVO1.fleemarket_itemqty)*100}%;"  aria-valuenow="${fleeMarket.orderCount }" aria-valuemin="0" aria-valuemax="100"> ${(bestFleeMarket.orderCount)/(bestFleeMarket.fleeMarketVO1.fleemarket_itemqty)*100}%</div>
														</div>
													</div>
													<div class="row">
														<div class="col-6" style="color: #ffc107;" align="left">0%</div>
														<div class="col-6 text-end" style="color: #ffc107;">100%</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-3"></div>
									</div>		
						   		</div>
							</c:otherwise>
						</c:choose>
					    </c:forEach>
					</div>
					</div>
					<button class="carousel-control-prev" type="button" data-bs-target="#bestFleeMarketCa" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true" style="padding:0; color: #fccc0c;"></span>
					 	<span class="visually-hidden">Prev</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#bestFleeMarketCa" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true" style="padding:0; color: #fccc0c;"></span>
					    <span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>	
		
		</div>
	</div>
	<!-- test -->

	
	<div class="row mb-5">
		<div class="col fleeMarket" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">공동구매</div>
	</div>
			
			<!-- 게시물 카운트 -->
	
			<div id="total_search" align="left">
			
				<c:if test="${empty fleeMarketCount }">
					<div id="total"> 총 ${fleeMarketCount }개의 게시물이 있습니다.</div>
				</c:if>
				
				<c:if test="${!empty fleeMarketCount }">
					<div id="total"> 총 ${fleeMarketCount }개의 게시물이 있습니다.</div>
				</c:if>
			</div>
	


			
			<!-- 이미지 카드 EX -->
			<div class="row row-cols-2 row-cols-lg-4 g-1 g-lg-5">
			<jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
			<fmt:parseNumber value="${today.time/(1000*60*60*24)}" var="now" integerOnly="true" />
				<c:forEach items="${ fleeMarketList }" var="data">
					<div class="col">
						<div class="card border_clear mb-3">
							<!-- 썸네일 이미지 -->
							<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_startdate.time/(1000*60*60*24)}" var="startdate" integerOnly="true" />
     						<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_enddate.time/(1000*60*60*24)}" var="enddate" integerOnly="true" />
							<c:choose>
								<c:when test="${startdate - now > 0 }">
									<div class="card-img-top"
									style="height: 300px; background-image: url('${pageContext.request.contextPath}/resources/img/open2.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
									</div>
								</c:when>
								<c:when test="${enddate - now < 0}">
									<div class="card-img-top"
									style="height: 300px; background-image: url('${pageContext.request.contextPath}/resources/img/close.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
									</div>
								</c:when>
								<c:otherwise>
								<div>
									<a class="card-title fleemarket_title"
											href="${pageContext.request.contextPath }/fleemarket/readFleeMarketContentPage.do?fleemarket_no=${data.fleeMarketVO.fleemarket_no }">
										<img class="card-img-top" style="height: 300px; background-image: background-repeat: no-repeat; background-size: cover; background-position: center;" src="/upload_files/${data.fleeMarketImageVO[0].fleemarketimage_location }"></a>
								</div>
								</c:otherwise>
							</c:choose>
							<div class="card-body">
								<c:choose>
									<c:when test="${startdate - now > 0 || enddate - now < 0}">
										<span class="card-title fleemarket_title"><i class="bi bi-box-seam"> ${data.fleeMarketVO.fleemarket_title }</i></span>
									</c:when>
									<c:otherwise>
										<i class="bi bi-box-seam"> ${data.fleeMarketVO.fleemarket_title }</i>
									</c:otherwise>
								</c:choose>
								
								<p class="card-text">
									<div class="seller_name"><img style="heigth: 17px; width: 16px;"src="${pageContext.request.contextPath }/resources/img/BeeSeller.png"> ${ data.sellerVO.seller_name }</div>
									<div class="fleemarket_price"><i class="bi bi-bootstrap" style="color: #ffde40"></i> ${ data.fleeMarketVO.fleemarket_price }원</div>
									<div class="fleemarket_startdate">
									<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_startdate.time/(1000*60*60*24)}" var="startdate" integerOnly="true" />
									<fmt:parseNumber value="${data.fleeMarketVO.fleemarket_enddate.time/(1000*60*60*24)}" var="enddate" integerOnly="true" />
							         <c:set value="${startdate-now}" var="daydiff2" />
							         <c:choose>
							            <c:when test="${startdate-now > 0 || enddate-now < 0}">
							               <div class="col"><i class="bi bi-x-circle-fill" style="color: #ff0006;"></i> 구매불가</div>
							               <div class="fleemarket_itemqty"><i class="bi bi-cart4"></i> 0/${ data.fleeMarketVO.fleemarket_itemqty }개</div>
							            </c:when>
							            <c:otherwise>
							               <div class="col"><i class="bi bi-circle-fill" style="color: #b0c779;"></i> 구매가능</div>
							               <div class="fleemarket_itemqty"><i class="bi bi-cart4"></i> ${ data.orderCount }/${ data.fleeMarketVO.fleemarket_itemqty }개</div>
							            </c:otherwise>
							         </c:choose></div>
								</p>
								</div>
								<div class="progress">
								  <div class="progress-bar bg-warning" role="progressbar" style="width: ${(data.orderCount)/(data.fleeMarketVO.fleemarket_itemqty)*100}%; height: 100px; "  aria-valuenow="${fleeMarket.orderCount }" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
								<div class="row">
									<div class="col-6" style="color: #ffc107;" align="left">0%</div>
									<div class="col-6 text-end" style="color: #ffc107;">100%</div>
								</div>
								<div class="text-center"><fmt:formatDate value="${ data.fleeMarketVO.fleemarket_startdate}" pattern="yyyy년MM월dd일"/></div>
								<div class="text-center"><fmt:formatDate value="${ data.fleeMarketVO.fleemarket_enddate}" pattern="yyyy년MM월dd일"/></div>
							</div>
						
					</div>
				</c:forEach>
			</div>
		</div>
		
		
	<div class="row">
	<div class="col-2"></div>
	<div class="col-8 text-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:choose>
					<c:when test="${beginPage <= 1 }">
						<li class="page-item disabled">
							<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${beginPage - 1}" tabindex="-1" aria-disabled="true">Prev</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${beginPage - 1}" tabindex="-1" aria-disabled="true">Prev</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<c:forEach begin="${beginPage }" end="${endPage }" var="page">
					<c:choose>
						<c:when test="${page == currentPage }">
							<li class="page-item active">
								<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${page}">${page}</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${page}">${page}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:choose>
					<c:when test="${endPage >= totalPageCount }">
						<li class="page-item disabled">
							<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${endPage + 1}">Next</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do?page_num=${endPage + 1}">Next</a>
						</li>
					</c:otherwise>
				</c:choose>	
			</ul>
		</nav>
	</div>
	<div class="col-2"></div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>