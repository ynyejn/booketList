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
.form-group{
	width: 430px;
}
td {
	border: 1px solid #eeeeee;
	border-collapse: collapse;
}
#mypage{
	background-color: #666666;
	font-color:#3cbcc7;
	border-radius: 2px;
	color: white;
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
						<a href="/member/mypage.do" class="list-group-item active">내
							정보 수정</a> <a href="/member/mypageRentFrm.do" class="list-group-item">도서
							대여 목록</a> <a href="/member/mypageReservationFrm.do"
							class="list-group-item">도서 예약신청목록</a> <a
							href="/member/mypageApplyFrm.do" class="list-group-item">도서
							입고신청</a> <a href="/member/mypageLostBookFrm.do"
							class="list-group-item">도서 분실 신고</a> <a
							href="/member/mypageReviewFrm.do" class="list-group-item">내가
							작성한 후기</a>
					</div>
				</div>
				<!-- /.col-lg-3 -->

				<div class="col-lg-9">
					<div class="card mt-4">
		
						<div class="card-body">
							<h3 class="card-title">내정보 수정</h3>
							<form action="/member/mUpdate.do" method="post">
								<div class="form-group">
									<label for="id">아이디</label> <input type="text"
										class="form-control" id="memberId" name="memberId"
										value="${sessionScope.member.memberId }" readonly>
								</div>
								<div class="form-group">	
								<label for="nickName">닉네임</label>
								 <input type="text"	class="form-control" id="memberNickname" name="memberNickname"
									value="${sessionScope.member.memberNickname }" readonly>
								</div>
								<div class="form-group">
								<label for="name">이름</label> 
								<input type="text"	class="form-control" id="memberName" name="memberName"
									value="${sessionScope.member.memberName }">	</div>
								
								<div class="form-group">	
								<label for="memberPhone">휴대폰 번호</label>
								 <input type="text"	class="form-control" id="memberPhone" name="memberPhone"
									value="${sessionScope.member.memberPhone }">
								</div>
								<div class="form-group">	
								<label for="memberEmail">이메일</label>
								 <input type="text"	class="form-control" id="memberEmail" name="memberEmail"
									value="${sessionScope.member.memberEmail }">
								</div>
								<div class="form-group">	
								<label for="memberCategory1">도서취향1</label>
								 <input type="text"	class="form-control" id="memberCategory1" name="memberCategory1"
									value="${sessionScope.member.memberCategory1 }">
								</div>
								<div class="form-group">
								<label for="memberCategory2">도서취향2</label>
								 <input type="text"	class="form-control" id="memberCategory2" name="memberCategory2"
									value="${sessionScope.member.memberCategory2 }">
								</div>
								<div class="form-group">
								<label for="memberCategory3">도서취향3</label>
								 <input type="text"	class="form-control" id="memberCategory3" name="memberCategory3"
									value="${sessionScope.member.memberCategory3 }">
								</div>
								<div class="form-group">
								<label for="enrollDate">가입일</label>
								 <input type="text"	class="form-control" id="enrollDate" name="enrollDate"
									value="${sessionScope.member.enrollDate }" readonly>
								</div>										
								<input type="submit" id="mypage" value="정보수정" style="width: 200px;">
								
						</form>
													<c:if test="${not empty sessionScope.member }">
							<form action="/member/delete.do" method="post">
							<input type="submit" id="mypage"value="회원탈퇴"style="width: 200px;">
							</form>
						</c:if>
							
					</div>
				</div>

				<hr>
				<a href="#" class="btn btn-success" id="mypage">위로가기</a>
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