<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<script type="text/javascript">

	var sessionAdminNo = null;
	var sellerQnA_no = ${data.sellerQnAVO.sellerQnA_no};
	
	
	function getSessionAdminNo(){
		
		//AJAX 호출..... 
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionAdminNo = obj.admin_no;
			}
		};
		
		xmlhttp.open("get","../admin/getSessionAdminNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
	}


	
	
	//리플...
	function writeSellerQnAAnswer(){
		
		if(sessionAdminNo == null){
			alert("관리자만 작성가능합니다.");
			return;
		}
		
		var commentValue = document.getElementById("commentInput").value;
		var sellerQnA_no = ${data.sellerQnAVO.sellerQnA_no};
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			   // var obj = JSON.parse(xmlhttp.responseText);
			      refreshAnswer();  
			    
			}
		};
		
		xmlhttp.open("post","../admin/writeSellerQnAAnswer.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("sellerQnA_no=" + sellerQnA_no + "&sellerqnaanswer_content=" + commentValue);
	}
	
	
	
	
	
		 function refreshAnswer(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    var commentListBox = document.getElementById("commentListBox");
			    
			    commentListBox.innerHTML = "";
			    
			    for(var data of obj){
			    	
			    	var rowBox = document.createElement("div");
			    	rowBox.setAttribute("class","row");
			    	
			    	var nameBox = document.createElement("div");
			    	nameBox.setAttribute("class","col-2 bg-primary");
			    	nameBox.innerText = data.adminVO.admin_name;
			    	rowBox.appendChild(nameBox);
			    	
			    	var contentBox = document.createElement("div");
			    	contentBox.setAttribute("class","col-6 bg-secondary");
			    	contentBox.innerText = data.sellerQnAAnswerVO.sellerqnaanswer_content;
			    	rowBox.appendChild(contentBox);
			    	
			    	var dateBox = document.createElement("div");
			    	dateBox.setAttribute("class","col-3 bg-success");
			    	
			    	var d = new Date(data.sellerQnAAnswerVO.sellerqnaanswer_writedate);
			    	
			    	dateBox.innerText = d.getFullYear() + "." + (d.getMonth() + 1) + "." + d.getDate();
			    	rowBox.appendChild(dateBox);
			    	
			    	if(sessionAdminNo == data.adminVO.admin_no){
				    	var deleteBox = document.createElement("div");
				    	deleteBox.setAttribute("class","col-1 bg-danger");
				    	deleteBox.innerText = "삭제";
				    	deleteBox.setAttribute("onclick" , "removeAnswer("+data.sellerQnAAnswerVO.sellerqnaanswer_no+")");
				    	rowBox.appendChild(deleteBox);
			    	}
			    	
			    	commentListBox.appendChild(rowBox);
			    	
			    }
			    
			}
		};
		
		xmlhttp.open("get","../admin/getSellerQnAAnswerList.do?sellerQnA_no=" + sellerQnA_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();				
		
		
	} 
	
	  function removeAnswer(sellerQnANo){
		
		  var sellerQnANo = sellerQnANo; 
		  
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				 refreshAnswer();
			}
	};
	
	xmlhttp.open("get","../admin/deleteSellerQnAAnswer.do?sellerQnAAnswer_no=" + sellerQnANo , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();		
	  }
	 
	
	function init(){
		getSessionAdminNo();
		refreshAnswer();
		setInterval(refreshAnswer,5000);  
	}
	
</script>

</head>
<body onload="init()">
	<h1>게시글 보기</h1>
	<br>
	
	제목 : ${data.sellerQnAVO.sellerQnA_title }<br>
	작성자 : ${data.sellerVO.seller_id }<br>
	답변상태 : ${data.sellerQnAVO.sellerQnA_statue}<br>
	작성일 : ${data.sellerQnAVO.sellerQnA_writedate}<br>
	내용 : <br>
	${data.sellerQnAVO.sellerQnA_content }<br>
	
	<br><br>
	
	<a href="${pageContext.request.contextPath }/admin/SellerQnAPage.do">목록으로</a>	
	
	<c:if test="${data.adminVO.admin_no}"><!--  deleteContentProcess 추가해야함 -->
		<a href="${pageContext.request.contextPath }/seller/deleteContentProcess.do?sellerQnA_no=${data.sellerQnAVO.sellerQnA_no}">관리자 삭제</a>
	</c:if>
	
		 
	<div id="commentListBox">
		<div class="row">
			<div class="col-2 bg-primary">누가</div>
			<div class="col-6 bg-secondary">어떤 내용을</div>
			<div class="col-3 bg-success">몇일..</div>
			<div class="col-1 bg-danger">삭제</div>
		</div>
	</div>
	<form>
		<textarea id="commentInput" rows="3" cols="60"></textarea>
		<input type="button" value="댓글 작성" onclick="writeSellerQnAAnswer()">
	</form>
			
		
		
		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>		
</body>
</html>





