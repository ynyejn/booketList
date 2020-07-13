<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 신고</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<style>
table {
	margin-top: 100px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	height: 50%;
}
.title{
	font-size: 2.2em;
}
#gogo {
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
td{
	font-size: 20px;
}
#complainCategory{
	 height: 30px;
	 font-size: 20px;
}
#yellow{
	background-color: #dddddd;
}

</style>
<body>
	<form action="/complain/complainInsert.do" method="post" id="yellow">
		<input type="hidden" name="memberId"
			value="${sessionScope.member.memberId}">
		<table>
			<tbody>
			<tr>
				<td colspan="2"><h1 class="title" >신고합니다</h1></td>
				</tr>
				<tr>
					<td>상대방 아이디 :</td>
					
					<td>${memberIds }<input type="hidden" name="attacker"
						value="${memberIds }">
				
					</td>
					
				</tr>
				
				<tr>
					<td>신고사유</td>
					<td><select id="complainCategory" name="complainCategory">
							<option id="complain1" value="욕설">욕설</option>
							<option id="complain1" value="음란물">음란물</option>
							<option id="complain1" value="성적인발언">성적인발언</option>
					</select></td>
				</tr>
				<tr>
					<td>신고내용 :</td>
					<td><c:if test="${empty complainContent  }">
							<input type="hidden" name="complainFilename" value="${fileName }">
							<img src="${fileName }">
						</c:if> <c:if test="${not empty complainContent  }">${complainContent }
		<input type="hidden" name="complainContent"
								value="${complainContent }">
							<input type="hidden" name="complainFilename" value="">
						</c:if></td>
				</tr>
				<tr>
					<td><input id="gogo" type="submit" value="등록하기"></td>
					<td><input type="button" id="cancle" onclick="window.close()"
						value="취소"></td>
				</tr>
			</tbody>
		</table>
	</form>

</body>
<script type="text/javascript">
	var ws;
	var memberId = '${sessionScope.member.memberId }';
	function connect() {
		ws = new WebSocket("ws://192.168.10.181/adminMsg.do");
		ws.onopen = function() {
			console.log("웹소켓 연결 생성");
		};
		ws.onmessage = function(e) {

		};
		ws.onclose = function() {
			console.log("연결종료");
		};
	}
	$(function() {
		connect();
		$("#gogo").click(function() {
			console.log("갓니");
			var msg = {
				type : "complainAlarmCount"

			}
			ws.send(JSON.stringify(msg));
		})
	})
</script>
</html>