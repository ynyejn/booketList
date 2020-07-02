<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting방</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<input type="hidden" id="title"value="${c.chatPeople }">
<input type="hidden" id="title"value="${c.chatTitle }">
<input type="hidden" id="title"value="${c.memberNickname }">
<textarea rows="5" cols="30" id="msgArea"></textarea>
	<br>
	메세지 : <input type="text" id="chatMsg"><br>
	
	<button id="sendBtn">전송</button>
	${sessionScope.member.memberNickname}
<script>
	var ws;
	var memberNickname = '${sessionScope.member.memberNickname}';
	var	title = $("#title").val();

	
	function connect() {
		ws = new WebSocket("ws://192.168.219.102/openChatting.do?memberNickname="+memberNickname+" "+title);
		
		ws.onopen = function () {
			console.log("웹소켓 연결 생성");
			console.log(title);
			var msg = {
					type : "register",
					memberNickname : memberNickname,
					title : title
			}
			
			ws.send(JSON.stringify(msg));//스트링으로 풀어서 보내기 type : "register",memberId : 'tjehdrjs1230';
		}
		
		ws.onmessage = function (e) {
			var msg = e.data;
			var chat = $("#msgArea").val()+"\n상대방 :"+msg;
			$("#msgArea").val(chat);
		}
		
		ws.onclose = function () {
		
			
			console.log("연결종료");
		}
		
		
	}
	$(function() {
		connect();
		var	title = $("#title").val();
		$("#sendBtn").click(function () {
			var chat = $("#chatMsg").val();
			var msg = $("#msgArea").val()+"\n나 : "+chat;
			$("#msgArea").val(msg);
			$("#chatMsg").val("");
			var sendMsg = {
					type : "chat",
					msg : chat,
					title : title,
					memberNickname : memberNickname
			};
			var socketMsg = JSON.stringify(sendMsg);
			ws.send(socketMsg);
		});
	});
	</script>
</body>
</html>