<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트 스트랩 -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
   crossorigin="anonymous">
<title>Flee Market</title>
<script type="text/javascript">
   function ex(){
   var xxx1 = document.getElementById("xxx1");
      xxx1.submit();
   }
   var oTbl;
   //Row 추가
   function insRow() {
   /*   oTbl = document.getElementById("addTable");
     var oRow = oTbl.insertRow();
     oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
     var oCell = oRow.insertCell(); */

     //삽입될 Form Tag
     /* var frmTag = "<div><input type=text name='fleemarketdetail_option' placeholder='색상, 사이즈'></div>";
     frmTag += "<div><input type=button value='삭제' onClick='removeRow()'></div>";
     oCell.innerHTML = frmTag; */
     
     var addBox = document.getElementById("addBox");
     var divBox1 = document.createElement("div");
     divBox1.setAttribute("id","OptionBox");
     divBox1.setAttribute("class","row");
     addBox.appendChild(divBox1);
     
     var divBox2 = document.createElement("div");
     divBox2.setAttribute("class","col-6 mt-3");
     divBox1.appendChild(divBox2);
     var inputBox = document.createElement("input");
     inputBox.setAttribute("type","text");
     inputBox.setAttribute("name","fleemarketdetail_option");
     inputBox.setAttribute("placeholder","색상, 사이즈");
     inputBox.setAttribute("style","border : 1px solid #fbdf1a; width : 263px; height : 30px; width: 400px;");
     divBox2.appendChild(inputBox);
     
     var divBox3 = document.createElement("div");
     divBox3.setAttribute("class","col-6 text-center mt-3");
     divBox1.appendChild(divBox3);
     var deletebtn = document.createElement("input");
     deletebtn.setAttribute("type","button");
     deletebtn.setAttribute("class","btn btn-warning");
     deletebtn.setAttribute("value","삭제");
     deletebtn.setAttribute("style","height : 30px; padding-top : 3px;");
     deletebtn.setAttribute("onclick","deleteOption(this)");
     deletebtn.innerHTML = "삭제";
     divBox3.appendChild(deletebtn);

   }
   
   function deleteOption(e) {
	   
	   e.parentElement.parentElement.remove();
	   
   }
   
   
   //Row 삭제dddd
   function removeRow() {
     oTbl.deleteRow(oTbl.clickedRowIndex);
   }
     
   
   function productName() { 
		var productnameBox = document.getElementById("fleemarket_name");	//producnameBox 변수 ID 가져오기
		var nameAlert = document.getElementById("nameAlert");
		if(productnameBox.value == ""){
			nameAlert.setAttribute("style","color : red;");
			nameAlert.innerText = "상품이름을 입력해 주세요.";
			productnameBox.focus();
			return;
		}else {
			productnameAlert.innerText = "";
		}
	}
   
   function productImage() { 
		var productimageBox = document.getElementById("fleemarket_image");	//producnameBox 변수 ID 가져오기
		var nameAlert = document.getElementById("imageAlert");
		if(productimageBox.value == ""){
			nameAlert.setAttribute("style","color : red;");
			nameAlert.innerText = "이미지를 입력해 주세요.";
			productimageBox.focus();
			return;
		}else {
			productimageAlert.innerText = "";
		}
	}
   
   function productTitle(){
	   var producttitleBox = document.getElementById("fleemarket_title"); //producttitleBox가져오기
	   var nameAlert = document.getElementById("titleAlert");
	   if(producttitleBox.value== ""){
		   nameAlert.setAttribute("style","color : red;");
		   nameAlert.innerText = "제목을 입력해 주세요.";
		   producttitleBox.focus();
		   return;
	   }else{
		   producttitleAlert.innerText ="";
	   }
	   
   }
   
   function productPrice(){
	   var productpriceBox = document.getElementById("fleemarket_price");
	   var nameAlert = document.getElementById("priceAlert");
	   if(productpriceBox.value==""){
		   nameAlert.setAttribute("style","color : red;");
		   nameAlert.innerText = "상품 가격을 입력해주세요.";
		   productpriceBox.focus();
		   return;
	   }else{
		   productpriceAlert.innerText = "";
	   }
	  
   }
   
 

</script>
</head>
<body>
<div class="container">
<header>
   <jsp:include page="/WEB-INF/views/commons/headerForSeller.jsp"></jsp:include>
</header>

<div class="row" style="height: 50px;"></div>
<div class="row">
<form id="xxx1" action="${pageContext.request.contextPath }/fleemarket/writeFleeMarketProcess.do" method="post" enctype="multipart/form-data">
   <div class="row">
      <div class="col text-center mt-3"><h2>공동구매 상품 등록</h2><hr></div>
   </div>
   
      <div class="row">
      	<div class="row">
         <div class="col-3 text-end mt-3"><h4>상품이름  </h4></div>
         <div class="col-6 fleemarket_name mt-3">
            <h4><input name="fleemarket_name" id="fleemarket_name" placeholder="상품이름을 입력해주세요" style="border : 1px solid #fbdf1a; width: 400px;" onblur="productName()"></h4>
         <div id="nameAlert"></div>
         </div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>상품이미지 등록  </h4></div>
            <div class="col-6 mt-3"><h4><input type="file" id="fleemarket_image" accept="image/*" name="upload_files" style="border : 1px solid #fbdf1a; width: 400px;" onblur="productImage()" multiple></h4>
            <div id="imageAlert"></div>
            </div>
            <div class="col"></div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>카테고리 </h4></div>
            <div class="col-6 mt-3">
               <select name="categorydetail_no" style="border : 1px solid #fbdf1a;">
                 <c:forEach items="${categoryDetailList }" var="data">
                  <option value="${ data.categoryDetailVO.categorydetail_no }" >${data.categoryDetailVO.categorydetail_name}</option> 
                 </c:forEach>
               </select>
            </div>
            <div class="col"></div>
         </div> 
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>제목 </h4></div>
            <div class="col-6 mt-3"><h4><input type="text" name="fleemarket_title" id="fleemarket_title" placeholder="제목을 입력해주세요." style="border : 1px solid #fbdf1a; width: 400px;" onblur="productTitle()"></h4>
            <div id="titleAlert"></div>
            </div>
            <div class="col"></div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>상품내용 </h4></div>
            <div class="col-6 mt-3"></div>
            <div class="col"></div>
         <div class="row">
            <div class="col-2"></div>
            <div class="col">
               <h4><textarea name="fleemarket_content" rows="5px" cols="60px" placeholder="내용을 입력해주세요." style="border : 1px solid #fbdf1a; width: 500px;"></textarea></h4>
            </div>
         </div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>상품가격 </h4></div>
            <div class="col-6 mt-3"><h4><input type="text" name="fleemarket_price" id="fleemarket_price" placeholder="가격을 입력해주세요." style="border : 1px solid #fbdf1a" onblur="productPrice()">원</h4>
            <div id="priceAlert"></div>
            </div>
            <div class="col"></div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>공동구매 시작일 </h4></div>
            <div class="col-6 mt-3"><h4><input type="date" name="fleemarket_startdate" id="fleemarket_startdate" style="border : 1px solid #fbdf1a; width: 400px;"></h4>
            <div id="startdateAlert"></div>
            </div>
            <div class="col"></div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>공동구매 마감일 </h4></div>
            <div class="col-6 mt-3"><h4><input type="date" name="fleemarket_enddate" id="fleemarket_enddate" style="border : 1px solid #fbdf1a; width: 400px;"></h4></div>
            <div class="col"></div>
         </div>
         <div class="row">
            <div class="col-3 text-end mt-3"><h4>수량 </h4></div>
            <div class="col-6 mt-3"><h4><input type="number" name="fleemarket_itemqty" id="fleemarket_itemqty" placeholder="100~10000개까지 입력 가능합니다" style="border : 1px solid #fbdf1a; width: 400px;" onblur="itemQty()"  min="100" max="10000"></h4>
            <div id="itemqtyAlert"></div>
            </div>
            <div class="col"></div>
         </div>
         
         <script type="text/javascript">
         
         function itemQty(){
      	   var itemqtyBox = document.getElementById("fleemarket_itemqty");
      	   var nameAlert = document.getElementById("itemqtyAlert");
      	   var itemqty = itemqtyBox.value; 
      	   if(itemqty=="" || itemqty < 100 || itemqty > 10000){
      		   itemqtyBox.value = "";
      		   nameAlert.setAttribute("style","color : red;");
      		   nameAlert.innerText = "상품 수량을 다시해주세요.";
      		   itemqtyBox.focus();
      		   return;
      	   }else{
      		   itemqtyAlert.innerText = "";
      	   }
      	  
         }
         
         </script>
         
         <div id="addTable" class="row">
         	<div class="col-3 text-end mt-3"><h4>상품옵션</h4></div>
	        <div class="col-6" id="addBox"></div>
	        <div class="col-2 mt-4"><input class="btn btn-warning" name="addButton" type="button" style="cursor:hand; padding-top : 3px; height : 30px" onClick="insRow()" value="추가"></div>
	        <div class="col"></div>
         </div>
         <div class="row">
            <div class="col"></div>
            <div class="col"></div>
            <div class="col-2 text-center">
               <button type="button" class="btn btn-outline-warning" onclick="ex()">
               	<img src="${pageContext.request.contextPath }/resources/img/writeimg.jpg" width="50" height="50">
               </button>
            </div>
         </div>
      </div>

</form>
</div>
</div>


   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
      crossorigin="anonymous"></script>
</body>
</html>