<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/shop-item.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 120px auto 0 auto;
	height: 1500px;
	background-color: aliceblue;
}

td {
	border: 1px solid #eeeeee;
	border-collapse: collapse;
}
</style>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<div class="row">

				<div class="col-lg-3">
					<h2 class="my-4">마이페이지</h2>
					<div class="list-group">
						<a href="#" class="list-group-item active">내 정보 수정</a> <a href="#"
							class="list-group-item">도서 목록</a> <a href="#"
							class="list-group-item">도서 예약신청목록</a> <a href="#"
							class="list-group-item">내가 작성한 후기</a>
					</div>
				</div>
				<!-- /.col-lg-3 -->

				<div class="col-lg-9">
					<div class="card mt-4">
						<img class="card-img-top img-fluid"
							src="http://placehold.it/900x400" alt="">
						<div class="card-body">
							<h3 class="card-title">내정보 수정</h3>
							<form action="/member/mUpdate.do" method="post">
								아이디 : <input type="text" name="memberId"
									value="${sessionScope.member.memberId }" readonly><br>
								이름 : <input type="text" name="memberName"
									value="${sessionScope.member.memberName }"><br>
								닉네임 : <input type="text" name="memberNickname"
									value="${sessionScope.member.memberNickname }" readonly><br>
								휴대폰 번호 : <input type="text" name="memberPhone"
									value="${sessionScope.member.memberPhone }"><br>
								이메일 : <input type="text" name="memberEmail"
									value="${sessionScope.member.memberEmail }"><br>
								도서취향 1: <input type="text" name="memberCategory1"
									value="${sessionScope.member.memberCategory1 }"><br>
								도서취향 2: <input type="text" name="memberCategory2"
									value="${sessionScope.member.memberCategory2 }"><br>
								도서취향 3: <input type="text" name="memberCategory3"
									value="${sessionScope.member.memberCategory3 }"><br>
								가입일 : <input type="text" name="enrollDate"
									value="${sessionScope.member.enrollDate }" readonly><br>
								<input type="submit" value="정보수정">
							</form>
							<c:if test="${not empty sessionScope.member }">
								<form action="/member/delete.do" method="post">
									<input type="submit" value="회원탈퇴">

								</form>
							</c:if>
							
						</div>
					</div>
					<!-- /.card -->
					<div class="card card-outline-secondary my-4">
						<div class="card-header">Product Reviews</div>
						<div class="card-body">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
								Omnis et enim aperiam inventore, similique necessitatibus neque
								non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
								Sequi mollitia, necessitatibus quae sint natus.</p>
							<small class="text-muted">Posted by Anonymous on 3/1/17</small>
							<hr>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
								Omnis et enim aperiam inventore, similique necessitatibus neque
								non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
								Sequi mollitia, necessitatibus quae sint natus.</p>
							<small class="text-muted">Posted by Anonymous on 3/1/17</small>
							<hr>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
								Omnis et enim aperiam inventore, similique necessitatibus neque
								non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
								Sequi mollitia, necessitatibus quae sint natus.</p>
							<small class="text-muted">Posted by Anonymous on 3/1/17</small>
							<hr>
							<a href="#" class="btn btn-success">위로가기</a>
						</div>
					</div>
					<!-- /.card -->

				</div>
				<!-- /.col-lg-9 -->

			</div>

		</div>
		<!-- Bootstrap core JavaScript -->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>