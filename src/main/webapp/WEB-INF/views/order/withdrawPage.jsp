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
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
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
	margin-top:0;
	margin-left:0;
	width: 960px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    padding-left: 80px;
    padding-right: 80px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:100%;
 }
 #infoSection{height:100%;}
 #key_value_section{
 position:relative;
 }
#key_section{text-align: center; font-weight: bold; background-color: #dcdcdc;}
#key_value_section #key_section {
    position: absolute;
    width: 170px;
    height: 70px;
    line-height: 70px;
    font-size: 14px;
    font-family: NanumGothicBold;
    border: 1px solid #bebebe;
}
#key_value_section #value_section {
    padding-left: 180px;
    height:70px;
    border: 1px solid #bebebe;
    padding-top: 10px;
}

#info{
    width: 100%;
    box-sizing: border-box;
    height: 70px;
    border-radius: 4px;
    border: 1px solid #e1e1e1;
    font-family: NanumGothic;
    color: #333333;
    font-size: 14px;
    padding-left: 20px;
    padding-right: 20px;
}
input {
    height:45px;
    width:440px;
}
input:focus{outline:none;}
#bottomSection{padding-top:50px; text-align:right;}
#button{text-align: center;}
#buttonBox{text-align: center; margin-top:20px;}
#ment{margin-top:10px; font-size: 12px;}
#nick{color:#FFC81E; font-weight: bold;}
#valueSectionWrapper{border:1px solid #bebebe;}
#warning{color:red;}
</style>

<script type="text/javascript">
function showCash(){
	var cash_amount=document.getElementById("cash_amount").value;
	var withdraw_amount=document.getElementById("withdraw_amount").value;
	var afwithdraw_cash=document.getElementById("afwithdraw_cash");
	var afwithdraw_input=cash_amount-withdraw_amount;
	afwithdraw_cash.setAttribute("value",afwithdraw_input);
}
if(${!empty param.success}){
	alert("출금이 완료되었습니다.");
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
			<h2>출금하기</h2>
			<p id="ment">판매수수료 ${sellerWallet.sellerGradeVO.sellergrade_rate}%을 포함한 금액이 차감됩니다.</p>
			<c:if test="${!empty param.error}">
				<p id="warning">암호를 다시 확인해주세요.</p>
			</c:if>
			<form method="post" action="${pageContext.request.contextPath }/order/withdrawProcess.do">
			<div id="infoSection">
				<div id="valueSectionWrapper">
					<div id="key_value_section">
						<div id="key_section">보유캐시</div>
						<input type="hidden" id="wallet_no" name="wallet_no" value="${sellerWallet.sellerWalletVO.wallet_no}" >
						<div id="value_section"><input type="text" id="cash_amount" name="cash_amount" value="${sellerWallet.sellerWalletVO.cash_amount}" readonly style="width:100px;"><span style="color:red; width:50px;">Jelly</span></div>
					</div>
					<div id="key_value_section">
						<div id="key_section">계좌번호</div>
						<input type="hidden" id="bank_no" name="bank_no" value="${sellerWallet.bankVO.bank_no}">
						<div id="value_section"><input type="text" id="seller_account" name="seller_account" value="[${sellerWallet.bankVO.bank_name}]${sellerWallet.sellerVO.seller_account}" readonly></div>
					</div>
					<div id="key_value_section">
						<div id="key_section">출금금액</div>
						<div id="value_section"><input type="text" id="withdraw_amount" name="withdraw_amount" onchange="showCash()" style="width:200px; margin-right:10px;"><input type="text" id="afwithdraw_cash" placeholder="출금 후 잔액" name="afwithdraw_cash" style="width:200px;" readonly></div>
					</div>
					<div id="key_value_section">
						<div id="key_section">아이디</div>
						<div id="value_section"><input type="text" id="seller_id" name="seller_id" value="${sessionSeller.seller_id}" readonly></div>
					</div>
					<div id="key_value_section">
						<div id="key_section">비밀번호</div>
						<div id="value_section"><input type="password" id="seller_pw" name="seller_pw" placeholder="암호를 입력해주세요."></div>
					</div>
					
				</div>	
					<div id="buttonBox">
						<button type="submit" class="btn btn-primary">출금하기</button>
						<button type="button" class="btn btn-danger" onclick="location.href='../seller/sellerPage.do?seller_no='+${sessionSeller.seller_no}">취소</button>
					</div>
			</div>	
			</form>
		</div>
	</div>
</div>
</body>
</html>