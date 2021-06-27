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
<title>Bee fleeMarketDetail</title>
<script type="text/javascript">
	function cart() {
		var of= document.getElementById("orderForm");
		of.action = "../order/cartProcess.do";
		of.submit();
	}
	function order() {
		var of = document.getElementById("orderForm");
		of.action = "../order/orderProcess.do";
		of.submit();
	}



</script>

</head>
<body>

<div class="container">

	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>
	
    <div class="container">
    	<div class="row">
    		<div class="col">
    			${ allDataList.category_name } > ${ allDataList.categoryDetailVO.categorydetail_name }
    		</div>
    		<div class="col">
    		</div>
    		<div class="col">
    		</div>
    	</div>
    	<div class="row">
    		<div class="col">
    			<img src="/upload_files/${ allDataList.fleeMarketImageList[0].fleemarketimage_location }" class="img-fluid">
    		</div>
    	<div class="col">
    		${ allDataList.fleeMarketVO.fleemarket_name }
    		<p class="price"><span>${ allDataList.minimumPrice }</span></p>
    		<p>${ allDataList.fleeMarketVO.fleemarket_title }</p>
    		<p>${ allDataList.fleeMarketVO.fleemarket_content }</p>
    <form id="orderForm">
		<div class="row">
			<div class="col">
				<div class="form-group d-flex">
		              <div class="select-wrap">
	                  <div class="icon"><span class="ion-ios-arrow-down"></span></div>
	                  <select name="fleemarketdetail_no" id="fleemarketdetail_no" class="form-control">
	                  	<c:forEach items="${ allDataList.fleeMarketDetailList }" var="data">
	                  			<option value="${ data.fleemarketdetail_no}">${data.fleemarketdetail_option }</option>
	                  	</c:forEach>
	                  </select>
	                  </div>
				</div>
			</div>
			<div class="w-100"></div>
			<div class="input-group col-md-6 d-flex mb-3">
				<span class="input-group-btn mr-2">
					<button type="button" class="quantity-left-minus btn"  data-type="minus" data-field="">
						<i class="ion-ios-remove"></i>
					</button>
				</span>
				<input type="number" id="fleemarketdetail_count" name="fleemarketdetail_count" class="quantity form-control input-number" value="1" min="1" max="100">
				<span class="input-group-btn ml-2">
					<button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
						<i class="ion-ios-add"></i>
					</button>
				</span>
			</div>
			<div class="w-100"></div>
			<!-- <div class="col-md-12">
				<p style="color: #000;">재고량??</p>
			</div> -->
			</div>
			<c:if test="${ sessionCustomer != null}">
				<p><button onclick="cart()" class="btn btn-black py-3 px-5 mr-2">Add to Cart</button><button onclick="order()" class="btn btn-primary py-3 px-5">Buy now</button></p>
			</c:if>
			</form>
			
			</div>
		</div>




    		<%-- <div class="row mt-5">
          <div class="col-md-12 nav-link-wrap">
            <div class="nav nav-pills d-flex text-center" id="v-pills-tab" role="tablist" aria-orientation="vertical">
              <a class="nav-link ftco-animate active mr-lg-1" id="v-pills-1-tab" data-toggle="pill" href="#v-pills-1" role="tab" aria-controls="v-pills-1" aria-selected="true">Description</a>

              <a class="nav-link ftco-animate mr-lg-1" id="v-pills-2-tab" data-toggle="pill" href="#v-pills-2" role="tab" aria-controls="v-pills-2" aria-selected="false">Manufacturer</a>

              <a class="nav-link ftco-animate" id="v-pills-3-tab" data-toggle="pill" href="#v-pills-3" role="tab" aria-controls="v-pills-3" aria-selected="false">Reviews</a>

            </div>
          </div>
          <div class="col-md-12 tab-wrap">
            
            <div class="tab-content bg-light" id="v-pills-tabContent">

              <div class="tab-pane fade show active" id="v-pills-1" role="tabpanel" aria-labelledby="day-1-tab">
              	<div class="p-4">
	              	<h3 class="mb-4">${allDataList.productDetail.productVO.product_name }</h3>
	              	<p>제품 정보</p>
              	</div>
              </div>

              <div class="tab-pane fade" id="v-pills-2" role="tabpanel" aria-labelledby="v-pills-day-2-tab">
              	<div class="p-4">
	              	<h3 class="mb-4">판매자</h3>
	              	<p>판매자 정보</p>
              	</div>
              </div>
              <div class="tab-pane fade" id="v-pills-3" role="tabpanel" aria-labelledby="v-pills-day-3-tab">
              	<div class="row p-4">
						   		<div class="col-md-7">
						   			<h3 class="mb-4">review</h3>
						   			<!-- 리뷰 에이작스 사용 -->
						   			<div class="review">
								   		<div class="user-img" style="background-image: url()"></div>
								   		<div class="desc">
								   			<h4>
								   				<span class="text-left">구매자 아이디</span>
								   				<span class="text-right">후기 게시 날짜</span>
								   			</h4>
								   			<p class="star">
								   				<span>
								   					<i class="ion-ios-star-outline"></i>
								   					<i class="ion-ios-star-outline"></i>
								   					<i class="ion-ios-star-outline"></i>
								   					<i class="ion-ios-star-outline"></i>
								   					<i class="ion-ios-star-outline"></i>
							   					</span>
							   					<span class="text-right"><a href="#" class="reply"><i class="icon-reply"></i></a></span>
								   			</p>
								   			<p>리뷰</p>
								   		</div>
								   	</div>
						   		</div>
						   		<div class="col-md-4">
						   			<div class="rating-wrap">
							   			<h3 class="mb-4">Give a Review</h3>
							   			<!-- 리뷰 점수 -->
							   			<p class="star">
							   				<span>
							   					<i class="ion-ios-star-outline"></i>
							   					<i class="ion-ios-star-outline"></i>
							   					<i class="ion-ios-star-outline"></i>
							   					<i class="ion-ios-star-outline"></i>
							   					<i class="ion-ios-star-outline"></i>
							   					(98%)
						   					</span>
						   					<span>20 Reviews</span>
							   			</p>
							   		</div>
						   		</div>
						   	</div>
              </div>
            </div>
          </div>
        </div> --%>
    	</div>
	
	
</div>
<div class="row">
	<div style="background-color: #efefef; height:100px;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>