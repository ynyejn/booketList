<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<!DOCTYPE html>
<html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5bb2ba2ec8d74284b765268fe83a0ad3&libraries=services,drawing"></script>

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
        opacity: 40%;
    }

    .cTop>span {
        color: #f5f5f5;
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
    
    .selectZone{
        border: 1px solid lightgray;
        width: 100%;
        overflow: hidden;
    }
    .spotFrame {
        width: 100%;
        height: 600px;
        border: 1px solid #dddddd;
    }

    .spotFrame>div {
        padding: 30px;
        float: left;
        width: 50%;
        height: 100%;
        border: 1px solid #dddddd;
    }
    #map{
        margin: 30px;
        width: 538px;
        height: 538px;
    }

    .spotList>div:first-of-type {
        border-top: 2px solid #1A6FBA;
    }

    .spotList>div:last-of-type {
        border-bottom: 2px solid #1A6FBA;
    }

    .listBox {
        border-bottom: 1px solid #dddddd;
        height: 108px;
        padding: 20px 20px;
    }

    .listBox>div {
        float: left;
    }

    .radioBtn {
        padding-top: 2px;
        width: 5%;
        height: 70px;
    }

    .spotInfo {
        padding-left: 20px;
    }

    .spotInfo2 {
        padding-left: 20px;
        margin-top: 10px;
        width: 95%;
    }

    .spotName {
        border: 1px solid #cccccc;
        display: inline-block;
        font-size: 14px;
        text-align: center;
        width: 130%;
        height: 28px;
        color: #111111;
        line-height: 28px;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>반납 장소 선택</span>
        </div>
        <div class="content">
            <div class="selectZone"></div>
            <div class="spotFrame">
                <div id="map"></div>
                <div class="spotList">
                    <c:forEach items="${list }" var="s">
                        <div class="listBox">
                            <div class="radioBtn"><input type="radio" name="spotName" value="${s.spotName}" style="width:22px; height:22px"></div>
                            <div class="spotInfo">
                                <div class="spotName">${s.spotName}</div>
                            </div>
                            <div class="spotInfo2">
                                <div class="spotAddr">${s.spotAddr}</div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>

<script>
    $(function() {
            var xx;
            var yy;
            var addr;
            var name;
        $("input[type=radio]").click(function() {
            
            name = $(this).val();
            addr = $(this).parent().next().next().children().html();

            var geocoder = new kakao.maps.services.Geocoder();

            var callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    console.log(result);
                    xx = result[0].x;
                    yy = result[0].y;
                    console.log(xx + "," + yy);
                }
            };
            
            geocoder.addressSearch(addr, callback);
            
            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            var options = { //지도를 생성할 때 필요한 기본 옵션
                center: new kakao.maps.LatLng(yy, xx), //지도의 중심좌표.
                level: 3 //지도의 레벨(확대, 축소 정도)
            };

            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴     
            

        });
        $("input[type=radio]").first().click();
    });

</script>
