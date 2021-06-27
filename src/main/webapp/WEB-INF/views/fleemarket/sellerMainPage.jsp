<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   a:link{
      text-decoration:none;
   }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script>


	 function detailList(no){
	


		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var obj = JSON.parse(xmlhttp.responseText);
				
				var orderFleeMarketList = document.getElementById("orderFleeMarketList");
				var hiddenForm = document.getElementById("hidden");
				
				orderFleeMarketList.innerHTML ="";
				
				for(totalMap of obj.totalMap){
					var tr = document.createElement("tr");
					orderFleeMarketList.appendChild(tr);
					
					var td1 = document.createElement("td");
					td1.innerText = totalMap.CNAME;
					tr.appendChild(td1);
					
					var td2 = document.createElement("td");
					td2.innerText = totalMap.FLEEMARKET_NAME;
					tr.appendChild(td2);
					
					var td3 = document.createElement("td");
					td3.innerText = totalMap.FLEEMARKETDETAIL_OPTION;
					tr.appendChild(td3);
					
					var td4 = document.createElement("td");
					td4.innerText = totalMap.FLEEMARKETDETAIL_COUNT;
					tr.appendChild(td4);
					
					var td5 = document.createElement("td");
					td5.innerText = totalMap.TOTAL_PRICE;
					tr.appendChild(td5);
					
					/*
					var input1 = document.createElement("input");
					input1.setAttribute("class","ttt1");
					input1.setAttribute("type","hidden");
					input1.setAttribute("name","fleemarketdetail_no");
					input1.value = orderData.fleeMarketDetailVO.fleemarketdetail_no;
					hiddenForm.appendChild(input1);
					
					var input2 = document.createElement("input");
					input1.setAttribute("class","ttt2");
					input2.setAttribute("type","hidden");
					input2.setAttribute("name","fleemarketdetail_count");
					input2.value = orderData.fleemarketCount;
					hiddenForm.appendChild(input2);
					*/
					
				}
			}
		};
		
		xmlhttp.open("post", "${pageContext.request.contextPath}/fleemarket/orderDataLoarding.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("fleemarket_no=" + no);
		
		}

</script>
</head>
<body>

   


<div class="container">
   <div class="row">
   	<jsp:include page="/WEB-INF/views/commons/headerForSeller.jsp"></jsp:include>
   </div>   
   <div class="row mb-5">
   <div class="col text-center" style="color: #5b5b5b; font-size: 40px; font-weight: bold; text-align: left;">공동구매 상품목록 리스트</div>
   </div>     
   <div class="row mt-4 text-center">      
      <div class="col-1 btn btn-warning">글 번호</div>
      <div class="col-1 btn btn-warning">상품이름</div>
      <div class="col-3 btn btn-warning">상품제목</div>
      <div class="col-1 btn btn-warning">수량</div>
      <div class="col-1 btn btn-warning">신청자수</div>
      <div class="col-1 btn btn-warning">시작일</div>
      <div class="col-1 btn btn-warning">마감일</div>
      <div class="col-2 btn btn-warning">작성일</div>
      <div class="col-1 btn btn-warning">진행현황</div>               
   </div>            
      <jsp:useBean id="today" class="java.util.Date"></jsp:useBean>
      <fmt:parseNumber value="${today.time/(1000*60*60*24)}" var="now" integerOnly="true" />
   <c:forEach items="${fleeMarketList}" var="fleeMarket">
   
      <div class="row text-center" style="border:solid 1px;">      
         <div class="col border-end">${fleeMarket.fleeMarketVO.fleemarket_no }</div>
         <div class="col border-end">${fleeMarket.fleeMarketVO.fleemarket_name }</div>
         <div class="col-3 border-end"><a href="./readSellerFleeMarketContentPage.do?fleemarket_no=${fleeMarket.fleeMarketVO.fleemarket_no }">${fleeMarket.fleeMarketVO.fleemarket_title}</a></div>
         <div class="col border-end">${fleeMarket.fleeMarketVO.fleemarket_remainqty}/${fleeMarket.fleeMarketVO.fleemarket_itemqty}</div>
         <div class="col border-end">
         <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="detailList(${fleeMarket.fleeMarketVO.fleemarket_no})">${fleeMarket.applicantCount}
         </button>
         </div>
         <!-- Modal -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			
			  <div class="modal-dialog modal-lg" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel">고객님 구매현황</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <!-- body -->
					   <div id="container">
					   
					   <div id="main">
					      <div id="wrapper">
					         <hr>
					         <table class="table table-hover">
					      
					            <tbody>
					            
					            <tr>
					               <td>구매자 이름</td>
					               <td>상품명</td>
					               <td>상품옵션</td>
					               <td>주문개수</td>
					               <td>총 가격</td>
					            </tr>
					            </tbody>
					            <tbody id="orderFleeMarketList">

					            </tbody>
					           
					         </table>
					      </div>
					   </div>
					</div>
			        
			        
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-warning" style="background-color: #fccc0c !important; border: none;" data-bs-dismiss="modal">확인</button>
			      </div>
			    </div>
			  </div>
			 
			</div>
         <fmt:parseNumber value="${fleeMarket.fleeMarketVO.fleemarket_startdate.time/(1000*60*60*24)}" var="startdate" integerOnly="true" />
         <fmt:parseNumber value="${fleeMarket.fleeMarketVO.fleemarket_enddate.time/(1000*60*60*24)}" var="enddate" integerOnly="true" />
         <c:set value="${startdate-now}" var="daydiff2" />
         <c:choose>
	         <c:when test="${startdate-now > 0}">
	         	<div class="col-1 border-end">오픈전</div>
	         </c:when>
            <c:when test="${enddate-now < 0}">
               <div class="col-1 border-end">구매불가</div>
            </c:when>
            <c:otherwise>
               <div class="col-1 border-end">구매가능</div>
            </c:otherwise>
         </c:choose>
         <c:set value="${enddate-now}" var="daydiff" />
         <c:choose>
            <c:when test="${enddate-now < 0 }">
               <div class="col-1 border-end">마감</div>
            </c:when>
            <c:when test="${startdate-now > 0 }">
            	<div class="col-1 border-end">${startdate-now }일 전</div>
            </c:when>
            <c:otherwise>
               <div class="col-1 border-end">${daydiff}일 남음</div>
            </c:otherwise>
         </c:choose>
            <div class="col-2"><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${fleeMarket.fleeMarketVO.fleemarket_writedate}"/></div>
            <div class="col border-end">${fleeMarket.fleeMarketVO.fleemarket_statusnm}</div>
      </div>
   </c:forEach>   
   <div class="row mt-4">
      <div class="col"></div>
      <div class="col text-senter">
         <nav aria-label="Page navigation example">
           <ul class="pagination justify-content-center">
              <c:choose>
                 <c:when test="${beginPage <= 1 }">   
                   <li class="page-item disabled">
                     <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${beginPage - 1}">Prev</a>
                   </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${beginPage - 1}">Prev</a>
                   </li>
               </c:otherwise>
            </c:choose>
            
               <c:forEach begin="${beginPage }" end="${endPage }" var="page">
                  <c:choose>
                     <c:when test="${page == currentPage }">
                        <li class="page-item active">
                           <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${page}">${page}</a>
                        </li>   
                     </c:when>
                     <c:otherwise>
                        <li class="page-item">
                           <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${page}">${page}</a>
                        </li>
                     </c:otherwise>
                  </c:choose>
               </c:forEach> 
               
               <c:choose>
                   <c:when test="${endPage >= totalPageCount }">
                      <li class="page-item disabled">
                        <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${endPage + 1}">Next</a>
                      </li>
                   </c:when>
                   <c:otherwise>
                      <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/fleemarket/sellerMainPage.do?page_num=${endPage + 1}">Next</a>
                      </li>
                   </c:otherwise>
               </c:choose>
           </ul>
         </nav>
      </div>
      <div class="col text-end">
         <c:if test="${!empty sessionSeller }">
         <button type="button" class="btn btn-outline-warning" onclick="location.href='./writeFleeMarketPage.do'">
            <img src="${pageContext.request.contextPath }/resources/img/writeimg.jpg" width="50" height="50">
         </button>
         </c:if>
      </div>
   </div>   
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
      
      
</body>
</html>