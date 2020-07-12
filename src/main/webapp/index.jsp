<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/css/header/slide.css">
    <link rel="stylesheet" type="text/css" href="/resources/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="/resources/slick/slick-theme.css" />
    <title>Booket List</title>
</head>

<body style="line-height: normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div id="slider" style="margin-top: 120px; height: 550px;">
            <div class="slides">
                <div class="slider">
                    <div class="legend"></div>
                    <div class="content">
                        <div class="content-txt">
                            <h1>도서 대여 및 반납</h1>
                            <h2>
                                BOOKET LIST에서는 다양한 책의 대여가 가능합니다.<br>도서관에 직접가는 수고없이 여러분이
                                지정하시는 스팟에서 손쉽게 책을 대여 및 반납 할 수 있습니다.
                            </h2>
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
                            <h2>
                                BOOKET LIST에서는 여러분의 취향을 분석하여 책을 추천해드립니다.<br> 취향분석 메뉴를 이용해
                                몰랐던 책을 알아가세요!
                            </h2>
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
                            <h2>BOOKET LIST에서는 여러분이 서로 소통하실 수 있는 오픈 채팅방이 마련되어있습니다. 다른
                                회원들과 책 관련 이야기를 나누고 견문을 넓혀보세요!</h2>
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
                            <h2>BOOKET LIST에서는 자신이 가진 책의 기증 및 판매가 가능합니다. 책의 상태를 기준으로 기증
                                및 판매가 가능하니 박혀있는 책을 세상밖으로 꺼내보세요!</h2>
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
        <div class="content2">
            <div class='bookList'>
                <div class='onebook'>
                    <img src="/resources/imgs/book_bg.png">
                    <div>
                        <img src="https://image.aladin.co.kr/product/24158/20/coversum/k292639642_1.jpg">
                    </div>
                </div>
                <div class='onebook'>
                    <img src="/resources/imgs/book_bg.png">
                    <div>
                        <img src="https://image.aladin.co.kr/product/24158/20/coversum/k292639642_1.jpg">
                    </div>
                </div>
                <div class='onebook'>
                    <img src="/resources/imgs/book_bg.png">
                    <div>
                        <img src="https://image.aladin.co.kr/product/24158/20/coversum/k292639642_1.jpg">
                    </div>
                </div>
                <div class='onebook'>
                    <img src="/resources/imgs/book_bg.png">
                    <div>
                        <img src="https://image.aladin.co.kr/product/24158/20/coversum/k292639642_1.jpg">
                    </div>
                </div>
                <div class='onebook'>
                    <img src="/resources/imgs/book_bg.png">
                    <div>
                        <img src="https://image.aladin.co.kr/product/24158/20/coversum/k292639642_1.jpg">
                    </div>
                </div>
                
            </div>
            <div style="padding: 300px 100px; background-color: skyblue; display: none;">
                <div class="product">
                    <div>1</div>
                    <div>2</div>
                    <div>3</div>
                    <div>4</div>
                    <div>5</div>
                    <div>6</div>
                    <div>7</div>
                    <div>8</div>
                    <div>9</div>
                    <div>10</div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

    </div>

</body>

<script type="text/javascript" src="/resources/slick/slick.js"></script>

<script type="text/javascript">
    $(function() {
        $('.product').slick({
            slide: 'div', //슬라이드 되어야 할 태그 ex) div, li 
            infinite: true, //무한 반복 옵션	 
            slidesToShow: 4, // 한 화면에 보여질 컨텐츠 개수
            slidesToScroll: 1, //스크롤 한번에 움직일 컨텐츠 개수
            speed: 1000, // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
            arrows: true, // 옆으로 이동하는 화살표 표시 여부
            dots: true, // 스크롤바 아래 점으로 페이지네이션 여부
            autoplay: true, // 자동 스크롤 사용 여부
            autoplaySpeed: 1000, // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
            pauseOnHover: true, // 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
            vertical: false, // 세로 방향 슬라이드 옵션
            dotsClass: "slick-dots", //아래 나오는 페이지네이션(점) css class 지정
            draggable: true
            //드래그 가능 여부 

        });
    })

</script>

</html>
<style>
    .content2 {
        /*-지우지마세요-*/
        width: 1200px;
        overflow: hidden;
        margin: 0 auto;
        height: 900px;
        border: 1px solid lightgray;
    }

    .onebook {
        float: left;
        width: 191px;
        overflow: hidden;
        position: relative;
        margin-right: 60.5px;
    }

    .onebook>img {
        width: 100%;
    }

    .onebook>div {
        position: absolute;
        top: 0;
        left: 0;
    }

    .onebook>div>img {
        width: 184px;
        height: 270px;
        border: 1px solid #a9a9a9;
    }

    .onebook:last-of-type {
        margin-right: 0px;
    }

    /* 화살표 */
    .slick-arrow {
        z-index: 2;
        /* prev버튼은 위치 이동시 이미지 뒤로 숨겨짐 */
        position: absolute;
        /* 원하는 위치에 지정 */
        top: 0;
        width: 50px;
        height: 50px;
    }

    .slick-prev.slick-arrow {
        /* prev 이전 */
        left: 0;
    }

    .slick-next.slick-arrow {
        /* next 다음 */
        right: 0;
    }

    /* 아래점 */
    .slick-dots {
        text-align: center;
    }

    .slick-dots li {
        display: inline-block;
        margin: 0 5px;
    }

</style>
