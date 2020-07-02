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
            height: 100%;
            background-color: aliceblue;
        }

</style>
</head>
<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<h1>도서 신청</h1>
			<button>도서 검색</button>
			<form action="/apply/applyInsert.do" method="post">
			<input type="hidden" name="memberId" value="${sessionScope.member.memberId }">
				<table>
					<tr>
						<th>도서이름</th>
						<th>
						<input type="text" id="bookName" name="bookName" value="">
						</th>
					</tr>
					<tr>
						<th>출판일</th>
						<th>
						<input type="text" id="bookPubDates" name="bookPubDates">
						</th>
					</tr>
					<tr>
						<th>작가</th>
						<th>
						<input type="text" id="bookWriter" name="bookWriter">
						</th>
					</tr>
					<tr>
						<th>출판사</th>
						<th>
						<input type="text" id="bookPublisher" name="bookPublisher">
						</th>
					</tr>
					<tr>
						<th>카테 고리</th>
						<th>
						<input type="text" id="bookCategory" name="bookCategory">
						</th>
					</tr>
					<tr>
						<th>이미지</th>
						<td><img id="bookImg1"name="bookImg1" width="300px" height="150px" >
						<input type="text" id="bookImg" name="bookImg">
						</td>
					</tr>
					<tr>
						<th>도서내용</th>
						<th><input type="text" id="bookContent" name="bookContent"></th>
					</tr>
					<tr>
						<th>신청 사유</th>
						<th><textarea name="applyContent" rows="5" cols="30"></textarea></th>
					</tr>
					<tr>
						<td><input type="submit" value="신청하기"></td>
						<td><a href="/">취소</a></td>
					</tr>
				</table>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
<script type="text/javascript">
	$(function () {
		$("button").click(function () {
			window.name="apply"
			var url = "/apply/applySearch.do";
			var title = "도서 검색";
			var style = "width=400,height=400,top=100,left=400";
			window.open(url,title,style);
		});
	})
</script>
</body>
</html>