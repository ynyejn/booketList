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
<script>
	var ws;
	var memberId = '${sessionScope.member.memberId}';
	var	result = $("#onon").val();
	var msg1 = {
			type : "delete",
			memberId : memberId,
			result : result
	}
	
	
	function connect() {
		ws = new WebSocket("ws://192.168.10.28/onon.do?memberId="+memberId+" "+result);
		
		ws.onopen = function () {
			console.log("웹소켓 연결 생성");
			console.log(result);
			var msg = {
					type : "register",
					memberId : memberId,
					result : result
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
		var	result = $("#onon").val();
		$("#sendBtn").click(function () {
			var chat = $("#chatMsg").val();
			var msg = $("#msgArea").val()+"\n나 : "+chat;
			$("#msgArea").val(msg);
			$("#chatMsg").val("");
			var sendMsg = {
					type : "chat",
					msg : chat,
					result : result,
					memberId : memberId
			};
			ws.send(JSON.stringify(sendMsg));
		});
	});
	</script>
</body>
</html>