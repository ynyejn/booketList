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
<link rel="stylesheet" href="resources/mypageBootstrap/vendor/bootstrap/css/bootstrap.min.css">
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="resources//mypageBootstrap/css/shop-item.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- Bootstrap core JavaScript -->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<title>도서 분실 신고</title>
<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 120px auto 0 auto;
	background-color: aliceblue;
}
.delAttr{
	border : none;
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
.card-header{
	font-weight:bold;
}
.payInfo {
	font-size: 16px;
	line-height: 42px;
	height: 42px;
	color: #535253;
	vertical-align: text-bottom;
	width: 500px;
	height: 140px;
	margin: 0 auto;
}

.check {
	width: 20px;
	height: 20px;
	vertical-align: -2px;
}

#contentDiv {
	width: 100%;
	margin: 0 auto;
}

#ck_all {
	border: none;
	background-color: #666666;
	color: white;
	width: 80px;
	height: 35px;
	font-size: 14px;
	border-radius: 2px;
	cursor: pointer;
	margin-bottom: 15px;
}

#needCenter {
	width: 300px;
	margin: 0 auto;
}

#payBtn {
	width: 300px;
	height: 60px;
	margin-bottom: 50px;
	background-color: black;
	color: white;
	font-size: 20px;
	font-weight: bold;
	border: 0px;
	cursor: pointer;
}
</style>

<script>
var ws;
var memberId = '${sessionScope.member.memberId }';
function connect() {
	ws = new WebSocket("ws://192.168.10.179/adminMsg.do");
	ws.onopen = function() {
		console.log("웹소켓 연결 생성");

	};
	ws.onmessage = function(e) {

	};
	ws.onclose = function() {
		console.log("연결종료");
	};
}

	$(function() {
		connect();
		var chk = 0;

		$("#allSelect")
				.click(
						function() {

							if (chk == 0) {
								for (var i = 0; i < $("input:checkbox[name=chkbox]").length; i++) {
									$("input:checkbox[name=chkbox]").eq(i)
											.prop("checked", true);

								}
								chk = 1;
							} else {
								for (var i = 0; i < $("input:checkbox[name=chkbox]").length; i++) {
									$("input:checkbox[name=chkbox]").eq(i)
											.prop("checked", false);
								}
								chk = 0;
							}
						});

		$(".checkRow").click(function() {
			var count = 0;
			$(".checkRow:checked").each(function() {
				count += 1000;
			});
			$(".payPrice").html(count);
		});

		$("#ck_all").click(function() {
			var count = 0;
			if (chk == 0) {
				$(".checkRow").prop("checked", true);
				chk = 1;
			} else {
				$("input[type=checkbox]").prop("checked", false);
				chk = 0;
			}

			$(".checkRow:checked").each(function() {
				count += 20000;
			});
			$(".payPrice").html(count);
		});
		if ($(".checkRow").is(":checked") == false) {
			$("#payBtn")
		}
	});
	function payFunc() {
		if ($(".checkRow").is(":checked") == false) {
			alert("도서를 선택해 주세요");
			return false;
		}
		$("#payBtn").attr("disabled", false);
		if ($(".payPrice").html() == "0") {
			alert("분실한 책을 선택하세요");
		} else {
			var d = new Date();
			var date = d.getFullYear() + "" + (d.getMonth() + 1) + ""
					+ d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();

			var payPrice = Number($(".payPrice").html());
			IMP.init("imp03735690");
			IMP.request_pay({
				//결제정보넘김
				merchant_uid : '상품명_' + date,
				name : 'BooketList',
				amount : payPrice,
				buyer_email : 'test@naver.com',
				buyer_name : '${sessionScope.member.memberName}',
				buyer_tel : '010-1111-2222',
				buyer_postcode : '01234'
			}, function(rsp) {
				if (rsp.success) {
					//결제 성공햇을때
					var checkArr = new Array();
					var count = 0;
					$(".checkRow:checked").each(function() {
						checkArr.push($(this).val());
						count = count+1;
					});
					console.log("결제성공 아작스보내기전");
					$.ajax({
						url : "/userLostBookUpdate.do",
						type : "get",
						traditional : true,
						data : {
							chBox : checkArr
						},
						success : function(result) {
							console.log("아작스 성공");
							console.log(result);
							if (result > 0) {
								alert("분실신고가 완료되었습니다.");
								var sendMsg = {
									type : "lostbookAlarmCount",
									data : count
								};
								ws.send(JSON.stringify(sendMsg));
								location.href = "mypageLostBookFrm.do"; 
							} else {
								alert("수정이 실패 하였습니다.");
							}
						}
					});

				} else {
					console.log(rsp);
					alert("결제가 취소 되었습니다.");
				}
			});
		}

	}

	$("#selDelete").click(function() {
		if (confirm("선택 도서를 삭제 하시겠습니까?")) {
			var checkArr = new Array();
			/* var reqPages = ${reqPage }; */

		} else {
			return false;
		}
	});
</script>

</head>

<body>
	<div class="wrapper" style='background-color :#f3f5f7;'>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<div class="row">

				<div class="col-lg-3">
					<h2 class="my-4">마이페이지</h2>
					<div class="list-group">
						<a href="/member/mypage.do" class="list-group-item " id="mypage1">내 정보 수정</a> 
						<a href="/member/mypageRentFrm.do"	class="list-group-item " id="mypage2">도서 대여 목록</a> 
						<a href="/member/mypageReservationFrm.do"class="list-group-item" id="mypage3">도서 예약신청목록</a>
						<a href="/member/mypageApplyFrm.do"class="list-group-item" id="mypage4">도서 입고신청</a> 
							<a href="/member/mypagelostBookFrm.do" class="list-group-item active" id="mypage5">도서 분실 신고</a> 
						<a href="/member/mypageReviewFrm.do" class="list-group-item" id="mypage6">내가 작성한 후기</a>
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
						<div class="card-header">도서 분실 신고</div>
						<div class="card-body">
	<div id="contentDiv">
		<button type="button" id="ck_all">전체 선택</button>
		<div id="MainContentDiv">
			<table>
				<tbody>
					<c:forEach items="${list }" var="p" varStatus="i">
						<tr>
							<th class="width5 delAttr" style="padding:40px;"><input type="checkbox" class="checkRow"
								value="${p.bookNo }"></th>
							<td class="width2 delAttr"><img src="${p.bookImg }"
								style="width: 110px; height: 160px;"></td>
							<td class="width9 delAttr" style="text-align: left;"><span
								style="font-weight: bold; color: #0066b3;margin-left:10px;">${p.bookName }</span>
								<ul style="padding-left: 15px;">
									<li
										style="font-size: 13px; text-align: left; margin-bottom: 3px;">작가
										: ${p.bookWriter }</li>
									<li
										style="font-size: 13px; text-align: left; margin-bottom: 3px;">출판사
										: ${p.bookPublisher }</li>
									<li
										style="font-size: 13px; text-align: left; margin-bottom: 3px;">장르
										: ${p.bookCategory }</li>
									<li
										style="font-size: 13px; text-align: left; margin-bottom: 3px;">출판일
										: ${p.bookPubDate }</li>
								</ul></td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
	</div>
	<div class="payInfo">
	
		<div id="needCenter" class="payBackground">
		
			<img src="/resources/imgs/bluecheck.png" class="check"><span
				class="payPrice" style="font-size: 20px; font-weight: bold;">0</span><b><small>원</small></b><small
				style="color: gray; margin-left: 15px; font-weight: bold">한
				권당 <span style="color: red;">20000</span>원 씩 계산됩니다
			</small>
			<button id="payBtn" onclick="payFunc()">결제하기</button>
		</div>

	</div>
				<a href="#" class="btn btn-success" id="upBtn">위로가기</a>			
						</div>
					</div>
					<!-- /.card -->

				</div>
				<!-- /.col-lg-9 -->

			</div>

		</div>
		
	</div>
	<br><br><br><br>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>