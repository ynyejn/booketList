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
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url : "/member/findPw.do",
				type : "POST",
				data : {
					id : $("#memberId").val(),
					email : $("#memberEmail").val()
				},
				success : function(result) {
					alert(result);
					location.href="/";
				},
			})
		});
	})
</script>
<br> 회원아이디 : <input type="text" id="memberId"><br>
				<br> email : <input type="email" id="memberEmail"><br><br>
				<button id="findBtn">메일발송</button>
</body>
</html>