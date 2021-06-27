<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
ul{list-style:none; padding-left:0px;}
#sidebar{float:left; width:20%; height:auto; border:1px solid #F4FFFF; background-color: #ffffff;}
#side-menu{margin-top:50px; margin-left:40px;}
#side-list{margin-top:20px; margin-bottom:30px;}
.sideMenuTitle{
	font-size: 20px;
}
</style>
<body>
	<div id="sidebar">
		<div id="side-menu">
			<div class="sideMenuTitle" style="font-weight: bold;">상품관리 현황</div>
			<div id="side-list">
				<ul>
					<li><a href="#">상품등록</a></li>
					<li><a href="#">프로모션참여</a></li>
				</ul>
			</div>
		</div>	
		<div id="side-menu">
			<div class="sideMenuTitle" style="font-weight: bold;">판매관리 현황</div>
			<div id="side-list">
				<ul>
					<li><a href="#">주문완료</a></li>
					<li><a href="#">입고관리</a></li>
					<li><a href="#">할인등록</a></li>
				</ul>
			</div>
		</div>	
		<div id="side-menu">
			<div class="sideMenuTitle" style="font-weight: bold;">정산관리 현황</div>
			<div id="side-list">
				<ul>
					<li><a href="#">출금하기</a></li>
					<li><a href="#">출금내역</a></li>
				</ul>
			</div>	
		</div>
		<div id="side-menu">
			<div class="sideMenuTitle" style="font-weight: bold;">판매자 마이페이지</div>
			<div id="side-list">
				<ul>
					<li><a href="#">매출통계</a></li>
					<li><a href="#">상품Q&A</a></li>
					<li><a href="#">판매자정보수정</a></li>
				</ul>
			</div>	
		</div>	
	</div>
</body>
</html>