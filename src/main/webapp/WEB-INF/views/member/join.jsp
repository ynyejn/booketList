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
<script type="text/javascript">
	//모든 공백체크 정규식
	var empty = /\s/g;
	//아이디 정규식
	var id = /^[a-zA-Z][a-zA-Z0-9]{4,19}$/;
</script>
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
			전화번호<input type="text" name="memberPhone"><br>
			이메일<input type="text" name="memberEmail"><button type="button" id="emailBtn"/>
			인증번호<input type="text" name="number"><button type="button" id="numberBtn"/>
			<h2>카톡 api</h2><h2>네이버 api</h2>
			<h2>도서선호장르 최대3개까지 선택가능</h2>
			<input type="checkbox" name="bookcheck" value="컴퓨터/모바일" />
			<input type="checkbox" name="bookcheck" value="과학" />
			<input type="checkbox" name="bookcheck" value="경제경영" />
			<input type="checkbox" name="bookcheck" value="종교/역학" />
			<input type="checkbox" name="bookcheck" value="사회과학" />
			<input type="checkbox" name="bookcheck" value="역사" />
			<input type="checkbox" name="bookcheck" value="여행" /><br>
			<input type="checkbox" name="bookcheck" value="소설/시/희곡" />
			<input type="checkbox" name="bookcheck" value="에세이" />
			<input type="checkbox" name="bookcheck" value="인문학" />
			<input type="checkbox" name="bookcheck" value="만화" />
			<input type="checkbox" name="bookcheck" value="예술/대중문화" />
			<input type="checkbox" name="bookcheck" value="잡지" />
			<input type="checkbox" name="bookcheck" value="전집/중고전집" /><br>
			<input type="checkbox" name="bookcheck" value="외국어" />
			<input type="checkbox" name="bookcheck" value="자기계발" />
			<input type="checkbox" name="bookcheck" value="수험서/자격증" />
			<input type="checkbox" name="bookcheck" value="초등학교참고서" />
			<input type="checkbox" name="bookcheck" value="중학교참고서" />
			<input type="checkbox" name="bookcheck" value="고등학교참고서" />
			<input type="checkbox" name="bookcheck" value="대학교재/전문서적" /><br>
			<input type="checkbox" name="bookcheck" value="유아" />
			<input type="checkbox" name="bookcheck" value="어린이" />
			<input type="checkbox" name="bookcheck" value="청소년" />
			<input type="checkbox" name="bookcheck" value="좋은부모" />
			<input type="checkbox" name="bookcheck" value="가정/요리/뷰티" />
			<input type="checkbox" name="bookcheck" value="건강/취미/레저" />
			<input type="checkbox" name="bookcheck" value="달력/기타" /><br>
			<input type="submit" value="회원가입">
		</form>	
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>