<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>

<style type="text/css">
.allUsersList{
  width: 300px;
  margin: 20px;
}
.allUsersList .card-header{
  background: #683db8;
  color: #FFF;
  padding: 10px;
}
.allUsersList .image img{
  border-radius: 16px;
}
.usersChatList{
  position: absolute;
  width: 250px;
  bottom: 0;
  margin-bottom: 0;
  right: 360px;
}
.show{
  display: block;
}
.thumb-user-list{
  display: none;
}
.thumb-user-list .image img{
  border-radius: 30px;
}
.usersChatList .card-header{
  background: #683db8;
  font-size: 13px;
}
.chatBox{
  position: absolute;
  bottom: 0;
  right: 0;
  width: 300px;
  margin: 40px;
  margin-bottom: 0;
  font-size: 13px;
}
.chat-content{
  overflow: auto;
  height: 300px;
}
.chatBox .card{
  border-radius: 4px;
}
.chatBox .card-header{
  background: #683db8;
}
.header-title{
  height: 50px;
}
.card-header-title i{
  font-size: 10px;
  color: #32e4cd;
  margin-right: 6px;
}
.card-header .card-header-title{
  color: #FFF;
}
.chat-content small{
  margin: 0;
}
.chat-content p{
  background: #ecf1f8;
  padding: 10px;
  border-radius: 8px;
  margin-bottom: 0;
}
.my-content .media-content{
  width: 80%;
}
.my-content .message{
  float: right;
  background: #683db8;
  color: #FFF;
  text-align: right;
  padding: 10px;
  margin-bottom: 4px;
  font-size: 13px;
}
.my-content .chat-content small{
  float: right;
}
.my-content small{
  display: block;
  float: right;
  width: 100%;
  text-align: right;
}
.chat-textarea{
  font-size: 14px;
  padding: 8px;
  height: 40px;
  width: 100%;
  border: none;
  overflow: auto;
  outline: none;

  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
  resize: none;
}
.chat-message-group{
  
}
.chat-message-group .chat-thumb{
  float: left;
  width: 20%;
}
.chat-message-group .chat-messages{
  float: left;
  width: 80%;
  margin-bottom: 20px;
}
.chat-message-group .message{
  float: left;
  padding: 10px;
  background: #ecf1f8;
  font-size: 13px;
  border-radius: 5px;
  margin-bottom: 3px;
}
.chat-messages .from{
  float: left;
  display: block;
  width: 100%;
  text-align: left;
  font-size: 11px;
}
.chat-thumb img{
  border-radius: 40px;
}
.writer-user .chat-messages{
  float: right;
  width: 100%;
}
.writer-user .chat-messages .message{
  float: right;
  background: #683db8;
  color: #FFF;
}
.writer-user .chat-messages .from{
  float: left;
  display: block;
  width: 100%;
  text-align: right;
}
.chat-message-group .typing{
  float: left;
}
.chatBox .card-header-icon i{
  color: #FFF;
  font-size: 13px;
}
/* CSSS */
.outside-box{
  height: 100px;
  background: #F8C;
  width: 200px;
  margin: 20px;
  overflow: auto;
}
.outside-box .content-insider{
  height: 300px;
  background: #C9C;
}
/* CSS Spinner */
.spinner {
  margin: 0 30px;
  width: 70px;
  text-align: center;
}

.spinner > div {
  width: 4px;
  height: 4px;
  background-color: #888;

  border-radius: 100%;
  display: inline-block;
  -webkit-animation: sk-bouncedelay 1.4s infinite ease-in-out both;
  animation: sk-bouncedelay 1.4s infinite ease-in-out both;
}

.spinner .bounce1 {
  -webkit-animation-delay: -0.32s;
  animation-delay: -0.32s;
}

.spinner .bounce2 {
  -webkit-animation-delay: -0.16s;
  animation-delay: -0.16s;
}

@-webkit-keyframes sk-bouncedelay {
  0%, 80%, 100% { -webkit-transform: scale(0) }
  40% { -webkit-transform: scale(1.0) }
}

@keyframes sk-bouncedelay {
  0%, 80%, 100% { 
    -webkit-transform: scale(0);
    transform: scale(0);
  } 40% { 
    -webkit-transform: scale(1.0);
    transform: scale(1.0);
  }
}
/* EmojiBox */
.emojiBox{
  width: 150px;
  margin: 30px;
}
.emojiBox .box{
  height: 100px;
  padding: 4px;
}
/* */
.card-header-title img{
  border-radius: 40px;
}
</style>
<body>
<div id="chatApp">
<div class="chatBox" id="chatBox">
  <div class="card">
 
 <header class="card-header header-title" @click="toggleChat()">
    <p class="card-header-title" style="padding-top:10px;">
      <i class="fa fa-circle is-online"></i>&nbsp;${sessionCustomer.customer_name}님
    </p>
    <a class="card-header-icon">
      <span class="icon">
        <i class="fa fa-close"></i>
      </span>
    </a>
  </header>
  <!-- 상대방 -->
 <div id="chatbox-area">
  <div class="card-content chat-content">
    <div id="content" class="content" style="min-height:200px;">
      <div class="chat-message-group">
      	  <div class="chat-thumb">
	          <figure class="image is-32x32">
	            <img src="https://k0.okccdn.com/php/load_okc_image.php/images/32x0/971x939/0/10846088441021659030.webp?v=2">
	          </figure>
	      </div>
	      <div class="chat-messages">
	          <div class="message">반갑습니다. ${sessionCustomer.customer_name}님</div>
	          <div class="message">무엇을 도와드릴까요?</div>
	         <!-- 현재 시간 뜨게 하는 법??!! -->
	          <div class="from">00:00</div>
	       </div>
      </div>
	<!-- 나 -->
      <%-- <div class="chat-message-group writer-user">
        <div class="chat-messages">
          <div id="messageArea" class="message" ></div>
          <div id="from" class="from" >${sessionCustomer.customer_name } 04:55</div>
        </div>
      </div> --%>
  </div>
  <footer class="card-footer" id="chatBox-textbox">
    <div style="width: 63%">
      <textarea id="message" class="chat-textarea" placeholder="질문을 남겨주세요."></textarea>
    </div>
    <div class="has-text-centered" style="width: 37%">
      <a class="button is-white">
        <i class="fa fa-smile-o fa-5" aria-hidden="true"></i>
      </a>
    <button id="sendBtn" class="btn btn-primary btn-sm">전송</button></div>
  </footer>
  </div>
</div>
</div>
<div class="emojiBox" style="display: none">
  <div class="box">
  </div>
</div>
</div>
<script type="text/javascript">
//채팅 소킷js
	$("#sendBtn").click(function() {
		if(${sessionCustomer.customer_no eq null}){
			var con = confirm("로그인이 필요한 서비스입니다.");
			if(con==true){
			location.href='../customer/loginCustomerPage.do';				
			}
		}else{
			
		sendMessage();
		
		var content = document.getElementById("content");
		var myChatBox = document.createElement("div");
		myChatBox.setAttribute("class", "chat-message-group writer-user");
		var myChatMSG = document.createElement("div");
		myChatMSG.setAttribute("class", "chat-messages");
		myChatMSG.setAttribute("id", "chat-messages");
		var messageArea = document.createElement("div");
		messageArea.setAttribute("name", "messageArea");
		messageArea.setAttribute("class", "message");
		var from = document.createElement("div");
		from.setAttribute("id", "from");
		from.setAttribute("class", "from");
		
		content.appendChild(myChatBox);
		myChatBox.appendChild(myChatMSG);
		myChatMSG.appendChild(messageArea);
		myChatMSG.appendChild(from);
		
		alert("메시지를 전송했습니다.");
		
		$('#message').val('');
		}
		

	});

	let sock = new SockJS("http://localhost:8181/beeMarket/echo/");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	// 메시지 전송
	function sendMessage() {
		sock.send($("#message").val());
		
	}
	
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		$("div[name=messageArea]").append(data + "<br/>");
		
		/* var content = document.getElementById("content");
		var adminChatBox = document.createElement("div");
		adminChatBox.setAttribute("class", "chat-message-group");
		
		var adminChatMSG = document.createElement("div");
		adminChatMSG.setAttribute("class", "chat-messages");
		adminChatMSG.setAttribute("id", "chat-messages");
		var messageArea = document.createElement("div");
		messageArea.setAttribute("id", "messageArea");
		messageArea.setAttribute("class", "message");
		var from = document.createElement("div");
		from.setAttribute("id", "from");
		from.setAttribute("class", "from");
		
		content.appendChild(myChatBox);
		myChatBox.appendChild(myChatMSG);
		myChatMSG.appendChild(messageArea);
		myChatMSG.appendChild(from); */
	}
	
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("연결 끊김");

	}
</script>
</body>
</html>