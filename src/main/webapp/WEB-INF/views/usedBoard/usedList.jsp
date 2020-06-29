<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        height: 150px;
        background-image: url(/resources/imgs/bookStore3.jpg);
        position: relative;
    }

    .black {
        background-color: #3C5567;
        width: 100%;
        height: 100%;
        opacity: 40%;
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
        border: 1px solid lightgray;
    }
/*--------------------------------------------------------------------------------------------------*/
    
    .notice{
        border: 1px solid #dddddd;
        width: 1100px;
        padding: 30px 50px;
        margin: 0 auto;
        margin-top: 50px;
        overflow:hidden;
    }
    .notice>div{
    float:left;
    }
</style>
<body style="line-height:normal;">
<div class="wrapper" >
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="cTop">
            <div class="black"></div><span>기증 / 판매</span>
        </div>
        <div class="content">
        <div class="notice">
            <div class="imgBox"><img src="/resources/imgs/used_book.png"></div>
            <div></div>
            </div>
        </div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>