<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 후기</title>

<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 0 auto;
	height: 100%;
	text-align: center;
}

.reviewBox {
	text-align: center;
	border: 1px solid lightgray;
	width: 350px;
	margin : 0 auto;
	display: block;
	border-radius: 3px;
	overflow: hidden;
	margin : 10px;
	background-color : white;
	box-shadow: 1px 1px 5px lightgray;
/* 	float: left; */
}
.reviewBox>table tr:first-child {
	background-color : #f3f5f7;
	border-bottom : 1px solid lightgray;
}

.reviews {
	width: 32%;
	margin-bottom: 2%;
	display: inline-block;
	width: 370px;
	margin : 0 auto;
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

.allCheck {
	border: none;
	background-color: #666666;
	color: white;
	width: 110px;
	height: 35px;
	font-size: 14px;
	border-radius: 3px;
}

#searchDiv {
	margin: 0 auto;
	border-top: 2px solid #666666;
	text-align: center;
}

.reviceImg {
	width: 100%;
}

table {
	width: 350px;
}

.revdate {
	font-size: 0.8em;
}

.revNick {
	text-align: left;
}

#reviewList {
	padding-left:50px;
	display : flex;
	align-content: space-between;
	content: "";
	clear: both;
}

#reviewList > div{
	display : flex;
	flex-direction : column;
}
.reviewImg{
	width: 30px;
	height: 30px;
	padding: 0;
}
.reviewImgBox{
	width: 40px;
	height: 40px;
	padding : 0;
}
.reviewScore{
	text-align: right;
	padding-right: 10px;
}
#listBookNameSpan {
	font-size : 13px;
	font-weight : bold;
}
#listBookPublisherSpan, #listBookWriterSpan {
	font-size : 12px;
	color : #3e4348;
}
#listReviewContent {
	width : 332px;
	word-wrap: break-word;
	white-space: pre-wrap;
	white-space: -moz-pre-wrap;
	white-space: -pre-wrap;
	white-space: -o-pre-wrap;
	word-break:break-all;
	overflow:hidden;
	font-family: 'Noto Sans KR', sans-serif;
	color: #333333;
	

}
#lastContentTr>td {
	font-size : 15px;
	width:340px;
}
#lastContentTr>td {
	text-align:left;
	padding-top:4px;
	padding-left : 8px;
	padding-right : 8px;
	border-top : 1px solid lightgray;
	color: #333333;

}
#contentTr>td {
 	background-color : #f3f5f7;
	text-align:left;
	padding-left : 8px;
	padding-right : 8px;
	
}
#reviewImgBox2 {
	padding: 0;
}
</style>
</head>
<body>
	<div class="wrapper" style ="background-color : #f3f5f7;">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="cTop">
			<div class="black"></div>
			<span>후기 게시판</span>
		</div>
		<div class="content">
			<div class="emptyDiv" style="height: 35px;"></div>
			<div class="btnBox">
				<button class="allCheck" type="button">후기 작성</button>
			</div>
			<div id="searchDiv"></div>
			<div id="reviewList">
				<div>
					<c:forEach var="list" items="${r }" varStatus="status">
						<c:if test="${status.count % 3 == 1 }">
							<div class="reviews">
								<br>
								<div class="reviewBox">
									<table>
										<tr>
										<td class="reviewImgBox"><img src="/resources/review/noun_853841_cc.png" class="reviewImg"></td>
											<th class="revNick">${list.memberNickName }<br> <span
												class="revdate">${list.reviewDate }</span>
											</th>
											<th class="reviewScore">${list.reviewScore }점</th>
										</tr>
										<tr>
											<th id="reviewImgBox2" colspan="3"><img class="reviceImg"
												src="${list.reviewFilepath }"></th>
										</tr>
										<tr id="contentTr">
											<td colspan="3"><span id="listBookNameSpan">${list.bookName }</span><br>
												<c:if test="${not empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter } / </span><span id="listBookPublisherSpan">${list.bookPublisher }</span>																					
												</c:if>
												<c:if test="${empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookPublisherSpan">${list.bookPublisher }</span>												
												</c:if>
												<c:if test="${not empty list.bookWriter && empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter }</span>																																	
												</c:if>
												<c:if test="${empty list.bookWriter && empty list.bookPublisher}">
													<br>																																	
												</c:if>
											</td>
										</tr>
										<tr id="lastContentTr">
											<td colspan="3">
												<pre id="listReviewContent">${list.reviewContent }</pre>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div>
					<c:forEach var="list" items="${r }" varStatus="status">
						<c:if test="${status.count % 3 == 2 }">
							<div class="reviews">
								<br>
								<div class="reviewBox">
									<table>
										<tr>
										<td class="reviewImgBox"><img src="/resources/review/reviewBook2.png" class="reviewImg"></td>
											<th class="revNick">${list.memberNickName }<br> <span
												class="revdate">${list.reviewDate }</span>
											</th>
											<th class="reviewScore">${list.reviewScore }점</th>
										</tr>
										<tr>
											<th id="reviewImgBox2" colspan="3"><img class="reviceImg"
												src="${list.reviewFilepath }"></th>
										</tr>
										<tr id="contentTr">
											<td colspan="3"><span id="listBookNameSpan">${list.bookName }</span><br>
												<c:if test="${not empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter } / </span><span id="listBookPublisherSpan">${list.bookPublisher }</span>																					
												</c:if>
												<c:if test="${empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookPublisherSpan">${list.bookPublisher }</span>												
												</c:if>
												<c:if test="${not empty list.bookWriter && empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter }</span>																																	
												</c:if>
												<c:if test="${empty list.bookWriter && empty list.bookPublisher}">
													<br>																																	
												</c:if>
											</td>
										</tr>
										<tr id="lastContentTr">
											<td colspan="3"><pre id="listReviewContent">${list.reviewContent }</pre></td>
										</tr>

									</table>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div>
					<c:forEach var="list" items="${r }" varStatus="status">
						<c:if test="${status.count % 3 == 0 }">
							<div class="reviews">
								<br>
								<div class="reviewBox">
									<table>
										<tr>
										<td class="reviewImgBox"><img src="/resources/review/noun_853841_cc.png" class="reviewImg"></td>
											<th class="revNick">${list.memberNickName }<br> <span
												class="revdate">${list.reviewDate }</span>
											</th>
											<th class="reviewScore">${list.reviewScore }점</th>
										</tr>
										<tr>
											<th id="reviewImgBox2" colspan="3"><img class="reviceImg"
												src="${list.reviewFilepath }"></th>
										</tr>
										<tr id="contentTr">
											<td colspan="3"><span id="listBookNameSpan">${list.bookName }</span><br>
												<c:if test="${not empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter } / </span><span id="listBookPublisherSpan">${list.bookPublisher }</span>																					
												</c:if>
												<c:if test="${empty list.bookWriter && not empty list.bookPublisher}">
													<span id="listBookPublisherSpan">${list.bookPublisher }</span>												
												</c:if>
												<c:if test="${not empty list.bookWriter && empty list.bookPublisher}">
													<span id="listBookWriterSpan">${list.bookWriter }</span>																																	
												</c:if>
												<c:if test="${empty list.bookWriter && empty list.bookPublisher}">
													<br>																																	
												</c:if>
											</td>
										</tr>
										<tr id="lastContentTr">
											<td colspan="3"><pre id="listReviewContent">${list.reviewContent }</pre></td>
										</tr>

									</table>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div id="searchDiv"></div>
			<br><br>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
		$(function() {
			var memberId = '${sessionScope.member.memberId}';
			
			$("button").click(function() {
				if(memberId==""){
					alert("로그인이 필요합니다");
					location.href="/member/loginFrm.do";
				}else{
					
				window.name = "reviewWriting.do";
				var url = "/review/reviewWriting.do";
				var title = "후기";
				var style = "width=400,height=400,top=100,left=400";
				window.open(url, title, style);
				}
			});
				
		})
	

		
	</script>
</body>
</html>