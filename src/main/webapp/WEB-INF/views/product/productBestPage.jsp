<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/bestProductPage.css">
<script type="text/javascript">
	function selectCategory() {
		
		var c = document.getElementById("category_area");
		
		var categoryIndexNo = c.selectedIndex;
		var selectedOption = c.options[categoryIndexNo];
		var categoryNo = selectedOption.value;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var detailBox = document.getElementById("categoryDetail_area");
				detailBox.innerHTML="";
				
				for(categoryDetailList of obj.categoryDetailList){
					var cDetailOption = document.createElement("option");
					cDetailOption.setAttribute("value", categoryDetailList.categoryDetailVO.categorydetail_no);
					cDetailOption.setAttribute("name", "categorydetail_no");
					cDetailOption.setAttribute("id", "categorydetail_no");
					cDetailOption.innerText = categoryDetailList.categoryDetailVO.categorydetail_name;
					detailBox.appendChild(cDetailOption);
				}
			
			}
		};
		
		xmlhttp.open("get","./updateCategoryDetailByNo.do?category_no=" + categoryNo, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	function updateBestProductsByCategory() {
		
		var categoryData = document.getElementById("category_area");
		var categoryNo = categoryData.options[categoryData.selectedIndex].value;
		
		var categoryDetailData = document.getElementById("categoryDetail_area");
		var categoryDetailNo = categoryDetailData.options[categoryDetailData.selectedIndex].value;
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var cardAreaBox = document.getElementById("card_area");
				cardAreaBox.innerHTML = "";
			    
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
					img.setAttribute("src","/upload_files/" + data.productImageVO[0].productimage_location );
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
					inner_row3.innerText = data.productVO.product_title;
					inner_col.appendChild(inner_row3);
					
					cardAreaBox.appendChild(cardArea);
					
			    }
			
			}
		};
		
		xmlhttp.open("post","./updateBestProductsByCategory.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("category_no="+categoryNo+"&categorydetail_no="+categoryDetailNo);
	}
</script>
</head>
<body onload="selectCategory()">
<div class="container" >
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>
	
	<div class="row mb-2">
		<div class="col todayBest" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">BEST PRODUCTS</div>
		<div class="col" style="text-align: right;">
			<select id="category_area" class="category_area" onchange="selectCategory()">
				<c:forEach items="${ getCategoryList }" var="cate">
					<option id="selectedCategory" value="${ cate.categoryVO.category_no }">${ cate.categoryVO.category_name }</option>
				</c:forEach>
			</select>
			<select id="categoryDetail_area" class="categoryDetail_area"></select>
			<button type="button" class="selectButton" onclick="updateBestProductsByCategory()">적용하기</button>
		</div>
	</div>	
	
	<div class="row">
		<!-- 카테고리별 리스트 출력 -->
		<div class="col">
			<div class="row" id="card_area">
				<c:forEach items="${ bestProductDataList }" var="data">
					<div class="col-3 cardSector" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${ data.productVO.product_no }'">
						<div class="row cardImageArea">
							<img class="cardImage" alt="" src="/upload_files/${ data.productImageVO[0].productimage_location }">
						</div>
						<div class="row cardContentsArea">
							<div class="col">
								<div class="row cardTitle">
									${data.productVO.product_name }
								</div>
								<div class="row mb-2 cardPrice">
								    ${ data.minimumPrice } 원 ~
								</div>
								<div class="row cardName">
									${ data.productVO.product_title}
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div> <!-- class="container" 끝 -->

<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>

<!-- 부트스트랩 자바스크립트 코드 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>

</body>
</html>