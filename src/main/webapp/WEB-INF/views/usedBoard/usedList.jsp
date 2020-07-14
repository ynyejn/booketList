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
        padding-bottom: 200px;
    }

    /*--------------------------------------------------------------------------------------------------*/

    .notice {
        width: 1100px;
        padding: 25px 50px;
        margin: 50px auto;
        border: 1px solid #e5e5e5;
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

    /*------------------------------------------------------------------------------------------*/
    .boardFrame {
        overflow: hidden;
        width: 1100px;
        padding: 50px;
        padding-top:30px;
        margin: 20px auto;
        border: 1px solid #dddddd;
        background-color: #ffffff;
        position: relative;
    }

    .boardFrame>span {
        position: absolute;
        right: 50px;
        text-align: center;
        display: inline-block;
        width: 100px;
        height: 30px;
        color: #111111;
        font-size: 14px;
        line-height: 30px;
        background-color: #e5e5e5;
    }
    .boardFrame>span:hover{
    	background-color: #222222;
    	color:white;
    }
    .boardList {
        margin-top:40px;
    }

    .boardBox {
        width: 100%;
        height: 100px;
        border-bottom: 1px solid #dddddd;
        -webkit-transition: all 0.3s;
        transition: all 0.3s;
    }

    .boardBox:first-of-type {
        border-top: 2px solid #585858;
    }

    .boardBox:last-of-type {
        border-bottom: 2px solid #585858;
    }

    .boardBox:hover {
        background-color: #f3f4fa;
    }


    .boardBox>a>div>div {
        float: left;
    }

    .sec1 {
        color: #03166c;
        font-weight: 700;
        text-align: center;
        line-height: 52px;
    }

    .sec2 {
        font-size: 18px;
        font-weight: 600;
        color: #4f4f4f;
        white-space: normal;
        text-overflow: ellipsis;
    }

    .sec2:hover {
        text-decoration: underline;
    }

    .sec3>span {
        font-size: 15px;
        height: 15px;
        line-height: 14px;
        color: #898989;
        display: inline-block;
        padding-left: 15px;
        padding-right: 19px;
        border-right: 1px solid #898989;
    }

    .sec3>span:first-of-type {
        padding-left: 0;
    }

    .sec3>span:last-of-type {
        border: none;
    }
    .check {
        width: 20px;
        height: 20px;
        vertical-align: -2px;
        opacity: 60%;
    }
    .modal-footer{
        text-align: center;
        margin-right: 130px;
        padding-top: 0px;
        padding-bottom: 30px;
    }
    .modal-footer>button{
        background-color: #e5e5e5; color:#222222; border:none;
        width: 80px;
        height: 30px;
    }
    .modal-footer>button:first-of-type:hover{
         background-color:#222222;
        color: white;
    }
    .modal-footer>button:last-of-type:hover{
         background-color:#666666;
        color: white;
    }
    .nFrame{
        width: 100%;
        margin-top: 14px;
        overflow: hidden;
        text-align: center;
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
    <div class="wrapper" style="background-color:#f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div><span>기증 / 판매</span>
        </div>
        <div class="content">
            <div class="notice">
                <div class="imgBox"><img src="/resources/imgs/bookicon.png"></div>
                <div class="text"><strong style="text-decoration:underline;">여러분의 참여를 기다립니다.</strong><br>
                    당신의 서재에서 잠자고 있는 자료들이 <span style="color:#3cbcc7;">Booket List</span>를 통해 세상의 빛과 만나게 됩니다.<br>
                    기증 및 판매를 원하는 개인은 글을 작성하신 후 판매자의 응답에 따라 기증 및 판매가 가능합니다.</div>
            </div>
            <div class="boardFrame">
                <c:if test="${not empty sessionScope.member }">
		<c:if test="${sessionScope.member.memberId != 'admin' }">
		<span onclick="location.href='/goUsedBoard.do?reqPage=1&memberId=${sessionScope.member.memberId}'" style="right:165px; cursor:pointer;">내 글 보기</span>
            <span onclick="location.href='/goBoardWrite.do'" style="cursor:pointer;">글작성</span></c:if></c:if>
                <div class="boardList">
                    <c:forEach items="${list }" var="l">
                        <div class="boardBox">
                            <a href="javascript:void(0)" onclick="openModal(${l.usedNo});">
                              <div style="padding:24px 0;">
                                    <div class='sec1' style='width:246px; height:52px;'>
                                        도서${l.usedType}
                                    </div>
                                    <div class='sec2' style='width:750px; height:26px;'>
                                        ${l.usedTitle}</div>
                                    <div class='sec3' style='width:750px; height:26px;'>
                                        <c:if test="${l.usedStatus eq 0}">
                                            <span style='color:#AAB6EF;' data-toggle="tooltip" data-placement="bottom" title="관리자의 답변을 기다리세요.">요청 완료</span>
                                        </c:if>
                                        <c:if test="${l.usedStatus eq 1}">
                                            <span style='color:#FA6556;' data-toggle="tooltip" data-placement="bottom" title="추가 자료를 올려주세요!">피드백 요청</span>
                                        </c:if>
                                        <c:if test="${l.usedStatus eq 2}">
                                            <span style='color:#0066b3;' data-toggle="tooltip" data-placement="bottom" title="관리자의 답변을 기다리세요.">피드백 완료</span>
                                        </c:if>
                                        <c:if test="${l.usedStatus eq 3}">
                                            <span style='color:#7ABA81;'>기증/판매 확정</span>
                                        </c:if>
                                        <c:if test="${l.usedStatus eq 4}">
                                            <span style='color:#FA6556;' data-toggle="tooltip" data-placement="bottom" title="반려되었습니다.">기증/판매 반려</span>
                                        </c:if>
                                        <span>${l.memberId}</span>
                                        <span>${l.usedDate}</span>
                                        <span>조회 ${l.readCount}</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="nFrame">${pageNavi}</div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
  <div class="modal fade" id="myModal" style="top:200px;">
    <div class="modal-dialog">
      <div class="modal-content" style="padding-left:96px; padding-top:45px; background-color: #f3f5f7; height:200px; font-size:18px; border:1px solid #222222;">
          
     <!-- Modal body -->
        <div class="modal-body" style="padding:0px;">
          <img src="/resources/imgs/bookicon.png" class="check">비밀번호를 입력하세요.<br>
            <input type="password" id="ans" style="width:300px; height:38px; border: 1px solid #dddddd; margin-top:10px;">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" style="border-top:none; padding-top:0px;">
            <button type="button" class="btn" id="goBtn">확인</button>
          <button type="button" class="btn" data-dismiss="modal" >닫기</button>
        </div>
        <input type="hidden" id="modalUsedNo">
      </div>
    </div>
  </div>
<script>
//모달열기
function openModal(usedNo){
    $("#myModal").modal();
    $("#ans").val("");
    $("#modalUsedNo").val(usedNo);
    $("#goBtn").attr("onclick","return goBoardView("+usedNo+");");
    
}
//비밀번호확인
function goBoardView(usedNo){
    var usedPw=$("#ans").val();
    $.ajax({
		  url:"/checkUsedPw.do",
		  data : {usedNo:usedNo,usedPw:usedPw},
		  type:"post",
		  success:function(data){
			  if (data == "0") {
				  alert("비밀번호를 확인해주세요.");
				  $("#ans").val("");
			        return false;
               } else {
            	   location.href="/goBoardView.do?usedNo="+usedNo;
               }
		  }
	  })

}
</script>

</html>
