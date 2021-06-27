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
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<meta charset="UTF-8">
<title>My Bee</title>
</head>
<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#container{
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
#main{float:left; width:80%; height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
   margin-left:0;
   width: 960px;
    background-color: #ffffff; 
    -webkit-border-radius: 5px; 
    -moz-border-radius: 5px; 
    border-radius: 5px;    
    border: 1px solid #e5e5e5;
    padding-left: 20px;
    padding-right: 20px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:90%;
    overflow:scroll;
 }
#wrapper::-webkit-scrollbar {display: none; /* Chrome, Safari, Opera*/}
table{text-align: center;}
</style>
<script type="text/javascript">   
/* function apply(clicked_id){
   var example = "<c:out value='${sessionSeller.seller_name}'/>";
   alert(example);
   var no = document.getElementById("no");
   var title = document.getElementById("title");
   var discountRate = document.getElementById("discountRate");
   alert(discountRate.value);
   alert("clicked3");
   alert(no.value);
   alert(title.value);
   $("#product_no").attr('value', no.value);
   $("#product_title").attr('value', title.value);
   $("#discount_rate").attr('value', discountRate.value);
   alert("checked");
   
} */

function ShowPrice(originPrice , e){
	var discountRate = e.closest("tr").querySelector(".discount-rate");
	var discountRateValue = parseInt(discountRate.value);
	var savePrice = originPrice * (discountRateValue / 100);
	var showPrice = e.closest("tr").querySelector(".show-price");
	showPrice.value = originPrice - savePrice;
	
	/*
     var originPrice =  originPrice; 
        //document.querySelector("#originPrice").value;
  
     var size = document.getElementsByName("afDiscount_price").length;
     var afDiscountArray = new Array();
     var rateArray = new Array();
     
     for(var i=0; i<size; i++){
	     var afDiscount_priceName = document.getElementsByName("afDiscount_price")[i].value;
	     var rate = document.getElementsByName("newDiscount_rate")[i].value;
	     var savePrice = originPrice *(rate / 100);
	   	 if(rate!=""){ //','를 왜 읽을까.................
	    	 //afDiscountArray.push(afDiscount_price);
	    	 rateArray.push(rate);
		     var afDiscount_price = originPrice - savePrice;
	   	 	 //$("#afDiscount_price").attr("value", afDiscountArray[i]);
	   	 	 document.getElementsByName("afDiscount_price")[i].setAttribute("value" , afDiscount_price);
	    }
	   	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
	}
     */
}

//싹다 읽어오기
var pageNum=1;
function refreshForm(page_num){
	
	page_num = pageNum;
	
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();

   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
          var obj = JSON.parse(xmlhttp.responseText);
          
          
          /* //페이징
         	var pagingBox = document.getElementById("pagingBox");  
			var pagingDiv = document.createElement("div");
		    pagingBox.innerHTML="";
		    //pagingDiv.innerHTML="";
		    
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
			 */
          
          var discountTable=document.getElementById("discountTableN");
          var dtTable=document.createElement("table");
          dtTable.innerHTML="";
          dtTable.setAttribute("class","table table-hover");
          var tr1=document.createElement("tr");
          dtTable.appendChild(tr1);
          var td1=document.createElement("td");
          td1.innerText="옵션번호";
          tr1.appendChild(td1); 
          var td2=document.createElement("td");
          td2.innerText="상품명";
          tr1.appendChild(td2);
          var td3=document.createElement("td");
          td3.innerText="상품옵션";
          tr1.appendChild(td3);
          var td4=document.createElement("td");
          td4.innerText="원가";
          tr1.appendChild(td4);
          var td5=document.createElement("td");
          td5.innerText="시작일";
          tr1.appendChild(td5);
          var td6=document.createElement("td");
          td6.innerText="마감일";
          tr1.appendChild(td6);
          var td7=document.createElement("td");
          td7.innerText="할인율(%)";
          tr1.appendChild(td7);
          var td9=document.createElement("td");
          td9.innerText="적용";
          tr1.appendChild(td9);
          
          for(sellerProductListN of obj.sellerProductListN){
             var tr2=document.createElement("tr");
             dtTable.appendChild(tr2);
             var dtd1=document.createElement("td");
             dtd1.setAttribute("id","productdetail_no");
             dtd1.setAttribute("name","productdetail_no");
             dtd1.setAttribute("value",sellerProductListN.productDetailVO.productdetail_no);
             dtd1.innerText=sellerProductListN.productDetailVO.productdetail_no; 
             tr2.appendChild(dtd1);
             var dtd2 = document.createElement("td");
             dtd2.innerText=sellerProductListN.productVO.product_name;
             tr2.appendChild(dtd2);
             var dtd3 = document.createElement("td");
             dtd3.innerText=sellerProductListN.productDetailVO.productdetail_option;
             tr2.appendChild(dtd3);
             var dtd4 = document.createElement("td");
             var dtd4input = document.createElement("input");
             dtd4input.setAttribute("class","form-control");
             dtd4input.setAttribute("type","hidden");
             dtd4input.setAttribute("id","productdetail_price");
             dtd4input.setAttribute("name","productdetail_price");
             dtd4input.setAttribute("value",sellerProductListN.productDetailVO.productdetail_price);
             dtd4.innerText=sellerProductListN.productDetailVO.productdetail_price;
             tr2.appendChild(dtd4);
             tr2.appendChild(dtd4input);
            
             //할인시작일
             var dtd5 = document.createElement("td");
               var beginDate= document.createElement("input");
               beginDate.setAttribute("class","form-control");
               beginDate.setAttribute("type","date");
               beginDate.setAttribute("id","discountBegindate");
               beginDate.setAttribute("name","discountBegindate");
               dtd5.appendChild(beginDate);
             tr2.appendChild(dtd5);
             
             //할인종료일
             var dtd6 = document.createElement("td");
               var endDate= document.createElement("input");
               endDate.setAttribute("class","form-control");
               endDate.setAttribute("type","date");
               endDate.setAttribute("id","discountEnddate");
               endDate.setAttribute("name","discountEnddate");
               dtd6.appendChild(endDate);
             tr2.appendChild(dtd6);
             
             //할인율
             var dtd7 = document.createElement("td");
               var discountRate= document.createElement("input");
               discountRate.setAttribute("class","form-control");
               discountRate.setAttribute("id","discountRate");
               discountRate.setAttribute("name","discountRate");

               discountRate.setAttribute("maxlength","2");
               discountRate.setAttribute("placeholder","할인율(%)");
               dtd7.appendChild(discountRate);
             tr2.appendChild(dtd7);
             /* //할인적용유무
             var dtd8 = document.createElement("td");
             dtd8.innerText=sellerProductListN.productDetailVO.discount_status;
             tr2.appendChild(dtd8); */
             
             //적용하기 버튼
             var dtd9 = document.createElement("td");
             var applyButton=document.createElement("button");
             applyButton.setAttribute("type","button");
             applyButton.setAttribute("id","insertDiscountButton");
             applyButton.setAttribute("name","insertDiscountButton");
             applyButton.setAttribute("onclick","insertDiscount("+sellerProductListN.productDetailVO.productdetail_no+","+sellerProductListN.productDetailVO.productdetail_price+")");
             applyButton.innerText="적용";
             dtd9.appendChild(applyButton);
             tr2.appendChild(dtd9);
            
             discountTable.appendChild(dtTable);
          }
          
          var discountTableY=document.getElementById("discountTableY");
          var dtTableY=document.createElement("table");
          dtTableY.innerHTML="";
          dtTableY.setAttribute("class","table table-hover");
          var tr3=document.createElement("tr");
          dtTableY.appendChild(tr3);
          var ytd1=document.createElement("td");
          ytd1.innerText="옵션번호";
          tr3.appendChild(ytd1);
          var ytd2=document.createElement("td");
          ytd2.innerText="상품명";
          tr3.appendChild(ytd2);
          var ytd3=document.createElement("td");
          ytd3.innerText="상품옵션";
          tr3.appendChild(ytd3);
          var ytd4=document.createElement("td");
          ytd4.innerText="원가";
          tr3.appendChild(ytd4);
          var ytd5=document.createElement("td");
          ytd5.setAttribute("style","width:100px;");
          ytd5.innerText="시작일";
          tr3.appendChild(ytd5);
          var ytd6=document.createElement("td");
          ytd6.innerText="마감일";
          ytd6.setAttribute("style","width:100px;");
          tr3.appendChild(ytd6);
          var ytd7=document.createElement("td");
          ytd7.innerText="할인율(%)";
          tr3.appendChild(ytd7);
          var ytd8=document.createElement("td");
          ytd8.innerText="현재할인가";
          tr3.appendChild(ytd8);
          var ytd13=document.createElement("td");
          ytd13.innerText="수정/삭제";
          tr3.appendChild(ytd13);
          
          for(sellerProductListY of obj.sellerProductListY){
             var tr4=document.createElement("tr");
             dtTableY.appendChild(tr4);
             var ydtd1=document.createElement("td");
             var ydtd1Input=document.createElement("input");
             ydtd1Input.setAttribute("type","hidden");
             ydtd1Input.setAttribute("name","productdetail_noAppliedDiscount");
             ydtd1Input.setAttribute("class","productdetail_no");
             ydtd1Input.setAttribute("value", sellerProductListY.productDetailVO.productdetail_no)
             ydtd1.setAttribute("value",sellerProductListY.productDetailVO.productdetail_no);
             ydtd1.innerText=sellerProductListY.productDetailVO.productdetail_no;
             ydtd1.appendChild(ydtd1Input);
             tr4.appendChild(ydtd1);
             var ydtd2 = document.createElement("td");
             ydtd2.innerText=sellerProductListY.productVO.product_name;
             tr4.appendChild(ydtd2);
             var ydtd3 = document.createElement("td");
             ydtd3.innerText=sellerProductListY.productDetailVO.productdetail_option;
             tr4.appendChild(ydtd3);
             var ydtd4 = document.createElement("td");
             var ydtd4input = document.createElement("input");
             ydtd4input.setAttribute("class","form-control");
             ydtd4input.setAttribute("type","hidden");
             ydtd4input.setAttribute("id","originPrice");
             ydtd4input.setAttribute("value",sellerProductListY.productDetailVO.productdetail_price);
             ydtd4.innerText=sellerProductListY.productDetailVO.productdetail_price;
             tr4.appendChild(ydtd4input);
             tr4.appendChild(ydtd4);
             
             //할인시작일
             var ydtd5 = document.createElement("td");
               var beginDateY= document.createElement("input");  
               beginDateY.setAttribute("type","text");
               beginDateY.setAttribute("style","width:100px;");
               beginDateY.setAttribute("disabled","disabled");
               //beginDateY.setAttribute("pattern","yyyy-MM-dd");
               beginDateY.setAttribute("value",sellerProductListY.discountVO.discount_begindate);
               beginDateY.innerText=sellerProductListY.discountVO.discount_begindate;
               ydtd5.appendChild(beginDateY);
               tr4.appendChild(ydtd5);
             
               //할인종료일
             var ydtd5 = document.createElement("td");
               var endDateY= document.createElement("input");
               endDateY.setAttribute("type","text");
               endDateY.setAttribute("style","width:100px;");
               endDateY.setAttribute("value",sellerProductListY.discountVO.discount_enddate);
               endDateY.setAttribute("disabled","disabled");
               //endDateY.setAttribute("pattern","yyyy-MM-dd");
               endDateY.innerText=sellerProductListY.discountVO.discount_enddate;
              
               var endDateYInput = document.createElement("input");
               endDateYInput.setAttribute("type", "hidden");
               endDateYInput.setAttribute("value", sellerProductListY.discountVO.discount_enddate);
               endDateYInput.setAttribute("name","endOfDiscountDay");
               endDateYInput.setAttribute("id","endOfDiscountDay");
               
               ydtd5.appendChild(endDateY);
               ydtd5.appendChild(endDateYInput);
               tr4.appendChild(ydtd5);
             
               //적용된 할인율
             var ydtd7 = document.createElement("td");
             ydtd7.innerText=sellerProductListY.discountVO.discount_rate+"%";
               var discountRateY= document.createElement("input");
               discountRateY.setAttribute("class","form-control");
               discountRateY.setAttribute("type","hidden");
               discountRateY.setAttribute("value",sellerProductListY.discountVO.discount_rate+"%");
               ydtd7.appendChild(discountRateY);
               tr4.appendChild(ydtd7);
             
               //현재 할인가
             var ydtd8 = document.createElement("td");
             ydtd8.innerText=sellerProductListY.discountVO.discount_price;
             var discountPriceNow= document.createElement("input");
             discountPriceNow.setAttribute("class","form-control");
             discountPriceNow.setAttribute("type","hidden");
             discountPriceNow.setAttribute("id","discountPriceNow");
             discountPriceNow.setAttribute("name","discountPriceNow");
             discountPriceNow.setAttribute("value",sellerProductListY.discountVO.discount_price);
             discountPriceNow.innerText=sellerProductListY.discountVO.discount_price;
             ydtd8.appendChild(discountPriceNow);
             tr4.appendChild(ydtd8);
             
             //변경/삭제
             var ydtd13 = document.createElement("td");
             var updateButton=document.createElement("button");
             updateButton.setAttribute("type","submit");
             updateButton.setAttribute("id","stockModalBtn");
             updateButton.setAttribute("name","stockModalBtn");
             updateButton.setAttribute("data-toggle","modal");
             updateButton.setAttribute("data-target","#stockModal");
             updateButton.setAttribute("onclick","openModal("+sellerProductListY.productDetailVO.productdetail_no+",this)");
             updateButton.setAttribute("name","discount_price");
             updateButton.innerText="변경";
             ydtd13.appendChild(updateButton);
             var deleteButton=document.createElement("button");
             deleteButton.setAttribute("type","button");
             deleteButton.setAttribute("onclick","deleteDiscount("+sellerProductListY.productDetailVO.productdetail_no+")");
             deleteButton.setAttribute("name","discount_price");
             deleteButton.innerText="삭제";
             ydtd13.appendChild(deleteButton);
             tr4.appendChild(ydtd13);
            
             discountTableY.appendChild(dtTableY);
          }
          expireDiscount();
      }
   };
   
   xmlhttp.open("get","./writeDiscount.do?page_num="+page_num, true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   //url 인코디드방식?
}

function insertDiscount(productdetail_no, productdetail_price){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   var productdetail_no = productdetail_no;
   
   var productdetail_price = productdetail_price;
   var size=document.getElementsByName("discountRate").length;
  
	var discountRateArray = new Array();
	var discountBegindateArray = new Array();
	var discountEnddateArray = new Array();
	
   for(var i=0;i<size;i++){
   var discountRate = document.getElementsByName("discountRate")[i].value;
   var discountBegindate = document.getElementsByName("discountBegindate")[i].value;
   var discountEnddate = document.getElementsByName("discountEnddate")[i].value;
   
	  if(discountRate!=""){	  
	   discountRateArray.push(discountRate);
	   discountBegindateArray.push(discountBegindate);
	   discountEnddateArray.push(discountEnddate);
	  }
  }
   
   /* alert("dr:"+discountRate);
   alert("dbd:"+discountBegindate);
   alert("ded:"+discountEnddate); */

   var param="";
   param+="productdetail_no="+productdetail_no+"&discount_rate="+discountRateArray+"&productdetail_price="+productdetail_price+"&discount_begindate="+discountBegindateArray+"&discount_enddate="+discountEnddateArray,true
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
         refreshForm();
         discountTableN.innerHTML="";
         discountTableY.innerHTML="";
      }
   };
   
   xmlhttp.open("post","./insertDiscount.do");
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send(param);   //url 인코디드방식?
}   

function updateDiscount(productdetail_no){
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   var productdetail_no = productdetail_no
   var length=document.getElementsByName("newDiscount_rate").length;

   for(var i=0; i<length; i++){ 
      var discount_rate = document.getElementsByName("newDiscount_rate")[i].value;
      var discount_enddate = document.getElementsByName("newDiscount_enddate")[i].value;
      var discount_price = document.getElementsByName("afDiscount_price")[i].value;
   }
   var con = confirm(productdetail_no+"번 상품의 할인 정보를 수정하시겠습니까?");
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
            
          refreshForm();
          discountTableN.innerHTML="";
          discountTableY.innerHTML="";
          
      }
   };
   if(con==true){
   alert(productdetail_no+"번 상품의 할인 정보가 성공적으로 수정되었습니다.");      
   xmlhttp.open("get","./updateDiscount.do?productdetail_no="+productdetail_no+"&discount_rate="+discount_rate+"&discount_enddate="+discount_enddate+"&discount_price="+discount_price, true);
   }else if(con==false){
   alert("취소하셨습니다.");      
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   }
   xmlhttp.send();   //url 인코디드방식?
}   

function deleteDiscount(productdetail_no){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   var productdetail_no = productdetail_no
   var con = confirm(productdetail_no+"번 상품의 할인을 삭제하시겠습니까?");
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
            
          refreshForm();
          discountTableN.innerHTML="";
          discountTableY.innerHTML="";
        
      }
   };
   if(con==true){   
      xmlhttp.open("get","./deleteDiscount.do?productdetail_no="+productdetail_no, true);
      alert("정상적으로 삭제되었습니다.");
   }else if(con==false){
      alert("취소되었습니다.");
      return;
   }
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   //url 인코디드방식?
}

 //할인자동마감
function expireDiscount(){
	var xmlhttp = new XMLHttpRequest();
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var today = year+"-"+month+"-"+day;
	var date1=new Date(today);
	var result1 = date1.toDateString();//오늘
	//alert(result1);
	
	var size = document.getElementsByName("endOfDiscountDay").length;
	for(var i=0; i<size; i++){
		var endOfDiscountDay = document.getElementsByName("endOfDiscountDay")[i].value;
		var date2=new Date(endOfDiscountDay);
		var result2 = date2.toDateString();//마감일
		var pdnoArray = new Array();
		var pdno =  document.getElementsByName("productdetail_noAppliedDiscount")[i].value;
			   
		//result1 = 오늘 날짜 // reuslt2 = 마감일
		if(result1 > result2){
	   		pdnoArray.push(pdno);
			
			
			//호출 후 값을 받았을때... 처리 로직....
			   xmlhttp.onreadystatechange = function(){
			      if(xmlhttp.readyState== 4 && xmlhttp.status == 200){
			         // var obj = JSON.parse(xmlhttp.responseText);
			         discountTableN.innerHTML="";
			         discountTableY.innerHTML="";
			         refreshForm();
			        
			         
					alert("마감날짜가 지나 할인된 상품디테일번호 "+pdno+"의 상품할인이 삭제되었습니다.");
			   
			      }
			   };
			   xmlhttp.open("post","./deleteDiscountForTime.do?productdetail_no="+pdnoArray);
			   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			   xmlhttp.send();   //url 인코디드방식? 
		}
	} 
}
</script>
<body onload="expireDiscount();refreshForm()">
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
   <jsp:include page="../commons/sidebar.jsp" flush="true"/>
   <div id="main">
      <input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
      <div id="wrapper">
       <div class="row mb-5">
	      <div class="col" style="color: #5b5b5b; font-size: 30px; font-weight: bold; text-align: left;">상품 할인등록</div>
	   </div>
	   <hr>
	   <div id="discountTableN"></div>
	   <div id="pagingBox" align="center">
	   <div class="row mb-5">
	      <div class="col" style="color: #5b5b5b; font-size: 30px; font-weight: bold; text-align: left;">등록된 할인수정/삭제</div>
	   </div>
	   <hr>
	   <div id="discountTableY"></div>
      </div>
     						 <!-- Modal -->
                                    <div class="modal fade" id="stockModal" tabindex="-1"
                                       aria-labelledby="exampleModalLabel" aria-hidden="true">
                                       <div class="modal-dialog modal-dialog-centered modal-dialog modal-lg">
                                          <div class="modal-content">
                                             <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
                                                   할인 수정
                                                </h5>
                                                <button type="button" class="btn-close"
                                                   data-dismiss="modal"></button>
                                             </div>
                                             <div class="modal-body" id="mBody">
                                             	<div id="tableBox"></div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
   <script type="text/javascript">
	//updateButton.setAttribute("onclick","updateDiscount("+sellerProductListY.productDetailVO.productdetail_no+")");
	function openModal(productdetail_no,e){
		var productdetailNo = e.closest("tr").querySelector(".productdetail_no").value;
		var size= document.getElementsByName("stockModalBtn").length;
		for(var i=0; i<size; i++){
		var button = document.getElementsByName("stockModalBtn");		
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				var modalbody=document.getElementById("mBody");
				
				//테이블
				var tableBox = document.getElementById("tableBox");
				 	tableBox.innerHTML = "";
				var setTable = document.createElement("table");
		          setTable.setAttribute("class","table table-hover");
		          var tr1 = document.createElement("tr");
		          setTable.appendChild(tr1);
		         	  var ytd8=document.createElement("td");
			          ytd8.innerText="옵션명";
			          tr1.appendChild(ytd8);
		         	  var ytd9=document.createElement("td");
			          ytd9.innerText="마감일 수정";
			          tr1.appendChild(ytd9);
			          var ytd10=document.createElement("td");
			          ytd10.innerText="할인율 변경(%)";
			          tr1.appendChild(ytd10);
			          var ytd11=document.createElement("td");
			          ytd11.innerText="할인 가격보기";
			          tr1.appendChild(ytd11);
			          var ytd12=document.createElement("td");
			          ytd12.innerText="최종 할인가";
			          tr1.appendChild(ytd12); 
			          var ytd13=document.createElement("td");
			          ytd13.innerText="버튼";
			          tr1.appendChild(ytd13); 
			             
		        	 var tr2 = document.createElement("tr");
		             setTable.appendChild(tr2);
			              //할인종료일 수정
			             var ydtd8 = document.createElement("td");
			             var OptionTitle= document.createElement("input");
			             OptionTitle.setAttribute("class","form-control");
			             OptionTitle.setAttribute("type","text");
			             OptionTitle.setAttribute("id","productdetail_option");
			             OptionTitle.setAttribute("name","productdetail_option");
			             OptionTitle.setAttribute("disabled","disabled");
			             OptionTitle.setAttribute("style","text-align:center");
			             OptionTitle.setAttribute("value",obj.sellerProductListYByPdno.productDetailVO.productdetail_option);
			             ydtd8.appendChild(OptionTitle);
			             tr2.appendChild(ydtd8);
			             
			             var ydtd9 = document.createElement("td");
			             var changeEndDate= document.createElement("input");
			             changeEndDate.setAttribute("class","form-control");
			             changeEndDate.setAttribute("type","date");
			             changeEndDate.setAttribute("id","newDiscount_enddate");
			             changeEndDate.setAttribute("name","newDiscount_enddate");
			             ydtd9.appendChild(changeEndDate);
			             tr2.appendChild(ydtd9);
			             
			             //할인율 수정
			             var ydtd10 = document.createElement("td");
			             var changeDiscountRate=document.createElement("input");
			             changeDiscountRate.setAttribute("class","form-control discount-rate");
			             changeDiscountRate.setAttribute("type","text");
			             changeDiscountRate.setAttribute("id","newDiscount_rate");
			             changeDiscountRate.setAttribute("name","newDiscount_rate");
			             changeDiscountRate.innerText="적용";
			             ydtd10.appendChild(changeDiscountRate);
			             tr2.appendChild(ydtd10);
			             
			             //가격보기
			             var ydtd11 = document.createElement("td");
			             var showPriceButton=document.createElement("button");
			             showPriceButton.setAttribute("onclick","ShowPrice("+obj.sellerProductListYByPdno.productDetailVO.productdetail_price+",this)");
			             showPriceButton.innerText="가격보기";
			             ydtd11.appendChild(showPriceButton);
			             tr2.appendChild(ydtd11);
			            
			             //최종할인가
			             var ydtd12 = document.createElement("td");
			             var showPriceButton=document.createElement("input");
			             showPriceButton.setAttribute("class","form-control show-price");
			             showPriceButton.setAttribute("type","text");
			             showPriceButton.setAttribute("id","afDiscount_price");
			             showPriceButton.setAttribute("name","afDiscount_price");
			             showPriceButton.setAttribute("placeholder","최종할인가");
			             ydtd12.appendChild(showPriceButton);
			             tr2.appendChild(ydtd12); 
			             var ydtd13 = document.createElement("td");
			             var updateButton=document.createElement("button");
			             updateButton.setAttribute("onclick","updateDiscount("+obj.sellerProductListYByPdno.productDetailVO.productdetail_no+")");
			             updateButton.setAttribute("name","discount_price");
			             updateButton.innerText="변경";
			             ydtd13.appendChild(updateButton); 
			             tr2.appendChild(ydtd13); 

		         			tableBox.appendChild(setTable);
		                    modalbody.appendChild(tableBox);
		         
			}
		};
			xmlhttp.open("post","./writeDiscountForModal.do", true);
		   	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		  	xmlhttp.send("productdetail_no="+productdetailNo);   //url 인코디드방식?
	}	
	
	function init(){
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
	}
   </script>
   </div>
</div>
</body>
</html>