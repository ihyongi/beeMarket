<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#alarm{
		background-color: #ffffff;
		border: 1px solid #cccccc;
		width: 300px;
		height: 100px;
		position: fixed;
		right: 10px;
		bottom: 10px;
		z-index: 100;
	}
</style>
</head>
<body>


<div id="alarm" style="display:none;">
	<div class="col">
		<div class="row">
			<div class="col">ALARM</div>
		</div>
	
	</div>
</div>

<script type="text/javascript">

	function sendAlarm() {
		
	}
	
	
	function initInteval(){
		setInterval(sendAlarm, 5000);
	}
	window.addEventListener('DOMContentLoaded' , initInteval);
	
</script>


</body>
</html>