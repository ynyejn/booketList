<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 120px auto 0 auto;
	height: 900px;
	background-color: aliceblue;
}
</style>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<form action="/join.do" method="post">
			<h2>회원가입</h2>
			아이디  <input type="text" name="memberId"><br>
			비밀번호 <input type="password" name="memberPw"><br>
			비밀번호 확인 <input type="password" name="memberPw"><br>
			이름 <input type="text" name="memberName"><br>
			닉네임 <input type="text" name="memberNickname"><br>
			
		</form>	
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>