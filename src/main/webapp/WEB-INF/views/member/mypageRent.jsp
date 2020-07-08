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
						<a href="/member/mypage.do" class="list-group-item active">내 정보 수정</a> 
						<a href="/member/mypageRentFrm.do"	class="list-group-item">도서 목록</a> 
						<a href="/member/mypageReservationFrm.do"class="list-group-item">도서 예약신청목록</a>
						<a href="/member/mypageApplyFrm.do"class="list-group-item">도서 입고신청</a> 
						<a href="/member/mypageReviewFrm.do" class="list-group-item">내가 작성한 후기</a>
					</div>
				</div>
				<!-- /.col-lg-3 -->

				<div class="col-lg-9">
					<div class="card mt-4">
						<img class="card-img-top img-fluid"
							src="http://placehold.it/900x400" alt="">
						<div class="card-body">
							<h3 class="card-title"></h3>
							
							
						</div>
					</div>
					<!-- /.card -->
					<div class="card card-outline-secondary my-4">
						<div class="card-header">도서 목록</div>
						<div class="card-body">
						
						<table class="rentList">
							<tr>
							<th>대여번호</th>
							<th>책번호</th>
							<th>대여장소</th>
							<th>대여일</th>
							<th>대여종료일</th>
							<th>반납일</th>
							<th>도서 명</th>
							
							  </tr>
							 <c:forEach items="${list }" var="r">
							 
                        <tr>
                            <td>${r.rentNo}</td>
                            <td>${r.bookNo}</td>
                            <td>${r.spotName}</td>
                            <td>${r.rentStartDate}</td>
                            <td>${r.rentEndDate}</td>
							<td>${r.rentReturn}</td>
							<td>${r.bookName}</td>
                        </tr>
                    </c:forEach>
						</table>	
						
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