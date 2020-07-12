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
<style>
	#makeRoom {
	background-color: #00a3e0;
	font-color: #3cbcc7;
	border-radius: 2px;
	border-color: #00a3e0;
	color: white;
	
}
#cancle {
	background-color: #666666;
	font-color: #3cbcc7;
	border-radius: 2px;
	border-color: #303538;
	color: white;
}
</style>
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
				}else{
					$("#titleSpan2").html("");
				}
			}
		})
	})
</script>
<body>
<table>
<form action="/chat/chat.do" method="post">
<input type="hidden" name="memberNickname" value="${m.memberNickname }">
<tbody>
	<tr>방제목 : <input type="text" name="chatTitle" id="chatTitle"><span id="titleSpan"></span></tr>
	<tr>최대 인원수 : <input type="text" name="chatPeople" id="chatPeople"><span id="titleSpan2"></span></tr>
	<tr><input type="submit" value="방만들기" id="makeRoom"></tr>
	<tr><input type="button" onclick="window.close()"value="취소" id="cancle"></tr>
	</tbody>
</form>
</table>
</body>
</html>