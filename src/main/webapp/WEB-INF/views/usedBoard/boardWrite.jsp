<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Booket List-기증/판매 게시판</title>
</head>
<style>
    .cTop {
        margin-top: 120px;
        width: 100%;
        height: 160px;
        background-image: url(/resources/imgs/bookStore3.jpg);
        position: relative;
    }

    .black {
        background-color: #1B3A50;
        width: 100%;
        height: 100%;
        opacity: 45%;
    }

    .cTop>span {
        color: #eeeeee;
        font-size: 40px;
        font-weight: bolder;
        position: absolute;
        padding-left: 300px;
        padding-right: 30px;
        top: 45px;
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
        border: 1px solid lightgray;
    }

    .check {
        width: 20px;
        height: 20px;
        vertical-align: -2px;
    }

    /*--------------------------------------------------------------------------------------------------*/

    .notice {
        width: 1100px;
        padding: 20px 50px;
        margin: 0 auto;
        margin-top: 50px;
        overflow: hidden;
        background-color: white;
    }
    
    .notice>div {
        float: left;
    }
     .imgBox {
        margin-left: 80px;
    }

    .imgBox>img {
        margin-top: 10px;
        width: 80px;
        height: 80px;
        opacity: 70%;
    }

    .text {
        margin-left:80px;
        font-size: 16px;
        color: #666666;
    }

    .boardFrame {
        overflow: hidden;
        width: 1100px;
        background-color: white;
        margin: 0 auto;
        margin-top: 50px;

    }
    .boardFrame>form>table{
        width: 1000px;
        margin: 30px auto;
        border-top: 1px solid #585858;
         border-bottom: 1px solid #585858;
    }
    .boardFrame>form tr{
        border-bottom: 1px solid #dddddd;
    }
    .boardFrame>form td{
        height: 50px;
        font-size: 15px;
        text-indent: 10px;
        color: #595959;
    }
    .boardFrame>form tr>td:first-of-type{
        background-color: #f8f9f9;
        width: 18%;
    }
    .boardFrame>form tr>td:last-of-type{
        padding-left: 30px;
    }
    .boardFrame>form input{
        border: 1px solid lightgray;
        width: 95%;
        height: 35px;
    }
    .boardFrame>form input[type=text]{
        width: 95%;
    }
</style>

<body style="line-height:normal;">
    <div class="wrapper" style="background-color:#f7f8f8;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>기증 / 판매</span>
        </div>
        <div class="content">
            <div class="notice">
                <div class="imgBox"><img src="/resources/imgs/bookicon.png"></div>
                <div class="text">기증 및 판매 할 도서의 사진을 반드시 첨부해주세요. <br>
                첨부사진이 충분하지 않아 상태판단에 어려움이 있을 시 추가자료가 요청 될 수 있습니다.<br>
                판매 확정 시 금액은 정가의10% 이고, 책 도착 후 2-3일 내에 작성하신 계좌로 입금됩니다.<br>
                기부 확정 시 기부도서에는 기부자명이 표기됩니다.</div>
                
            </div>
            <div class="boardFrame">
            <form action="#" method="get">
            <table>
            <tr>
            <td>분류</td>
            <td><select name="usedType" style="width:200px; height:35px; border:1px solid lightgray;">
                <option value="기증">기증</option>
                <option value="판매">판매</option>
                </select></td>
            </tr>  
            <tr>
            <td>글제목<span style="color:#fc3f3f;">*</span></td>
            <td><input type="text" name="usedTitle" placeholder="글제목을 입력하세요." required></td>
            </tr>
            <tr>
            <td>내용<span style="color:#fc3f3f;">*</span></td>
            <td><textarea></textarea></td>
            </tr>
            <tr>
            <td>비밀번호<span style="color:#fc3f3f;">*</span></td>
                <td><input type="password"></td>
            </tr>
            </table>
            </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>

</html>
