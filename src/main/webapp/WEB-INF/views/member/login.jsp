<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 120px auto 0 auto;
	height: 1200px;
	background-color: aliceblue;
}
td {
	border: 1px solid #eeeeee;
	border-collapse: collapse;
}
h2{
	text-align:center;
}

#login2 {
	margin: 0 auto;
	overflow: hidden;
	width: 500px;
}
#loginBtn {
	background-color: #00a3e0;
	font-color: #3cbcc7;
	border-radius: 2px;
	border-color: #00a3e0;
	color: white;
	width: 440px; 
	margin: 0 auto;
}
#findIdbtn{
	background-color: #666666;
	font-color: #3cbcc7;
	border-radius: 2px;
	border-color: #303538;
	color: white;
	width: 440px; 
}
#findPwbtn
{
	background-color: #666666;
	font-color: #3cbcc7;
	border-radius: 2px;
	border-color: #303538;
	color: white;
	width: 440px; 
}
</style>
<script>
	$(function(){
		$("#findPwbtn").click(function(){
			location.href='/member/findPwFrm.do';
		});
	});
	$(function(){
		$("#findIdbtn").click(function(){
			location.href='/member/findIdFrm.do';
		});
		if( ${fail } != null){
			alert("아이디 또는 비밀번호를 확인해주세요.");
		}
	});
</script>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<form id="login2" action="/member/login.do" method="post">
			<br><br>
				<h2>로그인</h2>
				<br><br>
				 <c:if test="${sessionScope.member.memberId eq 'admin' }">
				 <a href="adminPage.do">
				 </c:if>
				<div class="form-group">
						<label for="id">아이디</label> 
						<input type="text"class="form-control" id="memberId" name="memberId"placeholder="ID" style="width: 430px;"><br>
				</div>
				<div class="form-group">
						<label for="id">비밀번호</label> 
						<input type="password"class="form-control" id="memberPw" name="memberPw" placeholder="PASSWORD" style="width: 430px;"><br>
				</div>
				
				<input type="submit" value="로그인" id="loginBtn"><br><br>
				<button type="button" id="findIdbtn">아이디찾기</button><br><br>
				<button type="button" id="findPwbtn">비밀번호 찾기</button><br><br>
				
			</form>	
			
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>