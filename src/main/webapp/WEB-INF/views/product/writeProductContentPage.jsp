<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: auto;">
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 100%;
}

#container {
	width: 1200px !important;
	max-width: none !important;
	margin: 0 auto !important;
}

.container {
	width: 1200px !important;
	max-width: none !important;
	margin: 0 auto !important;
}

#main {
	float: left;
	width: 80%;
	height: 100%;
	min-height: 100%;
	background-color: #dcdcdc;
	display: block;
}

#wrapper {
	margin-left: 0;
	width: 960px;
	background-color: #ffffff;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	border: 1px solid #e5e5e5;
	padding-left: 30px;
	padding-right: 30px;
	box-sizing: border-box;
	padding-top: 50px;
	padding-bottom: 60px;
	height: 100%;
}

#sidebar {
	height: 1438px;
}

#productdetail_option{
	width: 374px;
}
 #productwarehouse_pluscount, #productdetail_price{
	width: 224px;
}

#productTitle{
	width: 898px;
}
#productName{
	width: 898px;
}
#upload_files{
	width: 898px;
}
.addInputArea{
	width: 898px;
}
#addRowBox {
	margin-left: 15px;
}
#chBox {
	width: 27px;
	margin-top: 10px;
}

.row input {
	width: 190px;
	margin-right: 0 auto;
}

#saveOption, #saveButton, #deleteButton, #initButton {
	margin-right: 10px;
}

td {
	width: 40px;
	text-align: center;
}

#wrapper::-webkit-scrollbar {
	display: none; /* Chrome, Safari, Opera*/
}

#categorydetail_no, #category_no {
	width: 48%;
	float: left;
}

#categorydetail_no {
	margin-left: 20px;
}

textarea {
	width: 100%;
}
a{cursor:pointer;}
#pagingA{margin:auto 10px;}
</style>

<script type="text/javascript">
//상품등록
function insertProduct(){
	/* if(sessionSeller ==null){
		alert("로그인을 하셔야 이용가능합니다");
		return;
	} */
	
	var seller_no = document.getElementById("sellerNo").value;
	var category_no = document.getElementById("category_no").value;
	var categorydetail_no = document.getElementById("categorydetail_no").value;
	var delivery_no = document.getElementById("delivery_no").value;
	var product_title = document.getElementById("productTitle").value;
	var product_name = document.getElementById("productName").value;
	var product_content = document.getElementById("product_content").value;
	
	var productdetail_option = document.getElementsByName("productdetail_option");
	var productwarehouse_pluscount = document.getElementsByName("productwarehouse_pluscount");
	var productdetail_price = document.getElementsByName("productdetail_price");
	
	var productdetail_optionArray = new Array();
	var productwarehouse_pluscountArray = new Array();
	var productdetail_priceArray = new Array();
	for (var i = 0; i < productdetail_option.length; i++) {
		productdetail_optionArray.push(productdetail_option[i].value);
		productwarehouse_pluscountArray.push(productwarehouse_pluscount[i].value);
		productdetail_priceArray.push(productdetail_price[i].value);
	}
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
		    refreshForm();
		    var productTitle = document.getElementById("productTitle");
		    var productName = document.getElementById("productName");
		    var product_content = document.getElementById("product_content");
		    var upload_files = document.getElementById("upload_files");
		    var productdetail_option = document.getElementById("productdetail_option");
		    var productwarehouse_pluscount = document.getElementById("productwarehouse_pluscount");
		    var productdetail_price = document.getElementById("productdetail_price");
		    var categoryOptBox = document.getElementById("categoryOptBox");
		    var delivery_no = document.getElementById("delivery_no");
		    productTitle.value="";
		    productName.value="";
		    product_content.value="";
		    upload_files.value="";
		    category_no.value="";
		    delivery_no.value="";
		    
		    var formContainer=document.getElementById("formContainer");
		    formContainer.innerHTML = "";
		    var size=document.getElementsByName("productdetail_option").length;
		    for (var i=0;i<size;i++){
		    productdetail_option[i].value="";
		    productwarehouse_pluscount[i].value="";
		    productdetail_price[i].value="";		    	
		    }
		    
		    
	          
		}
	};
	
	//이미지첨부시
	var sendingData = new FormData();
	sendingData.append("seller_no",seller_no);	
	sendingData.append("product_title",product_title);
	sendingData.append("product_name",product_name);
	sendingData.append("product_content",product_content);
	sendingData.append("delivery_no",delivery_no);
	sendingData.append("categorydetail_no",categorydetail_no);
	
	for(i=0 ; i < productdetail_optionArray.length ; i++){
		sendingData.append("productdetail_option",productdetail_optionArray[i]);
		sendingData.append("productdetail_price",productdetail_priceArray[i]);
		sendingData.append("productwarehouse_pluscount",productwarehouse_pluscountArray[i]);
		
	}	
	
	var fileInput = document.getElementById("upload_files");
	for(xxx of fileInput.files){
		sendingData.append("upload_files",xxx);
	}
	var con = confirm("상품을 추가하시겠습니까?");
	
	if(con==true){
		xmlhttp.open("post","./insertProduct.do" , true);
		//xmlhttp.setRequestHeader("Content-type","multipart/form-data");
		xmlhttp.send(sendingData);	//url 인코디드방식?
		alert("상품 등록을 하셨습니다.");

	}else{
		alert("상품 등록을 취소하셨습니다.");
		return;
	}
}	

//row추가
function addRow(){
	var formContainer=document.getElementById("formContainer");
	var div=document.createElement("div");
	div.setAttribute("id","addRowBox");
	
	var row = document.createElement("div");
	row.setAttribute("class","row addInputArea");
	
	var col1 = document.createElement("div");
	col1.setAttribute("class","col-5");
	var row1 = document.createElement("div");
	row1.setAttribute("class","row inputRowMargin");
	
	var col2 = document.createElement("div");
	col2.setAttribute("class","col-3");
	var row2 = document.createElement("div");
	row2.setAttribute("class","row");
	
	var col3 = document.createElement("div");
	col3.setAttribute("class","col-3");
	var row3 = document.createElement("div");
	row3.setAttribute("class","row");
	
	var col4 = document.createElement("div");
	col4.setAttribute("class","col-1");
	var row4 = document.createElement("div");
	row4.setAttribute("class","row");
	
	
	//input
	var input1=document.createElement("input");
	input1.setAttribute("class","form-control");
	input1.setAttribute("type","text");
	input1.setAttribute("name","productdetail_option");
	input1.setAttribute("id","productdetail_option");
	input1.setAttribute("placeholder","색상,사이즈");
	row1.appendChild(input1);
		
	var input2=document.createElement("input");
	input2.setAttribute("class","form-control");
	input2.setAttribute("type","text");
	input2.setAttribute("name","productwarehouse_pluscount");
	input2.setAttribute("id","productwarehouse_pluscount");
	input2.setAttribute("placeholder","수량");
	row2.appendChild(input2);
	
	var input3=document.createElement("input");
	input3.setAttribute("class","form-control");
	input3.setAttribute("type","text");
	input3.setAttribute("name","productdetail_price");
	input3.setAttribute("id","productdetail_price");
	input3.setAttribute("placeholder","가격");
	row3.appendChild(input3);
	
	//button
	var input4=document.createElement("input");
	input4.setAttribute("class","btn btn-light btn-sm");
	input4.setAttribute("style","height:38px;");
	input4.setAttribute("type","button");
	input4.setAttribute("value","닫기");
	input4.setAttribute("onclick","removeRow(this)");
	row4.appendChild(input4);
	
	row.appendChild(col1);
	row.appendChild(col2);
	row.appendChild(col3);
	row.appendChild(col4);
	
	col1.appendChild(row1);
	col2.appendChild(row2);
	col3.appendChild(row3);
	col4.appendChild(row4);
	
	div.appendChild(row);
	formContainer.appendChild(div);
	
	}
	
 //수정시 row추가
function updateAddRow(){
	
	var formContainer=document.getElementById("formContainer");
	//div
	var div=document.createElement("div");
	div.setAttribute("id","addRowBox");
	
	var row = document.createElement("div");
	row.setAttribute("class","row addInputArea");
	
	var col1 = document.createElement("div");
	col1.setAttribute("class","col-4");
	var row1 = document.createElement("div");
	row1.setAttribute("class","row inputRowMargin");
	
	var col2 = document.createElement("div");
	col2.setAttribute("class","col-3");
	var row2 = document.createElement("div");
	row2.setAttribute("class","row");
	
	var col3 = document.createElement("div");
	col3.setAttribute("class","col-3");
	var row3 = document.createElement("div");
	row3.setAttribute("class","row");
	
	var col4 = document.createElement("div");
	col4.setAttribute("class","col-1");
	var row4 = document.createElement("div");
	row4.setAttribute("class","row");
	
	var col5 = document.createElement("div");
	col5.setAttribute("class","col-1");
	var row5 = document.createElement("div");
	row5.setAttribute("class","row");
		
	//input
	var input1=document.createElement("input");
	input1.setAttribute("class","form-control");
	input1.setAttribute("type","text");
	input1.setAttribute("name","productdetail_option");
	input1.setAttribute("id","productdetail_option");
	input1.setAttribute("placeholder","색상,사이즈");
	row1.appendChild(input1);
		
	var input2=document.createElement("input");
	input2.setAttribute("class","form-control");
	input2.setAttribute("type","text");
	input2.setAttribute("name","productwarehouse_pluscount");
	input2.setAttribute("id","productwarehouse_pluscount");
	input2.setAttribute("placeholder","수량");
	row2.appendChild(input2);
	
	var input3=document.createElement("input");
	input3.setAttribute("class","form-control");
	input3.setAttribute("type","text");
	input3.setAttribute("name","productdetail_price");
	input3.setAttribute("id","productdetail_price");
	input3.setAttribute("placeholder","가격");
	row3.appendChild(input3);
	
	//button
	var input4=document.createElement("input");
	input4.setAttribute("type","button");
	input4.setAttribute("style","height:38px;");
	input4.setAttribute("class","btn btn-light btn-sm");
	input4.setAttribute("value","닫기");
	input4.setAttribute("onclick","removeRow(this)");
	row4.appendChild(input4);
	
	//button
	var input5=document.createElement("input");
	input5.setAttribute("type","button");
	input5.setAttribute("style","height:38px; color:white;");
	input5.setAttribute("class","btn btn-primary btn-sm");
	input5.setAttribute("id","input5");
	input5.setAttribute("value","삽입");
	input5.setAttribute("onclick","insertOption()");
	row5.appendChild(input5);
	
	row.appendChild(col1);
	row.appendChild(col2);
	row.appendChild(col3);
	row.appendChild(col4);
	row.appendChild(col5);
	
	col1.appendChild(row1);
	col2.appendChild(row2);
	col3.appendChild(row3);
	col4.appendChild(row4);
	col5.appendChild(row5);
	
	div.appendChild(row);
	formContainer.appendChild(div);
	optionContainer.appendChild(formContainer);
	}  

//row 삭제
function removeRow(e) {
	e.closest("#addRowBox").remove();
}

//상품내용
function showProductDetail(product_no, cate_no){	
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
				
					var rowBox = document.createElement("div");
				    rowBox.setAttribute("class","row")
				    
				    
			    	
			    	var productTitle = document.getElementById("productTitle");
			    	productTitle.setAttribute("value", obj.productContent.productVO.product_title);
			    	var productNo = document.getElementById("productNo");
			    	productNo.setAttribute("value", obj.productContent.productVO.product_no);
			    	var productName = document.getElementById("productName");
			    	productName.setAttribute("value", obj.productContent.productVO.product_name);
			    	var product_content = document.getElementById("product_content");
			    	product_content.innerText =obj.productContent.productVO.product_content;
			    	
			    	var category_no = document.getElementById("category_no");
			    	category_no.setAttribute("id","category_no");
			    	category_no.setAttribute("name","category_no");
			    	category_no.setAttribute("onchange","selectCategory(this)");
			    	for(var categoryList of obj.categoryList){
				    	var categoryOptBox = document.getElementById("categoryOptBox");
				    	
				    	categoryOptBox.setAttribute("name", "OptCategory_no");
				    	categoryOptBox.setAttribute("value", categoryList.categoryVO.category_no);
				    	categoryOptBox.innerText=categoryList.categoryVO.category_name;
				    	category_no.appendChild(categoryOptBox);  	
				    	if(categoryOptBox.value==obj.productContent.categoryVO.category_no){
				    	categoryOptBox.setAttribute("selected", "selected");
				    	}
				    }
			    	
			    	var categorydetail_no = document.getElementById("categorydetail_no");
			    	categorydetail_no.setAttribute("id","categorydetail_no");
			    	categorydetail_no.setAttribute("name","categorydetail_no");
			    	for(var categoryDetailList of obj.categoryDetailList){
				    	var categoryDetailOptBox = document.createElement("option");
				    	categoryDetailOptBox.setAttribute("id", "OptCategorydetail_no");
				    	categoryDetailOptBox.setAttribute("name", "OptCategorydetail_no");
				    	categoryDetailOptBox.setAttribute("value", categoryDetailList.categoryDetailVO.categorydetail_no);
				    	categoryDetailOptBox.innerText=categoryDetailList.categoryDetailVO.categorydetail_name;
				    	categorydetail_no.appendChild(categoryDetailOptBox);  	
				    	if(categoryDetailOptBox.value==obj.productContent.productVO.categorydetail_no){
				    	categoryDetailOptBox.setAttribute("selected", "selected");
				    	}
				    }
			    	
			    	var delivery_no = document.getElementById("delivery_no");
			    	delivery_no.setAttribute("id","delivery_no");
			    	delivery_no.setAttribute("name","delivery_no");
			    	for(var deliveryCompany of obj.deliveryCompany){
				    	var deliveryOptBox = document.getElementById("deliveryOptBox");
				    	
				    	deliveryOptBox.setAttribute("name", "OptDelivery_no");
				    	deliveryOptBox.setAttribute("value", deliveryCompany.deliveryVO.delivery_no);
				    	deliveryOptBox.innerText=deliveryCompany.deliveryVO.delivery_name;
				    	delivery_no.appendChild(deliveryOptBox);  	
				    	if(deliveryOptBox.value==obj.productContent.productVO.delivery_no){
				    		deliveryOptBox.setAttribute("selected", "selected");
				    	}
				    }
			    	
			    	//상품옵션			    	
			    	var optionBox = document.getElementById("optionBox");
					optionBox.innerHTML = "";	
					
						//모두선택
						var checkAllBox = document.createElement("div");
						checkAllBox.setAttribute("class","allCheckBox");
						
						var checkBox= document.createElement("input");
						checkBox.setAttribute("type","checkbox");
						checkBox.setAttribute("name","allCheck");
						checkBox.setAttribute("id","allCheck");
						checkBox.setAttribute("style","width: 40px");
						//checkBox.setAttribute("onclick","selectAll(this)");
						checkAllBox.appendChild(checkBox);
						
						var labelBox=document.createElement("label");
						labelBox.setAttribute("for","allCheck");
						labelBox.innerText="모두선택";
						checkAllBox.appendChild(labelBox);
						
						optionBox.appendChild(checkAllBox);
						 
					
			    	for(var productDetail of obj.productDetail){
			    		var rowBox2 = document.createElement("div");
				    	rowBox2.setAttribute("class","row");
				    	
				    	var row = document.createElement("div");
						row.setAttribute("class","row addInputArea");
						
						var col1 = document.createElement("div");
						col1.setAttribute("class","col-1");
						col1.setAttribute("style","padding-left: 40px");
						var row1 = document.createElement("div");
						row1.setAttribute("class","row");
						
						var col2 = document.createElement("div");
						col2.setAttribute("class","col-4");
						var row2 = document.createElement("div");
						row2.setAttribute("class","row");
						
						var col3 = document.createElement("div");
						col3.setAttribute("class","col-3");
						var row3 = document.createElement("div");
						row3.setAttribute("class","row");
						
						var col4 = document.createElement("div");
						col4.setAttribute("class","col-4");
						var row4 = document.createElement("div");
						row4.setAttribute("class","row");
				    
				    	//checkbox
				    	var selectBox = document.createElement("input");
				    	selectBox.setAttribute("type","checkBox");
				    	selectBox.setAttribute("id","chBox");
				    	selectBox.setAttribute("name","chBox");
				    	selectBox.setAttribute("class","chBox");
				    	selectBox.setAttribute("value",productDetail.productDetailVO.productdetail_no);
				    	selectBox.setAttribute("data-pdno",productDetail.productDetailVO.productdetail_no);
				    	row1.appendChild(selectBox);
				    	
				    	//productdetail_option
				    	var pdoBox = document.createElement("input");
				    	pdoBox.setAttribute("class","form-control");
				    	pdoBox.setAttribute("type","text");
				    	pdoBox.setAttribute("name","productdetail_option");
				    	pdoBox.setAttribute("id","productdetail_option");
				    	pdoBox.setAttribute("value",productDetail.productDetailVO.productdetail_option);
				    	row2.appendChild(pdoBox);
				    	
				    	//productwarehouse_pluscount
				    	var pwpBox = document.createElement("input");
				    	pwpBox.setAttribute("class","form-control");
				    	pwpBox.setAttribute("type","text");
				    	pwpBox.setAttribute("name","productwarehouse_pluscount");
				    	pwpBox.setAttribute("id","productwarehouse_pluscount");
				    	pwpBox.setAttribute("value",productDetail.productWarehouseVO.productwarehouse_pluscount);
				    	row3.appendChild(pwpBox);
				  	
				    	//productdetail_price
				    	var pdpBox = document.createElement("input");
				    	pdpBox.setAttribute("class","form-control");
				    	pdpBox.setAttribute("type","text");
				    	pdpBox.setAttribute("name","productdetail_price");
				    	pdpBox.setAttribute("id","productdetail_price");
				    	pdpBox.setAttribute("value",productDetail.productDetailVO.productdetail_price);
				    	row4.appendChild(pdpBox);
				    				    	
				    	row.appendChild(col1);
				    	row.appendChild(col2);
				    	row.appendChild(col3);
				    	row.appendChild(col4);
				    	col1.appendChild(row1);
				    	col2.appendChild(row2);
				    	col3.appendChild(row3);
				    	col4.appendChild(row4);
				    	
				    	rowBox2.appendChild(row);
				    	
				    	optionBox.appendChild(rowBox2);
			    	}
			    	
			    	//수정하기 버튼
			    	var saveOption = document.getElementById("saveOption");
			    	saveOption.innerHTML = "";	
			    	var saveButton = document.createElement("button");
			    	saveButton.setAttribute("type","button");
			    	saveButton.setAttribute("id","saveButton");
			    	saveButton.setAttribute("class","btn btn-warning");
			    	saveButton.setAttribute("style","color:white;");
			    	saveButton.setAttribute("onclick","updateProduct()");
			    	saveButton.innerText="수정";
			    	saveOption.appendChild(saveButton);
			    	
			    	//삭제 버튼
			    	var deleteOption = document.createElement("button");
			    	deleteOption.setAttribute("type","button");
			    	deleteOption.setAttribute("id","deleteButton");
			    	deleteOption.setAttribute("class","btn btn-danger");
			    	deleteOption.setAttribute("onclick","deleteOption()");
			    	deleteOption.innerText="삭제";
			    	saveOption.appendChild(deleteOption);
			    	
			    	//초기화 버튼
			    	var initOption = document.createElement("button");
			    	initOption.setAttribute("type","button");
			    	initOption.setAttribute("id","initButton");
			    	initOption.setAttribute("class","btn btn-light");
			    	initOption.setAttribute("onclick","location.href='./writeProductContentPage.do?seller_no=${sessionSeller.seller_no }'");
			    	initOption.innerText="초기화";
			    	saveOption.appendChild(initOption);
			    	
  			    	//삽입
  			    	var addRowButton = document.getElementById("addRowButton");
  			    	addRowButton.setAttribute("onclick","updateAddRow()");
  			    	
	
	  				col1.appendChild(row1);
	  				col2.appendChild(row2);
	  				col3.appendChild(row3);
	  				col4.appendChild(row4);
  			    	
	  			  	row.appendChild(col1);
	  				row.appendChild(col2);
	  				row.appendChild(col3);
	  				row.appendChild(col4);
	  				
	  				rowBox2.appendChild(row);
			}
		};
		
		xmlhttp.open("get","./getProductDetail.do?product_no="+product_no+"&category_no="+cate_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	//url 인코디드방식?
	}


function insertOption(){
	var product_no = document.getElementById("productNo").value;
	var category_no = document.getElementById("category_no").value;
	var categorydetail_no = document.getElementById("categorydetail_no").value;
	var productdetail_option = document.getElementById("productdetail_option").value;
	var productwarehouse_pluscount = document.getElementById("productwarehouse_pluscount").value;
	var productdetail_price = document.getElementById("productdetail_price").value;
	
	var param="";
	param+="product_no="+product_no+"&productdetail_option="+productdetail_option +"&productwarehouse_pluscount="+ productwarehouse_pluscount+"&productdetail_price="+productdetail_price;
	
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

			showProductDetail(product_no, category_no);
			formContainer.innerHTML="";
		}
	};	
	xmlhttp.open("post","./insertOptionProcess.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(param);
}

var page_num=1;
//싹다 읽어오기
function refreshForm(page_num){
		
	page_num = page_num;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	

	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    var obj = JSON.parse(xmlhttp.responseText);
		    
		    var	pagingBox = document.getElementById("pagingBox");  
			var pagingDiv = document.createElement("div");
		    pagingBox.innerHTML="";
		    
		    pagingDiv.setAttribute("id", "col1");
		    pagingDiv.setAttribute("align", "center");

		    var totalBeginPage = obj.totalBeginPage;
		    var currentPage = obj.currentPage;
		    var totalEndPage = obj.totalEndPage;
		    var totalPageCount = obj.totalPageCount;
		    console.log("begin"+totalBeginPage);
		    console.log("current"+currentPage);
		    console.log("end"+totalEndPage);
		    console.log("count"+totalPageCount);

		    var td1 = document.createElement("td")
		    if(totalBeginPage <=1){
		    	td1.innerText="◀ ";
		    }else{
			    var a1= document.createElement("a");
			    a1.setAttribute("id", "paging");
			    a1.setAttribute("onclick", "refreshForm("+totalBeginPage-1+")");
			    a1.innerText="◀ ";
			    td1.appendChild(a1);
		    }
		   


			    var td2 = document.createElement("td");
		    for(var totalBeginPage=totalBeginPage; totalBeginPage<=totalEndPage; totalBeginPage++){
			    var a2 = document.createElement("a");
				    a2.setAttribute("onclick", "refreshForm("+totalBeginPage+")");
				    a2.setAttribute("id", "pagingA");
				    a2.innerText=totalBeginPage;
				    td2.appendChild(a2);

				    if(totalBeginPage == currentPage){
				    a2.setAttribute("style", "font-weight:bolder");
				    }
			    
		    }
				    
		    var td3 = document.createElement("td");
		    if(totalEndPage>=totalPageCount){
		    	td3.innerText=" ▶";
		    }else{
			    var a3 = document.createElement("a");
			    a3.setAttribute("onclick", "refreshForm("+totalEndPage+1+")");
			    a3.innerText=" ▶";
			    td3.appendChild(a3);
		    }
			
		    pagingDiv.appendChild(td1);
		    pagingDiv.appendChild(td2);
		    pagingDiv.appendChild(td3);
		    
		    pagingBox.appendChild(pagingDiv);
			
		    
		    
		    for(var getOptionList of obj.getOptionList){
		    //ArrayList로 날라옴..반복문(of)
		    	var rowBox1 = document.createElement("div");
		    	rowBox1.setAttribute("class","row")
		    	
		    	//checkbox
		    	var selectBox = document.createElement("input");
		    	selectBox.setAttribute("type","checkBox");
		    	selectBox.setAttribute("class","chBox");
		    	selectBox.setAttribute("id","checkboxProductdetail_no");
		    	selectBox.setAttribute("value",getOptionList.productDetailVO.productdetail_no);
		    	selectBox.setAttribute("data-pdno",getOptionList.productDetailVO.productdetail_no);
		    	rowBox1.appendChild(selectBox);
		    	
		    	//productdetail_no
		    	var pnoBox = document.createElement("input");
		    	pnoBox.setAttribute("type","hidden");
		    	pnoBox.setAttribute("id","productdetail_no");
		    	pnoBox.setAttribute("name","productdetail_no");
		    	pnoBox.setAttribute("value",getOptionList.productDetailVO.productdetail_no);
		    	rowBox1.appendChild(pnoBox);
		    	
		    	//productdetail_option
		    	var pdoBox = document.createElement("input");
		    	pdoBox.setAttribute("class","form-control");
		    	pdoBox.setAttribute("type","text");
		    	pdoBox.setAttribute("name","productdetail_option");
		    	pdoBox.setAttribute("value",getOptionList.productDetailVO.productdetail_option);
		    	rowBox1.appendChild(pdoBox);
		    	
		    	//productwarehouse_pluscount
		    	var pwpBox = document.createElement("input");
		    	pwpBox.setAttribute("class","form-control");
		    	pwpBox.setAttribute("type","text");
		    	pwpBox.setAttribute("name","productwarehouse_pluscount");
		    	pwpBox.setAttribute("value",getOptionList.productWarehouseVO.productwarehouse_pluscount);
		    	rowBox1.appendChild(pwpBox);
		  	
		    	//productdetail_price
		    	var pdpBox = document.createElement("input");
		    	pdpBox.setAttribute("class","form-control");
		    	pdpBox.setAttribute("type","text");
		    	pdpBox.setAttribute("name","productdetail_price");
		    	pdpBox.setAttribute("value",getOptionList.productDetailVO.productdetail_price);
		    	rowBox1.appendChild(pdpBox);
		    	
		    	optionBox.appendChild(rowBox1);
		    }
		    	 
		    //상품목록보이기
		    var tableBox = document.getElementById("tableBox");
		    tableBox.innerHTML = "";
		    
		    var setTable = document.createElement("table");
		    setTable.setAttribute("class","table");
		    var tr1 = document.createElement("tr");
		    setTable.appendChild(tr1);
		    var td1 = document.createElement("td");
		    td1.innerText="상품번호";
		    tr1.appendChild(td1);
		    var td2 = document.createElement("td");
		    td2.innerText="상품명";
		    tr1.appendChild(td2);
		    
		    var td5 = document.createElement("td");
		    td5.innerText="택배사";
		    tr1.appendChild(td5);
		    var td6 = document.createElement("td");
		    td6.innerText="수정/삭제";
		    tr1.appendChild(td6);
		    
		    for(var onlyProductList of obj.onlyProductList){
		    var tr2 = document.createElement("tr");
		    setTable.appendChild(tr2);
		    var std1 = document.createElement("td");
		    std1.setAttribute("id","productNoTd");
		    std1.setAttribute("value",onlyProductList.productVO.product_no);
		    std1.innerText=onlyProductList.productVO.product_no;
		    tr2.appendChild(std1);
		    var std2 = document.createElement("td");
		    std2.innerText=onlyProductList.productVO.product_name;
		    tr2.appendChild(std2);
		   
		    
 		    var std5 = document.createElement("td");
		    std5.innerText=onlyProductList.deliveryVO.delivery_name;
		    tr2.appendChild(std5);
		    
		    var std6 = document.createElement("td");
		    var updateButton = document.createElement("button");
		    updateButton.setAttribute("type","button");
		    updateButton.setAttribute("onclick","showProductDetail("+onlyProductList.productVO.product_no+","+onlyProductList.categoryVO.category_no+")");
		    updateButton.innerText="수정";
		    std6.appendChild(updateButton);
		    
		    var deleteButton = document.createElement("button");
		    deleteButton.setAttribute("type","button");
		    deleteButton.setAttribute("onclick","deleteProduct("+onlyProductList.productVO.product_no+")");
		    deleteButton.innerText="삭제";
		    std6.appendChild(deleteButton);
		    tr2.appendChild(std6);
		    tableBox.appendChild(setTable); 
		    }
		    
		    
		  
		    
		}		
	};
	
	xmlhttp.open("get","./getProductListBySellerNo.do?page_num="+page_num, true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();	//url 인코디드방식?
}
function deleteProduct(product_no){
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	var product_no = product_no;
	var con = confirm(product_no+"번 상품을 삭제하시겠습니까?");
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
		   
		    refreshForm();
		    //상품옵션 --productdetailVO, productwarehouseVO
		 
		}
	};
	if(con==true){		
	xmlhttp.open("get","./deleteProductByProductNo.do?product_no="+product_no, true);
	}else if(con==false){
		alert("상품 삭제를 취소하셨습니다.");
	return;
	}
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();	//url 인코디드방식?
}

function updateProduct(){
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	var product_no = document.getElementById("productNo").value;
	var seller_no = document.getElementById("sellerNo").value;
	var category_no = document.getElementById("category_no").value;
	var categorydetail_no = document.getElementById("categorydetail_no").value;
	var delivery_no = document.getElementById("delivery_no").value;
	var product_title = document.getElementById("productTitle").value;
	var product_name = document.getElementById("productName").value;
	var product_content = document.getElementById("product_content").value;
	
	var productdetail_no = document.getElementsByName("chBox");
	var productdetail_option = document.getElementsByName("productdetail_option");
	var productwarehouse_pluscount = document.getElementsByName("productwarehouse_pluscount");
	var productdetail_price = document.getElementsByName("productdetail_price");
	
	var productdetail_noArray = new Array();
	var productdetail_optionArray = new Array();
	var productwarehouse_pluscountArray = new Array();
	var productdetail_priceArray = new Array();
	
	for (var i = 0; i < productdetail_option.length; i++) {
		productdetail_noArray.push(productdetail_no[i].value);
		productdetail_optionArray.push(productdetail_option[i].value);
		productwarehouse_pluscountArray.push(productwarehouse_pluscount[i].value);
		productdetail_priceArray.push(productdetail_price[i].value);
	}
	
	var param = "";
	   param += "product_no="+product_no+"&seller_no="+seller_no +"&product_title="+ product_title+"&product_name=" + product_name+"&product_content="+ product_content+"&delivery_no="+ delivery_no + "&categorydetail_no="+ categorydetail_no;
	   for(i=0 ; i < productdetail_optionArray.length ; i++){
	      param += "&productdetail_no="+ productdetail_noArray[i];
	      param += "&productdetail_option="+ productdetail_optionArray[i];
	      param += "&productdetail_price="+ productdetail_priceArray[i];
	      param += "&productwarehouse_pluscount="+ productwarehouse_pluscountArray[i];
	      
	   }   

	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
			/* productdetail_option.value="";
			productwarehouse_pluscount.value="";
			productdetail_price.value=""; */
			alert("옵션을 수정하셨습니다.");
		    refreshForm();
			
		}
	};	
	xmlhttp.open("post","./updateProduct.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(param);
	
}

function deleteOption(){
	//AJAX 호출.....
	var confirm_val = confirm("정말 삭제하시겠습니까?");
  
 	if(confirm_val) {
	var xmlhttp = new XMLHttpRequest();
	var productdetail_no = new Array();
	var product_no = document.getElementById("productNo").value;
	var category_no = document.getElementById("category_no").value;
	
	$("input[id='chBox']:checked").each(function(){
		productdetail_no.push($(this).attr("data-pdno"));
	});
	
	alert(productdetail_no);
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
		    //var obj = JSON.parse(xmlhttp.responseText);
		    showProductDetail(product_no,category_no)
		    //refreshForm();
			
		}
	};	
	xmlhttp.open("post","./deleteOptionProcess.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("productdetail_no="+productdetail_no);
 	 }
}

/* function makeIst(){
	var optionContainer=document.getElementById("optionContainer");
	optionContainer.innerText="상품옵션";
	var optButton=document.createElement("button");
	optButton.setAttribute("type","button");
	optButton.setAttribute("onclick","addRow()");
	optButton.innerText="추가";
	optionContainer.appendChild(optButton);
}

function init(){
	refreshForm();
	makeIst();
}
 */
</script>
</head>
<body onload="refreshForm(1)">
	<div class="row">
		<div class="col">
			<div id="container">
				<jsp:include page="../commons/headerForSeller+head.jsp" flush="true" />
				<jsp:include page="../commons/sidebar.jsp" flush="true" />
				<div id="main">
					<div id="wrapper">
						<!-- 상품목록 -->
						<div class="row">
							<div class="col productList" style="color: #5b5b5b; font-size: 28px; font-weight: bold; text-align: left;">
								등록된 상품목록
							</div>
						</div>
						<br>
						<div id="tableBox"></div>
						<!-- 페이지 검색 전 -->
					     <div id="pagingBox" align="center">
<%-- 					      	<!-- 이전 -->
					    	  <c:choose>
							  <c:when test="${totalBeginPage <=1}">
					      		<td>◀&nbsp;</td>
							  </c:when>
							  <c:otherwise>
						 		<td><a id="paging" onclick="refreshForm(${totalBeginPage-1 })">◀&nbsp;</a></td>
						 	 </c:otherwise>               
							 </c:choose>
							  <!-- 1 2 3 이렇게 출력.. -->
					  	    <c:forEach begin="${totalBeginPage}" end="${totalEndPage}" var="ppp">
					  	    <c:choose>	  	 	    
							  		<c:when test="${ppp !=currentPage}">
							 			<td><a id="paging" onclick="refreshForm(${ppp})">${ppp}</a>&nbsp;</td>
							  		</c:when>
							 		<c:otherwise>
						 	  			<td><a id="paging" onclick="refreshForm(${ppp})">${ppp}</a>&nbsp;</td>
						  	  		</c:otherwise>
						 	 </c:choose>
						 	 </c:forEach>
						 	
						 	 <!-- 다음 -->
						 	<c:choose>
						  		<c:when test="${totalEndPage>=totalPageCount }">
						  			<td>&nbsp;▶</td>
						  		</c:when>
						  		<c:otherwise>
						  			<td><a class="page-link" onclick="refreshForm(${totalEndPage+1 })">▶</a></td>
						  		</c:otherwise>               
						 	 </c:choose> --%>
					     	 </div>
					     	 <!-- 페이징 끝 -->
						<br>
						<br>
						

						<!-- 상품등록 -->
						<div class="row">
							<div class="col insert" style="color: #5b5b5b; font-size: 28px; font-weight: bold; text-align: left;">
								상품등록 및 수정
							</div>
						</div>
						<br>
						<div id="productDetailBox">
							<form action="writeProductContentProcess.do" method="post" enctype="multipart/form-data">
								<input type="hidden" id="productNo" name="productNo" value="${data.productVO.product_no }">
								<input type="hidden" id="sellerNo" name="seller_no" value="${sessionSeller.seller_no }">
								제목
								<input class="form-control" type="text" id="productTitle" name="product_title">
								<br>
								상품명
								<input class="form-control" type="text" id="productName" name="product_name">
								<br>
								카테고리
								<br>
								<select class="form-control" id="category_no" name="category_no" onchange="selectCategory()">
									<c:forEach items="${categoryList}" var="data">
									<option id="categoryOptBox"  value="${data.categoryVO.category_no}" >${data.categoryVO.category_name}</option>	
									</c:forEach>
								</select>
								<select class="form-control" id="categorydetail_no" name="categorydetail_no" >
								</select>
								<br>
								<script type="text/javascript">
								//카테고리
								function selectCategory(){
									var category= document.getElementById("category_no");
									var categoryIndexNo = category.selectedIndex;
									var selectedOption = category.options[categoryIndexNo];
									var categoryNo = selectedOption.value;
									
									//AJAX 호출.....
									var xmlhttp = new XMLHttpRequest();
									
									//호출 후 값을 받았을때... 처리 로직....
									xmlhttp.onreadystatechange = function(){
										if(xmlhttp.readyState==4 && xmlhttp.status == 200){
											var obj = JSON.parse(xmlhttp.responseText);
											
											var detailBox = document.getElementById("categorydetail_no");
											detailBox.innerHTML="";
											
											for(categoryDetailList of obj.categoryDetailList){
												var cateOptionBox = document.createElement("option");
												cateOptionBox.setAttribute("value",categoryDetailList.categoryDetailVO.categorydetail_no);
												cateOptionBox.setAttribute("name", "categorydetail_no");
												cateOptionBox.setAttribute("id", "categorydetail_no");
												cateOptionBox.innerText=categoryDetailList.categoryDetailVO.categorydetail_name;
												detailBox.appendChild(cateOptionBox);
												
											}
										
										}
									};
									
									xmlhttp.open("get","./updateCategoryDetailByNo.do?category_no=" + categoryNo, true);
									xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
									xmlhttp.send();
								}
								</script>
								<br>
								택배사지정
								<select class="form-control" id="delivery_no" name="delivery_no">
									<c:forEach items="${deliveryCompany}" var="data">
										<option id="deliveryOptBox"
											value="${data.deliveryVO.delivery_no}">${data.deliveryVO.delivery_name}</option>
									</c:forEach>
								</select>
								<br>
								상품설명
								<br>
								<textarea class="form-control" name="product_content" id="product_content"></textarea>
								<br>
								상품이미지
								<input class="form-control" id="upload_files" type="file" accept="image/*" name="upload_files" multiple maxlength="4">
								<br>
								<br>
								<!-- class="btn btn-primary btn-sm" -->
								<div id="optionContainer">
									상품옵션&nbsp;&nbsp;
									<button type="button" id="addRowButton" onclick="addRow()" class="btn btn-warning btn-sm" style="color:white;">추가</button>
									<div id="optionBox">
										<div class="allCheck">
											<!-- <input type="checkbox" name="allCheck" id="allCheck" style="width:40px;"/><label for="allCheck">모두선택</label> -->
											<script>
												//모두선택 
												$(document).on('click', '#allCheck', function(){
													alert("모두 선택을 누르셨습니다.");
												 var chk = $("#allCheck").prop("checked");
												 if(chk) {
												  $(".chBox").prop("checked", true);
												 } else {
												  $(".chBox").prop("checked", false);
												 }
												});
											</script>
										</div>
									</div>
								</div>
								<div id="formContainer"></div>
								<br>
								<div id="saveOption" style="text-align: right;">
									<br>
									<button type="button" onclick="insertProduct()" class="btn btn-light">상품등록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
	</div>

</body>
</html>