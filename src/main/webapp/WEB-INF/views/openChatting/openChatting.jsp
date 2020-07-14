<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting</title>

<style>
        .content {
            width: 1200px;
	overflow: hidden;
	margin: 0 auto;
	height: 100%;
	text-align: center;
           
        }

.cTop {
	margin-top: 120px;
	width: 100%;
	height: 200px;
	background-image: url(/resources/imgs/applBook.jpg);
	position: relative;
}

.cTop>span {
	color: #eeeeee;
	font-size: 40px;
	font-weight: bolder;
	position: absolute;
	padding-left: 300px;
	padding-right: 30px;
	top: 55px;
	left: 0px;
	text-shadow: 1px 1px 2px black;
	border-bottom: 5px solid #dddddd;
	box-shadow: 0px 1px 0px black;
}
.btnBox {
	text-align: right;
	width: 90%;
	height: 60px;
	display: inline-block;
}
.aBox {
	
	width: 100%;
	height: 100%;
	display: block;
	
}
.allCheck {
	border: none;
	background-color: #007bff;
	color: white;
	width: 80px;
	height: 30px;
	font-size: 14px;
	border-radius: 3px;
	display: inline-block;
	text-align: center;
	font-weight : normal;
}
#searchDiv {
	width: 1100px;
	padding: 15px 10px;
	margin: 0 auto;
	border-top: 2px solid #585858;
	text-align: center;
}
.chatTitle{
	width: 100%;
	height: 70px;
	line-height:70px;
	text-align: center;

}
.openChatting{
	width: 32%;
	margin-bottom: 2%;
	display: inline-block;
	width: 370px;
	
}
.openChattingBox {
	text-align: center;
	border: 1px solid lightgray;
	width: 350px;
	display: inline-block;
	border-radius: 5px;
	overflow: hidden;
	box-shadow : 1px 1px 3px lightgray;
	background-color : white;
	
/* 	float: left; */
}
table {
	width: 350px;
}
.chatABox{
	line-height : 30px;
}

.chatDate{
	text-align: right;
	padding-right: 15px;
	font-weight : normal;
}
.chatPers{
	text-align: right;
	padding-right: 15px;
	font-weight : normal;

}
.aRet{
	text-align: right;
	padding-right: 7px;
}
.chatPe{
	text-align: left;
	padding-left: 15px;
}
</style>
</head>
<body>
<div class="wrapper" style='background-color : #f3f5f7;'>
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="cTop">
			<div class="black"></div>
			<span>오픈 채팅</span>
		</div>
		<div class="content">
		<div class="emptyDiv" style="height: 35px;"></div>
			<div class="btnBox">
				<button class="allCheck" type="button">방만들기</button>
			</div>
			<div id="searchDiv"></div>
		
		<c:forEach var="list" items="${openChatting }">
		<div class="openChatting">
		<br>
		<div class="openChattingBox">
		<table>
			<tr  class="chatTitle">
				<th colspan="2" class="chatTitle">
					<div class="chatTitle"><span class="chatTitle">${list.chatTitle }방</span></div>
				<input type="hidden" class="title" value="${list.chatTitle }">
				</th>
			</tr>
			<tr>
			<th class="chatPe">현재 인원수</th>
				<th class="chatPers"> ${list.chatPersonnel }/${list.chatPeople }
				</th>
			</tr>
			<tr>
			<th class="chatPe">개설일</th>
				<th class="chatDate">${list.chatEnrollDate }
				</th>
			</tr>
			<tr>
				<th colspan="2" class="aRet"><div class="aBox"><div class="chatABox">
					<a  type="button"class="allCheck"  href="/chat/chatRoom.do?title=${list.chatTitle }"  onclick="window.open(this.href, '_blank', ' location=no,width=500,height=600,toolbars=no,scrollbars=no'); return false;">
				방참여</a></div></div>
				</th>
			</tr>
		</table>
			
		</div>
			</div>
		</c:forEach>
		<div id="searchDiv"></div>
		<div class="emptyDiv" style="height: 35px;"></div>
			</div>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	$(function () {
		var memberId = '${sessionScope.member.memberId}';
		if(memberId==""){
			alert("로그인이 필요합니다");
			location.href="/member/loginFrm.do";
		}
	var title = 1;
		$("button").click(function () {
			window.name="apply"
			var url = "/chat/makingRoomFrm.do";
			title = title+1;
			var style = "location=no,width=500,height=600,top=100,left=400";
			window.open(url,title,style);
		});
		
	})
	
	</script>
</body>
</html>