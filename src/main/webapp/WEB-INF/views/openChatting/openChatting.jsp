<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style>
        .content {
            width: 1200px;
            overflow: hidden;
            margin: 120px auto 0 auto;
            height: 100%;
            background-color: aliceblue;
        }

</style>
</head>
<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<button>방만들기</button>
		<c:forEach var="list" items="${openChatting }">
		<a href="/chat/chat.do?chatTitle=${list.chatTitle }">
			${list.chatNo }<br>
			<input type="hidden" class="title" value="${list.chatTitle }">
			${list.chatTitle }<br>
			${list.chatPeople }<br>
			${list.chatPw }<br>
			${list.chatEnrollDate }<br>
			${list.memberNickname }<br>
			</a>
		</c:forEach>
			openChatting
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	var ws;
	
	var	title = document.getElementsByClassName("title");
	
	function connect() {
		ws = new WebSocket("ws://192.168.219.102/openChatting.do");
		ws.onopen = function () {
			console.log("웹소켓 연결 생성");
		for(var i=0;i<title.length;i++){
			var title2=$(".title").eq(i).val();
			var msg = {
					type : "type",
					title : title2
			}
			
			ws.send(JSON.stringify(msg));//스트링으로 풀어서 보내기 type : "register",memberId : 'tjehdrjs1230';
		}
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
	$(function () {
		console.log(title);
		connect();
		$("button").click(function () {
			window.name="apply"
			var url = "/chat/makingRoomFrm.do";
			var title = "도서 검색";
			var style = "width=400,height=400,top=100,left=400";
			window.open(url,title,style);
		});
	})
	
	</script>
</body>
</html>