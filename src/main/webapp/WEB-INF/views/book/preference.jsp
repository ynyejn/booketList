<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      <script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
    <!-- google charts -->
	   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
        .content {
            width: 1200px;
            overflow: hidden;
            margin: 120px auto 0 auto;
/*             height: 2000px; */
            background-color: aliceblue;
        }
</style>
	<!-- 구글차트 파이 차트. -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
    
    //model값 불러오기
	$(function () {

		var reviewListLength = ${reviewList}.length;
		var rentListLength = ${rentList}.length;
		var writerListLength = ${writerList}.length;
		var rentDateListLength = ${rentDateList}.length;
		
		var rentBookCategory = new Array();
		var rentBookCategoryCnt = new Array();
		for(var i=0; i<rentListLength; i++) {
			rentBookCategory.push(${rentList}[i]["bookCategory"]);
			rentBookCategoryCnt.push(${rentList}[i]["cnt"]);
		}
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart1);
		google.charts.setOnLoadCallback(drawChart2);

   
		//파이차트
		function drawChart1() {
			var sett = 'opacity: 0.85;';
			var data = new google.visualization.DataTable();
			data.addColumn("string", 'GENRE');
			data.addColumn("number", '3');
			data.addColumn({ type: 'string', role: 'style' });
			
			if(rentListLength>=1) {
				for(var i=0; i<rentListLength; i++) {
					data.addRow([${rentList}[i]["bookCategory"], ${rentList}[i]["cnt"], sett]);
				}    				
			}else {
				var html = "<H3>구독한 책이 한 권도 없습니다. </H3><H3>아래의 책들은 어떠신가요 ? </H3>"
				$("#chartDiv").children().remove();
				$("#chartDiv").append(html);				
			}
			var options = {
				title: '읽은 책들의 장르 비율',
				animation: {
					duration: 1000,
					easing: 'out',
					startup: true 
				},
				slices: 
					{0: {color: '#0066b3', offset: 0.05}, 
				 	1: {color: '#666666'}, 
				 	2: {color: '#00a3e0'}, 
				 	3: {color: '#eeeeee'}, 
				 	4: {color: '#666666'}, 
				 	5: {color: '#eeeeee'}},
					pieHole: 0.4
					/* #666666 */
			};
			var chart = new google.visualization.PieChart(document.getElementById('piechart'));
			chart.draw(data, options);

			// initial value
			var percent = 0;
			// start the animation loop
			var handler = setInterval(function(){
				// values increment
				percent += 0.05;
				// apply new values
				data.setValue(0, 1, percent);
				// update the pie
				chart.draw(data, options);
				// check if we have reached the desired value
				if (percent >= ${rentList}[0]["cnt"])
				    // stop the loop
				    clearInterval(handler);
			 }, 25);      
		}

		//바 차트
		function drawChart2() {
			var sett1 = 'opacity: 0.90; color:#0066b3;';
			var sett2 = 'opacity: 0.90; color:#00a3e0;';
			var data = new google.visualization.DataTable();
			data.addColumn("string", 'GENRE');
			data.addColumn("number", 'Review Score ');
			data.addColumn({ type: 'string', role: 'style' });
			
			if(reviewListLength > 1) {
				data.addRow([${reviewList}[0]["bookCategory"], ${reviewList}[0]["reviewScore"], sett1]);      
				for(var i=1; i<reviewListLength; i++) {
					data.addRow([${reviewList}[i]["bookCategory"], ${reviewList}[i]["reviewScore"], sett2]);
				}       				
			}else if(reviewListLength == 1) {
				data.addRow([${reviewList}[0]["bookCategory"], ${reviewList}[0]["reviewScore"], sett1]);      				
			}else {
				data.addRow([, , sett1]);
				var html = "<H3>취향 분석 데이터가 부족해 분석할 수 없습니다. </H3><H3>아래의 책들은 어떠신가요 ? </H3>"
				$("#chartDiv").children().remove();
				$("#chartDiv").append(html);
			}
			
			var view = new google.visualization.DataView(data);
			var options = {
				title: "내가 남긴 장르별 평점",
				width: 550,
				height: 550,
				bar: {groupWidth: 550/reviewListLength+'px'},
				opacity: 0.8,
				legend: { position: "none" },
				animation: {
				    duration:2000,
				    easing: 'out',
				    startup: true
				},
				colors: ['red', 'green', 'blue']
			};
			var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
			chart.draw(view, options);
		};
	});
    
	function refresh() {
		$.ajax({
			url : '/rent/refresh.do',
			success : function(data){
				$(".bookListTr").remove();
				var html = "";
				for(var i=0; i<data.length; i++) {
					html += "<tr class='bookListTr'><td><img src='"+data[i].bookImg+"'></td>";
					html += "<td><a href='/rent/searchBookDetail.do?categorySelect="+data[i].bookCategory+"&bookAttr=book_name&reqPage=1&sort=book_name&inputText="+data[i].bookName+"'>"+data[i].bookName+"</a></td>";
					html += "<td>"+data[i].bookCategory+"</td></tr>";
				}
				$("#bookListTable").append(html);
			}, error : function() {
				console.log("Ajax error");
			}
		});
	}
  </script>    
<body style="line-height:normal;">
<div class="wrapper" >
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<div style="height : 500px; background-image: url('/resources/imgs/romance.jpg');">
				<!-- <img src="/resources/imgs/romance.jpg"> -->
				<h1>${sessionScope.member.memberNickname}님의 취향은</h1>
 				<h1>[${userCategory}]입니다. </h1>
 				<c:if test="${type eq 0}">
	 				<h1>타입은 [선택 취향 없음]입니다</h1> 				
 				</c:if>
 				<c:if test="${type eq 1}">
	 				<h1>타입은 [책 10권 미만 구독자]입니다</h1> 				
 				</c:if>
 				<c:if test="${type eq 2}">
	 				<h1>타입은 [책 10권 이상, 평점3.0이상 없음]입니다</h1> 				
 				</c:if>
 				<c:if test="${type eq 3}">
	 				<h1>타입은 [책 10권 이상, 평점3.0이상 있음]입니다</h1> 				
 				</c:if>
			</div>
			<div id="chartDiv">
				그래프
				<hr>
				<H4>구글차트 테스트</H4>
				    <div id="piechart" style="width: 550px; height: 550px; display:inline-block;"></div>
					<div id="columnchart_values" style="width: 550px; height: 550px; display:inline-block;"></div>
				<hr>		
			</div>
			<div>
				추천 책목록
				<button type="button" onclick='refresh();'>새로 추천 받기</button>
				<table border='1' id="bookListTable">
					<tr id="bookListTitle">
						<th>이미지</th>
						<th>제목</th>
						<th>카테고리</th>
					</tr>
					<c:forEach items="${bookAndReviewList }" var="n" varStatus="i">
						<tr class="bookListTr">
							<td><img src='${n.bookImg }'></td>
							<td><a href='/rent/searchBookDetail.do?categorySelect=${n.bookCategory}&bookAttr=book_name&reqPage=1&sort=book_name&inputText=${n.bookName}'>${n.bookName }</a></td>
							<td>${n.bookCategory }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>