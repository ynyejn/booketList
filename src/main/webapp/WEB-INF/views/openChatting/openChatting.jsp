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
            height: 900px;
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
			${list.chatNo }<br>
			${list.chatTitle }<br>
			${list.chatFilepath }<br>
			${list.chatPeople }<br>
			${list.chatPw }<br>
			${list.chatEnrollDate }<br>
			${list.memberNickname }<br>
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