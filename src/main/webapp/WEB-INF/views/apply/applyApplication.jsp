<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 도서신청</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style>
        .content {
            width: 1200px;
            overflow: hidden;
            margin: 120px auto 0 auto;
            height: 900px;
            background-color: aliceblue;
        }

</style>
</head>
<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<h1>도서 신청</h1>
			<form action="/apply/applyInsert.do" method="get">
				<table>
					<tr>
						<th>도서이름<th>
						<th></th>
					<tr>
					<tr>
						<th>출판일</th>
						<th></th>
					</tr>
					<tr>
						<th>작가</th>
						<th></th>
					</tr>
					<tr>
						<th>출판사</th>
						<th></th>
					</tr>
					<tr>
						<th>카테 고리</th>
						<th></th>
					</tr>
					<tr>
						<th>이미지</th>
						<td></td>
					</tr>
				</table>
			</form>
			
			${sessionScope.member.memberId }
			신청 사유
			도서 이름 : 
			<textarea rows="5" cols="30"></textarea>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>