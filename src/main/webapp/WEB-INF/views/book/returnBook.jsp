<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<head>
    <meta charset="UTF-8">
    <title>Booket List-반납신청</title>
</head>
<style>
    .cTop {
        margin-top: 120px;
        width: 100%;
        height: 150px;
        background-image: url(/resources/imgs/returnbook.jpg);
        position: relative;
    }

    .black {
        background-color: #3C5567;
        width: 100%;
        height: 100%;
        opacity: 65%;
    }

    .cTop>span {
        color: #eeeeee;
        font-size: 40px;
        font-weight: bolder;
        position: absolute;
        padding-left: 300px;
        padding-right: 30px;
        top: 40px;
        left: 0px;
        text-shadow: 1px 1px 2px black;
        border-bottom: 5px solid #dddddd;
        box-shadow: 0px 1px 0px black;
    }

    .content {
        width: 1200px;
        overflow: hidden;
        margin: 0 auto;
        padding-bottom: 200px;
    }

    .btnDiv {
        width: 1000px;
        margin: 0px auto;
        margin-top: 20px;
        height: 35px;
    }

    .btnDiv>span {
        display: inline-block;
        margin-top: 7px;
    }

    .check {
        width: 20px;
        height: 20px;
        vertical-align: -2px;
    }

    .btnBox {
        text-align: right;
        width: 80%;
        height: 100%;
        display: inline-block;
    }

    .allCheck,
    .addDiv,
    .subDiv {
        border: none;
        background-color: #666666;
        color: white;
        width: 110px;
        margin-left: 2px;
        height: 35px;
        font-size: 14px;
        border-radius: 2px;
    }

    .addDiv {
        width: 30px;
        background-color: #0066b3;
    }


    /*--------------------공통*/
    .searchFrame {
        padding: 30px 20px;
        width: 1000px;
        margin: 0 auto;
        margin-top: 5px;
        border-top: 2px solid #426f8f;
        border-bottom: 2px solid #426f8f;
    }

    .returnFrame,
    .delayFrame {
        padding: 20px;
        width: 1000px;
        margin: 0 auto;
        border-bottom: 2px solid #426f8f;
        text-align: center;
    }

    .returnFrame>span,
    .delayFrame>span {
        font-size: 28px;

    }

    .returnFrame>small,
    .delayFrame>small {
        color: #0066b3;
    }

    .searchBox,
    .returnBox,
    .delayBox {
        padding: 20px 50px;
        background-color: #f5f5f5;
        position: relative;
        width: 960px;
    }

    /*--------------------검색창*/
    .searchBox {
        padding: 35px 50px;
    }

    .searchBox>input {
        width: 100%;
        height: 45px;
        border: 1px solid #0066b3;
        outline: none;
        box-sizing: border-box;
    }

    .bookList {
        position: absolute;
        width: 860px;
        overflow: hidden;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, .08), 0 0 5px rgba(1, 0, 0, .1);
        display: none;
        z-index: 300;
    }

    .bookList>li {
        text-indent: 10px;
        display: inline-block;
        width: 860px;
        height: 30px;
        font-size: 15px;
        line-height: 30px;
        background-color: white;
    }

    .bookList>li:hover {
        background-color: #a0c5e8;
        cursor: default;
    }

    /*---------------반납책내역*/
    .returnBox {
        background-color: white;
    }

    .returnBook {
        text-align: left;
        position: relative;
        border-bottom: 1px solid #dddddd;
        padding: 15px 0;
        color: #535253;
        font-size: 15px;
    }

    .returnBox>form>div:first-of-type {
        border-top: 2px solid #1A6FBA;
    }

    .returnBox>form>div:last-of-type {
        border-bottom: 2px solid #1A6FBA;
    }

    .subDiv {
        width: 15px;
        height: 24px;
        background-color: #dddddd;
        position: absolute;
        right: 0px;
        top: 10px;
    }

    .subDiv>img {
        margin-top: 3px;
        width: 13px;
        height: 13px;
    }

    .good, .bad {
        position: absolute;
        top: 50px;
        right: 0px;
        display: inline-block;
        width: 80px;
        height: 30px;
        line-height: 30px;
        font-size: 14px;
        background-color: #00a3e0;
        color: white;
        text-align: center;
        border-radius: 5px;
    }
    .bad {
        background-color: #FA6556;
    }
    span.bookName {
        font-size: 18px;
        color: #535253;
        display: inline-block;
        height: 18px;
/*         border-bottom: 10px solid #C2D7EC; */
    }

    span.bookWriter {
        color: #4ba9e0;
    }

    span.rentStartDate {
        color: #535253;
        padding-left: 40px;
    }

    span.rentEndDate {
        color: #FA6556;
        padding-left: 12px;
    }

    /*--------------------연체료 결제*/
    .delayBox {
        text-align: left;
        overflow: hidden;
    }

    .delayBox>table {
        width: 100%;
        background-color: white;
        text-align: center;
        margin-bottom: 10px;
    }

    .delayBox td {
        height: 35px;
    }

    .delayBox tr:first-of-type {
        background-color: #dddddd;
    }

    .payInfo {
        font-size: 18px;
    }

    #payBtn {
        float: right;
        width: 150px;
        height: 40px;
        border: none;
        border-radius: 5px;
        font-size: 15px;
        color: white;
        background-color: #666666;
    }

    /*-------------------맨밑에 버튼부분*/
    .submitBtn {
        padding-top: 40px;
        text-align: center;
    }

    [name=returnBtn] {
        width: 200px;
        display: inline-block;
        height: 70px;
        background-color: #303538;
        color: white;
        line-height: 70px;
        text-align: center;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>도서 반납 신청</span>
        </div>
        <div class="content">
            <div class="btnDiv"><span><img src="/resources/imgs/bluecheck.png" class="check">대여중인 도서 : ${fn:length(list)}권</span>
                <div class="btnBox">
                    <button class="allCheck">전체 도서 반납</button>
                    <button class="addDiv">+</button>
                </div>
            </div>
            <div class="searchFrame">
                <div class="searchBox">
                    <img src="/resources/imgs/bluecheck.png" class="check">도서 제목
                    <input type="text" name="bookName" placeholder="도서명을 입력하세요">
                    <ul class="bookList">
                        <c:forEach items="${list }" var="r">
                            <li onclick="func();"><span>${r.bookName }</span>
                                <input type="hidden" value=${r.bookNo} name="bookNo">
                                <input type="hidden" value=${r.rentStartDate} name="rentStartDate">
                                <input type="hidden" value=${r.rentEndDate} name="rentEndDate">
                                <input type="hidden" value=${r.bookWriter} name="bookWriter">
                                <input type="hidden" value=${r.bookStatus} name="bookStatus">
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="returnFrame">
                <span>반납도서</span>
                <small>반납 선택한 도서 목록입니다</small>
                <div class="returnBox">
                    <form action="/goSpotPage.do" method="get" onsubmit="return nextFunc();">
                        <div class="returnBook">
                            <input type="hidden" name="bookNo">
                            <button class="subDiv"><img src="/resources/imgs/x.png"></button>
                            <span class="bookName">책이름책이름책이름 책이름 책이름 챙책이름입니다</span> / <span class="bookWriter">ㅇㅇㅇ 지음</span><br>
                            대여일 :<span class="rentStartDate">2020-06-01</span><br>
                            반납예정일 :<span class="rentEndDate">2020-06-08</span>
                            <div class="good">대여중</div>
                        </div>
                        <div class="returnBook">
                            <button class="subDiv"><img src="/resources/imgs/x.png"></button>
                            <span class="bookName">책이름책이름책이름 책이름 책이름 챙책이름입니다</span> / <span class="bookWriter">ㅇㅇㅇ 지음</span><br>
                            대여일 :<span class="rentStartDate">2020-06-01</span><br>
                            반납예정일 :<span class="rentEndDate">2020-06-08</span>
                            <div class="bad">연체중</div>
                        </div>
                        <input type="submit" id="goReturn" style="display:none;">
                    </form>
                </div>
            </div>
            <div class="delayFrame">
                <span>연체료 결제</span>
                <small>연체요금을 확인하세요</small>
                <div class="delayBox" status="false">
                    <table border="1">
                        <tr>
                            <td style="width:60%;">도서명</td>
                            <td style="width:20%;">반납 예정일</td>
                            <td style="width:20%;">초과일</td>
                        </tr>
                        <tr>
                            <td>책이름책이름책이름책이름</td>
                            <td>2020-06-08</td>
                            <td>3</td>
                        </tr>
                    </table>
                    <div class="payInfo">총금액 : <span class="payPrice">1000* 초과일총합</span>
                        <button id="payBtn" onclick="payFunc();">결제하기</button></div>
                </div>
            </div>
            <div class="submitBtn"><label for="goReturn" name="returnBtn">다음으로</label><br></div>
            <button onclick="location.href='/bookDelay.do';">연체</button>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>

<script>
    $(function() {
        // 반납도서 검색창
        $("input[name=bookName]").keyup(function() {
            var val = $(this).val();
            if ($(this).val() == "") {
                $(this).next().hide();
            } else {
                $(this).next().show();
                $(this).next().children("li").show();
            }
            if (val.length > 1) {
                var regExp = new RegExp(val);
                $(".bookList>li").each(function() {
                    if (regExp.test($(this).children("span").html())) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }
        });
        $("input[name=bookName]").focusout(function() {
            $(this).next().hide();
        });


    });
    // 반납도서 선택했을 때
    //        $(".bookList>li").click(function(){
    //            alert("hi");
    //         var value =$(this).children("span").html();
    //           console.log(value); 
    //        });
    function func() {
        console.log("hi");
    }


    // 결제
    function payFunc() {
        var d = new Date();
        var date = d.getFullYear() + "" + (d.getMonth() + 1) + "" +
            d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();
        IMP.init("imp03735690");
        IMP.request_pay({
            //결제정보넘김
            merchant_uid: '상품명_' + date,
            name: 'BooketList',
            amount: 1000,
            buyer_email: 'test@naver.com',
            buyer_name: '${sessionScope.member.memberName}',
            buyer_tel: '010-1111-2222',
            buyer_postcode: '01234'
        }, function(rsp) {
            if (rsp.success) {
                //결제 성공햇을때
                $(".delayBox").attr("status", "true");
                $(".delayFrame").hide();
            } else {
                alert("결제취소");
            }
        });
    }

    function nextFunc() {
        if ($(".delayBox").css("display", "block") && $(".delayBox").attr("status") == "false") {
            alert("연체료를 확인하세요.");
            return false;
        }
    }

</script>
