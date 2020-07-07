<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script type="text/javascript" src="/resources/ckeditor4/ckeditor.js"></script>
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
        border: 1px solid #e5e5e5;
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
        margin-left: 80px;
        font-size: 16px;
        color: #666666;
    }

    .boardFrame {
        overflow: hidden;
        width: 1100px;
        background-color: white;
        margin: 0 auto;
        margin-top: 30px;
        padding-bottom: 70px;
        border: 1px solid #e5e5e5;
        text-align: center;
    }
    .boardFrame>span{
        float: right;
        font-size: 14px;
        margin-right: 50px;
        margin-top: 30px;
        color: #495057;
    }

    .boardFrame>form>table {
        text-align: left;
        width: 1000px;
        margin: 0px auto;
        margin-top: 30px;
        border-top: 1px solid #585858;
        border-bottom: 1px solid #585858;
    }

    .boardFrame>form tr {
        border-bottom: 1px solid #dddddd;
    }

    .boardFrame>form td {
        height: 50px;
        font-size: 15px;
        color: #595959;
    }

    .boardFrame>form tr>td:first-of-type {
        background-color: #f8f9f9;
        width: 18%;
    }

    .boardFrame>form tr>td:last-of-type {
        /*padding-left: 30px;*/
        text-indent:10px;

    }

    .boardFrame>form input {
        border: 1px solid lightgray;
        width: 250px;
        height: 35px;
    }
    .boardFrame button {
        width: 115px;
        height: 40px;
        margin: 5px;
        margin-top: 40px;
        border: 1px solid #666666;
        border-radius: 5px;
        font-size: 15px;
        color: #495057;
        background-color: white;
    }
    .boardFrame button[type=submit]{
        background-color: #222222;
        color: white;
        border: none;
    }

</style>

<body style="line-height: normal;">
    <div class="wrapper" style="background-color: #f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div>
            <span>도서기증 / 판매</span>
        </div>
        <div class="content">
            <div class="notice">
                <div class="imgBox">
                    <img src="/resources/imgs/bookicon.png">
                </div>
                <div class="text">
                    기증 및 판매 할 도서의 사진을 반드시 첨부해주세요. <br> 첨부사진이 충분하지 않아 상태판단에 어려움이 있을
                    시 추가자료가 요청 될 수 있습니다.<br> 판매 확정 시 금액은 정가의10% 이고, 책 도착 후 2-3일 내에
                    작성하신 계좌로 입금됩니다.<br> 기부 확정 시 기부도서에는 기부자명이 표기됩니다.
                </div>

            </div>
            <div class="boardFrame">
                <span><span style="color: #fc3f3f;">*</span> 필수 입력 사항</span>
                <form action="/insertBoard.do" method="get" onsubmit="return checkFunc();">
                    <table>
                        <tr>
                            <td>분류</td>
                            <td>${ub.usedType} </td>
                        </tr>
                        <tr>
                            <td>글제목<span style="color: #fc3f3f;">*</span></td>
                            <td style="text-indent:0px;"><input type="text" name="usedTitle" placeholder="글제목을 입력하세요." style="width:100%;" value="${ub.usedTitle}" required></td>
                        </tr>
                        <tr>
                            <td>내용<span style="color: #fc3f3f;">*</span></td>
                            <td><textarea class="form-control" id="p_content" name="usedContent">${ub.usedContent }</textarea>
                            </td>
                        </tr>
                    </table>
                    <button type="submit">등록</button><button type="button" onclick="location.href='/goBoardView.do?usedNo=${ub.usedNo}'">취소</button>
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
<script>
    //ck에디터
    CKEDITOR.replace('p_content', {
        height: 400
    });
    $(function() {
            var html = "";
            if ('${ud.usedType}' == '기증') {
                html += "<tr class='infoTr'><td>기증자 명</td><td>${ub.usedInfo}</td></tr>";
            } else {
                html += "<tr class='infoTr'><td >계좌번호</td><td>";
                html += "${ub.usedInfo}</td></tr>";
            }
            $(".boardFrame tbody").append(html);
 
    });

    function checkFunc(){
        var pw = $("input[name=usedPw]").val();
        var regExp = /^[0-9]{4}$/;
                if (!regExp.test(pw)) {
                    alert("비밀번호는 숫자4글자로 입력해주세요.")
                    return false;
                } 
    }
</script>

</html>
