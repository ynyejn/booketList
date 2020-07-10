<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		$(function() {
			$("#findIdBtn").click(function() {
				$.ajax({
					url : "/member/findId.do",
					type : "POST",
					data : {
						email : $("#memberEmail").val(),
						phone : $("#memberPhone").val()
					},
					success : function(mailCode) {
						alert(mailCode);
						location.href = "/";
					},
				})
			});
		})
	</script>
	<br>
	<br> email :
	<input type="email" id="memberEmail">
	<br>
	<br>
	<br> 휴대폰번호 :
	<input type="text" id="memberPhone">
	<br>
	<br>
	<button type="button" id="findIdBtn">메일발송</button>
</body>
</html>