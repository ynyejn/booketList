<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 후기</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
		
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
	background-color: aliceblue;
	border: 1px solid black;
	width: 350px;
	height: 90%;
	display: block;
	
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	overflow : hidden;
	float: left;
}

.reviews {
	 width: 32%;
  margin-bottom: 2%;
	display:inline-block;
	width: 370px;
	height: 100%;
	  
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
	font-size: 20px;
	border-radius: 3px;
}

#searchDiv {
	width: 1100px;
	padding: 15px 10px;
	margin: 0 auto;
	border-top: 2px solid #585858;
	text-align: center;
}
.reviceImg{
	width: 100%;
}
table{
	width: 350px;
}
.revdate{
	font-size: 0.8em;
}
.revNick{
	text-align: left;
}

/* #reviewList { */
/* padding-left: 80px; */

/*   align-content: space-between; */
/*    content:""; */
/*      display:block; */
/*      clear:both; */
/* } */




</style>
</head>
<body>
	<div class="wrapper">
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
			<c:forEach var="list" items="${r }">
				<div class="reviews">
					<br>
					<div class="reviewBox">
						<table>
							<tr>
								<th class="revNick">${list.memberNickName }<br> <span class="revdate">${list.reviewDate }</span>
								</th>
								<th>${list.reviewScore }점</th>
							</tr>
							<tr>
								<th colspan="2">${list.bookName }<br> ${list.bookPublisher }<br>
									${list.bookWriter }<br> ${list.bookCategory }
								</th>
							</tr>
							<tr>
								<th colspan="2">${list.reviewContent }</th>
							</tr>
							<tr>
								<th colspan="2"><img class="reviceImg"src="${list.reviewFilepath }"></th>
							</tr>
						</table>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#reviewList').msrItems({
				'colums': 3,
				'margin': 15
				});
			$( window ).on('resize',function(e) {
				clearTimeout(time);
				time = setTimeout(function(){
				$('.msrItems').msrItems('refresh');
				}, 200);
				
				})

			$("button").click(function() {
				window.name = "apply"
				var url = "/review/reviewWriting.do";
				var title = "후기";
				var style = "width=400,height=400,top=100,left=400";
				window.open(url, title, style);
			});
		})
		window.opener.location.reload();
		window.close();
	</script>
</body>
</html>