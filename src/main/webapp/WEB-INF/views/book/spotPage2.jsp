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
        height: 160px;
        background-image: url(/resources/imgs/spotPage.jpg);
        position: relative;
    }

    .black {
        background-color: #1B3A50;
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
    
    .selectZone{
        margin: 10px 0;
        margin-top: 50px;
        width: 100%;
        overflow: hidden;
    }
    #localName{
        width: 180px;
        height: 40px;
        text-indent: 10px;
        border: 1px solid lightgray;
        color: gray;
    }

    #nameList{
        text-indent: 10px;
        
    }
    input[name=keyword]{
        width: 300px;
        height: 38px;
        border: 1px solid lightgray;
        color: gray;
    }
    #searchBtn, #submitBtn{
        display: inline-block;
        height: 40px;
        line-height: 40px;
        width: 80px;
        text-align: center;
        font-size: 14px;
        color: white;
        background-color: #666666;
        border-radius: 5px;
    }
    #searchBtn:hover{
        cursor: pointer;
    }
    #submitBtn{
        float: right;
        width: 150px;
        height: 50px;
        margin-right: 50px;
        background-color: #444444;
        border: none;
        font-size: 16px;
        
    }
    #submitBtn:hover{
        background-color: #222222;
    }
    /*------------------------------------------------------------spot정보*/
    .spotFrame {
        width: 100%;
        height: 600px; 
        border-top: 2px solid #353835;
        border-bottom: 2px solid #353835;
    }

    .spotFrame>div {
        padding: 30px;
        float: left;
        width: 50%;
        height: 100%;
       
    }
    #map{
        margin: 30px;
        width: 538px;
        height: 538px;
        border: 1px solid #dddddd;
    }

    .spotList>div:first-of-type {
        border-top: 1px solid #dddddd;
    }



    .listBox {
        border-bottom: 1px solid #dddddd;
        height: 108px;
        padding: 20px 20px;
    }
    
    .listBox:hover{
        background-color: #f3f4fa;
    }
    .listBox:hover .spotName{
           border:1px solid #30353a;
    box-shadow: 5px 8.7px 5px rgba(0,0,0,.05);
    
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
        background-color: white;
        text-align: center;
        width: 130%;
        height: 28px;
        color: #111111;
        line-height: 28px;

    }
    .navi{
        text-align: center;
        margin-top: 17px;
    }
	.naviBtn, .selectPage, .heading{
        width: 35px;
        height: 35px;
        line-height: 35px;
        font-size: 20px;
        color: #a8adb5;
        display: inline-block;
	}
    .selectPage{
        color: #222222;
        font-size: 25px;
        border-bottom: 2px solid #222222;
    }
    .heading{
        width: 80px;
    }
</style>

<body style="line-height:normal;">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>대여 장소 선택</span>
        </div>
        <div class="content">
            <form action="/rent/rentBook.do" method="post">
            <div class="selectZone">
            <select name="localName" id="localName">
                <option value="" id="nameList">전체보기</option>
            <c:forEach items="${localList }" var="local">
            <option value="${local}" id="nameList">${local}</option>
            </c:forEach>
            </select>
            <input type="text" name="keyword" value="${keyword }">
            <div id="searchBtn">검색</div>
            <c:forEach items="${bookNo}" var="no">
            <input type="hidden" value="${no}" name="bookNoString">
                </c:forEach>
            <button type="submit" id="submitBtn">대여신청</button>
            </div>
            <div class="spotFrame">
                <div id="map"></div>
                <div class="spotList">
                    <c:forEach items="${list }" var="s">
                        <div class="listBox">
                            <div class="radioBtn"><input type="radio" name="spotName" value="${s.spotName}" style="width:22px; height:22px;"></div>
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
                </form>
            <div class="navi">
            ${pageNavi}
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>

<script>
    $(function() {
    	if ("${localName}" != "") {
            $("select[name=localName]").val("${localName}").attr("selected", "true");
         }
        $("#localName").change(function(){
           var localName = $(this).val();
           var bookNo= document.getElementsByName("bookNo");
           var str="";
           for (var i = 0; i < bookNo.length; i++) {
                   str+=("&bookNo="+bookNo[i].value);
           }
           if(localName==""){
        	   location.href="/goSpotPage.do?reqPage=1"+str;
           }else{
        	   location.href="/goSpotPage.do?reqPage=1&localName="+localName+str;   
           }
        });
        $("#searchBtn").click(function(){
        	var localName = $("#localName").val();
        	var keyword =$(this).prev().val();
        	var bookNo= document.getElementsByName("bookNo");
            var str="";
            for (var i = 0; i < bookNo.length; i++) {
                    str+=("&bookNo="+bookNo[i].value);
            }
            location.href="/goSpotPage2.do?reqPage=1&keyword="+keyword+"&localName="+localName+str; 
        });
        
        $("input[name=keyword]").keydown(function(event){
           if(event.keyCode==13){//키가 13이면 실행 (엔터는 13)
            event.preventDefault();
            $("#searchBtn").click();
           }
        });
                                
                    
        //--------------------------------------------지도------------------------------
            var xx;
            var yy;
            var addr;
            var name;
            var callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    console.log(result);
                    xx = result[0].x;
                    yy = result[0].y;
                    console.log(xx + "," + yy);
                    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
                    var options = { //지도를 생성할 때 필요한 기본 옵션
                        center: new kakao.maps.LatLng(yy, xx), //지도의 중심좌표.
                        level: 3 //지도의 레벨(확대, 축소 정도)
                    };

                    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 
                }
            };
        $("input[type=radio]").click(function() {
        	
            name = $(this).val();
            addr = $(this).parent().next().next().children().html();

            var geocoder = new kakao.maps.services.Geocoder();

           
            
            geocoder.addressSearch(addr, callback);
            
               
            

        });
        $("input[type=radio]").first().click();
    });

</script>
