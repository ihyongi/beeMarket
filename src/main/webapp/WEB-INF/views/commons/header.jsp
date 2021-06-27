<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
	<div class="row mt-5">
		<div class="col"></div>
		<div class="col" style="text-align:right;">
		<c:choose>
		<c:when test="${!empty sessionCustomer }">
			<span> ${ sessionCustomer.customer_name }님 환영합니다.&nbsp;|&nbsp;</span>
			<a href="${pageContext.request.contextPath }/customer/logoutCustomerProcess.do" class="btn btn-black py-3 px-5 mr-2">로그아웃</a>
		</c:when>
		<c:otherwise>
			<a href="${pageContext.request.contextPath }/customer/joinCustomerPage.do" class="btn btn-black py-3 px-5 mr-2">회원가입</a>&nbsp;|&nbsp;
			<a href="${pageContext.request.contextPath }/customer/loginCustomerPage.do" class="btn btn-black py-3 px-5 mr-2">로그인</a>
		</c:otherwise>
		</c:choose>
		</div>
	</div>
	
	<div class="row mt-3" style="height: 50px; line-height:50px;">
		<div class="col-1">
			<img onclick="openSideBar(); location.href='#'" src="${pageContext.request.contextPath }/resources/img/list.svg" alt="Bootstrap" width="45" height="45" style="margin-right: 30px; position: relative; top: -5px; left: -5px; cursor: pointer;">
		</div>
		<div class="col-1" style="padding: 0; position: relative; top: -5px;">
			<a href="../product/productMainPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE</a>
		</div>
		<div class="col-1"></div>
		<div class="col">
			<div class="row border border-5 border-warning rounded-pill" style="height: 45px;">
				<form class="d-flex" action="../product/productSearchList.do">
					<div class="col-1" style="margin: 0 30px 0 10px;  height:45px; line-height: 45px;">
						<select name="search_type" style="margin:0; padding:0; border: none; position: relative; top:-5px;">
							<option value="product">상품명</option>
							<option value="seller">판매자</option>
						</select>
					</div>
					<div class="col">
						<input class="form-control me-2 inputAppearance" 
						type="search" name="search_word"
						placeholder="Search" aria-label="Search" style="margin:0; padding:0; border: none; position: relative; top:6px;">
					</div>
					<div class="col-1" style="text-align: right; height:45px; line-height: 16px;">
					<button class="btn bi bi-search" type="submit" style="font-size: 23px; color: #fcc92f; padding: 0; margin: 0 0 0 10px;"></button>
					</div>
				</form>
			</div>
		</div>
		<div class="col-1"></div>
		<div class="col-2" style="text-align: right;">
		<c:choose>
		<c:when test="${ !empty sessionCustomer }">
			<a href="../customer/myPageMain.do"><img src="${pageContext.request.contextPath }/resources/img/person.svg" alt="Bootstrap" width="45" height="45" style="margin-right: 5px; position: relative; top: -5px;"></a>
			<a href="../order/cartPage.do"><img src="${pageContext.request.contextPath }/resources/img/cart.svg" alt="Bootstrap" width="45" height="40" style="margin-right: 7px; position: relative; top: -5px;"></a>
			<img src="${pageContext.request.contextPath }/resources/img/truck.svg" alt="Bootstrap" width="42" height="50" style="padding-top:5px; position: relative; top: -5px;">		
		</c:when>
		<c:otherwise>
			<img src="${ pageContext.request.contextPath }/resources/img/person.svg" alt="Bootstrap" width="45" height="45" style="margin-right: 5px; position: relative; top: -5px;">
			<img src="${ pageContext.request.contextPath }/resources/img/cart.svg" alt="Bootstrap" width="45" height="40" style="margin-right: 7px; position: relative; top: -5px;">
			<img src="${ pageContext.request.contextPath }/resources/img/truck.svg" alt="Bootstrap" width="42" height="50" style="padding-top:5px; position: relative; top: -5px;">		
		</c:otherwise>
		</c:choose>
		</div>
	</div>
	
	<div class="row mt-4 mb-5">
		<div class="col">
			<nav id="nav" style="word-spacing: 20px">
				<a href="${pageContext.request.contextPath }/product/productBestPage.do" class="menu">
				베스트</a>
				<a href="#" class="menu">
				오늘의할인</a>
				<a href="${pageContext.request.contextPath }/product/CouponEventPage.do" class="menu">
				쿠폰/이벤트</a>
				<a href="${pageContext.request.contextPath }/fleemarket/customerFleeMarketPage.do" class="menu">
				공동구매</a>
				<a href="${pageContext.request.contextPath }/communication/mainCommunicationPage.do" class="menu">
				자유게시판</a>
				<a href="${pageContext.request.contextPath }/review/mainReviewPage.do" class="menu">
				리뷰게시판</a>
			</nav>
		</div>
		<c:if test="${ empty sessionCustomer }">
			<div id="nav" class="col-2" style="text-align: right;"><a href="../seller/loginSellerPage.do" class="sellerMenu">BEE SELLER</a></div>
		</c:if>
	</div>
	
</div>


<!-- 사이드 메뉴바 -->
<div id="background_shadow_area"></div>
<div id="sideBar">
	<div class="row loginBarArea">
		<div class="col loginBar" onclick="location.href='${pageContext.request.contextPath }/customer/loginCustomerPage.do'">
			<c:choose>
			<c:when test="${ empty sessionCustomer }">
				<i class="bi bi-person loginBar" style="margin-right: 15px; font-size: 25px;"></i><span style="font-size: 25px;">로그인</span>
			</c:when>
			<c:otherwise>
				<span style="font-size: 20px; font-weight: bold;">${ sessionCustomer.customer_name } 님</span>
			</c:otherwise>
			</c:choose>
		</div>
		<div class="col-4" style="text-align: right; font-size: 40px;"><i class="bi bi-x" onclick="closeSideBar()"></i></div>
	</div>
	<div class="row catBarArea">
		<div class="col">
			<div class="row categoryBar">
				<div class="col" style="font-size: 20px; font-weight: bold;">카테고리</div>
			</div>
			<c:forEach items="${ categoryList }" var="data">
				<div class="row categoryBar" onclick="location.href='${ pageContext.request.contextPath }/product/selectedProductByCategoryPage.do?category_no=${ data.category.category_no }'">
					<div class="col bar_hover">${ data.categoryVO.category_name }</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<script type="text/javascript">
	var background_shadow_area = document.getElementById("background_shadow_area");
	var sideBar = document.getElementById("sideBar");
	
	function openSideBar() {
		if(background_shadow == undefined){
			var background_shadow = document.createElement("div");
			background_shadow.setAttribute("class","background_shadows");
			background_shadow_area.appendChild(background_shadow);
			sideBar.setAttribute("style","top:0; left: 0;");
		}
	}
	function closeSideBar() {
		background_shadow_area.innerHTML = "";
		sideBar.setAttribute("style","top: -10000px; left:  -10000px;");
	}
</script>
<!-- 사이드 메뉴바 -->
