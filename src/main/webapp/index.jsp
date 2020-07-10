<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List</title>
</head>

<body style="line-height: normal;">
	<div class="wrapper"">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content2">
			<img src="/resources/imgs/library2.jpg">
			<div class="main">
				<div>
					<img src="/resources/imgs/whitelogo2.png"><br> <label
						for="keyword2">
						<form action="/rent/searchBookDetail.do" method="get" class="searchForm two" id="two">
							<label for="search"><img src="/resources/imgs/fDot.png"></label>
							<input type="text" placeholder="필요한 도서정보에 대해 검색해보세요~!"
								id="keyword2"   name="inputText" value="${inputText }"><input type="submit" id="search2">
							<img src="/resources/imgs/x.png" id="x">
							<input type="hidden" name="categorySelect" value="">
					<input type="hidden" name="bookAttr" value="book_name">
					<input type="hidden" name="reqPage" value="1">
					<input type="hidden" name="sort" value="book_name">
						</form>
					</label>
				</div>
			</div>
		</div>
		<div class="content"></div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

	</div>
</body>
</html>
<style>
.content2 {
	margin-top: 120px;
	overflow: hidden;
	width: 100%;
	background-color: black;
	position: relative;
}
.content{
width:1200px;
margin:0 auto;
height:500px;
}

.content2>img {
	vertical-align: middle;
	width: 100%;
	opacity: 85%;
}

.main {
	position: absolute;
	display: block;
	top: 180px;
	left: 0;
	width: 100%;
}

.main>div {
	width: 800px;
	margin: 0 auto;
	text-align: left;
}

.main>div>img {
	width: 350px;
}

#two {
	text-align: left;
	width: 800px;
	height: 45px;
	line-height: 45px;
	background-color: white;
	border-radius: 4px;
	border: 5px solid lightgray;
	box-shadow: 5px 8.7px 5px rgba(0, 0, 0, .05);
	margin: 0;
}

.searchForm {
	height: 37px;
	background-color: #eee;
	font-size: 14px;
	border: 1px solid transparent;
	width: 90%;
	margin: 0 auto;
	margin-top: 10px;
}

#search, #search2 {
	display: none;
}

.searchForm input[type="text"] {
	font-size: 13px;
	width: 350px;
	border: none;
	background: none;
	outline: none;
}

#two>label>img {
	width: 21px;
	height: 21px;
	padding-left: 7px;
	opacity: 75%;
	vertical-align: text-top;
}

#two>input[type=text] {
	width: 600px;
	font-size: 16px;
	color: #303538;
	padding-left: 10px;
}
</style>