<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
</head>
<style>
.content {
	width: 100%;
	overflow: hidden;
	margin: 120px auto 0 auto;
	height: 600px;
	background-color: #f3f5f7;
	font-size: 14px;
}

#findIdBtn {
	
	border: none;
	background-color: #666666;
	color: white;
	width: 222px;
	height: 38px;
	font-size: 14px;
	border-radius: 2px;
	margin-left:50px;
	}

label {
	font-weight: bold;
}

table {
	margin: 0 auto;
	font-size: 16px;
}

.form-group {
	margin: 0 auto;
}

#form1 {
	margin: 0 auto;
}

h2 {
	text-align: center;
}
</style>
<body>
	<script>
		$(function() {
			$("#findIdBtn").click(function() {
				$.ajax({
					url : "/member/findPw.do",
					type : "POST",
					data : {
						id : $("#memberId").val(),
						email : $("#memberEmail").val()
					},
					success : function(result) {
						alert("메일이 발송되었습니다.");
						location.href = "/";
					},
				})
			});
		})
	</script>
	<div class="content">
		<h2>비밀번호 찾기</h2>
		<div class="form-group" id='form1'>
			<table>
				<tbody>
					<tr>
						<td><label for="id">회원아이디 : </label></td>
						<td><input type="text" class="form-control" id="memberId"
							name="memberId" placeholder="ID" style="width: 200px;"></td>
					</tr>
					<tr>
						<td><label for="id"> email :</label></td>
						<td><input type="email" class="form-control" id="memberEmail"
							name="memberEmail" placeholder="EMAIL" style="width: 200px;"></td>
					</tr>

					<tr>
						<td colspan="2"><button type="button" id="findIdBtn">메일발송</button></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>