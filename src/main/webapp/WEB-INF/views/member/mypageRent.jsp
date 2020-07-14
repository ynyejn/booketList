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
<title>도서목록</title>
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
	text-align: center;
}

tr {
	text-align: center;
}

.list-group>#mypage1:hover, .list-group>#mypage2:hover, .list-group>#mypage3:hover,
	.list-group>#mypage4:hover, .list-group>#mypage5:hover, .list-group>#mypage6:hover
	{
	background-color: rgb(2, 132, 230);
	cursor: pointer;
}

.delayBtn {
	margin-top: 20px;
	background-color: #00a3e0;
	color: white;
	border: 2px solid #00a3e0;
	border-radius: 2px;
}

#upBtn {
	background-color: #666666;
	border-color: #666666;
}
.card-header{
	font-weight:bold;
}
.rentList {
	font-size : 14px;
}
</style>
<script>
	var bool = true;
</script>

<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<div class="row">

				<div class="col-lg-3">
					<h2 class="my-4">마이페이지</h2>
					<div class="list-group">
						<a href="/member/mypage.do" class="list-group-item " id="mypage1">내
							정보 수정</a> <a href="/member/mypageRentFrm.do"
							class="list-group-item active" id="mypage2">도서대여 목록</a> <a
							href="/member/mypageReservationFrm.do" class="list-group-item"
							id="mypage3">도서 예약신청목록</a> <a href="/member/mypageApplyFrm.do"
							class="list-group-item" id="mypage4">도서입고신청</a> <a
							href="/member/mypagelostBookFrm.do" class="list-group-item"
							id="mypage5">도서분실 신고</a> <a href="/member/mypageReviewFrm.do"
							class="list-group-item" id="mypage6">내가 작성한 후기</a>
					</div>
				</div>
				<!-- /.col-lg-3 -->

				<div class="col-lg-9">
					<div class="card mt-4" style="width: 800px; height: 400px; margin:0 auto;">
					
						<img class="card-img-top img-fluid"
							src="/resources/imgs/mypage.png" alt=>
						<div class="card-body">
							<h3 class="card-title"></h3>
							
							
						</div>
					</div>
					<!-- /.card -->
					<div class="card card-outline-secondary my-4" >
						<div class="card-header">도서대여 목록</div>
						<div class="card-body">

							<table class="rentList">
								<tr>

									<th>책번호</th>
									<th>대여장소</th>
									<th>대여일</th>
									<th>대여종료일</th>
									<th>연장횟수</th>
									<th>도서 명</th>
									<hr>
								</tr>

								<c:forEach items="${list }" var="r">
									<c:if test="${r.countinueDate < 0 }">
										<tr style="background-color: red">
											<script>
												bool = false;
											</script>
									</c:if>
									<c:if test="${r.countinueDate >= 0 }">
										<tr>
									</c:if>

									<td>${r.bookNo}</td>

									<td>${r.spotName}</td>
									<td>${r.rentStartDate}</td>
									<td>${r.rentEndDate}</td>
									<td>${r.rentReturn}</td>
									<td style="width: 400px;">${r.bookName}<input id="rent"
										type="hidden" value="${r.rentNo}"></td>
									<td><a href="/member/rentUpdate.do?rentNo=${r.rentNo}"></a>
										<c:if test="${r.countinueDate >= 0 }">
											<button type="button" class="delayBtn">연장하기</button>
										</c:if><br> <br></td>
									</tr>

								</c:forEach>
							</table>
							<script>
								$(function() {
									$(".delayBtn").click(function() {
														var rentNo = $(this).parent().parent()
																.parent()
																.children()
																.find("#rent")
																.val();
														
														if ($(this).parent()
																.prev().prev()
																.html() == 0) {//버튼이어서 parent로 올라감

															if (!bool) {
																alert("연체된 책을 먼저 반납해주세요.");
															} else {
																alert("연장되었습니다.");
																location.href = "/member/rentUpdate.do?rentNo="
																		+ rentNo;
															}
														} else {
															alert("연장은 1회만 가능합니다.");

														}
													})
								});
							</script>

							<hr>
							<a href="#" class="btn btn-success" id="upBtn">위로가기</a>
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