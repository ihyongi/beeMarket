<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<title>Bee ProductDetail</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/productDetailPage.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	var sessionCustomer = null;
	var product_no = ${allDataList.productVO.product_no};
	
	
	//모달 관련
	var myModal = null;
	var myInput = null;
	
	
	function getSessionCustomerNo(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionCustomerNo = obj.customer_no;
			}
		};
		
		xmlhttp.open("get","../customer/getSessionCustomerNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	var myModal = null;
	
	function addCart(){
		var productdetail_no = document.getElementById("productdetail_no").value;
		var productdetail_count = document.getElementById("productdetail_count").value;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				myModal.show();
			}
		};
		
		xmlhttp.open("post","../order/addCart.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("productdetail_no="+productdetail_no+"&productdetail_count="+productdetail_count);
	}
	
	
	function cart() {
		var of= document.getElementById("orderForm");
		of.action = "../order/cartPage.do";
		of.submit();
	}
	function order() {
		var of = document.getElementById("orderForm");
		of.action = "../order/orderPage.do";
		of.submit();
	}

	
	
	
	//후기...(로그인이 아니라 제품을 구매시 orderVO에 구매 내역이 담겨 있을때)
	function writeComment(){
		if(sessionCustomerNo == null){
			alert("로그인을 하셔야 후기를 남길수 있습니다.");
			return;
		}
		
		var commentValue = document.getElementById("commentInput").value;
		
		if(commentValue == ""){
			alert("후기 내용을 작성해 주세요!");
			return;
		}
		var starValue = document.querySelector('input[name="rating"]:checked').value;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
			    refreshComment();
			    commentInput.value = "";
			    commentInput.focus();
			}
		};
		
		xmlhttp.open("post","../product/writeComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("product_no=" + product_no + "&productcomment_content=" + commentValue + "&productcomment_star=" + starValue);
	}
	
	function refreshComment(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    var commentListBox = document.getElementById("commentListBox");
			    
			    commentListBox.innerHTML = "";
			    
			    for(var data of obj){
			    	
			    	var rowBox = document.createElement("div");
			    	rowBox.setAttribute("class","row");
			    	rowBox.setAttribute("style","margin:0px;");
			    	
			    	var idBox = document.createElement("div");
			    	idBox.setAttribute("class","col-3 customer_id");
			    	idBox.innerText = data.customerVO.customer_id;
			    	rowBox.appendChild(idBox);
			    	
			    	var contentBox = document.createElement("div");
			    	contentBox.setAttribute("class","col-7 commentContent");
			    	contentBox.innerText = data.productCommentVO.productcomment_content;
			    	rowBox.appendChild(contentBox);
			    	
			    	var starBox = document.createElement("div");
			    	starBox.setAttribute("class","col-2 star-ratings");
			    	rowBox.appendChild(starBox);
			    	
			    	var starpoint = (data.productCommentVO.productcomment_star * 20) + 1.5;
			    	
			    	var starInBox = document.createElement("div");
			    	starInBox.setAttribute("class","star-ratings-fill space-x-2 text-lg");
			    	/* starInBox.setAttribute("style","width: "+starpoint+"'%'"); */
			    	starBox.appendChild(starInBox);
			    	
			    	for(var i=0; i<data.productCommentVO.productcomment_star; i++){
				    	var spanBox = document.createElement("span");
				    	spanBox.innerText = "★";
				    	starInBox.appendChild(spanBox);
			    	}
			    	
			    	var dateBox = document.createElement("div");
			    	dateBox.setAttribute("class","col commentDate");
			    	dateBox.setAttribute("style","text-align:right;");
			    	
			    	var d = new Date(data.productCommentVO.productcomment_writedate);
			    	
			    	dateBox.innerText = d.getFullYear() + "." + (d.getMonth() + 1) + "." + d.getDate();
			    	rowBox.appendChild(dateBox);
			    	
			    	/* if(sessionCustomerNo == sessionCustomer.customer_no){
				    	var deleteBox = document.createElement("div");
				    	deleteBox.setAttribute("class","col-1 bg-danger");
				    	deleteBox.innerText = "삭제";
				    	deleteBox.setAttribute("onclick" , "removeComment("+data.commentVO.comment_no+")");
				    	rowBox.appendChild(deleteBox);
			    	} */
			    	
			    	commentListBox.appendChild(rowBox);
			    	
			    }
			    
			}
		};
		
		xmlhttp.open("get","../product/getCommentList.do?product_no=" + product_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();		
	}

	function init(){
		getSessionCustomerNo();
		refreshComment();
		
		setInterval(refreshComment,5000);
		
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
		
	}
	
	
	/* 차트뽑기 */
	google.charts.load('current', {'packages':['corechart']});
	/* google.charts.setOnLoadCallback(drawChart); */
	
	function drawChart() {
		
		var product_no = ${allDataList.productVO.product_no};
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				TotalLength = [];
				titleList = [];
				
				/* 구매자 성비 차트 */
				var GenderDataKeys = [];
				var GenderDataValues = [];
				var the_gender_datas = [];
				
				GenderDataKeys.push("CUSTOMER_GENDER");
				GenderDataKeys.push("ORDERCNT");
				the_gender_datas.push(GenderDataKeys);
				for (var i = 0; i < obj.genderData.length; i++) {
					
					GenderDataValues.push(obj.genderData[i].CUSTOMER_GENDER);
					GenderDataValues.push(obj.genderData[i].ORDERCNT);
					the_gender_datas.push(GenderDataValues);
					
					GenderDataValues = [];
					
				}
				TotalLength.push(the_gender_datas);
				titleList.push("구매자 성별 비율");
				
				
				/* 구매자 연령대 차트 */
				var ageDataKeys = [];
				var ageDataValues = [];
				var the_age_datas = [];
				
				ageDataKeys.push("CUSTOMER_BIRTH");
				ageDataKeys.push("ORDERCNT");
				the_age_datas.push(ageDataKeys);
				for (var i = 0; i < obj.ageData.length; i++) {
					
					ageDataValues.push(obj.ageData[i].CUSTOMER_BIRTH);
					ageDataValues.push(obj.ageData[i].ORDERCNT);
					the_age_datas.push(ageDataValues);
					
					ageDataValues = [];
					
				}
				TotalLength.push(the_age_datas);
				titleList.push("구매자 연령대 비율");
				
				
				for (var i = 0; i < TotalLength.length; i++) {
					
					var data = google.visualization.arrayToDataTable(TotalLength[i]);
					
					var options = {
					  title: titleList[i]
					};
					
					var piecharts = document.getElementById('piecharts');
					var piechart = document.createElement("div");
					piecharts.appendChild(piechart);
					piechart.setAttribute("class","piechart");
					/* piechart.setAttribute("style","width: 900px; height: 500px;"); */
					
					var chart = new google.visualization.PieChart(document.getElementsByClassName('piechart')[i]);
				
					chart.draw(data, options);
					
				}
				
			}
		};
		
		xmlhttp.open("post","../product/getOrderGenderChartData.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("product_no="+product_no);
	}
	
	function likeProduct() {
		
		var product_no = ${allDataList.productVO.product_no};
		var customer_no = document.getElementById("customer_session");
		
		if (customer_no != null) {
			
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				    //var obj = JSON.parse(xmlhttp.responseText);
				    
				    alert('찜 성공');
				    
				    var heart = document.getElementById("heart");
				    heart.innerHTML = "";
				    
				    var heartFill = document.createElement("i");
				    heartFill.setAttribute("class","bi bi-heart-fill");
				    heartFill.setAttribute("onclick","deleteLikeProduct()");
				    heart.appendChild(heartFill);
				    
				}
			};
			
			xmlhttp.open("post","../customer/likeProduct.do" , true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("product_no="+product_no+"&customer_no="+customer_no);
			
		}
		
	}
	
	function deleteLikeProduct() {
		
		var product_no = ${allDataList.productVO.product_no};
		var customer_no = document.getElementById("customer_session");
		
		if (customer_no != null) {
		
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				    //var obj = JSON.parse(xmlhttp.responseText);
				    
				    alert('찜 취소 성공');
				    
				    var heart = document.getElementById("heart");
				    heart.innerHTML = "";
				    
				    var heartNonFill = document.createElement("i");
				    heartNonFill.setAttribute("class","bi bi-heart");
				    heartNonFill.setAttribute("onclick","likeProduct()");
				    heart.appendChild(heartNonFill);
				    
				}
			};
			
			xmlhttp.open("post","../customer/deleteLikeProduct.do" , true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("product_no="+product_no+"&customer_no="+customer_no);
			
		}
		
	}
	
</script>
<script src="https://code.iconify.design/1/1.0.7/iconify.min.js"></script>
</head>
<body onload="init()">

	<input type="hidden" id="customer_session" value="${ sessionCustomer.customer_no }">

	<div class="container">

		<div class="row">
			<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
		</div>

		<div class="row mb-2 category_area">
			<div class="col">${ allDataList.category_name } > ${ allDataList.categoryDetailVO.categorydetail_name }</div>
		</div>
		
		<div class="row mb-5">
		
			<div class="col-5">
				<div class="row" style="height: 500px; width: 500px;">
					<div class="col changeImageArea">
						<img id="image_container" class="img-fluid" src="/upload_files/${ allDataList.productImageList[0].productimage_location }" alt="">
					</div>
				</div>
				<div class="row">
					<div class="col" style="text-align: center;">
						<c:forEach items="${ allDataList.productImageList }" var="imageData">
							<img src="/upload_files/${ imageData.productimage_location }" class="imagePrev imageHover" onclick="change_img(this)" alt="">
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col" style="margin-left: 30px;">
				<div class="row mb-1">
					<div class="col title">
						${ allDataList.productVO.product_title }
					</div>
				</div>
				<div class="row">
					<div class="col name">${ allDataList.productVO.product_name }</div>
				</div>
				
				<div class="row">
					<div class="col price">
						<c:if test="${!empty allDataList.discountVO}">
							<span id=discountPrice>
								최저가 ${ allDataList.discountVO.discount_price } 원~ 
								${ allDataList.minimumPrice }원
							</span>
						</c:if>
					
						<c:if test="${empty allDataList.discountVO}">
							<span id=discountPrice>${ allDataList.minimumPrice }원</span>
						</c:if>
					</div>
				</div>
				
				<div class="row">
					<hr style="border-top-width: 0.5px; border-top-color: #919191; border-top-style: solid; border-bottom-width: 0.5px; border-bottom-color: #919191; border-bottom-style: solid; margin: 15px;">
				</div>
				<div class="row mb-5" style="height: 142px;">
					<div class="col content">${ allDataList.productVO.product_content }</div>
				</div>
				
				<form id="orderForm">
					<div class="row mb-3">
						<div class="col-6">
							<div class="row mb-2">
								<div class="col">옵션선택</div>
							</div>
							<div class="row">
								<div class="col">
									<select class="form-select" id="productdetail_no" name="productdetail_no" style="width: 646px;">
										<option selected>상품 옵션을 선택하세요</option>
										<c:forEach items="${allDataList2}" var="allDataList">
											<c:if test="${allDataList.productWarehouseVO.productwarehouse_pluscount ne 0}">
												<c:if test="${allDataList.productDetailVO.discount_status eq 'N'}">
													<option value="${allDataList.productDetailVO.productdetail_no}">
														${allDataList.productDetailVO.productdetail_option }/
														${allDataList.productDetailVO.productdetail_price }원/
														재고${allDataList.productWarehouseVO.productwarehouse_pluscount }개
													</option>                                       
												</c:if>
											</c:if>
											<c:if test="${allDataList.productWarehouseVO.productwarehouse_pluscount ne 0}">
												<c:if test="${allDataList.productDetailVO.discount_status eq 'Y'}">
													<option value="${allDataList.productDetailVO.productdetail_no}">
														${allDataList.productDetailVO.productdetail_option }/
														${allDataList.discountVO.discount_price }원/
														재고${allDataList.productWarehouseVO.productwarehouse_pluscount }개
													</option>                                       
												</c:if>
											</c:if>
											<c:if test="${allDataList.productWarehouseVO.productwarehouse_pluscount eq 0}">
												<c:if test="${allDataList.productDetailVO.discount_status eq 'N'}">
													<option value="${allDataList.productDetailVO.productdetail_no}" disabled="disabled">
														${allDataList.productDetailVO.productdetail_option }/
														${allDataList.productDetailVO.productdetail_price }원/
														재고${allDataList.productWarehouseVO.productwarehouse_pluscount }개
													</option>
												</c:if>
											</c:if>
											<c:if test="${allDataList.productWarehouseVO.productwarehouse_pluscount eq 0}">
												<c:if test="${allDataList.productDetailVO.discount_status eq 'Y'}">
													<option value="${allDataList.productDetailVO.productdetail_no}" disabled="disabled">
														${allDataList.productDetailVO.productdetail_option }/
														${allDataList.discountVO.discount_price }원/
														재고${allDataList.productWarehouseVO.productwarehouse_pluscount }개
													</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="row mb-2">
								<div class="col">주문수량</div>
							</div>
							<div class="row">
								<div class="col">
									<input type="number" id="productdetail_count" name="productdetail_count" class="quantity form-control input-number" value="1" min="1" max="100"> 
									<span class="input-group-btn ml-2">
										<button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
											<i class="ion-ios-add"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>	
					
					<c:if test="${ sessionCustomer != null}">
					<div class="row">
						<div class="col" style="text-align: right;">
							<div id="heart" style="display: inline; height: 38px;">
								<c:choose>
									<c:when test="${ myLikeCount == 1 }">
										<i class="bi bi-heart-fill" onclick="deleteLikeProduct()"></i>
									</c:when>
									<c:otherwise>
										<i class="bi bi-heart" onclick="likeProduct()"></i>
									</c:otherwise>
								</c:choose>
							</div>
							<!-- 장바구니 Modal 버튼 -->
							<button type="button" onclick="addCart()" class="btn btn-warning">
								장바구니
							</button>
							<button onclick="order()" class="btn btn-warning">
								구매하기
							</button>
						</div>
					</div>	
						<!-- Modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">
											Add to Cart
										</h5>
										<button type="button" class="btn-close"
											onclick="myModal.hide();"></button>
									</div>
									<div class="modal-body">선택하신 옵션의 상품이 장바구니에 담겼습니다.</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">계속 둘러보기</button>
										<button type="button" onclick="cart()" class="btn btn-primary">장바구니 페이지로 이동</button>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</form>
			</div><!-- 상품 정보 표시하는 부분 div 끝 -->
		
		</div><!-- 상품 이미지영역, 정보 표기영역 감싸는 row 끝 -->
		
		

		<ul class="nav nav-tabs mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="pills-home-tab"
					data-bs-toggle="pill" data-bs-target="#pills-home" type="button"
					role="tab" aria-controls="pills-home" aria-selected="true">Description</button>
			</li>
			<li class="nav-tabs" role="presentation">
				<button class="nav-link" id="pills-profile-tab"
					data-bs-toggle="pill" data-bs-target="#pills-profile"
					type="button" role="tab" aria-controls="pills-profile"
					aria-selected="false">Manufacturer</button>
			</li>
			<li class="nav-tabs" role="presentation">
				<button class="nav-link" id="pills-contact-tab"
					data-bs-toggle="pill" data-bs-target="#pills-contact"
					type="button" role="tab" aria-controls="pills-contact"
					aria-selected="false">Reviews</button>
					
			</li>
			<li class="nav-tabs" role="presentation">
				<button class="nav-link" id="pills-numbers-tab"
					data-bs-toggle="pill" data-bs-target="#pills-numbers"
					type="button" role="tab" aria-controls="pills-numbers"
					aria-selected="false" onclick="drawChart()">Numbers</button>
					
			</li>
		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home"
				role="tabpanel" aria-labelledby="pills-home-tab">
				<div class="col" style="padding-left: 50px; padding-right: 50px; padding-top: 40px;">
				<h3 class="mb-4" style="color: #fcc92f; font-weight: bold;">${ allDataList.productVO.product_name }</h3>
				<p>${ allDataList.productVO.product_content }</p>
				</div>
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel"
				aria-labelledby="pills-profile-tab">
				<div class="col" style="padding-left: 50px; padding-right: 50px; padding-top: 40px;">
				<h3 class="mb-4" style="color: #fcc92f; font-weight: bold;">판매자</h3>
				<p></p>
				</div>
			</div>
			<div class="tab-pane fade" id="pills-contact" role="tabpanel"
				aria-labelledby="pills-contact-tab">
				<div class="row p-4">
					<div class="col" style="padding-left: 50px; padding-right: 50px;">
						<h3 class="mb-4" style="color: #fcc92f; font-weight: bold;" >Review</h3>

						<!-- 리뷰 에이작스 사용 -->
						<div class="review">
							<div class="user-img" style="background-image: url()"></div>
							
								<div class="row desc" style="border-bottom: 1px solid #fcc92f;">
				
									<div class="col-3">
										<h4>
											<span>아이디</span>
										</h4>
									</div>
									<div class="col-7">
										<h4>
											<span>후기</span>
										</h4>
									</div>
									<div class="col-2" style="text-align: right;">
										<h4>
											<span>등록일</span>
										</h4>
									</div>
								</div>
								<div id="commentListBox">
								<div class="row">
									<div class="col-3 customer_id">아이디</div>
									<div class="col-7 commentContent">후기</div>
									<div class="col-2 commentDate">등록일</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
				</div>

			</div>
			<div class="tab-pane fade" id="pills-numbers" role="tabpanel"
				aria-labelledby="pills-numbers-tab">
				<div class="col" style="padding-left: 50px; padding-right: 50px; padding-top: 40px;">
					<h3 class="mb-4" style="color: #fcc92f; font-weight: bold;" >구매자 통계</h3>
				<div id="piecharts"></div>
				</div>
			</div>
		</div>
		
	</div>

	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
	</div>
	
	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
	crossorigin="anonymous">
</script>
<script type="text/javascript">
	//이미지 콘테이너에 하나 담기
	var container = document.getElementById("image_container");
	function change_img(image){
		container.src = image.src;
	}
</script>
</body>
</html>