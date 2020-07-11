<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
        height: 160px;
        background-image: url(/resources/imgs/guillaume-techer-Fbr64OJNW6U-unsplash.jpg);
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
        padding-bottom: 100px;
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
        width: 83%;
        height: 100%;
        display: inline-block;
    }

    .allCheck,
    .subDiv {
        border: none;
        background-color: #666666;
        color: white;
        width: 110px;
        height: 35px;
        font-size: 14px;
        border-radius: 2px;
    }


    /*--------------------공통*/
    .searchFrame {
        padding: 30px 20px;
        width: 1100px;
        margin: 0 auto;
        margin-top: 5px;
        border-top: 2px solid #585858;
        border-bottom: 2px solid #585858;
    }

    .returnFrame,
    .delayFrame {
        padding: 20px;
        width: 1100px;
        margin: 0 auto;
        border-bottom: 2px solid #585858;
        text-align: center;
    }

    .returnFrame>span,
    .delayFrame>span {
        font-size: 30px;
    }

    .returnFrame>small,
    .delayFrame>small {
        color: #0066b3;
    }

    .searchBox,
    .returnBox,
    .delayBox {
        padding: 20px 50px;
        background-color: #ffffff;
        position: relative;
        width: 1060px;
    }

    /*--------------------검색창*/
    .searchBox {
        padding: 50px 50px;
        padding-left: 100px;
        font-size: 17px;
        border: 1px solid #e5e5e5;
    }

    .searchBox>input {
        width: 860px;
        height: 50px;
        border: 1px solid #03166c;
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
        text-indent: 20px;
        display: inline-block;
        width: 860px;
        height: 38px;
        font-size: 16px;
        line-height: 38px;
        background-color: white;
    }

    .bookList>li:hover {
        background-color: #C8DDF0;
        cursor: default;
    }

    /*---------------반납책내역*/
    .returnBox {
        padding: 9px 50px;
        background-color: white;
        margin-top: 10px;
        border: 1px solid #e5e5e5;
    }

    .returnBook {
        text-align: left;
        position: relative;
        border-bottom: 1px solid #dddddd;
        padding: 22px 0;
        color: #535253;
        font-size: 15px;
    }

    .returnBox>form>div:last-of-type {
       border-bottom: none;
    }
    .nobook{
        width: 100%;
        padding: 20px;
        overflow: hidden;
        text-align: center;
        font-size: 30px;
        font-weight: bolder;
        opacity: 50%;
    }
    .nobook>img{
        width: 250px;
        height: 250px;
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

    .good,
    .bad {
        position: absolute;
        bottom: 13px;
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
    .delayFrame{
        display: none;
    }
    .delayBox {
        text-align: left;
        overflow: hidden;
        padding:30px 50px;
        margin-top: 10px;
    }

    .delayBox>table {
        width: 100%;
        border: 1px solid lightgray;
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
        font-size: 16px;
        line-height: 42px;
        height: 42px;
        color: #535253;
        vertical-align: text-bottom;
    }
    .payPrice{
        font-weight: bold;
        color: #3cbcc7;
        font-size: 18px;
    }
    
    #payBtn {
        float: right;
        width: 160px;
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
        width: 250px;
        display: inline-block;
        height: 70px;
        background-color: #303538;
        color: white;
        line-height: 70px;
        text-align: center;
        border-radius: 5px;
        cursor: pointer;
    }
    [name=returnBtn]:hover, #payBtn:hover{
        background-color: #222222;
    }

</style>

<body style="line-height: normal;">
    <div class="wrapper" style="background-color:#f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div>
            <span>도서 반납 신청</span>
        </div>
        <div class="content">
            <div class="btnDiv">
                <span><img src="/resources/imgs/bookicon.png" class="check"> 대여중인
                    도서 : ${fn:length(list)}권</span>
                <div class="btnBox">
                    <button class="allCheck" type="button">전체 도서 반납</button>
                </div>
            </div>
            <div class="searchFrame">
                <div class="searchBox">
                    <img src="/resources/imgs/bookicon.png" class="check"> 반납 도서 검색<br>
                    <input type="text" name="bookName" placeholder="도서명을 입력하세요">
                    <ul class="bookList">
                        <c:forEach items="${list }" var="r">
                            <li><span>${r.bookName }</span> <input type="hidden" value=${r.bookNo } name="bookNo"> <input type="hidden" value=${r.rentStartDate } name="rentStartDate"> <input type="hidden" value=${r.rentEndDate } name="rentEndDate">
                                <input type="hidden" value=${r.bookWriter } name="bookWriter">
                                <input type="hidden" value=${r.bookStatus } name="bookStatus">
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="returnFrame">
                <span>반납도서</span> <small>반납 선택한 도서 목록입니다</small>
                <div class="returnBox" status=0>
                    <div class="nobook"><img src="/resources/imgs/books.png"><br>
                    선택된 도서가 없습니다.</div>
                    <form action="/goSpotPage.do?reqPage=1" method="get" onsubmit="return nextFunc();">
                    	<input type="hidden" name="reqPage" value=1>
                        <input type='submit' id='goReturn' style='display: none;'>
                    </form>
                </div>
            </div>
            <div class="delayFrame">
                <span>연체료 결제</span> <small>연체료 결제이후 반납이 진행됩니다.</small>
                <div class="delayBox" status="true">
                    <table border="1">
                        <tr>
                            <td style="width: 60%;">도서명</td>
                            <td style="width: 20%;">반납 예정일</td>
                            <td style="width: 20%;">초과일</td>
                        </tr>
                    </table>
                    <div class="payInfo"><img src="/resources/imgs/bluecheck.png" class="check">
                        연체료 | <span class="payPrice">0</span>원<small style="color:#3cbcc7; margin-left:15px;">한 권당 하루 1000원 씩 계산됩니다</small>
                        <button id="payBtn" onclick="payFunc();">결제하기</button>
                    </div>
                </div>
            </div>
            <div class="submitBtn">
                <label for="goReturn" name="returnBtn">다음으로</label><br>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>


</html>

<script>
    $(function() {
    	if("${msg}"!=""){
    		if("${msg}"==0){
    			alert("반납신청이 완료되었습니다.");
    		}else{
    			alert("반납신청이 실패했습니다.");
    		}
    	}
    	
        // 반납도서 검색창
        $("input[name=bookName]").keyup(function() {
            var value = $(this).val();
            if (value == "") {
                $(this).next().hide();
            } else {
                var regExp = /^[ㄱ-ㅎ a-z ㅏ-ㅣ]{1}$/;
                if (regExp.test(value)) {
                    $(this).next().show();
                    $(this).next().children("li").show();
                } else {
                    var regExp2 = new RegExp(value);
                    $(this).next().show();
                    $(".bookList>li").each(function() {
                        if (regExp2.test($(this).children("span").html())) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                }
            }

        });
        // 반납도서 선택했을 때
        $("input[name=bookName]").focusout(function() {
            var value = $(this).val();
            $(".bookList>li").each(function() {
                if (value == $(this).children().html()) {
                    var check=0;
                    $(".returnBook>.bookName").each(function(){
                       if($(this).html()==value){
                           check++;
                       } 
                    });
                    if(check==0){
                    if($(".nobook").css("display")=="block"){
                        $(".nobook").hide();
                    }
                    var html = "";
                    var html2 = "";
                    html += "<div class='returnBook'>";
                    html += "<input type='hidden' name='bookNo' value='" + $(this).children('input[name=bookNo]').val() + "'>";
                    html += "<button class='subDiv' type='button' onclick='subFunc(this);'><img src='/resources/imgs/x.png'></button>";
                    html += "<span class='bookName'>" + value + "</span> /";
                    html += "<span class = 'bookWriter'>" + $(this).children('input[name=bookWriter]').val() +
                        "</span><br>";
                    html += "대여일 :<span class='rentStartDate'>" + $(this).children('input[name=rentStartDate]').val() + "</span><br> 반납예정일 :<span class='rentEndDate'>" + $(this).children('input[name=rentEndDate]').val() + "</span>";
                    if ($(this).children('input[name=bookStatus]').val() == "4") {
                        var test1 = $(this).children('input[name=rentEndDate]').val();
                        var dt1 = new Date();
                        var dt2 = new Date(test1);
                        var day = (dt1 - dt2) / (1000 * 86400);
                        day = Math.floor(day);
                        if(day!=0){
                        	html += "<div class='bad'>연체중</div></div>";
                            html2 += "<tr><td class='delayBookName'>" + value + "</td>";
                            html2 += "<td style='color: #FA6556;'>" + $(this).children('input[name=rentEndDate]').val() + "</td>";
                            html2 += "<td class='delaydays'>" + day + "</td></tr>";
                            $(".payPrice").html(Number($(".payPrice").html())+day*1000);
                            $(".delayFrame").show();
                            $(".delayBox").attr("status","false");	
                        }
        
                    } else {
                        html += "<div class='good'>대여중</div></div>";
                    }
                    $(".returnBox").attr("status",Number($(".returnBox").attr("status"))+1);
                    $(".returnBox>form").append(html);
                    $(".delayBox tbody").append(html2);
                    $("input[name=bookName]").val("");
                        }else{
                            alert("이미 반납목록에 추가된 책입니다.");
                            $("input[name=bookName]").val("");
                        }
                }
            });
            $(this).next().hide();
        });
        $(".bookList>li").mouseenter(function() {
            $("input[name=bookName]").val($(this).children().html());
        });

        
    //대여중인 도서 전체 반납
        $(".allCheck").click(function(){
            if($(".nobook").css("display")=="block"){
                        $(".nobook").hide();
                    }
            $(".returnBook").each(function(){
                $(this).children(".subDiv").click();
            });
            $(".bookList>li").each(function(){
               $("input[name=bookName]").val($(this).children().html());
                 $("input[name=bookName]").focusout();
            });
        });
         $("button").mousedown(function(){
            $(this).css("outline","none");
        });
      
    });

    //반납내역에서 빼기    
    function subFunc(btn) {
        var bookName = $(btn).next().html();
        $(".delayBookName").each(function() {
            if ($(this).html() == bookName) {
                //연체료빼고
                var day=Number($(this).next().next().html());
                $(".payPrice").html(Number($(".payPrice").html())-day*1000);
                //연체내역에서지우기
                $(this).parent("tr").remove();
                if($(".payPrice").html()=="0"){
                    $(".delayFrame").hide();
                    $(".delayBox").attr("status","true");
                }
            }
        });
        $(btn).parent("div").remove();
        $(".returnBox").attr("status",Number($(".returnBox").attr("status"))-1);
        if($(".returnBox").attr("status")==0){
                        $(".nobook").show();          
        }
    }

    // 결제
    function payFunc() {
        var d = new Date();
        var date = d.getFullYear() + "" + (d.getMonth() + 1) + "" +
            d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();
        var payPrice=Number($(".payPrice").html());
        IMP.init("imp03735690");
        IMP.request_pay({
            //결제정보넘김
            merchant_uid: '상품명_' + date,
            name: 'BooketList',
            amount: payPrice,
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
    // 다음으로이동
    function nextFunc() {
        if($(".returnBox").attr("status")==0){
            alert("반납도서를 확인하세요.");
            return false;
        }
        if ($(".delayBox").attr("status") == "false") {
            alert("연체료를 확인하세요.");
            return false;
        }
    }

</script>
