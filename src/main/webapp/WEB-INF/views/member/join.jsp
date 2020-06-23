<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<meta charset="UTF-8">
		<title>회원가입</title>
	</head>
	<style>
		.content {
			width: 1200px;
			overflow: hidden;
			margin: 120px auto 0 auto;
			height: 1200px;
			background-color: aliceblue;
		}
			
		td {
			border: 1px solid #eeeeee;
			border-collapse: collapse;
		}
	</style>
	<script type="text/javascript">
		//모든 공백 체크 정규식
		var empty = "/\s/g";
		//아이디 정규식
		var id = "/^[a-z][a-z0-9]{4,19}$/";
		//비밀번호 정규식
		var pw = "/^[A-Z][a-z0-9~`!@#$%\\^&*()-]{4,11}$/";
		//이름정규식
		var name = "/^[가-힇]{2,4}$/";
		//닉네임 정규식
		var nickname = "/^[가-힇a-zA-Z0-9~`!@#$%\\^&*()-]{1,20}$/";
		//휴대폰 번호 정규식
		var phone = "/^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/";
		//이메일 검사 정규식
		var email = "/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i";
		//도서취향 체크박스(0개 선택,1개 선택,2개 선택,3개 선택)
		var bookArr = [];
		
		function member_join() {
			if($('#memberId').val()==''){
				$('#id_check').text('아이디를 입력하세요.');
				$('#id_check').css('color','red');
				return;
			}
			
			if($('#memberPw').val()==''){
				$('#pw_check').text('영문대문자로 시작하여 영문소문자, 숫자,특수문자포함 5~12자리만 가능합니다.');
				$('#pw_check').css('color','red');
				return;
			}
			
			if($('#memberPw2').val()==''){
				$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
				$('#pw2_check').css('color','red');
				return;
			}
			
			if($('#memberName').val()==''){
				alert('이름을 입력하세요');
				return;
			}
			
			if($('#memberNickname').val()==''){
				alert('닉네임을 입력하세요');
				return;
			}
			
			if($('#memberPhone').val()==''){
				alert('전화번호를 입력하세요');
				return;
			}
			
			if($('#memberEmail').val()==''){
				alert('이메일을 입력하세요');
				return;
			}
			
			//$('#form_join').submit();
			$.ajax({
				url : '/member/joinSuccess.do',
				type : 'post',
				dataType : 'text',
				data : {}
			 }); 
		}
				//아이디 중복 확인
				/* $("#memberId").blur(function(){
					if($('#memberId').val()==''){
						$('#id_check').text('아이디를 입력하세요.');
						$('#id_check').css('color','red');
					}else if(id.test($('#memberId').val())!=true){
						$('#id_check').text('5~20자의 영문, 숫자만 사용 가능합니다.');
						$('#id_check').css('color','red');
					}else if($('#memberId').val()!=''){
						var memberId=$('#memberId').val();
						$.ajax({
							async : true,
							type : 'POST',
							data : memberId,
							url : 'idcheck.do',
							dataType : 'json',
							contentType :"application/json; charset=UTF-8",
							success: function(data){
								if(data.cnt>0){
									$('#id_check').text('중복된 아이디입니다.');
									$('#id_check').css('color','red');
									$('#usercheck').attr('disabled',true);
								}else{
									if(id.test(memberId)){
										$('#id_check').text('사용가능한 아이디입니다.');
										$('#id_check').css('color','#eeeeee');
										$('#usercheck').attr("disabled",false);
									}
									else if(memberId==''){
										$('#id_check').text('아이디를 입력해주세요.');
										$('#id_check').css('color','red');
										$('#usercheck').attr('disabled',true);							
									}
									else{
										$('#id_check').text('아이디는 영문 소문자와 숫자 5~20자리만 가능합니다.');
										$('#id_check').css('color','red');
										$('#usercheck').attr('disabled',true);
									}
								}
							}
						});
					}
				});
				$('form').on('submit',function(){
					var inval_Arr = new Array(5).fill(false);
					if(id.test($('#memberId').val())){
						inval_Arr[0] =true;
					}else{
						inval_Arr[0]=false;
						alert('아이디를 확인하세요.');
						return false;
					}
					//비밀번호가 같은 경우&&비밀번호 정규식
					if(($('#memberPw').val()==($('#memberPw2').val()))&&pw.test($('#memberPw').val())){
						inval_Arr[1] = true;
					}else{
						inval_Arr[1] = false;
						alert('비밀번호를 확인하세요.');
						return false;
					}
					//이름 정규식
					if(name.test($('#memberName').val())){
						inval_Arr[2] = true;
					}else{
						inval_Arr[2] = false;
						alert('이름을 확인하세요');
						return false;
					}
					//닉네임 정규식
					if(nickname.test($('#memberNickname').val())){
					inval_Arr[3] = true;
				   }else{
					   inval_Arr[3] = false;
					   alert('닉네임을 확인하세요');
					   return false;
				   }
				 //전화번호 정규식
				   if(phone.test($('#memberPhone').val())){
					   console.log(phone.test($('#memberPhone').val()));
					   inval_Arr[4]=true;
				   }else{
					   inval_Arr[4]=false;
					   alert('휴대폰 번호를 확인하세요')
				   }
				   //이메일 정규식
				   if(email.test($('#memberEmail').val())){
					   console.log(email.test($('#memberEmail').val()));
					   inval_Arr[5] =true;
				   }else{
					   inval_Arr[5] =false;
					   alert('이메일을 확인하세요.');
					   return false;
				   }
				   //전체 유효성 검사
				   var total = true;
				   for(var i =0; i<inval_Arr.lengh;i++){
					   if(inval_Arr[i]==false){
						   total = false;
					   }
				   }
				   //유효성 모두 통과시
				   if(total== true){
					   alert('회원 가입이 되었습니다.');
				   }else{
					   alert('정보를 다시 확인해주세요.');
				   }
							
				});
				$('#memberId').blur(function(){
					if(id.test($('#memberId').val())){
						console.log('true');
						$('#id_check').text('');
					}else{
						console.log('false');
						$('#id_check').text('5~20자의 영문 소문자, 숫자만 사용 가능합니다.');
						$('#id_check').css('color','red');
					}
				});
				$('#memberPw').blur(function(){
					if(pw.test($('#memberPw').val())){
						console.log('true');
						$('#pw_check').text('');
					}else{
						console.log('false');
						$('#pw_check').text('영문대문자로 시작하여 영문소문자, 숫자,특수문자포함 5~12자리만 가능합니다.');
						$('#pw_check').css('color','red');
					}
				});
				//패스워드 일치 확인
				$('#memberPw2').blur(function(){
					if($('#memberPw').val() != $(this).val()){
						$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
						$('#pw2_check').css('color','red');
					}else{
						$('#pw2_check').text('');
					}
				});
				//이름에 특수 문자 들어가지 않도록 설정
				$('#memberName').blur(function(){
					if(name.test($(this).val())){
						console.log(name.test($(this).val()));
						$('#name_check').text('');
					}else{
						$('#name_check').text('한글 2~4자 이내로 입력하세요.(특수기호,공백 사용불가)');
						$('#name_check').css('color','red');
					}
				});
				$('#memberNickname').blur(function(){
					if(id.test($('#memberNickname').val())){
						console.log('true');
						$('#nickname_check').text('');
					}else{
						console.log('false');
						$('#nickname_check').text('5~20자의 영문 대소문자,한글,숫자,특수문자 사용 가능합니다.');
						$('#nickname_check').css('color','red');
					}
				});
				$('#memberPhone').blur(function(){
					if(phone.test($(this).val())){
						$('#phone_check').text('');
					}else{
						$('#phone_check').text('휴대폰 번호를 확인해주세요.');
						$('#phone_check').css('color','red');
					}
				});
				$('#memberEmail').blur(function(){
					if(email.test($(this).val())){
						$('#email_check').text('');
					}else{
						$('#email_check').text('이메일 양식을 확인해주세요.');
						$('#email_check').css('color','red');
					}
				});
				$("input[name='bookcheck']:checked").each(function(i){
					bookArr.push($(this).val());
				});
				$.ajax({
					url : 'bookcheck',
					type : 'post',
					dataType : 'text',
					data : {valueArr : bookArr}
				 }); */
		</script>
	<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<div class="col-md-6 col-md-offset-3">
				<h2>회원가입</h2>
				<form id="form_join" action="/member/joinSuccess.do" method="post">
					<div class="form-group">
						<label for="id">아이디</label> <input type="text"
							class="form-control" id="memberId" name="memberId"
							placeholder="ID">
						<div class="check_font" id="id_check"></div>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호 </label> <input type="password"
							class="form-control" id="memberPw" name="memberPw"
							placeholder="PASSWORD">
						<div class="check_font" id="pw_check"></div>
					</div>
					<div class="form-group">
						<label for="pw">비밀번호 확인 </label> <input type="password"
							class="form-control" id="memberPw2" name="memberPw2"
							placeholder="PASSWORD CHECK">
						<div class="check_font" id="pw2_check"></div>
					</div>
					<div class="form-group">
						<label for="name">이름</label> <input type="text"
							class="form-control" id="memberName" name="memberName"
							placeholder="Name">
						<div class="check_font" id="name_check"></div>
					</div>
					<div class="form-group">
						<label for="nickname">닉네임</label> <input type="text"
							class="form-control" id="memberNickname" name="memberNickname"
							placeholder="Nickname">
						<div class="check_font" id="nickname_check"></div>
					</div>
					<div class="form-group">
						<label for="phone">휴대폰 번호</label> <input type="text"
							class="form-control" id="memberPhone" name="memberPhone"
							placeholder="Phone Number">
						<div class="check_font" id="phone_check"></div>
					</div>
					<div class="form-group">
						<label for="email">이메일</label> <input type="text"
							class="form-control" id="memberEmail" name="memberEmail"
							placeholder="Email">
						<div class="check_font" id="email_check"></div>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="emailNum">
						<button type="button" id="numberBtn" />
						인증번호 입력
					</div>
					<h2>카톡 api</h2>
					<h2>네이버 api</h2>
					<h2>도서선호장르 최대3개까지 체크가능(선택)</h2>
					<div class="form-group">
						<input type="checkbox" id="bookcheck" name="bookcheck" value="컴퓨터/모바일" />컴퓨터/모바일
						<input type="checkbox" id="bookcheck" name="bookcheck" value="과학 " />과학
						<input type="checkbox" id="bookcheck" name="bookcheck" value="경제경영" />경제경영
						<input type="checkbox" id="bookcheck" name="bookcheck" value="종교/역학" />종교/역학
						<input type="checkbox" id="bookcheck" name="bookcheck" value="사회과학" />사회과학
						<input type="checkbox" id="bookcheck" name="bookcheck" value="역사" />역사 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="여행" />여행<br> 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="소설/시/희곡" />소설/시/희곡
						<input type="checkbox" id="bookcheck" name="bookcheck" value="에세이" />에세이
						<input type="checkbox" id="bookcheck" name="bookcheck" value="인문학" />인문학
						<input type="checkbox" id="bookcheck" name="bookcheck" value="만화" />만화
						<input type="checkbox" id="bookcheck" name="bookcheck" value="예술/대중문화" />예술/대중문화 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="잡지" />잡지 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="전집/중고전집" />전집/중고전집<br>
						<input type="checkbox" id="bookcheck" name="bookcheck" value="외국어" />외국어
						<input type="checkbox" id="bookcheck" name="bookcheck" value="자기계발" />자기계발 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="수험서/자격증" />수험서/자격증 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="초등학교참고서" />초등학교참고서
						<input type="checkbox" id="bookcheck" name="bookcheck" value="중학교참고서" />중학교참고서 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="고등학교참고서" />고등학교참고서 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="대학교재/전문서적" />대학교재/전문서적<br>
						<input type="checkbox" id="bookcheck" name="bookcheck" value="유아" />유아
						<input type="checkbox" id="bookcheck" name="bookcheck" value="어린이" />어린이
						<input type="checkbox" id="bookcheck" name="bookcheck" value="청소년" />청소년
						<input type="checkbox" id="bookcheck" name="bookcheck" value="좋은부모" />좋은부모 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="가정/요리/뷰티" />가정/요리/뷰티 
						<input type="checkbox" id="bookcheck" name="bookcheck" value="건강/취미/레저" />건강/취미/레저
						<input type="checkbox" id="bookcheck" name="bookcheck" value="달력/기타" />달력/기타<br> 
						<button type="button" onclick="member_join()">회원가입</button>
					</div>
			</div>
		</div>
	</div>
	</form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>