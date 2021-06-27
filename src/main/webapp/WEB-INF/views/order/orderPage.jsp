<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<title>orderPage</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/orderPage.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

var customer_no = ${sessionCustomer.customer_no};
var purchaseModal = null;
var myModal = null;
var deliveryModal = null;

function delivery() {
	
	var customer_no = ${sessionCustomer.customer_no};
	var deliveryBox = document.getElementById("deliveryBox");
	
	deliveryBox.innerHTML = "";
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
			var obj = JSON.parse(xmlhttp.responseText);
			
			for(addressData of obj.addressData){
				
				var div = document.createElement("div");
				div.setAttribute("class", "row");
				deliveryBox.appendChild(div);
				
				var div1 = document.createElement("div");
				div1.setAttribute("class", "col-3");
				div1.innerText = addressData.addressListVO.address_number;
				div.appendChild(div1);
				
				var div2 = document.createElement("div");
				div2.setAttribute("class", "col");
				div2.innerText = addressData.addressListVO.address_location;
				div.appendChild(div2);
				
				var div3 = document.createElement("div");
				div3.setAttribute("class", "col-1");
				div.appendChild(div3);
				
				var checkBox = document.createElement("input");
				checkBox.setAttribute("type", "checkbox");
				checkBox.setAttribute("name", "checkbox");
				checkBox.setAttribute("onclick", "selectAddress(this)");
				checkBox.setAttribute("value", addressData.addressListVO.address_no);
				div3.appendChild(checkBox);
				
			}
			
		}
	};

	xmlhttp.open("post", "./getCustomerDeliveryProcess.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("customer_no="+customer_no);
	}
	function addDelivery(){
		myModal.show();
		deliveryModal.hide();
		
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
			    delivery();
			    deliveryModal.show();
				
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
	
	
	function selectAddress(check) {
	
	if(check.checked == true){
		
		var chkval = check.value;
		var putCheckedAddress = document.getElementById("putCheckedAddress");
		
		putCheckedAddress.innerHTML = "";
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
	
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				var add = document.createElement("div");
				add.setAttribute("id", "address_no");
				add.setAttribute("name", "address_no");
				add.setAttribute("value", chkval);
				add.innerText = obj.addressVO.address_location;
				putCheckedAddress.appendChild(add);
				
			}
		};
	
		xmlhttp.open("post", "./getAddressVOByAddNo.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("address_no="+chkval);
	}
	
}

function coupon() {
	
	var couponBox = document.getElementById("couponBox");
	
	couponBox.innerHTML = "";
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
			var obj = JSON.parse(xmlhttp.responseText);
			
			for(couponData of obj.couponData){
				
				var div = document.createElement("div");
				div.setAttribute("class", "row");
				couponBox.appendChild(div);
				
				var div1 = document.createElement("div");
				div1.setAttribute("class", "col-3");
				div1.innerText = couponData.couponVO.coupon_name;
				div.appendChild(div1);
				
				/* var div2 = document.createElement("div");
				div2.setAttribute("class", "col");
				div2.innerText = couponData.addressListVO.address_location;
				div.appendChild(div2); */
				
				var div3 = document.createElement("div");
				div3.setAttribute("class", "col-1");
				div.appendChild(div3);
				
				var checkBox = document.createElement("input");
				checkBox.setAttribute("type", "checkbox");
				checkBox.setAttribute("name", "checkbox");
				checkBox.setAttribute("onclick", "selectMyCoupon(this)");
				checkBox.setAttribute("value", couponData.myCouponVO.mycoupon_no);
				div3.appendChild(checkBox);
				
			}
			
		}
	};

	xmlhttp.open("post", "./getCustomerCouponListProcess.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("customer_no="+customer_no);
}

function selectMyCoupon(check) {
	
	if(check.checked == true){
		
		var chkval = check.value;
		var mycoupon_area = document.getElementById("mycoupon_area");
		
		mycoupon_area.innerHTML = "";
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
	
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				var obj = JSON.parse(xmlhttp.responseText);
				
				var add = document.createElement("div");
				add.setAttribute("id", "mycoupon_no");
				add.setAttribute("name", "mycoupon_no");
				add.setAttribute("value", chkval);
				add.innerText = obj.couponVO.coupon_name;
				mycoupon_area.appendChild(add);
				
			}
		};
	
		xmlhttp.open("post", "./getCouponVOByMyCouponNo.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mycoupon_no="+chkval);
	}
	
}

function purchaseForm() {
	
	var adressArea = document.getElementById("address_no");
	
	if (adressArea == null) {
		alert("배송지 선택은 필수 입력사항입니다.");
		return;
	}
	
	purchaseModal.show();
	
	var productdetail_no = ${orderData.productDetailVO.productdetail_no};
	var mycoupon_no = document.getElementById("mycoupon_area").getAttribute("value");
	
	if(mycoupon_no == null){
		mycoupon_no=parseInt(0);
	}else{
		mycoupon_no = document.getElementById("mycoupon_area").getAttribute("value");
	}
	
	var address_no = document.getElementById("address_no").getAttribute("value");
	var orderpayment_no= document.getElementById("orderpayment_no").value;
	var productdetail_count = ${orderData.productDetailCount};
	
	var param ="";
	param += "productdetail_no="+productdetail_no;
	param += "&mycoupon_no="+mycoupon_no;
	param += "&address_no="+address_no;
	param += "&orderpayment_no="+orderpayment_no; 
	param += "&order_count="+productdetail_count;
	param += "&customer_no="+customer_no;
	
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		   
		}
	};
	
	xmlhttp.open("post", "./orderProcess.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(param);

}
function init() {
	purchaseModal = new bootstrap.Modal(document.getElementById('purchaseModal'));
	myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
	deliveryModal = new bootstrap.Modal(document.getElementById('deliveryModal'));
}
</script>
</head>
<body onload="init()">
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
</div>

<div class="container">
	
	<div class="row mt-5 cartbar pb-2" style="border-bottom: 2px solid #5b5b5b;">
		<div class="col-4">주문/결제</div>
		<div class="col" style="text-align: right">01 장바구니 > <span style="color: #fccc0c">02 주문/결제</span> > 03 결제완료</div>
	</div>
	
	<div class="row rowMargin">
		<div class="col semiTitle">
			"${ orderData.productVO.product_name }" 상품을 주문합니다
		</div>
	</div>
	
	
	<div class="row">
		<div class="col tableTitle">
			구매자 정보
		</div>
	</div>
	<div class="row rowMargin">
		<div class="col">
			<div class="row">
				<div class="col-4 thStyle">이름</div>
				<div class="col tdStyle">${ sessionCustomer.customer_name }</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">이메일</div>
				<div class="col tdStyle">${ sessionCustomer.customer_email }</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">휴대폰 번호</div>
				<div class="col tdStyle">${ sessionCustomer.customer_phone }</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">
					<div class="row">
						<div class="col">
							배송주소
							<div class="modalbtnStyle" data-bs-toggle="modal" data-bs-target="#deliveryModal" onclick="delivery()">배송지선택</div>
						</div>
					</div>
				</div>
				<div class="col tdStyle">
					<input type="hidden" name="cus_address" id="cus_address" value="">
					<div id="putCheckedAddress"></div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col tableTitle">
			주문상품
		</div>
	</div>
	<div class="row mb-5">
		<div class="col">
			<table class="table">
				<tbody>
					<tr>
						<th scope="row">
						<th scope="row">상품이름</th>
						<th scope="row">개당가격</th>
						<th scope="row">주문개수</th>
						<th scope="row">총 가격</th>
					</tr>
					<tr>
						<td class="tdStyle" style="width: 200px;">
							<img class="productImagePrev" alt="" src="/upload_files/${ orderData.productImageVO.productimage_location }">
						</td>
						<td class="tdStyle">
							<div class="row product_name">
								${ orderData.productVO.product_name }
							</div>
							<div class="row">
								선택 옵션 - ${ orderData.productDetailVO.productdetail_option }
							</div>
						</td>
						<c:if test="${ orderData.productDetailVO.discount_status eq 'N' }">
							<td class="tdCenterStyle">${ orderData.productDetailVO.productdetail_price } 원</td>
						</c:if>
						<c:if test="${ orderData.productDetailVO.discount_status eq 'Y' }">
							<td class="tdCenterStyle">${ orderData.discountVO.discount_price } 원</td>
						</c:if>
						<td class="tdCenterStyle" >${ orderData.productDetailCount } 개</td>
						
						<c:if test="${ orderData.productDetailVO.discount_status eq 'N' }">
							<td class="tdCenterStyle">${ orderData.total_priceN } 원
								<input class="ttt1" type="hidden" value="${ orderData.productDetailVO.productdetail_no }">
								<input class="ttt2" type="hidden" value="${ orderData.productDetailCount }">
							</td>               
						</c:if>
						<c:if test="${ orderData.productDetailVO.discount_status eq 'Y' }">
							<td class="tdCenterStyle">${ orderData.total_priceY } 원
								<input class="ttt1" type="hidden" value="${ orderData.productDetailVO.productdetail_no }">
								<input class="ttt2" type="hidden" value="${ orderData.productDetailCount }">
							</td>
						</c:if>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div id="hidden"></div>
	
	
	<div class="row">
		<div class="col tableTitle">
			결제 정보
		</div>
	</div>
	<div class="row rowMargin">
		<div class="col">
			<div class="row">
				<div class="col-4 thStyle">주문상품 합계</div>
				<c:if test="${ orderData.productDetailVO.discount_status eq 'N' }">
					<div class="col tdStyle">${ orderData.total_priceN } 원</div>
				</c:if>
				<c:if test="${ orderData.productDetailVO.discount_status eq 'Y' }">
					<div class="col tdStyle">${ orderData.total_priceY } 원</div>
				</c:if>
			</div>
			<div class="row">
				<div class="col-4 thStyle">배송비</div>
				<div class="col tdStyle">2500 원</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">
					<div class="row">
						<div class="col">
							쿠폰 적용
							<div class="modalbtnStyle"  data-bs-toggle="modal" data-bs-target="#couponModal" onclick="coupon()">보유쿠폰확인</div>
						</div>
					</div>
				</div>
				<div class="col tdStyle">
					<div id="mycoupon_area"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">로얄젤리</div>
				<div class="col tdStyle">100 RJ</div>
			</div>
			<div class="row">
				<div class="col-4 thStyle">결제금액</div>
				<c:if test="${ orderData.productDetailVO.discount_status eq 'N' }">
					<div class="col tdStyle">${ orderData.delivery_priceN+2500 } 원</div>
				</c:if>
				<c:if test="${ orderData.productDetailVO.discount_status eq 'Y' }">
					<div class="col tdStyle">${ orderData.delivery_priceY+2500 } 원</div>
				</c:if>
			</div>
			<div class="row">
				<div class="col-4 thStyle">결제방법 선택하기</div>
				<div class="col tdStyle">
					<select id="orderpayment_no">
						<option name="orderpayment_no" value="1">카드</option>
						<option name="orderpayment_no" value="2">로얄젤리</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col" style="text-align: right;">
			<!-- Button trigger modal -->
			<button type="button" class="button" style="background-color: #fccc0c !important; border: none;" onclick="purchaseForm()">결제하기</button>
		</div>
	</div>
	
	<div class="row" style="height: 100px;"></div>
</div>
<!-- 콘테이너 끝 -->

<!-- Modal Area -->
<!-- Modal -->
<div class="modal fade" id="purchaseModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">주문완료</h5>
				<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
			</div>
			<div class="modal-body">상품 주문이 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" onclick="location.href='../product/productMainPage.do'">메인페이지로 돌아가기</button>
				<button type="button" class="btn btn-warning" onclick="location.href='../customer/myPageMain.do'">주문내역 확인하기</button>
			</div>
		</div>
	</div>
</div>

<!-- Scrollable modal -->
<div class="modal fade" id="deliveryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">배송지관리</h5>
				<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
			</div>
			<div class="modal-body col">
				<div class="row mb-3 text-center" style="padding-left: 12px; text-align: center;">배송지목록</div>
				<div  id="deliveryBox" class="row mb-5" style="padding-left: 12px;"></div>
				<div class="row mt-5" onclick="addDelivery()" style="width: 466px; margin: 0 auto; padding: 0;">
					<p class="col text-center" style="text-align: center; border: 1px solid #fccc0c; color: #fccc0c; font-size: 20px; font-weight: bold; cursor: pointer; padding: 7px 0 7px 0;">
						배송지 추가
					</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-dismiss="modal" aria-label="Close">배송지선택완료</button>
			</div>
		</div>
	</div>
</div>

<!-- 쿠폰적용 모달 -->
<!-- Scrollable modal -->
<div class="modal fade" id="couponModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">보유 쿠폰 관리</h5>
				<!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
			</div>
			<div class="modal-body col">
				<div class="row mb-3 text-center" style="padding-left: 12px; text-align: center;">보유쿠폰목록</div>
				<div  id="couponBox" class="row mb-5" style="padding-left: 12px;"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-dismiss="modal" aria-label="Close">쿠폰선택완료</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal Area - 끝 --> 
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
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>