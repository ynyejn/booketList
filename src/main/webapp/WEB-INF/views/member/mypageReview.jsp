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
	text-align: center;
}
.list-group>#mypage1:hover,.list-group>#mypage2:hover,.list-group>#mypage3:hover,.list-group>#mypage4:hover,.list-group>#mypage5:hover,.list-group>#mypage6:hover{
	background-color : rgb(2, 132, 230);
    	cursor : pointer;
}
#upBtn{
	background-color: #666666;
	border-color:#666666;
}
.delayBtn {
	margin-top: 20px;
	background-color: #00a3e0;
	color: white;
	border: 2px solid #00a3e0;
	border-radius: 2px;
}
.card-header{
	font-weight:bold;
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
						<a href="/member/mypage.do"class="list-group-item " id="mypage1">내 정보 수정</a> 
						<a href="/member/mypageRentFrm.do"class="list-group-item" id="mypage2">도서 대여 목록</a> 
						<a href="/member/mypageReservationFrm.do"class="list-group-item" id="mypage3">도서 예약신청목록</a> 
						<a href="/member/mypageApplyFrm.do"class="list-group-item" id="mypage4">도서 입고신청</a>
							<a href="/member/mypageLostBookFrm.do" class="list-group-item" id="mypage5">도서 분실 신고</a> 
						<a href="/member/mypageReviewFrm.do" class="list-group-item active" id="mypage6">내가 작성한 후기</a>
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
					<div class="card card-outline-secondary my-4">
						<div class="card-header">내가 작성한 후기</div>
						<div class="card-body">
						
						<table class="reviewList">
							<tr>
							
							<th>도서이름</th>
							<th>후기내용</th>
							<th>별점</th>
							<th>출판사</th>
							<th>작가</th>
							<th>도서카테고리</th>
							  </tr>
							 <c:forEach items="${list }" var="r">
							 
                        <tr>
                           
                            <td>${r.bookName}</td>
                            <td>${r.reviewContent}</td>
                            <td>${r.reviewScore}</td>
                            <td>${r.bookPublisher}</td>
                            <td>${r.bookWriter}</td>
                            <td>${r.bookCategory}</td>
							<td><a><button type="button" class="deleteBtn">삭제하기</button></a></td>						
                        </tr>
                    </c:forEach>
						</table>	
						
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