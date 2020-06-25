<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Booket List-SPOT 선택</title>
</head>
<style>
    .cTop {
        margin-top: 120px;
        width: 100%;
        height: 150px;
        background-image: url(/resources/imgs/spotPage.jpg);
        position: relative;
    }

    .black {
        background-color: #3C5567;
        width: 100%;
        height: 100%;
        opacity:40%;
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
    .spotFrame{
        width: 100%;
        height: 800px;
        border: 1px solid #dddddd;
    }

  
</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>반납 장소 선택</span>
        </div>
        <div class="content">
          <div class="spotFrame"></div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>

<script>
    $(function() {
    });

</script>
