<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 후기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style>
        .content {
            width: 1200px;
            overflow: hidden;
            margin:  120px auto 0 auto;
            height: 100%;
            background-color: aliceblue;
        }

</style>
</head>
<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<c:forEach var="list" items="${r }">
			${list.reviewNo }<br>
			${list.memberNickName }<br>
			${list.reviewContent }<br>
			${list.reviewScore }<br>
			${list.reviewFilename }<br>
			${list.reviewFilepath }<br>
			${list.bookName }<br>
			${list.bookPublisher }<br>
			${list.bookWriter }<br>
			${list.bookCategory }<br>
		</c:forEach>
		<button>후기 쓰기</button>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	$(function () {
		$("button").click(function () {
			window.name="apply"
			var url = "/review/reviewWriting.do";
			var title = "후기";
			var style = "width=400,height=400,top=100,left=400";
			window.open(url,title,style);
		});
	})
	window.opener.location.reload();
	window.close();
	</script>
</body>
</html>