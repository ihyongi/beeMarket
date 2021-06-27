<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function addForm(){
	var formContainer=document.getElementById("formContainer")
	//div
	var div=document.createElement("div");
		div.setAttribute("class","rowBox");
	
	//input--흠.....
	//ajax써서 delete..insert 메서드 불러서 바로바로적용되게 만들어야하나,..ㅜㅜ
	
	var input=document.createElement("input");
	input.setAttribute("type","hidden");
	input.setAttribute("name","product_no");
	input.setAttribute("id","product_no");
	input.setAttribute("value","${param.product_no }");
	
	var input0=document.createElement("input");
	input0.setAttribute("type","hidden");
	input0.setAttribute("name","productdetail_no");
	input0.setAttribute("id","productdetail_no");
	
	var input1=document.createElement("input");
	input1.setAttribute("type","text");
	input1.setAttribute("name","productdetail_option");
	input1.setAttribute("id","productdetail_option");
	input1.setAttribute("placeholder","색상,사이즈");
		
	var input2=document.createElement("input");
	input2.setAttribute("type","text");
	input2.setAttribute("name","productwarehouse_pluscount");
	input2.setAttribute("id","productwarehouse_pluscount");
	input2.setAttribute("placeholder","수량");
	
	var input3=document.createElement("input");
	input3.setAttribute("type","text");
	input3.setAttribute("name","productdetail_price");
	input3.setAttribute("id","productdetail_price");
	input3.setAttribute("placeholder","가격");
	
	//button
	var input4=document.createElement("input");
	input4.setAttribute("type","button");
	input4.setAttribute("value","적용");
	input4.setAttribute("onclick","insertOption()");
	
	var input5=document.createElement("input");
	input5.setAttribute("type","button");
	input5.setAttribute("value","닫기");
	input5.setAttribute("onclick","removeRow(this)");
	
	div.appendChild(input);
	div.appendChild(input0);
	div.appendChild(input1);
	div.appendChild(input2);
	div.appendChild(input3);
	div.appendChild(input4);
	div.appendChild(input5);
	formContainer.appendChild(div);
	}

var product_no = ${data.productVO.product_no}

function insertOption(){
	var product_no = document.getElementById("product_no").value;
	var productdetail_option = document.getElementById("productdetail_option").value;
	var productwarehouse_pluscount = document.getElementById("productwarehouse_pluscount").value;
	var productdetail_price = document.getElementById("productdetail_price").value;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
			/* productdetail_option.value="";
			productwarehouse_pluscount.value="";
			productdetail_price.value=""; */
			alert("옵션을 추가하셨습니다.");
		    refreshForm();
			
		}
	};	
	xmlhttp.open("post","./insertOptionProcess.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("product_no="+product_no+"&productdetail_option="+productdetail_option +"&productwarehouse_pluscount="+ productwarehouse_pluscount+"&productdetail_price="+productdetail_price);
}

function refreshForm(){
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    var obj = JSON.parse(xmlhttp.responseText);
			var optionBox = document.getElementById("optionBox");
			optionBox.innerHTML = "";
		    	
		    //ArrayList로 날라옴..반복문(of)
		    for(var list of obj){
		    	var rowBox1 = document.createElement("div");
		    	rowBox1.setAttribute("class","row")
		    	
		    	//checkbox
		    	var selectBox = document.createElement("input");
		    	selectBox.setAttribute("type","checkBox");
		    	selectBox.setAttribute("id","checkboxProductdetail_no");
		    	selectBox.setAttribute("name","productdetail_no");
		    	selectBox.setAttribute("value",list.productDetailVO.productdetail_no);
		    	selectBox.setAttribute("data-pdno",list.productDetailVO.productdetail_no);
		    	rowBox1.appendChild(selectBox);
		    	
		    	//productdetail_option
		    	var pdoBox = document.createElement("input");
		    	pdoBox.setAttribute("type","text");
		    	pdoBox.setAttribute("name","productdetail_option");
		    	pdoBox.setAttribute("value",list.productDetailVO.productdetail_option);
		    	rowBox1.appendChild(pdoBox);
		    	
		    	//productwarehouse_pluscount
		    	var pwpBox = document.createElement("input");
		    	pwpBox.setAttribute("type","text");
		    	pwpBox.setAttribute("name","productwarehouse_pluscount");
		    	pwpBox.setAttribute("value",list.productWarehouseVO.productwarehouse_pluscount);
		    	rowBox1.appendChild(pwpBox);
		  	
		    	//productdetail_price
		    	var pdpBox = document.createElement("input");
		    	pdpBox.setAttribute("type","text");
		    	pdpBox.setAttribute("name","productdetail_price");
		    	pdpBox.setAttribute("value",list.productDetailVO.productdetail_price);
		    	rowBox1.appendChild(pdpBox);
		    	
		    	optionBox.appendChild(rowBox1);
		    }
		}
	};
	
	xmlhttp.open("get","./getOptionList.do?product_no="+product_no , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();	//url 인코디드방식?
}

function deleteOption(){
	//AJAX 호출.....
	var confirm_val = confirm("정말 삭제하시겠습니까?");
  
 	 if(confirm_val) {
	var xmlhttp = new XMLHttpRequest();
	var productdetail_no = new Array();
	$("input[id='checkboxProductdetail_no']:checked").each(function(){
		productdetail_no.push($(this).attr("data-pdno"));
	});
	
	alert(productdetail_no);
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
		    refreshForm();
			
		}
	};	
	xmlhttp.open("post","./deleteOptionProcess.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("productdetail_no="+productdetail_no);
 	 }
}


function removeRow(e){
	e.parentElement.remove();
	
}
function init(){
	refreshForm();
	setInterval(refreshForm,1000);
}

</script>
</head>
<body>
<h1>상품수정</h1>

<form action="updateProductContentProcess.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="seller_no" value="${sessionSeller.seller_no }">
<input type="hidden" name="product_no" value="${data.productVO.product_no}">
상품명 <input type="text" name="product_name" value="${data.productVO.product_name}"><br>
카테고리 
<select name="category_no">
	<c:forEach items="${categoryList}" var="data">
	<option value="${data.categoryVO.category_no}">${data.categoryVO.category_name}</option>	
	</c:forEach>
</select>
<select name="categorydetail_no">
	<c:forEach items="${categoryDetailList}" var="data">
	<option value="${data.categoryDetailVO.categorydetail_no}">${data.categoryDetailVO.categorydetail_name}</option>
	</c:forEach>
</select>
<br>
택배사지정 
<select name="delivery_no">
	<c:forEach items="${deliveryCompany}" var="data">
		<option value="${data.deliveryVO.delivery_no}">${data.deliveryVO.delivery_name}</option>
	</c:forEach>
</select>
<br>
상품설명<br>
<textarea name="product_content">${data.productVO.product_content}</textarea>
<br>
상품이미지 
<input type="file" accept="image/*" name="upload_files" multiple>
<br><br>
상품옵션 <span onclick="addForm()">(+)</span>
<!-- 전체 틀 -->
<div id="formContainer">
<!-- 옵션목록 -->
<div id="optionBox">
<div class="allCheck">
	<input type="checkbox" name="allCheck" id="allCheck"/><label for="allCheck">모두선택</label>
<script>
	//모두선택 
	$("#allCheck").click(function(){
	 var chk = $("#allCheck").prop("checked");
	 if(chk) {
	  $(".chBox").prop("checked", true);
	 } else {
	  $(".chBox").prop("checked", false);
	 }
	});
</script>
</div>
	<c:forEach items="${getOptionList }" var="data">
		<div class="rowBox">
		      <input type="checkbox" class="chBox" id="checkboxProductdetail_no" value="${data.productDetailVO.productdetail_no}" data-pdno="${data.productDetailVO.productdetail_no}">
		      <input type="hidden" name="productdetail_no" value="${data.productDetailVO.productdetail_no}">
		      <input type="text" name="productdetail_option" value="${data.productDetailVO.productdetail_option}">
		      <input type="text" name="productwarehouse_pluscount" value="${data.productWarehouseVO.productwarehouse_pluscount}">
		      <input type="text" name="productdetail_price" value="${data.productDetailVO.productdetail_price}">
		</div>
	</c:forEach>
</div> 
 <!-- insert 틀 -->
<div class="rowBox"></div>
</div>
<br>
<button onclick="location.href='${pageContext.request.contextPath}/product/updateProductContentProcess.do'">전체수정</button>
</form>
<button onclick="deleteOption()">선택삭제</button>
<button onclick="location.href='${pageContext.request.contextPath}/product/productList.do?seller_no=${sessionSeller.seller_no }'">뒤로가기</button>

</body>
</html>