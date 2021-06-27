<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#container{
	min-height:100%;
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
#main{float:left; width:80%; min-height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
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
    min-height:100%;
    overflow:scroll;
 }
#wrapper::-webkit-scrollbar {display: none; /* Chrome, Safari, Opera*/}
#piecharts{padding-bottom:75px;}
#wwwww{padding-bottom:100px;}
</style>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
/* 차트뽑기 */
google.charts.load('current', {'packages':['corechart', 'bar']});
//google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var date = date.getDate();
	var today = year+"/"+month+"/"+date;
	var order_orderdate = today;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			
			var obj = JSON.parse(xmlhttp.responseText);
			
			TotalLength = [];
			titleList = [];
			
			/* 클릭비율 차트 */
			var ClickDataKeys = [];
			var ClickDataValues = [];
			var the_Click_datas = [];
			
			ClickDataKeys.push("PRODUCT_NAME");
			ClickDataKeys.push("PRODUCT_READCOUNT");
			the_Click_datas.push(ClickDataKeys);
			for (var i = 0; i < obj.clickData.length; i++) {
				
				console.log("length:"+obj.clickData.length); //2
				console.log("product_name:"+obj.clickData[i].PRODUCT_NAME);
				console.log("product_readCount:"+obj.clickData[i].PRODUCT_READCOUNT);
				
				ClickDataValues.push(obj.clickData[i].PRODUCT_NAME);
				ClickDataValues.push(obj.clickData[i].PRODUCT_READCOUNT);
				the_Click_datas.push(ClickDataValues);
				
				ClickDataValues = [];
				
			}
			console.log("the click datas:"+the_Click_datas);
			TotalLength.push(the_Click_datas);
			titleList.push("상품 접속통계");
			
			
			/* 랭킹 차트 */
			var rankingDataKeys = [];
			var rankingDataValues = [];
			var the_ranking_datas = [];
			
			rankingDataKeys.push("PRODUCT_NAME");
			rankingDataKeys.push("ORDERCNT");
			the_ranking_datas.push(rankingDataKeys);
			for (var i = 0; i < obj.rankingData.length; i++) {
				
				rankingDataValues.push(obj.rankingData[i].PRODUCT_NAME);
				rankingDataValues.push(obj.rankingData[i].ORDERCNT);
				the_ranking_datas.push(rankingDataValues);
				
				rankingDataValues = [];
				
			}
			TotalLength.push(the_ranking_datas);
			titleList.push("판패상품 순위");
			
			/* 일별 판매량 차트 */
			var getDateDataKeys = [];
			var getDateDataValues = [];
			var the_DateData_datas = [];
			
			getDateDataKeys.push("ORDER_PRICE");
			getDateDataKeys.push("매출액");
			the_DateData_datas.push(getDateDataKeys);
			for (var i = 0; i < obj.getDateData.length; i++) {
				console.log("length:"+obj.getDateData.length); //2
				console.log("ORDER_PRICE:"+obj.getDateData[i].AA);
				console.log("ORDER_ORDERDATE:"+moment(obj.getDateData[i].BB).format("YYYY-MM-DD"));
				
				getDateDataValues.push(moment(obj.getDateData[i].BB).format("YYYY-MM-DD"));//시간
				getDateDataValues.push(obj.getDateData[i].AA);//매출액
				the_DateData_datas.push(getDateDataValues);
				
				getDateDataValues = [];
				
			}
			TotalLength.push(the_DateData_datas);
			titleList.push("일간 판매액");
			
			for (var i = 0; i < TotalLength.length - 1; i++) {
				
				var data = google.visualization.arrayToDataTable(TotalLength[i]);
				
				var options = {
				  title: titleList[i]
				};
				
				var piecharts = document.getElementById('piecharts');
				var piechart = document.createElement("div");
				piecharts.appendChild(piechart);
				piechart.setAttribute("class","piechart");
				/* piechart.setAttribute("style","width: 900px; height: 500px;"); */
				
				var chart = new google.visualization.PieChart(document.getElementsByClassName('piechart')[i]);
			
				chart.draw(data, options);
				
			}
			
			
			
			
			//...test
			var data1 = google.visualization.arrayToDataTable(TotalLength[2]);
			 var options1 = {
				        title: '전일 대비 판매액 비교',
				        chartArea: {width: '50%'},
				        hAxis: {
				          title: '매출액(원)',
				          minValue: 0
				        },
				        vAxis: {
				          title: '날짜'
				        }
				      };
			var chart1 = new google.visualization.BarChart(document.getElementById('wwwww'));

		     chart1.draw(data1, options1);
			
			
		}
	};
	
	xmlhttp.open("post","./getStatistics.do" , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(); 

}
</script>
</head>
<body onload="drawChart()">
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<div id="wrapper">
			<div class="row mb-5">
			   <div class="col" style="color: #5b5b5b; font-size: 30px; font-weight: bold; text-align: left;">통계분석</div>
			 </div>
			   <hr>
			<div id="piecharts"></div>
			<div id="wwwww"></div>
		</div>
	</div>
</div>
</body>
</html>