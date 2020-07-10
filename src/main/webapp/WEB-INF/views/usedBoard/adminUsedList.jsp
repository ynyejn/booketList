<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Booket List-기증/판매 게시판(관리자)</title>
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

    /*--------------------------------------------------------------------------------------------------*/

    .notice {
        width: 1100px;
        padding: 25px 50px;
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
        width: 80px;
        height: 80px;
        opacity: 70%;
    }

    .text {
        margin-left: 50px;
        padding-top: 5px;
        font-size: 17px;
        color: #666666;
    }

    .boardFrame {
        overflow: hidden;
        width: 100%;
        background-color: white;
        margin: 30px 0;
        text-align: center;
    }

    .boardFrame>table {
        border-top: 2px solid #222222;
        width: 100%;
        color: #595959;
        text-align: center;
    }

    .boardFrame>table th {
        background-color: #ebedf4;
        border-bottom: 1px solid #dddddd;
        height: 40px;
    }

    .boardFrame>table td {
        height: 40px;
        border-bottom: 1px solid #dddddd;
        color: #595959;
    }
    td>a:hover{
        text-decoration: underline;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper" style="background-color:#f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>기증 / 판매</span>
        </div>
        <div class="content">
            <div class="notice">
                <div class="imgBox"><img src="/resources/imgs/bookicon.png"></div>
                <div class="text"><strong  style="text-decoration:underline;">여러분의 참여를 기다립니다.</strong><br>
                    당신의 서재에서 잠자고 있는 자료들이 <span style="color:#3cbcc7;">Booket List</span>를 통해 세상의 빛과 만나게 됩니다.<br>
                    기증 및 판매를 원하는 개인은 글을 작성하신 후 판매자의 응답에 따라 기증 및 판매가 가능합니다.</div>
            </div>
            <div class="boardFrame">
                <table>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>작성자</th>
                        <th>글 제목</th>
                        <th>등록일</th>
                        <th>처리상태</th>
                    </tr>
                    <c:forEach items="${list }" var="l">
                        <tr>
                            <td>${l.usedNo}</td>
                            <td>${l.usedType}</td>
                            <td>${l.memberId}</td>
                            <td><a href="/goBoardView.do?usedNo=${l.usedNo}">${l.usedTitle}</a></td>
                            <td>${l.usedDate}</td>
                            <td>${l.usedStatus}</td>
                        </tr>
                    </c:forEach>
                </table>
                <span>${pageNavi}</span>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>

</html>
