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
    }

    /*--------------------------------------------------------------------------------------------------*/

    .notice {
        width: 1100px;
        padding: 25px 50px;
        margin: 50px auto;
        overflow: hidden;
        background-color: white;
        border: 1px solid #e5e5e5;
        text-align: center;
    }

    .notice>table{
        width: 100%;
        border: 1px solid lightgray;
    }
    .notice td{
        height: 35px;
    }
    .notice td:first-of-type {
        width: 40%;
    }
.notice td:last-of-type {
        text-align: left;
    }
 

    .text {
        padding-top: 5px;
        font-size: 20px;
        color: #666666;
        margin-bottom: 20px;
    }

    .boardFrame {
        overflow: hidden;
        width: 100%;
        background-color: #f3f5f7;
        margin: 30px 0;
        text-align: center;
    }

    .boardFrame>table {
        border-top: 2px solid #222222;
        border-bottom: 2px solid #222222;
        width: 100%;
        color: #595959;
        text-align: center;
        margin-bottom: 20px;
    }

    .boardFrame>table th {
        background-color: #ebedf4;
        border-bottom: 1px solid #222222;
        height: 50px;
    }

    .boardFrame>table td {
        height: 40px;
        border-bottom: 1px solid #dddddd;
        color: #595959;
    }

     .tag {
         float: left;
        display: inline-block;
        padding: 2px 35px;
        font-size: 17px;
        background-color: #03166c;
        border: 1px solid black;
        border-bottom: none;
        border-top-left-radius: 7px;
        border-top-right-radius: 7px;
        color: #f3f5f7;
    }
    /*--------------------------------페이징*/
.naviBtn, .selectPage, .heading{
        width: 35px;
        height: 35px;
        line-height: 35px;
        font-size: 16px;
        color: #a8adb5;
        display: inline-block;
	}
    .selectPage{
        color: #222222;
        font-size: 20px;
    }
    .heading{
        width: 80px;
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
                <span class="tag">게시글 처리상태</span>
                <table>
                    <tr>
                        <td>요청완료</td>
                        <td>사용자가 최초 글을 올린 상태</td>
                    </tr>
                    <tr style="background-color:#E8DFEE;">
                        <td>피드백 요청</td>
                        <td>관리자가 사용자에게 추가자료를 요구한 상태</td>
                    </tr>
                    <tr style="background-color:#FCEBDA;">
                        <td>피드백 완료</td>
                        <td>사용자가 추가자료를 올린 상태</td>
                    </tr>
                    <tr style="background-color:#F1F8F2;">
                        <td>기증/판매 확정</td>
                        <td>기증/판매가 확정된 상태</td>
                    </tr>
                    <tr style="background-color:#e5e5e5;">
                        <td>기증/판매 반려</td>
                        <td>상태불량 등의 이유로 기증/판매 반려</td>
                    </tr>
                </table>
            </div>
            <div class="boardFrame">
                <table>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>작성자</th>
                        <th>글 제목</th>
                        <th>등록일</th>
                        <th><select id="usedStatus">
                            <option value="-1">처리상태</option>
                            <option value="0">요청 완료</option>
                            <option value="1">피드백 요청</option>
                            <option value="2">피드백 완료</option>
                            <option value="3">기증/판매 확정</option>
                            <option value="4">기증/판매 반려</option>
                            </select></th>
                    </tr>
                    <c:forEach items="${list }" var="l">
                        <tr>
                            <td>${l.usedNo}</td>
                            <td>${l.usedType}</td>
                            <td>${l.memberId}</td>
                            <td><a href="/goBoardView.do?usedNo=${l.usedNo}">${l.usedTitle}</a></td>
                            <td>${l.usedDate}</td>
                            <c:if test="${l.usedStatus eq 0}">
                                <td class="usedStatus">요청 완료</td>
                            </c:if>
                            <c:if test="${l.usedStatus eq 1}">
                                <td class="usedStatus">피드백 요청</td>
                            </c:if>
                            <c:if test="${l.usedStatus eq 2}">
                                <td class="usedStatus">피드백 완료</td>
                            </c:if>
                            <c:if test="${l.usedStatus eq 3}">
                                <td class="usedStatus">기증/판매 확정</td>
                            </c:if>
                            <c:if test="${l.usedStatus eq 4}">
                                <td class="usedStatus">기증/판매 반려</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
                <span>${pageNavi}</span>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
<script>
    $(function() {
        $(".usedStatus").each(function() {
            var usedStatus = $(this).html();
            if (usedStatus == '피드백 요청') {
                $(this).parent().css("background-color", "#E8DFEE");
            } else if (usedStatus == '피드백 완료') {
                $(this).parent().css("background-color", "#FCEBDA");
            } else if (usedStatus == '기증/판매 확정') {
                $(this).parent().css("background-color", "#F1F8F2");
            } else if (usedStatus == '기증/판매 반려') {
                $(this).parent().css("background-color", "#e5e5e5");
            }else if (usedStatus == '요청 완료') {
                $(this).parent().css("background-color", "white");
            }
        });
        
        $("#usedStatus").change(function(){
           var usedStatus=$(this).val();
           location.href="/goAdminUsedBoard.do?reqPage=1&usedStatus="+usedStatus;
        });
        if("${selectStatus}" != ""){
            $("#usedStatus").val("${selectStatus}").prop("selected",true);
        }
    });

</script>

</html>
