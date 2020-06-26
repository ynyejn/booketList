<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting만들기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
<form action="/chat/chat.do" method="post">
<input type="hidden" name="memberNickname" value="${m.memberNickname }">
	방제목 : <input type="text" name="chatTitle"><span id="titleSpan"></span><br>
	최대 인원수 : <input type="text" name="chatPeople"><br>
	<input type="submit" value="방만들기"><input type="button" onclick="window.close()"value="취소">
</form>
<script type="text/javascript">
	$(function () {
		
		$("input[name=chatTitle]").focusout(function () {
			
			if($("input[name=chatTitle]").val() == ""){
				$("#titleSpan").html("제목을 입력해 주시기 바랍니다.");
			}else{
				$("#titleSpan").html("");
			}
		})
	})
</script>
</body>
</html>