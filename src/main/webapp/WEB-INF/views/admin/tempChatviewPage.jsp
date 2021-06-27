<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 채팅방(관리자)</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/realTimeChatForAdminCss.css">
</head>
<body id="body">
<div id="container">
<jsp:include page="../commons/headerForAdmin+head.jsp" flush="true"/>
   <jsp:include page="../commons/sidebarForAdmin.jsp" flush="true"/>
   <div id="main">
   	<div id="wrapper">
   		<div class="row mb-5" id="row">
	      <div class="col" style="color: #5b5b5b; font-size: 30px; font-weight: bold; text-align: left;">실시간 상담</div>   
		<!-- 채팅리스트 -->
					<div class="chatBox" id="chatBox">
			  			<div class="card">
			 				<header id="card-header" class="card-header header-title" @click="toggleChat()">
			    				<p class="card-header-title" style="padding-top:10px;">
								      <i class="fa fa-circle is-online"></i>&nbsp;<span id="SessionName" style="color:white;">${sessionAdmin.admin_name}님</span>
								    	<a onclick="exitChat()" class="card-header-icon" style="cursor:pointer;">
								     	 <span class="icon">
								        <i class="fa fa-close"><img id="closeIcon" style="width:20px; height:20px; float:right;" src="${pageContext.request.contextPath }/resources/img/close.png"></i>
								     	 </span>
								    	</a>
								    	</p>
							</header>
								  <!-- 상대방 -->
							<div id="chatbox-area">
								 <div class="card-content chat-content">
								    <div id="ChatContent" class="ChatContent">
									<!-- 본메시지 -->
								      <div class="chat-message-group writer-user" id="write-user">
									        <div class="chat-messages">
									        </div>
								      </div>
								  	</div>
								    <div class="foot-area">
								      <input type="hidden" id="admin_id" value="${sessionAdmin.admin_id}">
								      <textarea id="msg" name="msg" class="form-control" placeholder="답변을 남겨주세요." style="width:90%; min-height:60px; float:left; resize: none;"></textarea>
								    <button id="sendBtn" class="btn btn-primary btn-sm" style="float:right; min-height:62px; width:10%;" onclick="submitCustomer()">전송</button>
			    					</div>
			  					</div>
							</div>
						</div>
					</div>
<!-- 채팅 끝 -->
	   </div>
   	</div>
   </div>
</div>


<script type="text/javascript">
function lockBtn(){
	var size = document.getElementsByName("joinChatBtn").length;
	var joinChatBtn = document.getElementsByName("joinChatBtn");
	for(var i=0; i<size; i++){	
		joinChatBtn[i].setAttribute("disabled", "disabled");
	}
}

function exitChatRoom(){
	alert("채팅방을 나갔습니다.");
	location.href="${pageContext.request.contextPath }/admin/tempChatviewPage.do";
	//realTimeChat();
}

//전체 채팅 ( 구현 됨 )
var current_chat_no = 0;
function realTimeChat(){

	//AJAX 호출.....
	var httpRequest = new XMLHttpRequest();
	 httpRequest.onreadystatechange = function() {

	        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200 ) {
	        		var obj = JSON.parse(httpRequest.responseText);
					var chatmessages = document.querySelector(".chat-messages");
	
					
					for(var obj2 of obj.chatList){
							var messageArea = document.createElement("div");
							messageArea.innerText=obj2.sender+":"+obj2.message+"-"+obj2.chat_time;
							chatmessages.appendChild(messageArea);
							var writeUser = document.getElementById("write-user");	
							writeUser.appendChild(chatmessages);
							console.log(obj2.sender);
							
							if(obj2.sender =='admin'){
								messageArea.setAttribute("class" , "message_1");
								messageArea.setAttribute("value" , obj2.chat_no);
								
							}else{
								messageArea.setAttribute("class" , "message_2");
								messageArea.setAttribute("value" , obj2.chat_no);
							}		
							var btn = document.getElementById("sendBtn");
							btn.setAttribute("disabled","disabled");
							var msg = document.getElementById("msg");
							msg.setAttribute("readOnly","readOnly");
							msg.setAttribute("placeholder","채널 접속 후 답변해주세요.");
							var closeIcon = document.getElementById("closeIcon");
							closeIcon.setAttribute("hidden","true");
							current_chat_no = obj2.chat_no;
					}
					
					
					$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
					self.setTimeout(realTimeChat, 5000);
					

			}
		};

	//이후의 값이 있느냐
	httpRequest.open("get","./joinChatProcess?chat_no="+current_chat_no , true);
	httpRequest.send();
}
realTimeChat();	


//사용자별 채팅
var current_chatNo = 0;
function joinChannel(channelNo, customerId){
	var channelNo=channelNo;
	var customerId=customerId;
	clearTimeout(realTimeChat);
	realTimeChat=null;// 오진다 ㅜ
	
	//AJAX 호출.....
	var httpRequest = new XMLHttpRequest();
	 httpRequest.onreadystatechange = function() {

	        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200 ) {
	        		var obj = JSON.parse(httpRequest.responseText);
					//document.getElementById("chat").innerHTML=obj;
					//var customer_id = obj.chatChannelVO.customer_id;??이거
					var chatmessages = document.querySelector(".chat-messages");
					chatmessages.innerHTML="";
					document.getElementById("sendBtn").disabled=false;
					document.getElementById("msg").readOnly=false;
					msg.setAttribute("placeholder","메시지를 입력해주세요.");
					document.getElementById("closeIcon").hidden=false;
					document.getElementById("SessionName").innerText=customerId+" 님";
					
					for(var obj3 of obj.chatListByNo){
							
							var messageArea = document.createElement("div");
							messageArea.innerText=obj3.sender+":"+obj3.message+"-"+obj3.chat_time;
							chatmessages.appendChild(messageArea);
							var writeUser = document.getElementById("write-user");	
							writeUser.appendChild(chatmessages);
							console.log(obj3.sender);
							
							if(obj3.sender =='admin'){
								messageArea.setAttribute("class" , "message_1");
								messageArea.setAttribute("value" , obj3.chat_no);
								//messageArea.innerText=obj3.message;
								
							}else{
								messageArea.setAttribute("class" , "message_2");
								messageArea.setAttribute("value" , obj3.chat_no);
								var messageAreaInput = document.createElement("input");
								messageAreaInput.setAttribute("type", "hidden");
								messageAreaInput.setAttribute("id", "receiverInput");
								messageAreaInput.setAttribute("value", customerId);
								messageArea.appendChild(messageAreaInput);
								
								var channelNoInput = document.createElement("input");
								channelNoInput.setAttribute("type","hidden");
								channelNoInput.setAttribute("id","channelNoInput");
								channelNoInput.setAttribute("value", channelNo);
								messageArea.appendChild(channelNoInput);
								//messageArea.innerText=obj3.message;
							}		
							
							current_chatNo = obj3.chat_no;
							lockBtn();

							
					}
					
					
					$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
					self.setTimeout(RejoinChannel,5000,channelNo,customerId);
					

			}
		};

	//이후의 값이 있느냐
	httpRequest.open("get","./joinChatProcessByNo?chat_no="+current_chatNo+"&channel_no="+channelNo , true);
	httpRequest.send();
}

function RejoinChannel(channelNo, customerId){
	var channelNo=channelNo;
	var customerId=customerId;
	//clearTimeout(realTimeChat);
	
	//AJAX 호출.....
	var httpRequest = new XMLHttpRequest();
	 httpRequest.onreadystatechange = function() {

	        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200 ) {
	        		var obj = JSON.parse(httpRequest.responseText);
					//document.getElementById("chat").innerHTML=obj;
					//var customer_id = obj.chatChannelVO.customer_id;??이거
					var chatmessages = document.querySelector(".chat-messages");
					
					document.getElementById("sendBtn").disabled=false;
					document.getElementById("msg").readOnly=false;
					msg.setAttribute("placeholder","메시지를 입력해주세요.");
					document.getElementById("closeIcon").hidden=false;
					document.getElementById("SessionName").innerText=customerId+" 님";
					
					for(var obj3 of obj.chatListByNo){
							
							var messageArea = document.createElement("div");
							messageArea.innerText=obj3.sender+":"+obj3.message+"-"+obj3.chat_time;
							chatmessages.appendChild(messageArea);
							var writeUser = document.getElementById("write-user");	
							writeUser.appendChild(chatmessages);
							console.log(obj3.sender);
							
							if(obj3.sender =='admin'){
								messageArea.setAttribute("class" , "message_1");
								messageArea.setAttribute("value" , obj3.chat_no);
								
							}else{
								messageArea.setAttribute("class" , "message_2");
								messageArea.setAttribute("value" , obj3.chat_no);
								var messageAreaInput = document.createElement("input");
								messageAreaInput.setAttribute("type", "hidden");
								messageAreaInput.setAttribute("id", "receiverInput");
								messageAreaInput.setAttribute("value", customerId);
								messageArea.appendChild(messageAreaInput);
								
								var channelNoInput = document.createElement("input");
								channelNoInput.setAttribute("type","hidden");
								channelNoInput.setAttribute("id","channelNoInput");
								channelNoInput.setAttribute("value", channelNo);
								messageArea.appendChild(channelNoInput);
							}		
							
							current_chatNo = obj3.chat_no;
							lockBtn();
							
							
					}
					
					
					$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
					self.setTimeout(RejoinChannel,5000,channelNo,customerId);

			}
		};

	//이후의 값이 있느냐
	httpRequest.open("get","./joinChatProcessByNo?chat_no="+current_chatNo+"&channel_no="+channelNo , true);
	httpRequest.send();
}

function submitCustomer(){
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	alert("메시지를 전송하였습니다.");
	var msgInput = document.getElementById("msg");
	var message = document.getElementById("msg").value;
	var receiver = document.getElementById("receiverInput").value;
	var channel_no = document.getElementById("channelNoInput").value;
	
	

	xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			   //var obj = JSON.parse(xmlhttp.responseText);
			   msgInput.value="";
			}
		};
	

	xmlhttp.open("post","./insertChatLogProcessToCustomer.do?message="+message+"&receiver="+receiver+"&channel_no="+channel_no);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(); //url 인코디드방식?
	}
	
function exitChat() {
	exitChatRoom();
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>
</body>
</html>