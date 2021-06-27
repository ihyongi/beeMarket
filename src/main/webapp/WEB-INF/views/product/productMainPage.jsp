<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/mainPage.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/bestProductPage.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/realTimeChatCss.css">
<title>Bee Market Main</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

	var selectedElement = null;
	var category_name = null;
	var categoryProductBox = null;

	function over_category_area_boxes_event(e){
		e.style.backgroundColor = "#fede75";
		e.style.fontWeight = "bold";
		e.style.color = "#5b5b5b";
		e.style.border = "none";
	}

	function out_category_area_boxes_event(e){
		
		if(e == selectedElement) return;
		
		e.style.backgroundColor = "#ffffff";
		e.style.color = "#727272";
		e.style.fontWeight = "normal";
	}

	function click_category_area_boxes_event(e){
		
		if(selectedElement != null){
			selectedElement.style.backgroundColor = "#ffffff";
			selectedElement.style.color = "#727272";
			selectedElement.style.fontWeight = "normal";
		}
		
		/* categoryProductBox = document.getElementById("categoryProductList");
		
		if(selectedElement == e){
			selectedElement = null;
			categoryProductBox.innerHTML = "";
		}else if(selectedElement == null){
			selectedElement = e;	
			selectCategory(e);
		}else if(selectedElement != e){
			selectedElement = e;
		} */
		
		if(selectedElement == null || selectedElement != e){
			e.style.backgroundColor = "#fede75";
			e.style.fontWeight = "bold";
			e.style.color = "#5b5b5b";
			e.style.border = "none";
			selectCategory(e);
		}
		
		if(selectedElement == e){
			selectedElement = null;
			categoryProductBox.innerHTML = "";
		}else{
			selectedElement = e;
			selectCategory(e);
		}
		
	}
	
	function selectCategory(e){
		var category_name = e.innerHTML;
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    categoryProductBox = document.getElementById("categoryProductList");
			    
			    categoryProductBox.innerHTML = "";
			    
			    for(var data of obj){
			    	
					var cardArea = document.createElement("div");
					cardArea.setAttribute("class","col-3 cardSector");
					cardArea.setAttribute("onclick","location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=" + data.productVO.product_no + "'");
					
					// 이미지
					var row1 = document.createElement("div");
					row1.setAttribute("class","row cardImageArea");
					cardArea.appendChild(row1);
					
					var img = document.createElement("img");
					img.setAttribute("class","cardImage");
					img.setAttribute("src","/upload_files/" + data.productImageVO.productimage_location );
					row1.appendChild(img);
					// 이미지
					
					
					var row2 = document.createElement("div");
					row2.setAttribute("class","row cardContentsArea");
					cardArea.appendChild(row2);
					
					var inner_col = document.createElement("div");
					inner_col.setAttribute("class","col");
					row2.appendChild(inner_col);
					
					var inner_row1 = document.createElement("div");
					inner_row1.setAttribute("class","row cardTitle");
					inner_row1.innerText = data.productVO.product_name;
					inner_col.appendChild(inner_row1);
					
					var inner_row2 = document.createElement("div");
					inner_row2.setAttribute("class","row mb-2 cardPrice");
					inner_row2.innerText = data.minimumPrice+"원 ~";
					inner_col.appendChild(inner_row2);
					
					var inner_row3 = document.createElement("div");
					inner_row3.setAttribute("class","row cardName");
					inner_row3.innerText = data.categoryDetailName;
					inner_col.appendChild(inner_row3);
					
					categoryProductBox.appendChild(cardArea);
					
			    }
			    
			}
		};
		
		xmlhttp.open("get","../product/getCategoryListBox.do?category_name=" + category_name , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();		
	}
	
	function init(){
		
		var category_area_boxes = document.getElementsByClassName("category_area");
		for(x of category_area_boxes){
			x.setAttribute("onclick" , "click_category_area_boxes_event(this)");
			x.setAttribute("onmouseover" , "over_category_area_boxes_event(this)");
			x.setAttribute("onmouseout" , "out_category_area_boxes_event(this)");
			x.setAttribute("name", "category_name");
			x.setAttribute("id", "category_name");
		}
		
	}
</script>
</style>
</head>
<body onload="init()">
<jsp:include page="/WEB-INF/views/customer/alarms.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
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
	
	<!-- carosel BestProduct -->
	<div class="row bt-5 mb-3">
		<div class="col todayBest" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">TODAY BEST</div>
	</div>
	
	<div id="bestProductCa" class="carousel slide mb-5" data-bs-ride="carousel" style="height: 280px; background-color: #efefef;">
		<div class="carousel-indicators" style="margin-bottom: 3px;">
			<button type="button" data-bs-target="#bestProductCa" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#bestProductCa" data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#bestProductCa" data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<div class="row" style="height: 226px; margin-top: 27px;">
					<div class="col-1"></div>
						<c:forEach items="${ bestProductDataList }" var="best" begin="0" step="1" end="1">
							<div class="col" style="background-color: #ffffff; margin: 0px 5px; padding: 12px; border-radius: 5px;">
								<div class="row" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }'">
									<div class="col-5" style="text-align: center;">
										<img alt="" src="/upload_files/${ best.productImageVO[0].productimage_location }" class="bestImagePrev">
									</div>
									<div class="col-7">
										<div class="row mb-3 mt-1">
											<div class="col name">
												${ best.productVO.product_title }
											</div>
										</div>
										<div class="row mb-1">
											<div class="col">
												<a class="bestTitleStyle" href="${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }">${ best.productVO.product_name }</a>
											</div>
										</div>
										<div class="row  mb-3">
											<div class="col price">
												${ best.minimumPrice } 원 ~
											</div>
										</div>
										<div class="row">
											<div class="col content">
												${ best.productVO.product_content }
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					<div class="col-1"></div>
				</div>
			</div> <!-- carousel-item active - 1 끝 -->
			<div class="carousel-item">
				<div class="row" style="height: 226px; margin-top: 27px;">
					<div class="col-1"></div>
						<c:forEach items="${ bestProductDataList }" var="best" begin="2" step="1" end="3">
							<div class="col" style="background-color: #ffffff; margin: 0px 5px; padding: 12px; border-radius: 5px;">
								<div class="row" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }'">
									<div class="col-5" style="text-align: center;">
										<img alt="" src="/upload_files/${ best.productImageVO[0].productimage_location }" class="bestImagePrev">
									</div>
									<div class="col-7">
										<div class="row mb-3 mt-1">
											<div class="col name">
												${ best.productVO.product_title }
											</div>
										</div>
										<div class="row mb-1">
											<div class="col">
												<a class="bestTitleStyle" href="${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }">${ best.productVO.product_name }</a>
											</div>
										</div>
										<div class="row  mb-3">
											<div class="col price">
												${ best.minimumPrice } 원 ~
											</div>
										</div>
										<div class="row">
											<div class="col content">
												${ best.productVO.product_content }
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					<div class="col-1"></div>
				</div>
			</div> <!-- carousel-item - 2 끝 -->
			<div class="carousel-item">
				<div class="row" style="height: 226px; margin-top: 27px;">
					<div class="col-1"></div>
						<c:forEach items="${ bestProductDataList }" var="best" begin="4" step="1" end="5">
							<div class="col" style="background-color: #ffffff; margin: 0px 5px; padding: 12px; border-radius: 5px;">
								<div class="row" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }'">
									<div class="col-5" style="text-align: center;">
										<img alt="" src="/upload_files/${ best.productImageVO[0].productimage_location }" class="bestImagePrev">
									</div>
									<div class="col-7">
										<div class="row mb-3 mt-1">
											<div class="col name">
												${ best.productVO.product_title }
											</div>
										</div>
										<div class="row mb-1">
											<div class="col">
												<a class="bestTitleStyle" href="${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ best.productVO.product_no }">${ best.productVO.product_name }</a>
											</div>
										</div>
										<div class="row  mb-3">
											<div class="col price">
												${ best.minimumPrice } 원 ~
											</div>
										</div>
										<div class="row">
											<div class="col content">
												${ best.productVO.product_content }
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					<div class="col-1"></div>
				</div>
			</div> <!-- carousel-item - 3 끝 -->
		</div>
		<button class="carousel-control-prev carouselBTN" type="button" data-bs-target="#bestProductCa" data-bs-slide="prev">
			<span class="carousel-control-prev-icon btnLeft" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next carouselBTN" type="button" data-bs-target="#bestProductCa" data-bs-slide="next">
			<span class="carousel-control-next-icon btnRight" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- carosel BestProduct -->
	
	<!-- banner_bigSize -->
	<div class="row mb-5" style="padding-left: 12px; padding-right: 12px;">
		<div class="col" style="padding: 0;">
			<img alt="" src="${pageContext.request.contextPath }/resources/img/adBanner_1.png" class="bannerImageBig">
		</div>
		<div class="col" style="padding: 0; text-align: right;">
			<img alt="" src="${pageContext.request.contextPath }/resources/img/adBanner_2.png" class="bannerImageBig">
		</div>
	</div>		
	<!-- banner_bigSize -->
	
	<div class="row mb-3">
		<div class="col">
			<div class="row mb-3 mainCategory" id="mainCategory" style="color: #5b5b5b; font-size: 25px; font-weight: bold;">
				<div class="col">CATEGORY LIST</div>
			</div>
				<!-- 카테고리 리스트 -->
			<div class="row align-items-start" style="width: 1176px; margin: 0 auto; cursor: pointer;">
				<a class="col border category_area">패션의류/잡화</a>
			    <a class="col border category_area">뷰티</a>
			    <a class="col border category_area">출산/유아동</a>
			    <a class="col border category_area">식품</a>
			    <a class="col border category_area">주방용품</a>
			</div>
			<div class="row align-items-center" style="width: 1176px; margin: 0 auto; cursor: pointer;">
				<a class="col border category_area">생활용품</a>
			    <a class="col border category_area">홈인테리어</a>
			    <a class="col border category_area">가전디지털</a>
			    <a class="col border category_area">스포츠/레져</a>
			    <a class="col border category_area">자동차용품</a>
			</div>
			<div class="row align-items-end" style="width: 1176px; margin: 0 auto; cursor: pointer;">
			    <a class="col border category_area">도서/음반/DVD</a>
			    <a class="col border category_area">완구/취미</a>
			    <a class="col border category_area">문구/오피스</a>
			    <a class="col border category_area">반려동물용품</a>
			    <a class="col border category_area">헬스/건강식품</a>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
		<!-- 카테고리 별 리스트가 담길 공간 -->
			<div class="row" id="categoryProductList"></div>
		</div>
		<!-- 카테고리 별 리스트 끝 -->
	</div>
				
	<div class="row mb-5">
		<div class="col promotionbanner">
			<img alt="" src="${pageContext.request.contextPath }/resources/img/ad_Banner_primary.png" style="width: 1176px;">
		</div>
	</div>
	
	<!-- 카테고리별 리스트 출력 -->
	<div class="row mb-2">
		<div class="col" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">HOT! TREND 카테고리별 추천</div>
	</div>
	
	<c:forEach items="${ allDataList }" var="cat">
		<div style="margin-top: 2px; padding: 0;"><hr class="one" style="padding: 0;"></div>
		<div class="row mb-3">
			<div class="col" style="color: #fccd11; font-size: 21px; font-weight: bold;">${ cat.categoryVO.category_name }</div>
		</div>
		<div class="row" style="height: 467px;">
			<div class="col-3">
				<div class="row" style="height: 467px;">
					<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" style="width: 900px;">
						<div class="carousel-inner car_image">
							<div class="carousel-item active">
								<div class="d-block w-100" style="height: 467px; background-image: url('${pageContext.request.contextPath }/resources/img/mainImage1.jpg'); background-repeat: no-repeat; background-size: cover; <%-- background-position: center; --%>"></div>
							</div>
							<div class="carousel-item">
								<div class="d-block w-100" style="height: 467px; background-image: url('${pageContext.request.contextPath }/resources/img/mainImage2.jpg'); background-repeat: no-repeat; background-size: cover; <%-- background-position: center; --%>"></div>
							</div>
							<div class="carousel-item">
								<div class="d-block w-100" style="height: 467px; background-image: url('${pageContext.request.contextPath }/resources/img/mainImage3.jpg'); background-repeat: no-repeat; background-size: cover; <%-- background-position: center; --%>"></div>
							</div>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
			
			<div class="col">
				<div class="row">
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner" style="height: 467px;">
							<div class="carousel-item active">
								<div class="row">
									<c:forEach items="${ cat.mainPageProductInfoList }" var="data" begin="0" step="1" end="3">
										<div class="col-6" style="height: 234px; padding: 8px;">
											<div class="row">
												<div class="col">
													<img alt="" src="/upload_files/${ data.productImageVO.productimage_location }" class="detailImagePrev"
														onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'">
												</div>
												<div class="col" style="padding-left: 6px;">
													<div class="row mb-1">
														<div class="col name">
															${ data.productVO.product_title }
														</div>
													</div>
													<div class="row mb-1">
														<div class="col">
															<a class="aTagStyle" href="${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }">${data.productVO.product_name }</a>
														</div>
													</div>
													<div class="row mb-3">
														<div class="col content">
															${ data.productVO.product_content }
														</div>
													</div>
													<div class="row mb-3">
														<div class="col price">
															${ data.minimumPrice } 원 ~
														</div>
													</div>
													<div class="row category">
														<div class="col">
															${ cat.categoryVO.category_name } > ${ data.categoryDetailName }
														</div>
													</div>
												</div>
											</div>
										</div>	
									</c:forEach>
								</div>
								
							</div> <%-- class="carousel-item active 1" 끝--%>
							<div class="carousel-item">
								<div class="row">
									<c:forEach items="${ cat.mainPageProductInfoList }" var="data" begin="4" step="1" end="7">
										<div class="col-6" style="/* border: 1px solid #efefef; border-radius:3px;*/height: 234px; padding: 8px;">
											<div class="row">
												<div class="col">
													<img alt="" src="/upload_files/${ data.productImageVO.productimage_location }" class="detailImagePrev"
														onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ data.productVO.product_no }'">
												</div>
												<div class="col" style="padding-left: 6px;">
													<div class="row mb-1">
														<div class="col name">
															${ data.productVO.product_title }
														</div>
													</div>
													<div class="row mb-1">
														<div class="col">
															<a class="aTagStyle" href="${ pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ data.productVO.product_no }">${ data.productVO.product_name }</a>
														</div>
													</div>
													<div class="row mb-3">
														<div class="col content">
															${ data.productVO.product_content }
														</div>
													</div>
													<div class="row mb-3">
														<div class="col price">
															${ data.minimumPrice } 원 ~
														</div>
													</div>
													<div class="row category">
														<div class="col">
															${ cat.categoryVO.category_name } > ${ data.categoryDetailName }
														</div>
													</div>
												</div>
											</div>
										</div>	
									</c:forEach>
								</div>
							</div> <%-- class="carousel-item active 2" 끝--%>
							
							<div class="carousel-item">
								<div class="row">
									<c:forEach items="${ cat.mainPageProductInfoList }" var="data" begin="8" step="1" end="11">
										<div class="col-6" style="/* border: 1px solid #efefef; border-radius:3px;*/height: 234px; padding: 8px;">
											<div class="row">
												<div class="col">
													<img alt="" src="/upload_files/${ data.productImageVO.productimage_location }" class="detailImagePrev"
														onclick="location.href='${ pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'">
												</div>
												<div class="col" style="padding-left: 6px;">
													<div class="row mb-1">
														<div class="col name">
															${ data.productVO.product_title }
														</div>
													</div>
													<div class="row mb-1">
														<div class="col">
															<a class="aTagStyle" href="${ pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ data.productVO.product_no }">${ data.productVO.product_name }</a>
														</div>
													</div>
													<div class="row mb-3">
														<div class="col content">
															${ data.productVO.product_content }
														</div>
													</div>
													<div class="row mb-3">
														<div class="col price">
															${ data.minimumPrice } 원 ~
														</div>
													</div>
													<div class="row category">
														<div class="col">
															${ cat.categoryVO.category_name } > ${ data.categoryDetailName }
														</div>
													</div>
												</div>
											</div>
										</div>	
									</c:forEach>
								</div>
							</div> <%-- class="carousel-item active 3" 끝--%>
						</div> <%-- class="carousel-inner" 끝--%>
					
						
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
						
					</div> <%-- class="ccarouselExampleIndicators" 끝--%> 
				</div> <%-- row 끝 --%>
			</div> <%-- col-7 끝 --%>
		</div> <%-- row 끝 --%>
	</c:forEach>
	
	<div class="row" style="height: 100px;"></div>
</div> <%-- container 끝 --%>

<!-- 실시간 채팅 말머리 버튼 -->
<c:if test="${!empty sessionCustomer}">
	<a id="realtimeChat" onclick="showChat()" title=realtimeChat"><img alt="실시간 상담" src="${pageContext.request.contextPath }/resources/img/chatIcon.png"></a>
	<div id="chatLog" style="display:none;">
		<div class="chatBox" id="chatBox">
			<div class="card">
			<header class="card-header header-title" @click="toggleChat()">
				<p class="card-header-title" style="padding-top:10px;">
					<i class="fa fa-circle is-online"></i>&nbsp;${sessionCustomer.customer_name}님
					<a onclick="exitChat()" class="card-header-icon" style="cursor:pointer;">
						<span class="icon">
							<i class="fa fa-close"><img style="width:20px; height:20px; float:right;" src="${pageContext.request.contextPath }/resources/img/close.png"></i>
						</span>
					</a>
				</p>
			</header>
			
				<!-- 상대방 -->
				<div id="chatbox-area">
					<div class="card-content chat-content">
						<div id="ChatContent" class="ChatContent" style="min-height:200px;">
							<!--  header -->
							<div class="chat-message-group" id="writeAdmin">
								<div class="chat-messagesl" id="chatmessages">
									<div class="message_2" style=" margin-left: 10px; margin-top: 10px;">반갑습니다. ${ sessionCustomer.customer_name }님<br> 무엇을 도와드릴까요?</div>
								</div>
							</div>
							<!-- 본메시지 -->
							<div class="chat-message-group writer-user" id="write-user">
								<div class="chat-messages"></div>
							</div>
						</div>
						<div class="foot-area">
							<input type="hidden" id="customer_id" value="${sessionCustomer.customer_id }">
							<input type="hidden" id="chat_no" value="${lastChatNo}">
							<textarea id="msg" name="msg" class="chat-textarea" placeholder="질문을 남겨주세요." style="width:77%; min-height: 60px;"></textarea>
							<button id="sendBtn" class="btn btn-primary btn-sm" style="float:right;" onclick="submitAdmin()">전송</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
<script type="text/javascript">//실시간 상담 파트   
	function showChat() {
	   $("#chatLog").show();   
	   $("#realtimeChat").hide();
	   $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
	}
	
	function exitChat() {
	   $("#realtimeChat").show();   
	   $("#chatLog").hide();   
	}
	
	//insert
	function submitAdmin(){
	   //AJAX 호출.....
	   var xmlhttp = new XMLHttpRequest();
	   alert("메시지를 전송하였습니다.");
	   var msgInput = document.getElementById("msg");
	   var message = document.getElementById("msg").value;
	   var customer_id = document.getElementById("customer_id").value;
	   
	
	   xmlhttp.onreadystatechange = function(){
	         if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
	            //var obj = JSON.parse(xmlhttp.responseText);
	            
	            msgInput.value="";
	            realTimeChat()
	         }
	      };
	
	
	   xmlhttp.open("post","./insertChatLogProcessToAdmin.do?message="+message+"&customer_id="+customer_id);
	   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	   xmlhttp.send(); //url 인코디드방식?
	
	   }
	
	var current_chat_no = 0;
	//select해오는거 바꿔야됌...
	function realTimeChat(){
	   
	   //var chat_no= document.getElementById("chat_no").value;
	   //current_chat_no= chat_no;
	   
	   
	   //AJAX 호출.....
	   var httpRequest = new XMLHttpRequest();
	    httpRequest.onreadystatechange = function() {
	
	           if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200 ) {
	                 var obj = JSON.parse(httpRequest.responseText);
	               //document.getElementById("chat").innerHTML=obj;
	               var customer_id = obj.chatChannelVO.customer_id;
	               var chatmessages = document.querySelector(".chat-messages");
	                  
	               for(var obj2 of obj.addChatList){
	                     var messageArea = document.createElement("div");
	                     messageArea.innerText=obj2.message;
	                     chatmessages.appendChild(messageArea);
	                     var writeUser = document.getElementById("write-user");   
	                     writeUser.appendChild(chatmessages);
	                     
	                     if(obj2.sender==customer_id){
	                        messageArea.setAttribute("class" , "message_1");
	                        messageArea.setAttribute("value" , obj2.chat_no);
	                        messageArea.innerText=obj2.message;
	                        
	                     }else{
	                        messageArea.setAttribute("class" , "message_2");
	                        messageArea.setAttribute("value" , obj2.chat_no);
	                        messageArea.innerText=obj2.message;
	                     }      
	                     
	                     current_chat_no = obj2.chat_no;
	               }
	               
	               
	               $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
	               self.setTimeout("realTimeChat()", 5000);
	
	         }
	      };
	
	   //이후의 값이 있느냐
	   httpRequest.open("get","./main?chat_no="+current_chat_no , true);
	   httpRequest.send();
	}
	realTimeChat();
</script>
<!-- 채팅 -->

<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>

</body>
</html>