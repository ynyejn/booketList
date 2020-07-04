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
<form  id="ajaxFrom" method="post">

<input type="hidden" id="chatPeople"value="${c.chatPeople }">
<input type="hidden" id="chatTitle"value="${c.chatTitle }">
<input type="hidden" id="memberNickname"value="${c.memberNickname }">
<input type="file" name="file" id="file">
</form>
<div id="msgArea"></div>

	<br>
	메세지 : <input type="text" id="chatMsg"><br>
	
	<button id="sendBtn" type="button">전송</button>
	${sessionScope.member.memberNickname}
<script>
	var ws;
	var memberNickname = '${sessionScope.member.memberNickname}';
	var	title = $("#chatTitle").val();
	var	chatPeople = $("#chatPeople").val();
	console.log(title);
	console.log(memberNickname);
	
	function connect() {
		ws = new WebSocket("ws://192.168.219.101/openChatting.do?memberNickname="+memberNickname+" "+title);
		
		ws.onopen = function () {
			console.log("웹소켓 연결 생성");
			console.log(title);
			var msg = {
					type : "register",
					memberNickname : memberNickname,
					title : title,
					chatPeople : chatPeople
			}
			
			ws.send(JSON.stringify(msg));//스트링으로 풀어서 보내기 type : "register",memberId : 'tjehdrjs1230';
		}
		
		ws.onmessage = function (e) {
			var msg = e.data;
			var chat = $("#msgArea").html()+"\n상대방 :"+msg;
			$("#msgArea").html(chat);
		}
		
		ws.onclose = function () {
		
			
			console.log("연결종료");
		}
		
		
	}
	$(function() {
		connect();
		var	title = $("#chatTitle").val();
		$("#sendBtn").click(function () {
	        var form = $("#ajaxFrom")[0];
	        var formData = new FormData(form);
	        var fileName = "";
	        formData.append("file", $("#file")[0].files[0]);
			if($("#file")[0].files[0]!=null){
				
	        $.ajax({
	              url : "/chat/ajaxFormReceive.do"
	            , type : "POST"
	            , processData : false
	            , contentType : false
	            , data : formData
	            , success:function(data) {
	            	console.log(data);
	               fileName = data;
	               console.log(fileName);
	   			var chat = "<div><img id='img-view' width='350' src='"+fileName+"'></div>";
	   			var msg = $("#msgArea").html()+"\n나 : "+chat;
	   			$("#file").val("");
	   			$("#msgArea").html(msg);
	   			$("#chatMsg").val("");
	   			var sendMsg = {
	   					type : "chat",
	   					msg : chat,
	   					title : title,
	   					memberNickname : memberNickname
	   			};
	   			var socketMsg = JSON.stringify(sendMsg);
	   			ws.send(socketMsg);
	            }
	              
	        });
			}else{
				var chat = "<div>"+$("#chatMsg").val()+"</div>";
	   			var msg = $("#msgArea").html()+"\n나 : "+chat;
	   			$("#msgArea").html(msg);
	   			$("#chatMsg").val("");
	   			var sendMsg = {
	   					type : "chat",
	   					msg : chat,
	   					title : title,
	   					memberNickname : memberNickname
	   			};
	   			var socketMsg = JSON.stringify(sendMsg);
	   			ws.send(socketMsg);
			}
	        
		});
	});
	</script>
</body>
</html>