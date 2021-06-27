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
#side-menu{margin-top:50px; margin-left:10px;}
#side-list{margin-top:20px; margin-bottom:30px;}
.sideMenuTitle{
	font-size: 20px;
}

</style>
<body>
	<div id="sidebar">
		<div id="side-menu">
			<div class="sideMenuTitle" style="font-weight: bold;">채널리스트</div>
			<div id="side-list">
				<div id="channelList">
					<table class="table table">
						<tr>
							<td align="center">계정(메시지)</td>
							<!-- <td align="center" id="">읽지않은 메시지</td> -->
						</tr>
						<c:forEach items="${result}" var="data">
						<tr style="text-align:center;">
							<td>
							<button type="button" value="${data.chatChannelVO.channel_no }" id="joinChatBtn" 
							name="joinChatBtn" onclick="joinChannel('${data.chatChannelVO.channel_no}', '${data.chatChannelVO.customer_id }')">${data.chatChannelVO.customer_id }(${data.unreadCount })<input type="hidden" name="channel_no" value="${data.chatChannelVO.channel_no }"></button></td>
							<%-- <td class="unreadTD" ><input type="text" name="unreadCount" readOnly value=${data.unreadCount } style="text-align:center;"></td> --%>			
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>		
	</div>
</body>
</html>