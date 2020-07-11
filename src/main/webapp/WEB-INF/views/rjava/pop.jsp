<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pop Up</title>
<script>

function hidestatus() {
	window.status=''
	return true
}
if (document.layers) {
	document.captureEvents(Event.mouseover | Event.mouseout)
	document.onmouseover=hidestatus
	document.onmouseout=hidestatus
}

</script>
<style>
	body {
		text-align : center;
	}
	p {
		line-height : 10px;
	}
</style>
</head>
<body onLoad="setTimeout(window.close, 3000)">
	<p style='font-weight:bold; font-size:14px;'>로딩중입니다!</p>
	<p style='font-weight:bold; font-size:14px;'>잠시만 기다려주세요!</p>
	<img src="/resources/imgs/loading.gif"><br>
</body>
</html>