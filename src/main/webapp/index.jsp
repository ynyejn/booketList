<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/header/slide.css">
<title>Booket List</title>
</head>

<body style="line-height: normal;">
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		           <div id="slider" style="margin-top:120px; height:550px;">
  <div class="slides">
    <div class="slider">
      <div class="legend"></div>
      <div class="content">
        <div class="content-txt">
          <h1>도서 대여 및 반납</h1>
          <h2>BOOKET LIST에서는 다양한 책의 대여가 가능합니다.<br>도서관에 직접가는 수고없이 여러분이 지정하시는 스팟에서 손쉽게 책을 대여 및 반납 할 수 있습니다.</h2>
        </div>
      </div>
      <div class="image">
        <img src="resources/imgs/library2.jpg">
      </div>
    </div>
    <div class="slider">
      <div class="legend"></div>
      <div class="content">
        <div class="content-txt">
          <h1>취향 분석</h1>
          <h2>BOOKET LIST에서는 여러분의 취향을 분석하여 책을 추천해드립니다.<br> 취향분석 메뉴를 이용해 몰랐던 책을 알아가세요!</h2>
        </div>
      </div>
      <div class="image">
        <img src="/resources/imgs/library10.jpg">
      </div>
    </div>
    <div class="slider">
      <div class="legend"></div>
      <div class="content">
        <div class="content-txt">
          <h1>오픈 채팅방</h1>
          <h2>BOOKET LIST에서는 여러분이 서로 소통하실 수 있는 오픈 채팅방이 마련되어있습니다. 다른 회원들과 책 관련 이야기를 나누고 견문을 넓혀보세요!</h2>
        </div>
      </div>
      <div class="image">
        <img src="/resources/imgs/library9.jpg">
      </div>
    </div>
    <div class="slider">
      <div class="legend"></div>
      <div class="content">
        <div class="content-txt">
          <h1>기증 / 판매 게시판</h1>
          <h2>BOOKET LIST에서는 자신이 가진 책의 기증 및 판매가 가능합니다. 책의 상태를 기준으로 기증 및 판매가 가능하니 박혀있는 책을 세상밖으로 꺼내보세요!</h2>
        </div>
      </div>
      <div class="image">
        <img src="/resources/imgs/library4.jpg">
      </div>
    </div>
  </div>
  <div class="switch">
    <ul>
      <li>
        <div class="on"></div>
      </li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</div>
<div class="content2"></div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

	</div>
</body>
</html>
<style>
.content2{
            /*-지우지마세요-*/
            width: 1200px;
            overflow: hidden;
            margin: 0 auto;
            height: 900px;
            background-color: #f3f5f7;;
        }


</style>