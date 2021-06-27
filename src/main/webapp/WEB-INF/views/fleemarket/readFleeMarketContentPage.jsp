<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공동상품 읽기</title>

<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<title>Bee ProductDetail</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/productDetailPage.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

var oTbl;
//Row 추가
function insRow() {
  oTbl = document.getElementById("addTable");
  var oRow = oTbl.insertRow();
  oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
  var oCell = oRow.insertCell();

  //삽입될 Form Tag
  var frmTag = "<td><input type=text name='fleemarketdetail_option' placeholder='색상, 사이즈'></td>";
  frmTag += "<td><input type=button value='삭제' onClick='removeRow()'></td>";
  oCell.innerHTML = frmTag;
}
//Row 삭제dddd
function removeRow() {
  oTbl.deleteRow(oTbl.clickedRowIndex);
}






//로그인
var sessionCustomerNo = null;
var fleemarket_no = ${data.fleeMarketVO.fleemarket_no};




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
	
	xmlhttp.open("get","${pageContext.request.contextPath}/customer/getSessionCustomerNo.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();		
	
	
}



	function applicant(){
		if(sessionCustomerNo == null){
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
			    
			    refreshApplicant();
			    
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/fleemarket/applicant.do?fleemarket_no=" +fleemarket_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	
		
	}
	
	function fleeMarketSubmit() {
		var orderCount = document.getElementById("orderCount").value;
		var detailCount = document.getElementsByName("fleemarketdetail_count")[0].value;
		var itemqty = document.getElementById("fleemarket_itemqty").value;
		var form1 = document.getElementById("form1");
		if( parseInt(detailCount, 10) > (parseInt(itemqty, 10)-parseInt(orderCount, 10)) ){
			alert("재고가 "+(parseInt(itemqty, 10)-parseInt(orderCount, 10))+"개 남았습니다");
			return;
		}
		
		if( parseInt(detailCount, 10) > 100){
			alert("100까지만 입력가능합니다.");
			return;
		}
		
		form1.submit();
		
			
	}
	
	function refreshApplicant(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    var applicantButton = document.getElementById("applicantButton");
			    var fleeMarketbtn = document.getElementById("fleeMarketbtn");
			    if(obj.myApplicantCount > 0){
			    	applicantButton.innerText = "해제";
			    	
			    	var inputBtn = document.createElement("input");
			    	inputBtn.setAttribute("type","button");
			    	inputBtn.setAttribute("value","공동구매");
			    	inputBtn.setAttribute("id","fleeMarketButton");
			    	inputBtn.setAttribute("onclick","fleeMarketSubmit()");
			    	fleeMarketbtn.appendChild(inputBtn);
			    	
			    }else{
			    	applicantButton.innerText = "신청";
			    	fleeMarketbtn.innerHTML = "";
			    }
			    
			   
			    
			    var applicantCountBox = document.getElementById("applicantCountBox");
			    applicantCountBox.innerText = obj.applicantTotalCount;
			    
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/fleemarket/getApplicantData.do?fleemarket_no=" +fleemarket_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
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
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fleemarket/writeComment.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("fleemarket_no=" + fleemarket_no + "&comment_content=" + commentValue+"&fleemarket_score=" + starValue);
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
			    	
			    	var idBox = document.createElement("div");
			    	idBox.setAttribute("class","col-3 customer_id");
			    	idBox.innerText = data.customerVO.customer_name+"("+data.customerVO.customer_id+")";
			    	rowBox.appendChild(idBox);
			    	
			    	var contentBox = document.createElement("div");
			    	contentBox.setAttribute("class","col-5 commentContent");
			    	contentBox.innerText = data.fleeMarketCommentVO.comment_content;
			    	rowBox.appendChild(contentBox);
			    	
			    	var starBox = document.createElement("div");
			    	starBox.setAttribute("class","col-2 star-ratings");
			    	rowBox.appendChild(starBox);
			    	
			    	var starpoint = (data.fleeMarketCommentVO.fleemarket_score * 20) + 1.5;
			    	
			    	var starInBox = document.createElement("div");
			    	starInBox.setAttribute("class","star-ratings-fill space-x-2 text-lg");
			    	/* starInBox.setAttribute("style","width: "+starpoint+"'%'"); */
			    	starBox.appendChild(starInBox);
			    	
			    	for(var i=0; i<data.fleeMarketCommentVO.fleemarket_score; i++){
				    	var spanBox = document.createElement("span");
				    	spanBox.innerText = "★";
				    	starInBox.appendChild(spanBox);
			    	}
			    	
			    	var dateBox = document.createElement("div");
			    	dateBox.setAttribute("class","col-2 commentDate");
			    	
			    	var d = new Date(data.fleeMarketCommentVO.comment_date);
			    	
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
		xmlhttp.open("get","${pageContext.request.contextPath}/fleemarket/getCommentList.do?fleemarket_no="+fleemarket_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	/* function removeComment(commentNo){
		
		
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				refreshComment();
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/fleemarket/deleteComment.do?comment_no=" + commentNo, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	 */
		
	function init(){
		getSessionCustomerNo();
		refreshApplicant();
		refreshComment();
		
		setInterval(refreshComment, 5000);
		
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));

	}
		
	function drawChart() {
			
			var fleemarket_no = ${data.fleeMarketVO.fleemarket_no};
			
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
			
			xmlhttp.open("post","${pageContext.request.contextPath}/fleemarket/getOrderGenderChartData.do" , true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("fleemarket_no="+fleemarket_no);
		}

	
</script>

</head>

<!-- jquery-부트스트랩js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<body onload="init()">
   <header>
      <!-- 네비게이션.. -->
      <jsp:include page="/WEB-INF/views/commons/headerflee.jsp"></jsp:include>
   </header>
   
   
<!-- <script type="text/javascript">
	jQuery(document).ready(function(){
		$(".modal").show();
	});
	function closeModal(){
		$('#modalclose').jide();
	};

</script> -->
   <div class="modal" id="modalclose">
   		<div class="modal content"></div>
  		<h2>!!경고!!</h2>
   		<p>재고가 ${data.fleeMarketVO.fleemarket_itemqty - data.orderCount} 개 남았습니다</p>
   		<button type="button" class="modal_close" style="width: 50%; color:red;" id="modal_close">X</button>
   </div>
   
   
	<!-- 글 내용 -->
<div class="container">
	<form id="form1" method = "post" action = "${pageContext.request.contextPath }/fleeorder/fleeCartProcess.do">
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
			<div class="col-6">
				<h2 class="text-center">${data.fleeMarketVO.fleemarket_title }</h2><hr>
				<font>${data.fleeMarketVO.fleemarket_name}</font><hr>
				<font>시작일 <fmt:formatDate value="${data.fleeMarketVO.fleemarket_startdate }" pattern="yyyy년MM월dd일"></fmt:formatDate></font><hr>
				<font>마감일 <fmt:formatDate value="${data.fleeMarketVO.fleemarket_enddate }" pattern="yyyy년MM월dd일"></fmt:formatDate></font><hr>
				<font class="text-center"><fmt:formatNumber value="${data.fleeMarketVO.fleemarket_price}" pattern="###,###,###"/>원</font><hr>
				<font class="text-center" size="3em">신청수  <span id="applicantCountBox"></span> </font><hr>
				<select name="fleemarketdetail_no">
				<c:forEach items="${data.fleeMarketDetailVO}" var="fleeMarketDetail">
					<option value="${fleeMarketDetail.fleemarketdetail_no}" >${fleeMarketDetail.fleemarketdetail_option}</option>
				</c:forEach>
				</select>			
				<input type="number" name="fleemarketdetail_count" style="border : 1px solid #fbdf1a" value="1" min="1" max="100" >
				<input type="hidden" id="fleemarket_itemqty" value="${data.fleeMarketVO.fleemarket_itemqty }">
				<span id="fleeMarketbtn"></span>
				<input type="hidden" id="orderCount" value="${data.orderCount }">
				
			</div>
		</div>
		</form>
		<hr>			
	
			<div class="col-1"></div>
			
	
		<div class="row">
		<div class="col"></div>
		<div class="col-10 text-end">
	
	
	
			<!-- 신청 -->
			<span id="applicantButton" onclick="applicant()"><button></button></span>				
			<span id="applicantCountBox"><button></button></span>
			
			<c:if test="${!empty sessionCustomer && sessionCustomer.customer_no == data.customerVO.customer_no}">
			<a href="${pageContext.request.contextPath }/freeboard/deleteContentProcess.do?freeboard_no=${data.freeboardVO.freeboard_no}">삭제</a>
			<a href="${pageContext.request.contextPath }/freeboard/updateContentPage.do?freeboard_no=${data.freeboardVO.freeboard_no}">수정</a>
		</c:if>
			</div>
			<div class="col"></div>
		</div>
		<hr>
		
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

		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home"
				role="tabpanel" aria-labelledby="pills-home-tab">
				<h3 class="mb-4">${data.fleeMarketVO.fleemarket_name }</h3>
				<p></p>
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel"
				aria-labelledby="pills-profile-tab">
				<h3 class="mb-4">판매자</h3>
				<p>판매자 정보</p>
			</div>
			<div class="tab-pane fade" id="pills-contact" role="tabpanel"
				aria-labelledby="pills-contact-tab">
				<div class="row p-4">
					<div class="col-md-7">
						<h3 class="mb-4">review</h3>

						<!-- 리뷰 에이작스 사용 -->
						<div class="review">
							<div class="user-img" style="background-image: url()"></div>
							
								<div class="row desc">
				
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
									<div class="col-2">
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
		
					<!-- 구매후기 작성은 order테이블에 담긴 고객들만 가능 -->
					<div class="col-md-4" style="border: solid">
						<div class="rating-wrap">
							<h3 class="mb-4">Give a Review</h3>
							<!-- 리뷰 점수 -->
							<div class="star-rating space-x-4 mx-auto">
								<input type="radio" id="5-stars" name="rating" value="5" v-model="rating"/>
								<label for="5-stars" class="star pr-4">★</label>
								<input type="radio" id="4-stars" name="rating" value="4" v-model="rating"/>
								<label for="4-stars" class="star pr-4">★</label>
								<input type="radio" id="3-stars" name="rating" value="3" v-model="rating"/>
								<label for="3-stars" class="star pr-4">★</label>
								<input type="radio" id="2-stars" name="rating" value="2" v-model="rating"/>
								<label for="2-stars" class="star pr-4">★</label>
								<input type="radio" id="1-stars" name="rating" value="1" v-model="rating"/>
								<label for="1-stars" class="star pr-4">★</label>
							</div>
							<form>
								<textarea id="commentInput" rows="3" cols="30" style="resize: none; border: solid;"></textarea>
								<input type="button" class="btn-warning" value="후기 작성"
									onclick="writeComment()">
							</form>
						</div>
					</div>
				</div>
	
			</div>
	
		</div>
	
	</div>
	
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
	</div>
	
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
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