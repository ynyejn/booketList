<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 폰트 -->
<link
	href="https://fonts.googleapis.com/css?family=Bangers|Noto+Sans+KR&display=swap"
	rel="stylesheet">
<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.js"></script>

<!-- css 여기있어야함 -->
<link rel="stylesheet" href="/resources/css/header/hStyle.css">

<div class="header"
>
	<div class="header1">
		<a href="/"><img src="/resources/imgs/bluelogo.png"></a>
	</div>
	<div class="headermiddle">
		<label for="keyword">
			<form action="/rent/searchBookDetail.do" method="get">
				<label for="search"><img src="/resources/imgs/fDot.png"></label>
					<input type="text" placeholder="필요한 도서정보에 대해 검색해보세요~!" id="keyword"  name="inputText" value="${inputText }">
					<input type="submit" id="search"> <img src="/resources/imgs/x.png" id="x">
					<input type="hidden" name="categorySelect" value="">
					<input type="hidden" name="bookAttr" value="book_name">
					<input type="hidden" name="reqPage" value="1">
					<input type="hidden" name="sort" value="book_name">
			</form>
		</label>
	</div>
	<div class="header2">
		<ul>
			<c:if test="${empty sessionScope.member }">
				<!--로그인되어있지않을때 -->
				<li><a href="/member/loginFrm.do">로그인</a></li>
				<li><a href="/member/join.do">회원가입</a></li>
				<li><a href="/cart/goMyCart.do?reqPage=1">장바구니</a></li>
			</c:if>
			<c:if test="${not empty sessionScope.member }">
				<!--로그인되어있을때 -->
				<c:if test="${sessionScope.member.memberId eq 'admin' }">
				<li><a href="/adminPage.do">${sessionScope.member.memberName }</a></li>
				</c:if>
				<c:if test="${sessionScope.member.memberId ne 'admin' }">
				<li><a href="/member/mypage.do">${sessionScope.member.memberName }님</a></li>
				</c:if>
				<li><a href="/member/logout.do">로그아웃</a></li>
				<li><a href="/cart/goMyCart.do?reqPage=1">장바구니</a></li>
			</c:if>
		</ul>
	</div>
	<div class="header3">
		<div class="naviFrame">
			<ul class="hNavi1">
				<li><a href="/rent/goBookSearch.do?reqPage=1">도서 검색</a></li>
				<li><a href="javascript:void(0);" onclick="returnFunc('${sessionScope.member.memberId}');">도서 반납</a></li>
				<li><a href="javascript:void(0);" onclick="appl('${sessionScope.member.memberId}');">도서 입고 신청</a></li>
				<li><a href="/rent/goPreference.do" data-toggle="tooltip" title="Try it!">취향분석</a></li>
			</ul>
			<ul class="hNavi2">
				<li><a href="/review/reviewList.do">후기 게시판</a></li>
				<li><a  href="javascript:void(0);" onclick="chat('${sessionScope.member.memberId}');" data-toggle="tooltip" title="와글와글!">오픈 채팅방</a></li>
				<c:if test="${sessionScope.member.memberId ne 'admin' }">
				<li><a href="/goUsedBoard.do?reqPage=1">도서기증 / 판매</a></li>
				</c:if>
				<c:if test="${sessionScope.member.memberId eq 'admin' }">
				<li><a href="/goAdminUsedBoard.do?reqPage=1">도서기증 / 판매</a></li>
				</c:if>
				
			</ul>
		</div>
	</div>
	<c:if test="${not empty sessionScope.member }">
		<c:if test="${sessionScope.member.memberId != 'admin' }">
				<!-- Channel Plugin Scripts -->
				<script>
					(function() {
						var w = window;
						if (w.ChannelIO) {
							return (window.console.error || window.console.log || function() {
							})('ChannelIO script included twice.');
						}
						var d = window.document;
						var ch = function() {
							ch.c(arguments);
						};
						ch.q = [];
						ch.c = function(args) {
							ch.q.push(args);
						};
						w.ChannelIO = ch;
						function l() {
							if (w.ChannelIOInitialized) {
								return;
							}
							w.ChannelIOInitialized = true;
							var s = document.createElement('script');
							s.type = 'text/javascript';
							s.async = true;
							s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
							s.charset = 'UTF-8';
							var x = document.getElementsByTagName('script')[0];
							x.parentNode.insertBefore(s, x);
						}
						if (document.readyState === 'complete') {
							l();
						} else if (window.attachEvent) {
							window.attachEvent('onload', l);
						} else {
							window.addEventListener('DOMContentLoaded', l,
									false);
							window.addEventListener('load', l, false);
						}
					})();
					ChannelIO('boot', {
						"pluginKey" : "e1accb0b-c1ed-4d99-8813-52c156de2e18", //please fill with your plugin key
						"memberId" : "${sessionScope.member.memberId }", //fill with user id
						"profile" : {
							"name" : "${sessionScope.member.memberName }", //fill with user name
							"mobileNumber" : "YOUR_USER_MOBILE_NUMBER", //fill with user phone number
							"CUSTOM_VALUE_1" : "VALUE_1", //any other custom meta data
							"CUSTOM_VALUE_2" : "VALUE_2"
						}
					});
				</script>
				<!-- End Channel Plugin -->
			</c:if>
		</c:if>
</div>

<script>
	function chat(memberId){
	if(memberId==""){
		alert("로그인이 필요합니다");
		location.href="/member/loginFrm.do";
	}else{
		location.href="/chat/openChatting.do";
	}
}
	function returnFunc(memberId){
		if(memberId==""){
			alert("로그인이 필요합니다");
			location.href="/member/loginFrm.do";
		}else{
			location.href="/goBookReturn.do";
		}
	}
	function appl(memberId){
		if(memberId==""){
			alert("로그인이 필요합니다");
			location.href="/member/loginFrm.do";
		}else{
			location.href="/apply/applyApplication.do";
		}
	}
	function up() {
		window.scrollTo(0, 0);
	}
	$(function() {
		//검색창 클릭
		$(".headermiddle input[type=text] ").focusin(
				function() {
					$(this).parents("form").css("background-color", "white")
							.css("border", "1px solid #ddd");
				});
		$(".headermiddle input[type=text] ").focusout(
				function() {
					$(this).parents("form").css("background-color", "#eee")
							.css("border", "1px solid transparent");
				});

		//검색창x
		$(".headermiddle input[type=text]").keyup(function() {
			if ($(this).val().length != 0) {
				$("#x").show();
			} else {
				$("#x").hide();
			}
		});
		$("#x").click(function() {
			$(".headermiddle input[type=text]").val("");
			$(this).hide();
		});

		//툴팁
		$('[data-toggle="tooltip"]').tooltip();

	});
	$(window)
			.scroll(
					function() {
						var height = 0;
						height = $(window).scrollTop();
						if (height >= 59) {
							$(".header3").css("opacity", "95%").css(
									"background-color", "white").css(
									"border-top", "1px solid #eeeeee");
							$(".hNavi1>li>a").css("color", "#0066b3");
							$(".hNavi2>li>a").css("color", "gray");
							$(".header")
									.css("box-shadow",
											"0 4px 12px rgba(0, 0, 0, .08), 0 0 1px rgba(1, 0, 0, .1)");
						} else {
							$(".header3").css("opacity", "100%").css(
									"border-top", "1px solid #0066b3").css(
									"background-color", "#0066b3");
							$(".hNavi1>li>a").css("color", "");
							$(".hNavi2>li>a").css("color", "");
							$(".header").css("box-shadow", "none");
						}
					});
</script>