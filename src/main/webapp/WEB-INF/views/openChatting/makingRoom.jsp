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
	방제목 : <input type="text" name="chatTitle" required><span id="titleSpan"></span><br>
	최대 인원수 : <input type="text" name="chatPeople" required><span id="titleSpan2"></span><br>
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
		$("input[name=chatPeople]").focusout(function () {
			
			var res=/^[0-9]*$/;
			if(!res.test($("input[name=chatPeople]").val())){
				$("#titleSpan2").html("숫자만 입력 바랍니다.");
			}else{
				if($("input[name=chatPeople]").val()>10){
					$("#titleSpan2").html("최대인원수는 10명입니다.");
				}else if($("input[name=chatPeople]").val()<2){
					$("#titleSpan2").html("최소인원수는 2명입니다.");
				}else{
					$("#titleSpan2").html("");
				}
			}
		})
		$("form").submit(function () {
			if($("input[name=chatTitle]").val() == ""){
				$("#titleSpan").html("제목을 입력해 주시기 바랍니다.");
				return false;
			}else{
				$("#titleSpan").html("");
			}
			var res=/^[0-9]*$/;
			if(!res.test($("input[name=chatPeople]").val())){
				$("#titleSpan2").html("숫자만 입력 바랍니다.");
				return false;
			}else{
				if($("input[name=chatPeople]").val()>10){
					$("#titleSpan2").html("최대인원수는 10명입니다.");
					return false;
				}else if($("input[name=chatPeople]").val()<2){
					$("#titleSpan2").html("최소인원수는 2명입니다.");
					return false;
				}else{
					$("#titleSpan2").html("");
				}
			}
		})
	})
</script>
</body>
</html>