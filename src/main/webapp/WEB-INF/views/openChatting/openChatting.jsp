<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<div class="content"></div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>