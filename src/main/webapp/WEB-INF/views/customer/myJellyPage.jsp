<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
.container{
	width : 1200px;
	max-width: none !important;
}

a{
	text-decoration: none !important;
	margin: 0 !important; 
	padding: 0 !important;
}

a:hover{
	text-decoration: blink !important;
}
.tg  {border-color:#fcc92f;border-collapse:collapse;border-spacing:0;}
.tg td{border-color:#fcc92f;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:20px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:#fcc92f;border-style:solid;border-width:1px;border-top-color:#fcc92f;border-top-width:3px;font-family:Arial, sans-serif;font-size:20px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-c3ow{border-color:#fcc92f;text-align:center;vertical-align:top}
.tg .tg-zw9b{border-color:#fcc92f;background-color:#fff2cc;border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-0lax{border-color:#fcc92f;text-align:left; text-align:center; vertical-align:top}
</style>

<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	
	var jellyListModal = null;
	var jellyGiftModal = null;
	
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
	
	function jellyList(){
		jellyListModal.show();
	}
	
	function confrimButton(order_no){
		
		var orderNo=order_no;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				alert("구매확정 되었습니다^^ 감사합니다~");
				window.location.reload();
			}
		};
		
		xmlhttp.open("post","../order/updateConfirmStatus.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNo);
	}
	
	function jellyGift(){
		jellyGiftModal.show();
	}
	
	function giftOK(){
		var giftIDBox = document.getElementById("giftID");
		var giftValueBox = document.getElementById("giftValue");
		var inputId = giftIDBox.value;
		var giftValue = giftValueBox.value;
		
		if(giftIDBox.value == ""){
			alert("받으실 회원님의 ID를 작성해주세요.");
			giftIDBox.focus();
		}else{
			
			var confirmedId = false;
			
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
					var obj = JSON.parse(xmlhttp.responseText);
					//DOM 컨트롤.... 응용 많이 해야됨...
					if(obj.existId == true){
						
						confirmedId = true;
						
						giftProcess();
						
					}else{
						alert("받으실 분의 ID를 확인 부탁드립니다.");
						giftIDBox.value = "";
						giftIDBox.focus();
						confirmedId = false;
					}	
				}
			};
			
			xmlhttp.open("post","../customer/existId.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("customer_id="+inputId);
		}
	
	}
	
	function giftProcess(){
		var customerNO = ${sessionCustomer.customer_no};
		var giftIDBox = document.getElementById("giftID");
		var giftValueBox = document.getElementById("giftValue");
		var inputId = giftIDBox.value;
		var giftValue = giftValueBox.value;
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				alert("젤리 선물을 보냈습니다.");
				jellyGiftModal.hide();
				window.location.reload();
			}
		};
		
		xmlhttp.open("post","../customer/jellyGift.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("customer_no="+customerNO+"&point_minus="+giftValue+"&toCustomer_id="+inputId);
	}
	
	
	function init(){
		getSessionCustomerNo();
		jellyListModal = new bootstrap.Modal(document.getElementById('jellyListModal'));
		jellyGiftModal = new bootstrap.Modal(document.getElementById('jellyGiftModal'));
	}
	
	
</script>

</head>
<body onload="init()">

<div class="container">
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>

	<jsp:include page="/WEB-INF/views/commons/headerForCustomer.jsp"></jsp:include>
	<div class="row">
		<!-- 좌측네비바 -->
		<jsp:include page="/WEB-INF/views/commons/headerForCustomer+left.jsp"></jsp:include>
		
		<!-- 여기서부터는 마이페이지 내부의 여러 기능을 한페이지에서 구현 -->
	<div class="col" id="mainContainer">
		<!-- 포인트 관련 -->
		<div class="orderList">
			<!-- 로얄젤리 -->
			<div class="row mt-3 mb-5">
				<div class="col-3" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">로얄젤리</div>
				<div class="col"></div>
			</div>
			<div class="row mb-5">
				<table class="tg">
					<thead>
				  		<tr>
				    		<th class="tg-zw9b" rowspan="2">사용가능한 캐시<br>
				    			<span style="font-size: 30px;">
				    			
				    			${myJelly }원</span>
				    			
				    		</th>
				    		<th class="tg-zw9b">한 달 이내 소멸 예정 <span>0 원</span></th>
				  		</tr>
				  		<tr>
				    		<td class="tg-zw9b">예치금 <span style="text-align: right;">0원</span></td>
				  		</tr>
					</thead>
					<tbody>
				 		<tr>
				    		<td class="tg-c3ow" onclick="jellyList()" colspan="2"><img src="${ pageContext.request.contextPath }/resources/img/test.png"width="45" height="45" style="margin-right: 5px; position: relative; top: -5px;">로얄젤리 적립 및 사용내역</td>
				  		</tr>
					</tbody>
				</table>
			</div>
			<div class="row mt-3 mb-5">
				<div class="col-3" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">선물하기</div>
				<div class="col"></div>
			</div>
			<div class="row mb-3">
				<table class="tg">
					<thead>
						<tr>
					    	<th class="tg-0lax" onclick="jellyGift()"><img src="${ pageContext.request.contextPath }/resources/img/bee.png"width="45" height="45" style="margin-right: 5px; position: relative; top: -5px;">로얄젤리 선물하기</th>
					    	<th class="tg-0lax"><img src="${ pageContext.request.contextPath }/resources/img/honey.png"width="45" height="45" style="margin-right: 5px; position: relative; top: -5px;">로얄젤리 선물함(꿀단지)</th>
						</tr>
					</thead>
				</table>
			</div>
	
			<!-- Modal -->
			<div class="modal fade" id="jellyListModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
								로얄젤리 적립 및 사용내역
							</h5>
							<button type="button" class="btn-close"
								onclick="jellyListModal.hide();"></button>
						</div>
						<div class="modal-body">
							
							<c:forEach items="${myJellyData }" var="data">
							<hr class="one" style="height:3px; margin-bottom: 10px; margin-top: 0px; border-top:0px; color: #fcc92f;">
							<div class="row mb-3">
								<p class="card-text"><small class="text-muted"><fmt:formatDate value="${data.customerPointVO.point_updatedate}" pattern="yyyy.MM.dd" /></small></p>
								<p class="card-text">${data.customerPointDetailVO.pointdetail_name }
					
									<c:choose>
										<c:when test="${data.customerPointVO.point_plus == 0 }">
											-${data.customerPointVO.point_minus }
										</c:when>
										<c:otherwise>
											+${data.customerPointVO.point_plus }
										</c:otherwise>
									</c:choose>
								</p>
								<p class="card-text">point <small class="text-muted">당시 포인트</small></p>
							</div>
							<hr class="one" style="height:3px; margin-bottom: 0px; border-bottom:0px; margin-top: 10px; color: #fcc92f;">
							</c:forEach>
		
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning"
								data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
	
		</div>
	</div>
	<!-- 콘테이너 끝 -->
	<!-- 젤리 선물 Modal -->
	<div class="modal fade" id="jellyGiftModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
						로얄젤리 선물하기
					</h5>
					<button type="button" class="btn-close"
						onclick="jellyGiftModal.hide();"></button>
				</div>
				<div class="modal-body">
					<div style="border: 1px solid #fcc92f;">
						<form>
							<div class="row mb-3"></div>
							<h4 style="color: #5b5b5b; font-size: 15px; font-weight: bold; text-align: left; padding-top: 5px; padding-left: 20px;">선물하실 분</h4>
							<textarea id="giftID" class="form-control" style="resize: none; width:300px; height:40px; border: none; padding-left: 20px;" placeholder="선물하실 분의 ID를 입력해주세요."></textarea>
							<h4 style="color: #5b5b5b; font-size: 15px; font-weight: bold; text-align: left; padding-top: 5px; padding-left: 20px;">선물할 젤리</h4>
							<div class="input-group col-md-6 d-flex mb-3" style="width:300px; height:40px; padding-left: 20px;">
								<input type="number" id="giftValue"
									name="productdetail_count"
									class="quantity form-control input-number" value="1" min="1"
									max="${myJelly }"> 
								<span class="input-group-btn ml-2">
									<button type="button" class="quantity-right-plus btn"
										data-type="plus" data-field="">
										<i class="ion-ios-add"></i>
									</button>
								</span>
							</div>
	
							
						</form>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning"
						data-bs-dismiss="modal">취소</button>
					<button type="button" onclick="giftOK()" class="btn btn-warning">선물하기</button>
				</div>
			</div>
		</div>
	</div>
	
</div>

<div class="row" style="height: 100px;"></div>
</div>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>