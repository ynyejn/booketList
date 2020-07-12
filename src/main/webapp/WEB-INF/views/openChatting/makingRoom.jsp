<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting만들기</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<style>
table {
	margin-top:100px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	height: 50%;
}

#roomBtn {
	border: none;
	background-color: #007bff;
	color: white;
	width: 160px;
	height: 40px;
	font-size: 14px;
	border-radius: 2px;
	display: inline-block;
	margin: 10px;
}

#cancle {
	border: none;
	background-color: #666666;
	color: white;
	width: 160px;
	height: 40px;
	font-size: 14px;
	border-radius: 2px;
	display: inline-block;
	margin: 0;
}

#name {
	font-size: 20px;
}

#box {
	width: 180px;
}
.title{
	font-size: 2.2em;
}
.chatTitle{
	width:100%;
	height: 30px;
	font-size: 1.5em;
}
.chatPeople{
	width:100%;
	height: 30px;
	font-size: 1.5em;
	
}
</style>
<body  onresize="parent.resizeTo(500,660)" onload="parent.resizeTo(500,660)">


	<form action="/chat/chat.do" method="post">

		<input type="hidden" name="memberNickname"
			value="${m.memberNickname }">
		<table>
			<tbody>
				<tr>
					<td colspan="2"><h1 class="title" >오픈 채팅 방만들기!</h1></td>
				</tr>
				<tr>
					<td id="name" colspan="2">방제목</td>
				</tr>
				<tr>
					<td id="box"colspan="2"><input type="text" class="chatTitle"name="chatTitle" required></td>
				</tr>
				<tr>
					<td colspan="2"><span id="titleSpan"></span></td>
				</tr>
				<tr>
					<td id="name"colspan="2">최대 인원수</td>
				</tr>
				<tr>
					<td id="box"colspan="2"><input type="text"class="chatPeople" name="chatPeople" required></td>
					</tr>
				<tr>
					<td colspan="2"><span id="titleSpan2"></span></td>
				</tr>
				
				<tr>
					<td><input type="submit" value="방만들기" id="roomBtn"></td>
					<td><input type="button" onclick="window.close()" value="취소"
						id="cancle"></td>
				</tr>
				

			</tbody>
		</table>
	</form>

	<script type="text/javascript">
		$(function() {

			$("input[name=chatTitle]").focusout(function() {

				if ($("input[name=chatTitle]").val() == "") {
					$("#titleSpan").html("제목을 입력해 주시기 바랍니다.");
					$("#titleSpan").css("color", "red");
				} else {
					$("#titleSpan").html("");
				}
			})
			$("input[name=chatPeople]").focusout(function() {

				var res = /^[0-9]*$/;
				if (!res.test($("input[name=chatPeople]").val())) {
					$("#titleSpan2").html("숫자만 입력 바랍니다.");
					$("#titleSpan2").css("color", "red");
				} else {
					if ($("input[name=chatPeople]").val() > 10) {
						$("#titleSpan2").html("최대인원수는 10명입니다.");
						$("#titleSpan2").css("color", "red");
					} else if ($("input[name=chatPeople]").val() < 2) {
						$("#titleSpan2").html("최소인원수는 2명입니다.");
						$("#titleSpan2").css("color", "red");
					} else {
						$("#titleSpan2").html("");
					}
				}
			})
			$("form").submit(function() {
				if ($("input[name=chatTitle]").val() == "") {
					$("#titleSpan").html("제목을 입력해 주시기 바랍니다.");
					$("#titleSpan").css("color", "red");
					return false;
				} else {
					$("#titleSpan").html("");
				}
				var res = /^[0-9]*$/;
				if (!res.test($("input[name=chatPeople]").val())) {
					$("#titleSpan2").html("숫자만 입력 바랍니다.");
					$("#titleSpan2").css("color", "red");
					return false;
				} else {
					if ($("input[name=chatPeople]").val() > 10) {
						$("#titleSpan2").html("최대인원수는 10명입니다.");
						$("#titleSpan2").css("color", "red");
						return false;
					} else if ($("input[name=chatPeople]").val() < 2) {
						$("#titleSpan2").html("최소인원수는 2명입니다.");
						$("#titleSpan2").css("color", "red");
						return false;
					} else {
						$("#titleSpan2").html("");
					}
				}
			})
		})
	</script>
</body>
</html>