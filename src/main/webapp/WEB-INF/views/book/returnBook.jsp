<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

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
        border: 1px solid #dddddd;
    }
    .btnDiv{
        width: 950px;
        margin: 0px auto;
        margin-top: 20px;
        height: 35px;
        border: 1px solid lightgray;
    }
    .btnDiv>span{
        display: inline-block;
        margin-top: 7px;
    }
    .btnDiv>span>img{
        width: 20px;
        height: 20px;
        vertical-align: -2px;
    }
    .btnBox{
        text-align: right;
        width: 80%;
        height: 100%;
        display: inline-block;
    }
    .allCheck{
        border: none;
        background-color: #666666;
        color: white;
        width: 100px;
        height: 35px;
        font-size: 14px;
        border-radius: 2px;
    }
    .addDiv{
        border: none;
        background-color: #eeeeee;
        width: 35px;
        height: 35px;
        border-radius: 2px;
    }
    .addDiv>img{
        width: 15px;
        height: 15px;
    }
    .frame {
        width: 950px;
        height: 500px;
        margin: 0 auto;
        margin-top: 2px;
        margin-bottom: 30px;
        border-top: 2px solid #426f8f;
        border-bottom: 2px solid #426f8f;
    }

    .bookBox {
        margin: 20px;
        background-color: #eeeeee;
        width: 910px;
        height: 300px;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>도서 반납 신청</span>
        </div>
        <div class="content">
            <div class="btnDiv"><span><img src="/resources/imgs/bluecheck.png">대여중인 도서 : n권</span><div class="btnBox">
                <button class="allCheck">전체 도서 반납</button>
                <button class="addDiv"><img src="/resources/imgs/plus.png"></button>
                </div></div>
            <div class="frame">
                <div class="bookBox"></div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>

</html>
