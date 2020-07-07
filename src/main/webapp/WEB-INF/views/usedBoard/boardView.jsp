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
    div {
        box-sizing: border-box;
    }

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
        padding-top: 30px;
        padding-bottom: 200px;
    }

    /*--------------------------------------------------------------------------------------------------*/
    .content>span {
        margin-left: 50px;
        font-size: 16px;
        color: #666;
    }

    .boardFrame {
        overflow: hidden;
        width: 1100px;
        padding: 50px;
        margin: 0 auto;
        margin-top: 10px;
        border-bottom: 1px solid #e0e0e0;
        border-top: 1px solid #999;
        background-color: #ffffff;
        position: relative;
    }

    .bTitle>span {
        display: inline-block;
        font-size: 15px;
        background-color: white;
        text-align: center;
        margin-top: 5px;
        margin-left: 10px;
        margin-right: 20px;
        width: 77px;
        height: 33px;
        color: #111111;
        line-height: 33px;
        font-weight: 100;

    }

    .bTitle {
        border-bottom: 2px solid #585858;
        height: 50px;
        line-height: 42px;
        font-size: 28px;
        font-weight: bold;
        position: relative;
    }
    .bTitle>button{
        position: absolute;
        border: none;
        font-size: 14px;
        width: 90px;
        height: 30px;
        line-height: 30px;
        top:6px;
        border-radius: 3px;
    }
    #modBtn{
        background-color: #f3f4fa;
        color: #03169a;
        right: 110px;
    }
    #delBtn{
        background-color: #e5e5e5;
        right: 0;
    }
    .bContent {
        overflow: hidden;
        padding: 50px;
    }

    .bInfo {
        height: 40px;
        line-height: 40px;
        background-color: #f3f5f7;
        border-bottom: 1px solid #e0e0e0;
        text-align: right;
    }

    .bInfo>span {
        font-size: 15px;
        height: 15px;
        line-height: 14px;
        color: #898989;
        display: inline-block;
        padding-left: 15px;
        padding-right: 19px;
        border-right: 1px solid #898989;
    }

    .bInfo>span:nth-of-type(3) {
        border: none;
    }

    .bInfo>span:last-of-type {
        border: none;
        background-color: #585858;
        color: white;
        font-size: 14px;
        border-radius: 5px;
        padding-left: 19px;
        height: 30px;
        line-height: 30px;
    }

    #showComment {
        height: 40px;
        background-color: #585858;
        text-align: center;
    }
    .comment-write{
        border: 1px solid #b3b3b3;
    }

</style>

<body style="line-height:normal;">
    <div class="wrapper" style="background-color:#f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>기증 / 판매</span>
        </div>
        <div class="content">
            <span>기증/판매 게시판 > 상세글 보기</span>
            <div class="boardFrame">
                <div class="bTitle">${ub.usedTitle} <span>/ 도서 ${ub.usedType}</span><button id="modBtn" onclick="modifyFunc(${ub.usedNo});">수정</button><button id="delBtn" onclick="delFunc(${ub.usedNo});">삭제</button></div>
                <div class="bInfo"><span>${ub.memberId}</span>
                    <span>${ub.usedDate}</span>
                    <span>조회 ${ub.readCount}</span>
                    <c:if test="${ub.usedStatus eq 0}">
                        <span>요청 완료</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 1}">
                        <span>피드백 요청</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 2}">
                        <span>피드백 완료</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 3}">
                        <span>기증/판매 확정</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 4}">
                        <span>기증/판매 반려</span>
                    </c:if>
                </div>
                <div class="bContent">${ub.usedContent}</div>
                <div id="showComment" data-toggle="tooltip" title="댓글을 펼칩니다."><img src="/resources/imgs/more-icon.png"></div>
                
                <div class="comment-write">
		<!-- 작성자, 게시글번호, 댓글레벨, 댓글번호 보내줘야함-->
		<form action="/usedCommentInsert.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="commentWriter" value="${sessionScope.member.memberId }">
		<input type="hidden" name="usedNo" value="${ub.usedNo}"> <!-- 댓글써지는 글번호 -->
			<div><textarea name="commentContent"></textarea></div>
			<input type="file" name="files" multiple="multiple">
            <input type="submit" value="등록">
		</form>
	</div>
                <div class="commentFrame"></div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>

<script>
function delFunc(usedNo){
    if(confirm("정말 삭제하시겠습니까?")){
        location.href="/deleteUsedBoard.do?usedNo="+usedNo;
    }
}
function modifyFunc(usedNo){
    location.href="/goModifyUsedBoard.do?usedNo="+usedNo;
}
</script>

</html>
