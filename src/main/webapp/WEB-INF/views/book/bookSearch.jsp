<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List</title>
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
		<div id="searchDiv">
			<select>
				<option>카테고리 검색</option>
			</select>
			<select>
				<option>책이름/내용/작가</option>
			</select>
			<input type="text"><button type="button">검색</button>
		</div>
		<div class="content">
			<div id="searchDiv2">
				<a href="#">정렬방식1</a>
				<a href="#">정렬방식2</a>
				<a href="#">정렬방식3</a>
			</div>
			<div id="contentDiv">
				contentDiv
				<div id="selectDiv">
					<button type="button">전체 선택</button>
					<button type="button">선택한 책 장바구니에 담기</button>
				</div>
				<div id="MainContentDiv">
					사진 책이름
				</div>
			</div>
			<div id="searchDiv2">
					<button type="button">전체 선택</button>
					<button type="button">선택한 책 장바구니에 담기</button>
			</div>
		</div>
		<div id="naviDiv">
			{pageNavi}
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>