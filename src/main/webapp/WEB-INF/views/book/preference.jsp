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
            width: 1280px;
            overflow: hidden;
            margin: 0 auto;
        }
        .black {
	        background-color: #1B3A50;
	        width: 100%;
	        height: 100%;
	        opacity: 65%;
        }
        .mainImgDiv {
        	width : 100%;
        	margin-top : 120px;
        	height : 360px;
        	z-index : 50;
        	background-size : cover;
        	text-align :center;
        }
        .userNameSpan, .userCategorySpan {
        	color : #eeeeee;
		    font-size: 40px;
		    font-weight: bolder;
	        text-shadow: 1px 1px 2px black;
	        position : absolute;
	        z-index : 1000;
        }
        .userNameSpan {
           	margin-top : -250px;
         	margin-left : -300px;    
        }
        .userCategorySpan {
          	margin-top : -210px;
         	margin-left : -200px;   
        }
        .listDiv {
	 	    width : 1060px;
	 	    heigth: 178px;
			padding : 20px 30px;
			margin: 0 auto;    
	        border: 1px solid lightgray;
	   		background-color : white;
	   		margin-bottom : 10px;
    	}
    	#bookImg {
    		width: 95px;
    		height : 135px;
    	}
    	#bookNameATag {
      		font-size: 16px;  	
    		font-weight: bold;
    	}
    	#bookInfoSpan {
    		font-size: 14px;
    		color: #495057;
    	}
        .bookListTd1 {
        	width : 40px;
        	vertical-align: 0;
        	text-align : center;
        	font-weight : bold;
        }
        .bookListTd2 {
        	width : 150px;
			text-align : center;
        }
        .bookListTd3 {
        	width:750px;
        	vertical-align: 0;
        	padding-left : 10px;
        }
        #chartDiv {
        	width : 1100px;
        	height : 500px;
        	margin : 0 auto;
        	margin-top : 50px;
       }
        #chartDiv2 {
        	width : 1060px;
        	height : 402px;
        	margin : 0 auto;
        	text-align : center;
	        border: 1px solid lightgray;
	        background-color : white;
        }
        #spanDivSpan {
        	
           	font-size : 30px;
		    border-bottom: 2px solid #585858;
		    text-align:center;           
		    margin-bottom : 20px;	
        }
        .listDiv:hover {
        	background-color : lightgray;
        	cursor : pointer;
        }
        .spanDiv{
        	width : 1060px;
        	margin : 0 auto;
        }
        .contentList {
        	width : 1100px;
        	padding-top : 20px;
	    	border-top: 2px solid #585858;
		    border-bottom: 2px solid #585858;
		    margin : 0 auto;
		    margin-bottom : 70px;
         }
         .content>.spanDiv {
         	margin : 0 auto;
         	height : 48px;
         	
         }
         .spanDiv > div {
         	display : inline-block;
         	height : 48px;
         	width: 33%;
        	text-align : center;         
        	float : left;
         }
         .spanDiv>div>span{
        	font-size : 30px;
         }
         #refreshButton{  
         	float : right;
    	    border: none;
		    width: 50px;
		    height: 50px;
         }
         #refreshButton:hover {
         	cursor : pointer;
         	transition: all ease 1s;
         	transform: rotate(360deg);
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
				width: 400,
				height: 400,
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
				$(".contentList").children().remove();
 				var html = "";
				for(var i=0; i<data.length; i++) {
					html += "<div class='listDiv' onclick='searchBook("+(i+1)+")';>";
					html += "<input type='hidden' id='input"+(i+1)+"' value='"+data[i].bookCategory+"~구분~"+data[i].bookName+"'><table class='bookListTable'>";
					html += "<tr class='bookListTr'>";
					html += "<td class='bookListTd1'>"+(i+1)+".</td>"
					html += "<td class='bookListTd2'><img id='bookImg' src='"+data[i].bookImg+"'></td>";
					html += "<td class='bookListTd3'><a id='bookNameATag' href='/rent/searchBookDetail.do?categorySelect="+data[i].bookCategory+"&bookAttr=book_name&reqPage=1&sort=book_name&inputText="+data[i].bookName+"'>"+data[i].bookName+"</a><br><span id='bookInfoSpan'>"+data[i].bookWriter+"</span><br><span id='bookInfoSpan'>"+data[i].bookPublisher+"</span><br><span id='bookInfoSpan'>"+data[i].bookCategory+"</span></td></tr>";
					html += "</table></div>";
				}
				$(".contentList").append(html); 
			}, error : function() {
				console.log("Ajax error");
			}
		});
	}
	
	function searchBook(obj) {
		console.log(obj);
		var bookCategory = $('#input'+obj).val().split('~구분~')[0];
		var bookName = $('#input'+obj).val().split('~구분~')[1];
		location.href = "/rent/searchBookDetail.do?categorySelect="+bookCategory+"&bookAttr=book_name&reqPage=1&sort=book_name&inputText="+bookName;
	};
  </script>    
<body style="line-height:normal;">
<div class="wrapper"  style="background-color : #f3f5f7;">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<c:choose>
			<c:when test="${userCategory eq '사회과학'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/social.png');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>
			<c:when test="${userCategory eq '초등학교참고서'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/elementary.jpg');">
					<div class="black"  style="opacity:60%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '잡지'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/magazine.jpg');">
					<div class="black"  style="opacity:60%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '달력/기타'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/calendar.jpg');">
					<div class="black"  style="opacity:60%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>					
			<c:when test="${userCategory eq '에세이'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/essay.jpg');">
					<div class="black"  style="opacity:20%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>			
			<c:when test="${userCategory eq '만화'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/marvel.png');">
					<div class="black"  style="opacity:65%;"></div>		
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>
			<c:when test="${userCategory eq '좋은부모'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/family.jpg');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>			
			<c:when test="${userCategory eq '과학'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/science.png');">
					<div class="black"  style="opacity:40%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>
			<c:when test="${userCategory eq '컴퓨터/모바일'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/computer.png');">
					<div class="black"  style="opacity:10%;"></div>		
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>			
			<c:when test="${userCategory eq '예술/대중문화'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/art.jpg');">
					<div class="black" style="opacity:40%;"></div>	
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '고등학교참고서'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/analysis.png');">
					<div class="black"  style="opacity:50%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '전집/중고전집'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/antique.jpg');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
			</div>
			</c:when>			
			<c:when test="${userCategory eq '인문학'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/study.jpg');">
					<div class="black"  style="opacity:20%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>				
			<c:when test="${userCategory eq '종교/역학'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/religion.jpg');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '어린이'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/family.jpg');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '중학교참고서'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/analysis.png');">
					<div class="black"  style="opacity:50%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '외국어'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/english.jpg');">
					<div class="black"  style="opacity:40%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:when test="${userCategory eq '대학교재/전문서적'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/study2.png');">
					<div class="black"  style="opacity:35%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>			
			<c:when test="${userCategory eq '수험서/자격증'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/study.jpg');">
				<div class="black"  style="opacity:20%;"></div>
				<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
				<span class="userCategorySpan">[${userCategory}]입니다.</span>
			</div>
			</c:when>
			<c:when test="${userCategory eq '소설/시/희곡'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/essay.jpg');">
					<div class="black"  style="opacity:20%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>
			<c:when test="${userCategory eq '건강/취미/레저'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/leisure.jpg');">
					<div class="black"  style="opacity:20%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>		
			<c:when test="${userCategory eq '여행'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/travel.png');">
					<div class="black"  style="opacity:20%;"></div>	
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>			

			<c:when test="${userCategory eq '청소년'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/elementary.jpg');">
					<div class="black"  style="opacity:60%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>
			<c:when test="${userCategory eq '유아'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/family.jpg');">
					<div class="black"  style="opacity:30%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>		
			<c:when test="${userCategory eq '가정/요리/뷰티'}">
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/home.png');">
					<div class="black"  style="opacity:40%;"></div>
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:when>	
			<c:otherwise>
				<div class='mainImgDiv' style="background-image: url('/resources/imgs/analysis.png');">
					<div class="black"  style="opacity:50%;"></div>		
					<span class="userNameSpan">${sessionScope.member.memberNickname}님의 취향은</span><br>
					<span class="userCategorySpan">[${userCategory}]입니다.</span>
				</div>
			</c:otherwise>
		</c:choose>
	<div class="content">
		<div id="chartDiv">
			<div id="spanDivSpan">
				<img style='height:20px; width:20px;' src="/resources/imgs/bookicon.png" class="check">
				${sessionScope.member.memberNickname }님의 독서 통계
				<img style='height:20px; width:20px;' src="/resources/imgs/bookicon.png" class="check">
			</div>
			<div id="chartDiv2">
			    <div id="piechart" style="width: 450px; height: 400px; display:inline-block;"></div>
				<div id="columnchart_values" style="width: 400px; height: 400px; display:inline-block;"></div>	
			</div>
		</div>
		<div class='spanDiv'>
			<div class="spanDiv1"></div>
			<div class="spanDiv2">
				<img style='height:20px; width:20px;' src="/resources/imgs/bookicon.png" class="check">
				<span>추천 책 목록</span>			
				<img style='height:20px; width:20px;' src="/resources/imgs/bookicon.png" class="check">				
			</div>
			<div class="spanDiv3">
				<img id="refreshButton" onclick='refresh();' src="/resources/imgs/rotate_icon.png">
			</div>
		</div>
		<div class="contentList">
			<c:forEach items="${bookAndReviewList }" var="n" varStatus="i">
				<div class="listDiv" onclick="searchBook(${i.count});">
					<input type="hidden" id="input${i.count }" value="${n.bookCategory }~구분~${n.bookName}">
					<table class="bookListTable">
						<tr class="bookListTr">
							<td class='bookListTd1'>${i.count }.</td>
							<td class='bookListTd2'><img id='bookImg' src='${n.bookImg }'></td>
							<td class='bookListTd3'>
								<a id='bookNameATag' href='/rent/searchBookDetail.do?categorySelect=${n.bookCategory}&bookAttr=book_name&reqPage=1&sort=book_name&inputText=${n.bookName}'>${n.bookName }</a><br>
								<span id="bookInfoSpan">${n.bookWriter }</span><br>
								<span id="bookInfoSpan">${n.bookPublisher }</span><br>
								<span id="bookInfoSpan">${n.bookCategory }</span>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</div>
</body>
</html>