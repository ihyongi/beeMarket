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

.card{
	border: none;
}

</style>

<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");

	
	var cancelModal = null;
	var refundModal = null;
	var changeModal = null;
	var cancelConfirmModal= null;
	var changeConfirmModal= null;
	var refundConfirmModal= null;
	
	
	
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
	
	//취소
	function cancelStatus(order_no,detail_price){
		var cancelOrderNo=order_no;
		var price=detail_price;
		var customerName = '${sessionCustomer.customer_name}';
		
		var orderBox = document.getElementById("cancelOrderStatus");
		orderBox.innerHTML="";
		
		var div1Box = document.createElement("div");
		div1Box.setAttribute("class","col-5");
		div1Box.innerHTML = '고객명 : '+customerName;
		orderBox.appendChild(div1Box);
		
		var div2Box = document.createElement("div");
		div2Box.setAttribute("class","col-3");
		div2Box.innerHTML = '주문번호 : '+cancelOrderNo;
		orderBox.appendChild(div2Box);
		var hiddenBox = document.createElement("div");
		hiddenBox.setAttribute("class","row");
		hiddenBox.setAttribute("id","order_no");
		hiddenBox.setAttribute("style","display:none");
		hiddenBox.innerHTML=cancelOrderNo;
		div2Box.appendChild(hiddenBox);
		
		var div3Box = document.createElement("div");
		div3Box.setAttribute("class","col-4");
		div3Box.innerHTML = '결제금액 : '+price;
		orderBox.appendChild(div3Box);
		
		var cancelButtonBox = document.getElementById("cancelButton");
		cancelButtonBox.setAttribute("onclick","cancelOk()")
		
		cancelModal.show();
	}
	
	//0604
	function cancelOk(){
		var orderNO = document.getElementById("order_no").innerHTML;
		var description = document.getElementById("commentInput").value;
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				alert("취소처리가 완료되었습니다.");
				cancelModal.hide();
			}
		};
		
		xmlhttp.open("post","../customer/cancelOrder.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNO+"&cancel_description="+description);
	}
	
	//반품
	function refundStatus(order_no,detail_price){
		var refundOrderNo=order_no;
		var price=detail_price;
		var customerName = '${sessionCustomer.customer_name}';
		
		var orderBox = document.getElementById("refundOrderStatus");
		orderBox.innerHTML="";
		
		var div1Box = document.createElement("div");
		div1Box.setAttribute("class","col-5");
		div1Box.innerHTML = '고객명 : '+customerName;
		orderBox.appendChild(div1Box);
		
		var div2Box = document.createElement("div");
		div2Box.setAttribute("class","col-3");
		div2Box.innerHTML = '주문번호 : '+refundOrderNo;
		orderBox.appendChild(div2Box);
		var hiddenBox = document.createElement("div");
		hiddenBox.setAttribute("class","row");
		hiddenBox.setAttribute("id","order_no");
		hiddenBox.setAttribute("style","display:none");
		hiddenBox.innerHTML=refundOrderNo;
		div2Box.appendChild(hiddenBox);
		
		var div3Box = document.createElement("div");
		div3Box.setAttribute("class","col-4");
		div3Box.innerHTML = '결제금액 : '+price;
		orderBox.appendChild(div3Box);
		
		
		refundModal.show();
	}

	//0604
	function refundOk(){
		var orderNO = document.getElementById("order_no").innerHTML;
		var description = document.getElementById("refundCommentInput").value;
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				alert("반품신청이 완료되었습니다.");
				refundModal.hide();
			}
		};
		
		xmlhttp.open("post","../customer/refundOrder.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNO+"&refund_description="+description);
	}
	
	//교환
	function changeStatus(order_no, price, product_no, productdetail_option) {
		var changOrderNo = order_no;
		var customerName = '${sessionCustomer.customer_name}';
		var price = price;
		var productNo = product_no;
		var detailOption = productdetail_option;
		
		var orderBox = document.getElementById("changeOrderStatus");
		orderBox.innerHTML="";
		
		var div1Box = document.createElement("div");
		div1Box.setAttribute("class","col-5");
		div1Box.innerHTML = '고객명 : '+customerName;
		orderBox.appendChild(div1Box);
		
		var div2Box = document.createElement("div");
		div2Box.setAttribute("class","col-3");
		div2Box.innerHTML = '주문번호 : '+changOrderNo;
		var orderNoInput = document.createElement("input");
		orderNoInput.setAttribute("type","hidden");
		orderNoInput.setAttribute("id","orderNoInput");
		orderNoInput.setAttribute("value",changOrderNo);
		div2Box.appendChild(orderNoInput);
		orderBox.appendChild(div2Box);
		
		var hiddenBox = document.createElement("div");
		hiddenBox.setAttribute("class","row");
		hiddenBox.setAttribute("id","order_no");
		hiddenBox.setAttribute("style","display:none");
		hiddenBox.innerHTML=changOrderNo;
		div2Box.appendChild(hiddenBox);
		
		var div3Box = document.createElement("div");
		div3Box.setAttribute("class","col-4");
		div3Box.innerHTML = '결제금액 : '+price;
		orderBox.appendChild(div3Box);
	
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var div4Box = document.createElement("select");
					div4Box.setAttribute("style","width: auto");
				for(changeDetailList of obj.changeDetailList){			
					var div4BoxOption = document.createElement("option");
					if(changeDetailList.productWarehouseVO.productwarehouse_pluscount==0){
						div4BoxOption.setAttribute("disabled","disabled");
					}
					div4BoxOption.setAttribute("id","change_productdetail_no");
					div4BoxOption.setAttribute("value",changeDetailList.productDetailVO.productdetail_no);
					div4BoxOption.innerHTML='옵션 : '+changeDetailList.productDetailVO.productdetail_option;
					div4Box.appendChild(div4BoxOption);
				}
				orderBox.appendChild(div4Box);
				
				changeModal.show();
			}
		};
		xmlhttp.open("get","../customer/changeDetailList.do?product_no="+productNo , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
		
	}
	
	function changeOk(){
		var orderNO = document.getElementById("orderNoInput").value;
		var description = document.getElementById("changeCommentInput").value;
		var productdetailNo = document.getElementById("change_productdetail_no").value;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				alert("교환신청이 완료되었습니다.");
				refundModal.hide();
			}
		};
		
		xmlhttp.open("post","../customer/changeOrder.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNO+"&change_description="+description+"&change_productdetail_no="+productdetailNo);
	}
	//내역 모달 보여주는 펑션
	function cancelConfirmModalOpen(order_no){
		var orderNo = order_no;
		var order_no = document.getElementById("Corder_no");
		var customer_id = document.getElementById("Ccustomer_id");
		var product_name = document.getElementById("Cproduct_name");
		var productdetail_option = document.getElementById("Cproductdetail_option");
		var cancel_description = document.getElementById("cancel_description");
		var cancel_applyDate = document.getElementById("cancel_applyDate");
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				order_no.setAttribute("value", obj.orderVO.order_no);
				customer_id.setAttribute("value", obj.customerVO.customer_id);
				product_name.setAttribute("value", obj.productVO.product_name);
				productdetail_option.setAttribute("value", obj.productDetailVO.productdetail_option);
				cancel_description.innerText=obj.cancelVO.cancel_description;
				cancel_applyDate.setAttribute("value", obj.cancelVO.cancel_applyDate);
				alert("취소 내역입니다.");
				cancelConfirmModal.show()
			}
		};
		
		xmlhttp.open("post","cancelHistory.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNo);
	}
	
	function changeConfirmModalOpen(order_no){
		var orderNo = order_no;
		var order_no = document.getElementById("CHorder_no");
		var customer_id = document.getElementById("CHcustomer_id");
		var product_name = document.getElementById("CHproduct_name");
		var productdetail_option = document.getElementById("CHproductdetail_option");
		var change_description = document.getElementById("change_description");
		var change_addCost = document.getElementById("change_addCost");
		var change_applyDate = document.getElementById("change_applyDate");
		var change_authDate = document.getElementById("change_authDate");
		var Afproductdetail_option = document.getElementById("Afproductdetail_option");
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				order_no.setAttribute("value", obj.orderVO.order_no);
				customer_id.setAttribute("value", obj.customerVO.customer_id);
				product_name.setAttribute("value", obj.productVO.product_name);
				productdetail_option.setAttribute("value", obj.productDetailVO.productdetail_option);
				Afproductdetail_option.setAttribute("value", obj.AfProductDetailOption.productdetail_option);
				change_description.innerText=obj.changeVO.change_description;
				change_addCost.setAttribute("value", obj.changeVO.change_addCost);
				change_applyDate.setAttribute("value", obj.changeVO.change_applyDate);
				change_authDate.setAttribute("value", obj.changeVO.change_authDate);
				alert("교환 신청 내역입니다.");
				changeConfirmModal.show();
			}
		};
		
		xmlhttp.open("post","changeHistory.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNo);
		
	}
	
	function refundConfirmModalOpen(order_no){
		var orderNo = order_no;
		var order_no = document.getElementById("Rorder_no");
		var customer_id = document.getElementById("Rcustomer_id");
		var product_name = document.getElementById("Rproduct_name");
		var productdetail_option = document.getElementById("Rproductdetail_option");
		var refund_description = document.getElementById("refund_description");
		var refund_addCost = document.getElementById("refund_addCost");
		var refund_applyDate = document.getElementById("refund_applyDate");
		var refund_authDate = document.getElementById("refund_authDate");
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				order_no.setAttribute("value", obj.refundVO.order_no);
				customer_id.setAttribute("value", obj.customerVO.customer_id);
				product_name.setAttribute("value", obj.productVO.product_name);
				productdetail_option.setAttribute("value", obj.productDetailVO.productdetail_option);
				refund_description.innerText=obj.refundVO.refund_description;
				refund_addCost.setAttribute("value", obj.refundVO.refund_addCost);
				refund_applyDate.setAttribute("value", obj.refundVO.refund_applyDate);
				refund_authDate.setAttribute("value", obj.refundVO.refund_authDate);
				alert("환불 신청 내역입니다.");
				refundConfirmModal.show();
			}
		};
		
		xmlhttp.open("post","refundHistory.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("order_no="+orderNo);
		
		
	}
	
	function init(){
		getSessionCustomerNo();
		cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
		refundModal = new bootstrap.Modal(document.getElementById('refundModal'));
		changeModal = new bootstrap.Modal(document.getElementById('changeModal'));
		cancelConfirmModal = new bootstrap.Modal(document.getElementById('cancelConfirmModal'));
		changeConfirmModal = new bootstrap.Modal(document.getElementById('changeConfirmModal'));
		refundConfirmModal = new bootstrap.Modal(document.getElementById('refundConfirmModal'));
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
		
		<!-- 주문 내역 조회 -->
		<div class="orderList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mt-3 mb-5">
				<div class="col-7" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">취소/반품/교환</div>
				<div class="col-5">
					<div class="row border border-3 border-warning" style="height: 45px;">
						<form class="d-flex" action="../customer/orderSearchList.do">
							<div class="col-4" style="height:45px; line-height: 45px; text-align: center;">
								<select class="form-control" name="orderSelect" id="orderSelect" style="border:0px;">
									<option value="status">주문상태</option>
								</select>
							</div>
							<div class="col-7">
								<input class="form-control me-2 inputAppearance" 
									type="search" name="search_word"
									placeholder="Search" aria-label="Search" style="margin:0; padding:0; border: none; position: relative; top:6px;">
								<!-- <textarea style="height: 40px; align-content: center;"></textarea> -->
							</div>
							<div class="col-1" style="text-align: right; height:45px; line-height: 16px;">
								<button class="btn bi bi-search" onclick="searchSort()" style="font-size: 23px; color: #fcc92f; padding: 0; margin: 0 0 0 10px;"></button>
							</div>
						</form>
					</div>
				</div>
			</div>
			
			<!-- 주문상품 리스트 출력 -->
			<c:forEach items="${ myPageData }" var="data">
			<div class="row mb-3" style="width: 880px; padding-left: 20px;">
				<div class="col">
					<div class="row" style="border: 2px solid #f2f2f2; border-radius: 10px;">
						<div class="col">
							
							<div class="row" style="height: 166px;">
								<div class="card col" style="margin-bottom:10px; margin-top: 10px; border: 0px;">
									<div class="row g-0">
										<div class="col-2 md-4 img-thumbnail" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'" 
											style="background-image: url('/upload_files/${ data.productImageVO.productimage_location }'); background-repeat: no-repeat; background-size: cover; background-position: center; border:0px; height:145px;">
										</div>
										<div class="col md-6">
											<div class="row" style="color: #5b5b5b; font-size: 18px; font-weight: bold; text-align: left; padding-left: 30px;" onclick="location.href='${pageContext.request.contextPath }/product/productDetailPage.do?product_no=${data.productVO.product_no }'">
												${data.productVO.product_name }	
											</div>
											<hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
											<div class="row">
											<div class="col">
												<div class="row" style="padding-left: 21px;">
													<p style="padding-bottom: 7px; margin-bottom: 0px;">주문번호 <small class="text-muted">${data.orderVO.order_no }</small></p>
													<p style="padding-bottom: 7px; margin-bottom: 0px;">결제금액 <small class="text-muted">${data.productDetailVO.productdetail_price }원</small></p>
													<p style="padding-bottom: 7px; margin-bottom: 0px;">주문상태 <small class="text-muted">${data.orderStatusVO.order_status_name }</small></p>
												</div>
											</div>
										
											<div class="col-5" style="text-align: right">
												<div class="card-body">
													<div class="row">
														<c:choose>
															<c:when test="${data.orderVO.order_status_no == 1}">
																<button class="btn btn-outline-warning" onclick="cancelStatus(${data.orderVO.order_no }, ${data.productDetailVO.productdetail_price })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">취소</button>
															</c:when>
															<c:otherwise>
															<c:if test="${data.orderVO.order_status_no == 6}"> <!-- 결제취소내역 -->
																<button class="btn btn-outline-warning" onclick="cancelConfirmModalOpen(${data.orderVO.order_no })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">신청내역</button>
															</c:if>
															<c:if test="${data.orderVO.order_status_no == 7 || data.orderVO.order_status_no == 9 || data.orderVO.order_status_no == 11 || data.orderVO.order_status_no == 13}"> <!-- 교환진행 -->
																<button class="btn btn-outline-warning" onclick="changeConfirmModalOpen(${data.orderVO.order_no })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">신청내역</button>
															</c:if>
															<c:if test="${data.orderVO.order_status_no == 8 || data.orderVO.order_status_no == 10 || data.orderVO.order_status_no == 12 || data.orderVO.order_status_no == 13}"> <!-- 반품진행 -->
																<button class="btn btn-outline-warning" onclick="refundConfirmModalOpen(${data.orderVO.order_no })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">신청내역</button>
															</c:if>
															<c:if test="${data.orderVO.order_status_no == 4}"><!-- 배송완료상태 -->
																<button class="btn btn-outline-warning" onclick="refundStatus(${data.orderVO.order_no }, ${data.productDetailVO.productdetail_price })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">반품</button>
																<button class="btn btn-outline-warning" onclick="changeStatus(${data.orderVO.order_no }, ${data.productDetailVO.productdetail_price }, ${data.productVO.product_no })" style="width: 100px; height: 40px; display: inline; margin-left: 20px;">교환</button>
															</c:if>
															</c:otherwise>
														</c:choose>
													</div>
													<div class="row mt-2">
														
													</div>
												</div>
											</div>
										</div>												
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			
		</div>
		</div>
	<!-- 콘테이너 끝 -->
	<!-- 취소 Modal -->
		<div class="modal fade" id="cancelModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							취소 접수 가이드
						</h5>
						<button type="button" class="btn-close"
							onclick="cancelModal.hide();"></button>
					</div>
					<div class="modal-body">

							<div style="border: 1px solid #fcc92f;">
								<form>
									<div class="row mb-3"></div>
									<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">취소 정보</h4>
									<hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
									<div class="row" id="cancelOrderStatus" style="font-size: 15px; padding-left: 10px; text-align: left;">
									</div>
									<div class="row mt-2 mb-3">
										<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 30px;">사유작성</h4>
										<div class="col-1"></div>
										<div class="col">
										<textarea id="commentInput" class="form-control" style="resize: none; border: solid; border-width: thin;"></textarea>
										</div>
										<div class="col-1"></div>
									</div>
								</form>
							</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" id="cancelButton" class="btn btn-warning">접수 신청</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 반품 Modal -->
		<div class="modal fade" id="refundModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							반품 접수 가이드
						</h5>
						<button type="button" class="btn-close"
							onclick="refundModal.hide();"></button>
					</div>
					<div class="modal-body">
							<div style="border: 1px solid #fcc92f;">
								<form>
									<div class="row mb-3"></div>
									<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">반품 정보</h4>
									<hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
									<div class="row" id="refundOrderStatus" style="font-size: 15px; padding-left: 15px; text-align: left;">
									</div>
									<div class="row mt-2 mb-3">
										<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 30px;">사유작성</h4>
										<div class="col-1"></div>
										<div class="col">
										<textarea id="refundCommentInput" class="form-control" style="resize: none; border: solid; border-width: thin;"></textarea>
										</div>
										<div class="col-1"></div>
									</div>
								</form>
							</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" onclick="refundOk()" class="btn btn-warning">접수 신청</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 교환 Modal -->
		<div class="modal fade" id="changeModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							교환 접수 가이드
						</h5>
						<button type="button" class="btn-close"
							onclick="changeModal.hide();"></button>
					</div>
					<div class="modal-body">

							<div style="border: 1px solid #fcc92f;">
								<form>
									<div class="row mb-3"></div>
									<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">교환 정보</h4>
									<hr class="one" style="margin-bottom: 10px; margin-top: 10px; color: #fcc92f;">
									<div class="row" id="changeOrderStatus" style="font-size: 15px; padding-left: 15px; text-align: left;">
									</div>
									<div class="row mt-2 mb-3">
										
									</div>
									
									<div class="row mt-2 mb-3">
										<h4 style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 30px;">사유작성</h4>
										<div class="col-1"></div>
										<div class="col">
										<textarea id="changeCommentInput" class="form-control" style="resize: none; border: solid; border-width: thin;"></textarea>
										</div>
										<div class="col-1"></div>
									</div>
								</form>
							</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" onclick="changeOk()" class="btn btn-warning">접수 신청</button>
					</div>
				</div>
			</div>
		</div>
	<!-- 0605 내역 -->
		<!-- 취소신청내역 Modal -->
		<div class="modal fade" id="cancelConfirmModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							결제취소 신청내역
						</h5>
						<button type="button" class="btn-close"
							onclick="cancelConfirmModal.hide();"></button>
					</div>
					<div class="modal-body">
							<div>
									<div id="wrapper">
										<div id="key-value_section">
											<div id="key_section">주문번호</div>
											<div id=value_section><input class="form-control" id="Corder_no" name="order_no" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">구매자ID</div>
											<div id=value_section><input class="form-control" id="Ccustomer_id" name="customer_id" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">상품명</div>
											<div id=value_section><input class="form-control" id="Cproduct_name" name="product_name" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">상품옵션</div>
											<div id=value_section><input class="form-control" id="Cproductdetail_option" name="productdetail_option" value="" readOnly></div>
										</div>
										취소사유<br>
										<textarea class="form-control" id="cancel_description" name="cancel_description" style="width:100%; height:300px;" disabled></textarea><br>
										신청일<br>
										<input class="form-control" id="cancel_applyDate" name="cancel_applyDate" value="" readOnly><br>
										</div>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 교환신청내역 Modal -->
		<div class="modal fade" id="changeConfirmModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							교환 신청내역
						</h5>
						<button type="button" class="btn-close"
							onclick="changeConfirmModal.hide();"></button>
					</div>
					<div class="modal-body">

							<div>
								<div id="wrapper">
										<div id="key-value_section">
											<div id="key_section">주문번호</div>
											<div id=value_section><input class="form-control" id="CHorder_no" name="order_no" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">구매자ID</div>
											<div id=value_section><input class="form-control" id="CHcustomer_id" name="customer_id" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">상품명</div>
											<div id=value_section><input class="form-control" id="CHproduct_name" name="product_name" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">기존옵션</div>
											<div id=value_section><input class="form-control" id="CHproductdetail_option" name="productdetail_option" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">변경옵션</div>
											<div id=value_section><input class="form-control" id="Afproductdetail_option" name="Afproductdetail_option" value="" readOnly></div>
										</div>
										교환사유<br>
										<textarea class="form-control" id="change_description" name="change_description" style="width:100%; height:300px;" disabled></textarea><br>
										추가비용<br>
										<input class="form-control" id="change_addCost" name="change_addCost" value="" readOnly><br>
										신청일<br>
										<input class="form-control" id="change_applyDate" name="change_applyDate" value="" readOnly><br>
										승인일<br>
										<input class="form-control" id="change_authDate" name="change_authDate" value="" readOnly><br>
										</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 반품신청내역 Modal -->
		<div class="modal fade" id="refundConfirmModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
							반품 신청내역
						</h5>
						<button type="button" class="btn-close"
							onclick="refundConfirmModal.hide();"></button>
					</div>
					<div class="modal-body">
								<div>
									<div id="wrapper">
										<div id="key-value_section">
											<div id="key_section">주문번호</div>
											<div id=value_section><input class="form-control" id="Rorder_no" name="order_no" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">구매자ID</div>
											<div id=value_section><input class="form-control" id="Rcustomer_id" name="customer_id" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">상품명</div>
											<div id=value_section><input class="form-control" id="Rproduct_name" name="product_name" value="" readOnly></div>
										</div>
										<div id="key-value_section">
											<div id="key_section">상품옵션</div>
											<div id=value_section><input class="form-control" id="Rproductdetail_option" name="productdetail_option" value="" readOnly></div>
										</div>
										환불사유<br>
										<textarea class="form-control" id="refund_description" name="refund_description" style="width:100%; height:300px;" disabled></textarea><br>
										추가비용<br>
										<input class="form-control" id="refund_addCost" name="refund_addCost" value="" readOnly><br>
										신청일<br>
										<input class="form-control" id="refund_applyDate" name="refund_applyDate" value="" readOnly><br>
										승인일<br>
										<input class="form-control" id="refund_authDate" name="refund_authDate" value="" readOnly><br>
										</div>
								</div>
					</div>
				</div>
			</div>
		</div>
</div>

<div class="row" style="height: 100px;"></div>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>