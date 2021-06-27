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
<title>myDeliveryPage</title>
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
	color: #BDB76B;
}

a:hover{
	text-decoration: blink !important;
	color: #fcc92f;
}

.card{
	border: none;
}

</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var sessionCustomer = null;
	var myModal = null;
	var deleteModal = null;
	
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
	
	function addDelivery(){
		myModal.show();
	}
	
	function addMyDelivery(){
		
		var address_number =  document.getElementById('customer_address').value;
		
		var address_location1 = document.getElementById('customer_addressLocation').value;
		var address_detail = document.getElementById('customer_addressDetail').value;
		var address_location = address_location1 + address_detail;
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				alert("배송지 추가가 완료되었습니다.");
			    myModal.hide();
			    window.location.reload();
			}
		};
		
		xmlhttp.open("post","../customer/addDelivery.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("address_number=" + address_number + "&address_location=" + address_location);
	}
	
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('customer_address').value = data.zonecode;
               document.getElementById('customer_addressLocation').value = roadAddr+" "+data.jibunAddress;
            }
        }).open();
    }
	
	function deleteAddress(address_no){
		var addressNO = address_no;
		
		var okButton = document.getElementById("deleteButton");
		okButton.setAttribute("onclick",'deleteOK('+addressNO+')');
		okButton.setAttribute("class","btn btn-warning");
		
		deleteModal.show();
		
	}
	
	function deleteOK(address_no){
		var addressNO = address_no;
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				alert("배송지 삭제가 완료되었습니다.");
				window.location.reload();
				deleteModal.hide();
			}
		};
		
		xmlhttp.open("post","../customer/deleteDelivery.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("address_no=" + addressNO);
	}
	function init(){
		getSessionCustomerNo();
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
		deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
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
		<!-- 배송지 조회 -->
		<div class="deliveryList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mt-3 mb-4">
				<div class="col-7" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">배송지관리</div>
				<div class="col-5"></div>
			</div>
			
			<!-- 주문상품 리스트 출력 -->
			<c:forEach items="${ myDeliveryData}" var="data" varStatus="status">
			<div class="row mb-3">
				<div class="col">
					<div class="row" style="border: 2px solid #fcc92f;">
						<div class="col">
							<div class="row mb-1" style="color: #5b5b5b; font-size: 20px; font-weight:bold; text-align: left; padding-top: 10px; padding-left: 20px;">
								${ sessionCustomer.customer_name }
							</div>
							<div class="row mb-1" style="padding-left: 20px; text-align: center;">
							<c:if test="${status.first }">
								<span class="rounded-pill" style="width:70px; border: 1px solid #FA8258; color:#FA8258 ; text-align:center; font-size: 10px; padding-top: 0px; padding-right: 0px; padding-left: 0px;">기본배송지</span>
							</c:if>
							</div>
							<div class="row mb-1" style="padding-left: 20px;">
								<div class="col" style="margin-bottom:10px; padding-left: 0px; border: 0px;">
									<div class="row g-0">
										
										<div class="mb-1" >
											<p class="mb-1">우편번호 <small class="text-muted">${data.addressListVO.address_number }</small></p>
											<p class="mb-1">배송지 <small class="text-muted">${data.addressListVO.address_location }</small></p>
											<p class="mb-1">전화번호 <small class="text-muted">${sessionCustomer.customer_phone}</small></p>
										</div>
										<button class="btn btn-outline-warning" onclick="" style="width: 70px; height: 40px; display: inline; padding-right: 10px; padding-left: 10px;">수정</button>
										<c:if test="${!status.first }">
											<button class="btn btn-outline-warning" onclick="deleteAddress(${data.addressListVO.address_no })" style="width: 70px; height: 40px; display: inline; padding-right: 10px; padding-left: 10px; margin-left: 10px;">삭제</button>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			<div class="row mb-5" onclick="addDelivery()" style="color: #5b5b5b; font-size: 20px; font-weight:bold; text-align: left; border: 2px solid #fcc92f; padding-left: 20px; padding-top: 10px; padding-bottom: 10px; text-align: center;">
				+ 배송지 추가
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
								배송지 추가하기
							</h5>
							<button type="button" class="btn-close"
								onclick="myModal.hide();"></button>
						</div>
						<div class="modal-body">
							<div id="key_value_section">
								<div id="key_section">구매자</div>
								<div id="value_section"><input class="form-control" type="text" id="customer_name" value="${sessionCustomer.customer_name}" disabled></div>
							</div>
							<div id="key_value_section">
								<div id="key_section">배송지</div>
								<div id="value_section"><input class="form-control"  type="text" id="customer_address" placeholder="우편번호" value="" disabled></div>
								<div id="value_section"><input class="form-control"  type="text" id="customer_addressLocation" placeholder="주소지" style="margin-top:10px;" disabled></div><br>	
								<div id="value_section"><input class="form-control"  type="text" id="customer_addressDetail" placeholder="상세주소" style="margin-top:10px;"></div><br>					
								<div id="value_section" align="left"><input type="button" class="btn btn-warning btn-sm" onclick="execDaumPostcode()" value="우편번호 찾기" style="margin-right:20px;"></div>
								<br>
							</div>
						
		
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning"
								data-bs-dismiss="modal">취소</button>
							<button type="button" onclick="addMyDelivery()" class="btn btn-warning">배송지추가</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 콘테이너 끝 -->
	<!-- 배송지 삭제 확인 Modal -->
			<div class="modal fade" id="deleteModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left; padding-top: 10px; padding-left: 20px;">
								배송지 삭제 확인
							</h5>
							<button type="button" class="btn-close"
								onclick="deleteModal.hide();"></button>
						</div>
						<div class="modal-body">
							배송지 정보를 삭제하시겠습니까? 삭제하실 경우 추가를 통해 다시 배송지리스트에 등록이 가능합니다.
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning"
								data-bs-dismiss="modal">취소</button>
							<button type="button" id="deleteButton" class="btn btn-warning">배송지삭제</button>
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