<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting방</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style type="text/css">
	.${sessionScope.member.memberId}{
		margin: 0 auto;
		padding-left: 10px;
		
		background-color: antiquewhite;
		border: 1px solid antiquewhite;
		width: 30%;
		text-align: left;
		display: block;
        float: right;
        border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	.time{
		font-size : 0.7em;
	}

	#msgArea{
	width: 100%;
	height: 300px;
	overflow:auto;
	}
	#chatImg{
	color: white;
	line-height: 150px;
	float: left;
	display: block;
	border: 1px solid white;
	text-align: center;
	width: 100%;
	height: 150px;
	font-size : 2.5em;
	background-image: url(/resources/chat/bookChat.jpg);
	margin: 0 auot;
	background-size: 100%;
	}
	html{
	margin: 0 auot;
	padding: 0;
	}
</style>
</head>

<body>
<div id="chatImg">${c.chatTitle }오픈채팅방</div>
<form  id="ajaxFrom" method="post">

<input type="hidden" id="chatPeople"value="${c.chatPeople }">
<input type="hidden" id="chatTitle"value="${c.chatTitle }">
<input type="hidden" id="memberNickname"value="${c.memberNickname }">
<input type="file" name="file" id="file">
</form>
<div>
<div id="msgArea">
</div>
	<br>
	메세지 : <input type="text" id="chatMsg"><br>
	
	<button id="sendBtn" type="button" >전송</button>
	${sessionScope.member.memberNickname}
</div>
	
<script>
	var ws;
	var memberId = '${sessionScope.member.memberId}';
	var memberNickname = '${sessionScope.member.memberNickname}';
	var	title = $("#chatTitle").val();
	var	chatPeople = $("#chatPeople").val();
	

	function connect() {
		ws = new WebSocket("ws://192.168.10.16/openChatting.do?memberNickname="+memberNickname+" "+title);
		
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
			var chat = $("#msgArea").html()+msg+"<br>";
			$("#msgArea").html(chat);
			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
			
		}
		
		ws.onclose = function () {
		
			
			console.log("연결종료");
		}
		
		
	}
	$(function() {
		connect();
		
		$('#msgArea').scrollTop($('#msgArea').prop('scrollHeight'));


		$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 1000);
		let today = new Date();
	    let hours = today.getHours()<10?"0"+today.getHours():today.getHours(); // 시
	    let minutes = today.getMinutes()<10?"0"+today.getMinutes():today.getMinutes();  // 분
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
	   			var chat = "<div><input type='hidden' id='memberId' value='${sessionScope.member.memberId}'><p class='${sessionScope.member.memberId} chatp'><input type='hidden' id='fileName' value='"+fileName+"'>"+memberNickname+":<img id='img-view' width='200' src='"+fileName+"'><br><a href='javascript:fileDownload();'>다운로드</a><a  href='/complain/complain.do?memberId=${sessionScope.member.memberId }&fileName='"+fileName+"' onclick='window.open(this.href,'_blank',' location=no,width=500,height=600,toolbars=no,scrollbars=no'); return false;'>신고하기</a><span class='time'>"+hours+":"+minutes+"</span></p></div>";
	   			var msg = $("#msgArea").html()+chat;
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
	   			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
	            }
	              
	        });
			}else{
				var tit="window.open(this.href, '_blank', ' location=no,width=500,height=600,toolbars=no,scrollbars=no'); return false;";
				var chat = "<div style='margin: 0 auto;width:100%; overflow:hidden;'><input type='hidden' id='memberId' value='${sessionScope.member.memberId}'><p class='${sessionScope.member.memberId} chatp' id='chatMsgg'>"+memberNickname+":"+$("#chatMsg").val()+"<br><a  href='/complain/complain.do?memberId=${sessionScope.member.memberId }&complainContent="+$("#chatMsg").val()+"'  onclick='"+tit+"'>신고하기</a><span class='time'>"+hours+":"+minutes+"</span></p></div><br>";
	   			var msg = $("#msgArea").html()+chat;
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
	   			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
			}
	        
		});
		
	});
	function fileDownload() {
		var filepath=document.getElementById("fileName").value;
		console.log(filepath);
		var newFilepath = encodeURIComponent(filepath);
		location.href = "/chat/fileDownload.do?filepath=" + newFilepath;
	}
	</script>
</body>
</html>