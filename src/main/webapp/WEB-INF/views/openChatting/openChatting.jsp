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
		<a  href="/chat/chatRoom.do?title=${list.chatTitle }"  onclick="window.open(this.href, '_blank', 'width=400,height=300,toolbars=no,scrollbars=no'); return false;">
			${list.chatNo }<br>
			<input type="hidden" class="title" value="${list.chatTitle }">
			${list.chatTitle }<br>
			${list.chatPeople }<br>
			${list.chatEnrollDate }<br>
			${list.memberNickname }<br>
			현재 접속자수 ${list.chatPersonnel }
			<span class="span"></span><br>
			</a>
		</c:forEach>
			openChatting
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	$(function () {

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