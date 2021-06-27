<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<style type="text/css">
#chatHistory{height:300px; width:300px;}
</style>
<body onload="realTimeChat()">
실시간 1:1 채팅상담
<div id="chatBox" style="min-height:300px;">
	<div id="chatHistory">
		<div id="chatLog">
			<p id="chat" name="chat"></p>
		</div>
	</div>
	<div id="bottomLine">
		<input type="text" placeholder="메시지를 입력하세요." id="msg" name="msg">
		<c:if test="${sessionCustomer.customer_id ne 'admin' }">
		<input type="hidden" id="customer_id" value="${sessionCustomer.customer_id }">
		<button onclick="submitAdmin()">전송하기</button>
		</c:if>
		<c:if test="${sessionCustomer.customer_id eq 'admin' }">
		<input type="hidden" id="customer_id" value="${sessionCustomer.customer_id }">
		<button onclick="submitCustomer()">전송하기</button>
		</c:if>
	</div>
</div>
<script type="text/javascript">
function submitAdmin(){
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	alert("메시지를 전송하였습니다.");
	var msgInput = document.getElementById("msg");
	var message = document.getElementById("msg").value;
	var customer_id = document.getElementById("customer_id").value;
	

	xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			   //var obj = JSON.parse(xmlhttp.responseText);
				
			   msgInput.value="";
			    
			}
		};


	xmlhttp.open("post","./insertChatLogProcessToAdmin.do?message="+message+"&customer_id="+customer_id);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(); //url 인코디드방식?

	}
	
function submitCustomer(){
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	alert("activate Function");
	var msgInput = document.getElementById("msg");
	var message = document.getElementById("msg").value;
	var customer_id = document.getElementById("customer_id").value;
	

	xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			   //var obj = JSON.parse(xmlhttp.responseText);
				
			   msgInput.value="";
			    
			}
		};


	xmlhttp.open("post","./insertChatLogProcessToCustomer.do?message="+message+"&customer_id=s001");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(); //url 인코디드방식?

	}
	
function realTimeChat(){
	//AJAX 호출.....
	var httpRequest = new XMLHttpRequest();
	 httpRequest.onreadystatechange = function() {

	        if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200 ) {

	        		var obj = JSON.parse(httpRequest.responseText);
					//document.getElementById("chat").innerHTML=obj;
					var size=obj.length;
					var chat = document.getElementById("chat");
					
					chat.innerHTML = "";
					for(var i=0; i<size; i++){
					chat.innerHTML+=obj[i].sender+" : "+obj[i].message+"</br>";
						
					}

					 var chatLog = document.getElementById("chatLog");
					 chatLog.innerHTML = "";
					chatLog.appendChild(chat);	 

	        		self.setTimeout("realTimeChat()", 5000);

			}
		};


	httpRequest.open("get","./main", true);
	httpRequest.send();
}
realTimeChat();
</script>
</body>
</html>