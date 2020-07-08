<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>회원가입</title>
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

.join1 {
	margin: 0 auto;
	overflow: hidden;
	width: 600px;
}

#form_join {
	margin: 0 auto;
	overflow: hidden;
	width: 500px;
}
</style>
<script>
	//모든 공백 체크 정규식
	var empty = /\s/g;
	//아이디 정규식
	var id = /^[a-z0-9]{5,20}$/;
	//비밀번호 정규식
	var pw = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,11}$/;
	//이름정규식
	var name = /^[가-힇]{2,4}$/;
	//닉네임 정규식
	var nickname = /^[가-힇a-zA-Z0-9#?!@$%^&*-]{2,10}$/;
	//휴대폰 번호 정규식
	var phone = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	//이메일 검사 정규식
	var email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	//도서취향 체크박스(0개 선택,1개 선택,2개 선택,3개 선택)

	$(function() {
		$('#memberId').on("blur", function(event) {
			if (!id.test($('#memberId').val())) {
				$('#id_check').text('아이디는 영소문자,숫자 포함 5자 이상 20자 이하입니다.');
				$('#id_check').css('color', 'red');
				$("#memberId").val("");
			} else {
				$('#id_check').text('중복체크 버튼을 눌러주세요.');
				$('#id_check').css('color', '#666666');
				//아이디 중복 확인
				$("#doubleId").click(function() {
					var memberId = $('#memberId').val();
					$.ajax({
						type : 'POST',
						data : {
							memberId : memberId
						},
						url : '/member/checkId.do',
						success : function(data) {
							if (data == "1") {
								alert("중복아이디");
								$("#memberJoin").attr("disabled", "disabled");
							} else {
								alert("아이디사용가능");
								$("#memberJoin").removeAttr("disabled");
							}
						}
					});
				});
			}
		});

		$('#memberPw2')
				.on(
						"blur",
						function(event) {
							if (!pw.test($('#memberPw').val())) {
								$('#pw_check')
										.text(
												'비밀번호는 8자 이상 12자 이하이며, 숫자/영대소문자/특수문자를 모두 포함해야 합니다.');
								$('#pw_check').css('color', 'red');
								$("#memberPw").val("");
							} else {
								if ($('#memberPw').val() != $('#memberPw2')
										.val()) {
									$('#pw_check').text('비밀번호 확인을 다시 해주세요.');
									$('#pw_check').css('color', 'red');
									$("#memberPw").val("");
									$("#memberPw2").val("");
								} else {
									$('#pw_check').text('비밀번호 형식에 맞습니다.');
									$('#pw_check').css('color', '#666666');
								}
							}
						});

		$('#memberName').on("blur", function(event) {
			if (!name.test($('#memberName').val())) {
				$('#name_check').text('한글 2~4자 이내로 입력하세요.(특수기호,공백 사용불가)');
				$('#name_check').css('color', 'red');
				$("#memberName").val("");
			} else {
				$('#name_check').text('이름 형식에 맞습니다.');
				$('#name_check').css('color', '#666666');
			}
		});

		$('#memberNickname')
				.on(
						"blur",
						function(event) {
							if (!nickname.test($('#memberNickname').val())) {
								$('#nickname_check').text(
										'2~10자의 영문 대소문자,한글,숫자,특수문자 사용 가능합니다.');
								$('#nickname_check').css('color', 'red');
								$("#memberNickname").val("");
							} else {
								$('#nickname_check').text('중복체크 버튼을 눌러주세요');
								$('#nickname_check').css('color', '#666666');
								//닉네임 중복확인	
								$("#doubleNick")
										.click(
												function() {
													var memberNickname = $(
															'#memberNickname')
															.val();
													$
															.ajax({
																type : 'POST',
																data : {
																	memberNickname : memberNickname
																},
																url : '/member/checkNickname.do',
																success : function(
																		data) {
																	if (data == "1") {
																		alert("중복닉네임입니다.");
																		$(
																				"#memberJoin")
																				.attr(
																						"disabled",
																						"disabled");
																	} else {
																		alert("닉네임사용가능합니다.");
																		$(
																				"#memberJoin")
																				.attr(
																						"disabled");
																	}
																}
															})
												})
							}
						})
		$('#memberPhone').on("blur", function(event) {
			if (!phone.test($('#memberPhone').val())) {
				$('#phone_check').text('휴대폰 번호에 숫자만 입력해주세요');
				$('#phone_check').css('color', 'red');
				$("#memberPhone").val("");
			} else {
				$('#phone_check').text('맞는 휴대폰 번호 형식입니다. ');
				$('#phone_check').css('color', '#666666');

			}
		});

		$('#memberEmail').on("blur", function(event) {
			if (!email.test($('#memberEmail').val())) {
				$('#email_check').text('이메일은 @ 포함하여 입력해주세요 ');
				$('#email_check').css('color', 'red');
				$("#memberEmail").val("");
			} else {
				$('#email_check').text('맞는 이메일 형식입니다.');
				$('#email_check').css('color', '#666666');
				var mailCode = "";
				$("#mailBtn").click(function() {
					var mail = $("#memberEmail").val();
					$.ajax({
						url : "/member/sendMail.do",
						type : "post",
						data : {
							mail : mail
						},
						success : function(data) {
							mailCode = data;
							$("#mailCode").show();
							$("#mailResult").show();
						}
					});
				});

				$("#mailResult").click(function() {
					if ($("#mailCode").val() == mailCode) {
						$("#mailMsg").html('인증성공');
						$("#mailMsg").css('color', 'green');
					} else {
						$("#mailMsg").html('인증실패');
						$("#mailMsg").css('color', 'red');
					}
				});
			}
		});

	});

	function member_join() {

		if ($('#memberId').val() == '') {
			$('#id_check').text('아이디는 영소문자,숫자 포함 5자 이상 20자 이하입니다.');
			$('#id_check').css('color', 'red');
			return;
		}

		if ($('#memberPw').val() == '') {
			$('#pw_check').text(
					'비밀번호는 8자 이상 12자 이하이며, 숫자/영대소문자/특수문자를 모두 포함해야 합니다.');
			$('#pw_check').css('color', 'red');
			return;
		}

		if ($('#memberPw2').val() == '') {
			$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
			$('#pw2_check').css('color', 'red');
			return;
		}

		if ($('#memberName').val() == '') {
			$('#name_check').text('한글 2~4자 이내로 입력하세요.(특수기호,공백 사용불가)');
			$('#name_check').css('color', 'red');
			return;
		}

		if ($('#memberNickname').val() == '') {
			$('#nickname_check').text('2~10자의 영문 대소문자,한글,숫자,특수문자 사용 가능합니다.');
			$('#nickname_check').css('color', 'red');
			return;
		}

		if ($('#memberPhone').val() == '') {
			$('#phone_check').text('휴대폰 번호를 숫자만 입력해주세요.');
			$('#phone_check').css('color', 'red');
			return;
		}

		if ($('#memberEmail').val() == '') {
			$('#email_check').text('이메일을 입력해주세요 ');
			$('#email_check').css('color', 'red');
			return;
		}
		//체크박스 배열
		var bookArr = [];
		$("input[name=bookcheck]:checked").each(function(index) {
			bookArr[index] = $(this).val();
		});
		if (bookArr.length > 3) {
			alert("취향은 3개까지 선택가능합니다 :)");
		} else if (bookArr.length == 3) {
			alert("3개 취향존중");
			var choice1 = bookArr[0];
			var choice2 = bookArr[1];
			var choice3 = bookArr[2];
			console.log(choice1);
			console.log(choice2);
			console.log(choice3);
		} else if (bookArr.length == 2) {
			alert("2개 취향존중");
			var choice1 = bookArr[0];
			var choice2 = bookArr[1];
			console.log(choice1);
			console.log(choice2);
		} else if (bookArr.length == 1) {
			alert("1개 취향존중");
			var choice1 = bookArr[0];
			console.log(choice1);
		} else if (bookArr.length == 0) {
			alert("0개 취향존중");
			var choice1 = "";
			console.log(choice1);
		}

		var member = {
			"memberId" : $('#memberId').val(),
			"memberPw" : $('#memberPw').val(),
			"memberName" : $('#memberName').val(),
			"memberEmail" : $('#memberEmail').val(),
			"memberPhone" : $('#memberPhone').val(),
			"memberCategory1" : choice1,
			"memberCategory2" : choice2,
			"memberCategory3" : choice3,
			"memberNickname" : $('#memberNickname').val()
		}

		$.ajax({
			url : '/member/joinSuccess.do',
			type : 'post',
			dataType : 'json',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(member)
		});

	}
</script>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<div class="join1">

				<form id="form_join" action="/member/joinSuccess.do" method="post">
					<h2>회원가입</h2>
					<div class="form-group">
						<label for="id">아이디</label> <input type="text"
							class="form-control" id="memberId" name="memberId"
							placeholder="ID" style="width: 430px;"><br>
						<button type="button" id="doubleId">중복 체크</button>
						<div class="check_font" id="id_check"></div>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control" id="memberPw" name="memberPw"
							placeholder="PASSWORD" style="width: 430px;">
						<div class="check_font" id="pw_check"></div>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호 확인</label> <input type="password"
							class="form-control" id="memberPw2" name="memberPw2"
							placeholder="PASSWORD CHECK" style="width: 430px;">
						<div class="check_font" id="pw2_check"></div>
					</div>
					<div class="form-group">
						<label for="name">이름</label> <input type="text"
							class="form-control" id="memberName" name="memberName"
							placeholder="Name" style="width: 430px;">
						<div class="check_font" id="name_check"></div>
					</div>
					<div class="form-group">
						<label for="nickname">닉네임</label> <input type="text"
							class="form-control" id="memberNickname" name="memberNickname"
							placeholder="Nickname" style="width: 430px;"><br>
						<button type="button" id="doubleNick">중복 체크</button>
						<div class="check_font" id="nickname_check"></div>
					</div>
					<div class="form-group">
						<label for="phone">휴대폰 번호</label> <input type="text"
							class="form-control" id="memberPhone" name="memberPhone"
							placeholder="Phone Number" style="width: 430px;">
						<div class="check_font" id="phone_check"></div>
					</div>
					<div class="form-group">
						<label for="email">이메일</label> <input type="text"
							class="form-control" id="memberEmail" name="memberEmail"
							placeholder="Email" style="width: 430px;">
						<button type="button" id="mailBtn" class="btn btn-primary">메일전송</button>
						<input type="text" id="mailCode" style="display: none;">
						<button id="mailResult" type="button" class="btn btn-primary"
							style="display: none;">메일확인</button>
						<span id="mailMsg">
							<div class="check_font" id="email_check"></div>
					</div>



					<h2>카톡 api</h2>
					<h2>네이버 api</h2>
					<h2>도서선호장르 최대3개까지 체크가능(선택)</h2>
					<div class="form-group">
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="컴퓨터/모바일" />컴퓨터/모바일 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="과학 " />과학 <input type="checkbox"
							id="bookcheck" name="bookcheck" value="경제경영" />경제경영 <input
							type="checkbox" id="bookcheck" name="bookcheck" value="종교/역학" />종교/역학
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="사회과학" />사회과학 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="역사" />역사 <input type="checkbox"
							id="bookcheck" name="bookcheck" value="여행" />여행<br> <input
							type="checkbox" id="bookcheck" name="bookcheck" value="소설/시/희곡" />소설/시/희곡
						<input type="checkbox" id="bookcheck" name="bookcheck" value="에세이" />에세이
						<input type="checkbox" id="bookcheck" name="bookcheck" value="인문학" />인문학
						<input type="checkbox" id="bookcheck" name="bookcheck" value="만화" />만화
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="예술/대중문화" />예술/대중문화 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="잡지" />잡지 <input type="checkbox"
							id="bookcheck" name="bookcheck" value="전집/중고전집" />전집/중고전집<br>
						<input type="checkbox" id="bookcheck" name="bookcheck" value="외국어" />외국어
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="자기계발" />자기계발 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="수험서/자격증" />수험서/자격증 <input
							type="checkbox" id="bookcheck" name="bookcheck" value="초등학교참고서" />초등학교참고서
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="중학교참고서" />중학교참고서 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="고등학교참고서" />고등학교참고서 <input
							type="checkbox" id="bookcheck" name="bookcheck" value="대학교재/전문서적" />대학교재/전문서적<br>
						<input type="checkbox" id="bookcheck" name="bookcheck" value="유아" />유아
						<input type="checkbox" id="bookcheck" name="bookcheck" value="어린이" />어린이
						<input type="checkbox" id="bookcheck" name="bookcheck" value="청소년" />청소년
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="좋은부모" />좋은부모 <input type="checkbox" id="bookcheck"
							name="bookcheck" value="가정/요리/뷰티" />가정/요리/뷰티 <input
							type="checkbox" id="bookcheck" name="bookcheck" value="건강/취미/레저" />건강/취미/레저
						<input type="checkbox" id="bookcheck" name="bookcheck"
							value="달력/기타" />달력/기타<br>

						<button type="button" onclick="member_join()" id="memberJoin"
							disabled="disabled" style="width: 430px;">회원가입</button>
					</div>
			</div>
		</div>
	</div>
	</form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>