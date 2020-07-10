<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 신고</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<form action="/complain/complainInsert.do" method="post">
			신고자 : ${sessionScope.member.memberId}<br> <input type="hidden" name="memberId" value="${sessionScope.member.memberId}">
			신고당한 아이디 :${memberIds }<br><input type="hidden" name="attacker" value="${memberIds }">
	신고 사유 <input type="text" name="complainCategory"><br>
	신고내용 :
	<c:if test="${empty complainContent  }">
		<input type="hidden" name="fileName" value="${fileName }">
	</c:if>
	<c:if test="${not empty complainContent  }">
		<input type="hidden" name="complainContent" value="${complainContent }">
		<input type="hidden" name="fileName">
	</c:if>
		<input type="submit" value="등록하기"><input type="button" onclick="window.close()" value="취소">
	</form>

</body>
<script type="text/javascript">
var ws;
var memberId = '${sessionScope.member.memberId }'; 
function connect(){
	ws = new WebSocket("ws://192.168.10.16/adminMsg.do");
	ws.onopen = function(){
		console.log("웹소켓 연결 생성");
		var msg = {
				type : "output"
		};
		ws.send(JSON.stringify(msg));
	};
	ws.onmessage = function(e){
		
		
	
	};
	ws.onclose = function(){
		console.log("연결종료");
	};
}
$(function() {
	connect();
	$("from").submit(function () {
		var msg = {
			type : "complainAlarmClick"
			
		}
		ws.send(JSON.stringify(msg));
	})
})
</script>
</html>