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
        padding-bottom: 200px;
    }

    .btnDiv {
        width: 950px;
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
    .addDiv,.subDiv {
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
    .subDiv{
        width: 15px;
        height: 24px;
        background-color: #dddddd; 
        position: absolute;
        right: 10px;
        top:10px;
    }
    
    .subDiv>img{
        margin-top: 3px;
        width: 13px;
        height: 13px;
    }
    .frame {
        overflow: hidden;
        width: 950px;
        margin: 0 auto;
        margin-top: 5px;
        margin-bottom: 30px;
        border-top: 2px solid #426f8f;
        border-bottom: 2px solid #426f8f;
    }

    .bookBox {
        margin: 20px;
        padding: 25px 50px;
        background-color: #eeeeee;
        position: relative;
        width: 910px;
    }

    .bookBox>input {
        width: 100%;
        height: 35px;
        border: 1px solid #0066b3;
        outline: none;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>도서 반납 신청</span>
        </div>
        <div class="content">
            <div class="btnDiv"><span><img src="/resources/imgs/bluecheck.png" class="check">대여중인 도서 : n권</span>
                <div class="btnBox">
                    <button class="allCheck">전체 도서 반납</button>
                    <button class="addDiv">+</button>
                </div>
            </div>
            <div class="frame">
                <div class="bookBox">
                    <img src="/resources/imgs/bluecheck.png" class="check">도서 제목
                    <button class="subDiv"><img src="/resources/imgs/x.png"></button>
                    <input type="text" name="bookName" placeholder="도서제목을 입력하세요">
                    
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>
    
<script>
    $(".addDiv").click(function(){
        $.ajax({
            url : "/",
           success: function(){
               console.log("hi");
           }
        });
    });
</script>
