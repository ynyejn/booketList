<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

	<form action="/member/selectMember.do" method="post">
		아이디 : <input type="text" name="memberId">
		비밀번호 : <input type="password" name="memberPw">
		<input type="submit" value="로그인">	
	</form>
</body>
</html>