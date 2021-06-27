<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>My Bee</title>
</head>
<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#header{width:100%; min-height:120px;}
#head{height:54px;background-color: #dcdcdc; margin-top: 15px;}
#h-info{height:60px; background-color:#dcdcdc;}
#mybee{text-align:center; width:20%; height:100%; color:white; float:left; background-color: #FFC81E;}
#top{text-align:center; width:20%; height:50%; float:left; background-color: #FFEB5A; border:1px solid #dcdcdc;}
#bottom{text-align:center; width:20%; height:50%; float:left; border:1px solid #dcdcdc;}
#top-span{margin-left:30px;}
#container{
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
ul{list-style:none; padding-left:0px;}
#sidebar{float:left; width:20%; height:100%; border:1px solid #F4FFFF;}
#side-menu{margin-top:50px; margin-left:40px;}
#side-list{margin-top:20px; margin-bottom:30px;}
#main{float:left; width:80%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
	width: 960px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    margin: 0 auto;
    padding-left: 80px;
    padding-right: 100px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:100%;
 }
 #infoSection{height:100%;}
 #key_value_section{
 position:relative;
 margin-top:10px;
 }
#key_section{text-align: center; background-color: }
#key_value_section #key_section {
    position: absolute;
    width: 200px;
    height: 30px;
    line-height: 35px;
    font-size: 16px;
    font-family: NanumGothicBold;
}
#key_value_section #value_section {
    padding-left: 180px;
}
#info{
    width: 100%;
    box-sizing: border-box;
    height: 50px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
input:disabled {
    background-color: -internal-light-dark(rgba(239, 239, 239, 0.3), rgba(59, 59, 59, 0.3));
    border-color: rgba(118, 118, 118, 0.3);
}
#bottomSection{padding-top:50px; text-align:center;}
#button{text-align: center;}
#newPW {float:left; width:49%; margin-top: 10px; margin-right:2%;}
#confirmNewPW{width:49%; margin-top: 10px;}
p{text-align:center; color:red;}
#changePw{float:left;}
#withdrawMSG{float:left; padding-left:120px;}
#radioSection{font-size: 16px;}
#selectWithdrawMethod1{margin-right:50px;}
</style>
<script type="text/javascript">
function updateSellerVO(seller_no){
	var seller_no=seller_no;
	var seller_address1=document.getElementById("seller_address").value;
	var seller_address2=document.getElementById("seller_addressDetail").value;
	var seller_address=seller_address1+ seller_address2
	var seller_email=document.getElementById("seller_email").value;
	var bank_no=document.getElementById("bank_no").value;
	var seller_account=document.getElementById("seller_account").value;
	
	//AJAX 호출.....
	   var xmlhttp = new XMLHttpRequest();
	   
	   //호출 후 값을 받았을때... 처리 로직....
	   xmlhttp.onreadystatechange = function(){
	      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
	       alert("정보를 수정하였습니다.");
	      }
	   };
	   
	  	param="";
	   	param += "seller_address="+seller_address;
		param += "&seller_email="+seller_email;
		param += "&bank_no="+bank_no;
		param += "&seller_account="+seller_account; 
		param += "&seller_no="+seller_no;
	   
	   xmlhttp.open("post","./updateSellerInfo.do");
	   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	   xmlhttp.send(param);
}
</script>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller.jsp" flush="true"/>
	<div id="head">
		<div id="mybee"><h1>My Bee</h1></div>
	</div>
	<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<div id="wrapper">
			<h2>판매자정보수정</h2>
			<hr>
			<form action="">
			<div id="infoSection">
				<div id="key_value_section">
					<div id="key_section">판매자</div>
					<div id="value_section"><input class="form-control" type="text" id="seller_name" value="${sessionSeller.seller_name}" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">사업장주소</div>
					<div id="value_section"><input class="form-control"  type="text" id="seller_address" value="${sessionSeller.seller_address}" ></div>
					<div id="value_section"><input class="form-control"  type="text" id="seller_addressDetail" placeholder="상세주소" style="margin-top:10px;"></div><br>					
					<div id="value_section" align="left"><input type="button" class="btn btn-primary btn-sm" onclick="execDaumPostcode()" value="우편번호 찾기" style="margin-right:20px;"></div>
					<br>
				</div>
<!-- 주소 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
               document.getElementById('seller_address').value = data.zonecode+" "+roadAddr+" "+data.jibunAddress;

            }
        }).open();
    }
</script>
				<div id="key_value_section">
					<div id="key_section">판매자ID</div>
					<div id="value_section"><input class="form-control"  type="text" id="seller_id" name="seller_id" value="${sessionSeller.seller_id}" disabled></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">판매자PW</div>
					<div id="value_section"><input class="form-control"  type="password" id="seller_pw" name="seller_pw" placeholder="현재 비밀번호를 입력해주세요."></div>
					<div id="key_section"></div>
					<div id="value_section"><input class="form-control"  type="password" id="newPW" name="newPw" placeholder="변경할 암호"></div>
					<div id="key_section"></div>
					<div id="value_section"><input class="form-control"  type="password" id="confirmNewPW" placeholder="확인"></div>
					<br><div align="center" id="value_section">
					<button class="btn btn-primary btn-sm" id="changePw">암호변경</button><p>암호를 확인해주세요.</p>
					</div>
				</div>
				<br>
				<div id="key_value_section">
					<div id="key_section">이메일주소</div>
					<div id="value_section"><input class="form-control"  type="text" id="seller_email" name="seller_email" value="${sessionSeller.seller_email}" ></div>
				</div>
				<div id="key_value_section">
					<div id="key_section">휴대폰번호</div>
					<div id="value_section"><input class="form-control"  type="text" id="info" value="${sessionSeller.seller_phone}" disabled="disabled"></div>
					<!-- <br>
					<div id="value_section" align="left"><button class="btn btn-primary btn-sm">번호변경</butt on></div>-->
				</div>
				<br>
				<div id="key_value_section">
					<div id="key_section" style="line-height: 24px;">정산대금수령방법</div>
					<div id="value_section" style="padding-left: 200px;"><div id="radioSection"><input type="radio" id="" name="selectWithdrawMethod" onclick="" value="1" checked="checked"><span id=selectWithdrawMethod1>정산대금입금계좌</span><input type="radio" id="" name="selectWithdrawMethod" onclick="" value="2" >판매자충전금</div></div>		
					<br>
					<div id="key_section">정산대금입금계좌</div>
					<div id="value_section">
					<select id="bank_no" style="float:left; width:21%;" class="form-control">	
						<%-- <c:forEach items="${bankList}" var="bankList">
							<c:if test="${sessionSeller.bank_no eq bankList.bankVO.bank_no}"> --%>
							<option value="국민은행" selected="selected">국민은행</option>
						<%-- 	</c:if>
							<option value="국민은행" >국민은행</option>
						</c:forEach>						 --%>
					</select>
					</div>
					<div id="value_section"><input class="form-control"  type="text" id="seller_account" name="seller_account" value="${sellerVO.seller_account}" style="width:70%;"></div>
				</div>
			</div>
			<br>
				<div id="button">
				<button type="button" class="btn btn-primary" onclick="updateSellerVO(${sellerVO.seller_no })">수정하기</button>
				<button type="button" class="btn btn-info">뒤로가기</button>
				</div>
				<div id="bottomSection">
					<p id="withdrawMSG">탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.</p><button type="button" class="btn btn-dark btn-sm">회원탈퇴</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>