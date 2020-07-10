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
	        z-index : 500;
        }
        .userNameSpan {
           	margin-top : -250px;
         	margin-left : -200px;    
        }
        .userCategorySpan {
          	margin-top : -210px;
         	margin-left : -100px;   
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
       #chartDiv > img {
       		padding-left:10px;
       		padding-right:10px;
       		opacity : 0.98;
       }
        #chartDiv2 {
        	width : 1060px;
        	height : 402px;
        	margin : 0 auto;
        	text-align : center;
	        border: 1px solid lightgray;
	        background-color : white;
	        position : relative;
        }
        #spanDivSpan {
        	position : relative;
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
         .imgSpan0 {
         	color : #eeeeee;
         	font-weight : bold;
         	font-size : 28px;
         	position : absolute;
         	text-shadow: 1px 1px 2px black;
         }
         .imgSpan01 {
         	margin-left : 470px;
         	margin-top : -330px;
         }
         .imgSpan02 {
         	margin-left : 470px;
         	margin-top : -280px;
         }
         .imgSpan03 {
         	margin-left : 470px;
         	margin-top : -230px;
         }
         .imgSpan11 {
         	margin-left : 570px;
         	margin-top : -330px;
         }
         .imgSpan12 {
         	margin-left : 570px;
         	margin-top : -280px;
         }
         #noDataDiv {
         	position : absolute;
         	background-color : gray;
         	width : 140px;
         	height : 40px;
         	color : white;
         	top : 160px;
         	left : 685px;
         	line-height : 40px;
         	font-size : 12px;
         	opacity : 0.9;
         }
         #keywordBtn {
         	position : absolute;
         	top : 5px;
         	right : 20px;
			border: none;
	    	background-color: rgb(0, 102, 179);
	    	color: white;
		    width: 110px;
		    height: 35px;
		    font-size: 14px;
		    border-radius: 2px;         
    	}

</style>
<script>



</script>

	<!-- 구글차트 파이 차트. -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
    
    //model값 불러오기
	$(function () {

		var reviewListLength = ${reviewList}.length;
		var rentListLength = ${rentList}.length;
		var writerListLength = ${writerList}.length;
		var rentDateListLength = ${rentDateList}.length;
		var rentCount = 0;
		var rentBookCategory = new Array();
		var rentBookCategoryCnt = new Array();
		for(var i=0; i<rentListLength; i++) {
			rentBookCategory.push(${rentList}[i]["bookCategory"]);
			rentBookCategoryCnt.push(${rentList}[i]["cnt"]);
			rentCount += ${rentList}[i]["cnt"];
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
/* 				var html = "<H3>구독한 책이 한 권도 없습니다. </H3><H3>아래의 책들은 어떠신가요 ? </H3>"
				$("#chartDiv").children().remove();
				$("#chartDiv").append(html);	 */			
			}
			var options = {
				title: '읽은 책들의 장르 비율',
				chartArea:{top:60,left:100,width:"80%",height:"80%"},
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
/* 				data.addRow([, , sett1]);
				var html = "<H3>취향 분석 데이터가 부족해 분석할 수 없습니다. </H3><H3>아래의 책들은 어떠신가요 ? </H3>"
				$("#chartDiv").children().remove();
				$("#chartDiv").append(html); */
			}
			
			var view = new google.visualization.DataView(data);
			var options = {
				title: "내가 남긴 장르별 평점",
				chartArea:{width:"70%",height:"70%"},
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
		 $("#keywordBtn").click(function () {
				console.log("click");
				
				console.log(rentCount);
				if(rentCount > 1) {
					var status = "left=200px, top=150px, width=980px, height=550px, menubar=no, status=no, scrollbars=no"; 
					var title = "wordcloud";
		 			window.open("/rjava/connection.do",title, status); 				
				}else{
					$("#myBtn2").trigger('click');
				}
					
			 });
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
	};

	function searchBook(obj) {
		console.log(obj);
		var bookCategory = $('#input'+obj).val().split('~구분~')[0];
		var bookName = $('#input'+obj).val().split('~구분~')[1];
		console.log(bookCategory);
		console.log(bookName);
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
				<c:if test="${rentListSize > 0}">	
					<button id="keywordBtn" type="button">워드클라우드</button>									
				</c:if>			
			</div>
			<c:if test="${type eq 0}">
				<!-- //취향이 모두 비어있으며, 책 10권미만 구독. 취향을 선택하지 않아 정확한 이용이 불가능합니다. -->
				<img style="position : relative;" src="/resources/imgs/bookChild.jpg" style="width:1080px; height:400px;">
				<span class="imgSpan0 imgSpan01">취향을 선택하지 않아 정확한 이용이 불가능해요! </span>			
				<span class="imgSpan0 imgSpan02">10권 이상 대여하시면 이용이 가능하답니다 :) </span>
				<span class="imgSpan0 imgSpan03">아래 책들은 어떠신가요? </span>			
			</c:if>
			<c:if test="${type eq 1}">
				<c:if test="${rentListSize > 0}">
					<!-- 취향이 비어있지 않은데 책 10권 미만 구독 -->
					<div id="chartDiv2">
					    <div id="piechart" style="width: 450px; height: 400px; display:inline-block;"></div>
						<div id="columnchart_values" style="width: 400px; height: 400px; display:inline-block;"></div>	
						<c:if test="${reviewListSize == 0}">
							<div id="noDataDiv">No Data</div>
						</c:if>
					</div>			
				</c:if>
				<c:if test="${rentListSize == 0}">
					<!-- 취향이 비어있지 않은데 책 0권 구독. 책을 읽으세요 -->
					<img style="position : relative;" src="/resources/imgs/bookChild.jpg" style="width:1080px; height:400px;">			
					<span class="imgSpan0 imgSpan11">책을 한 권도 빌리지 않으셨네요! </span>
					<span class="imgSpan0 imgSpan12">아래 책들은 어떠신가요? </span>
				</c:if>
			</c:if>
			<c:if test="${type eq 2}">
			<!-- 읽은책 10권 이상, 리뷰 3.0이상 존재 X -->
				<div id="chartDiv2">
				    <div id="piechart" style="width: 450px; height: 400px; display:inline-block;"></div>
					<div id="columnchart_values" style="width: 400px; height: 400px; display:inline-block;"></div>	
					<c:if test="${reviewListSize == 0}">
						<div id="noDataDiv">No Data</div>
					</c:if>
				</div>			
			</c:if>
			<c:if test="${type eq 3}">
			<!-- 읽은 책 10권 이상 리뷰3.0이상 존재 O -->
				<div id="chartDiv2">
				    <div id="piechart" style="width: 450px; height: 400px; display:inline-block;"></div>
					<div id="columnchart_values" style="width: 400px; height: 400px; display:inline-block;"></div>	
				</div>
			</c:if>
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

<!-- Trigger/Open The Modal -->
<button id="myBtn">Open Modal</button>

<!-- The Modal -->
<div id="myModal" class="modal">
<!-- Modal content -->
	<div class="modal-content" style="height : 315px;">
		<span class="close">&times;</span>
		<h3><img src="/resources/imgs/fDot.png" style='width:23px; height:23px;'>&nbsp;&nbsp;취향분석에 오신걸 환영합니다!&nbsp;&nbsp;<img src="/resources/imgs/fDot.png" style='width:23px; height:23px;'></h3><br><br>                                                      
		<p>회원 가입시 골라주신 카테고리와 대여한 책, 남기신 리뷰를 바탕으로 회원님께 맞는 책을 추천해드리는 코너입니다 :)</p>
		<p>정확한 분석을 위해선 10권 이상의 대여 기록이 필요하니 이점 참고해주세요 !</p>
		<p>또한, 워드 클라우드의 경우엔 3권 이상 대여시 이용이 가능하답니다 ^ 3^</p>
	</div>
</div>

<!-- Trigger/Open The Modal -->
<button id="myBtn2">Open Modal</button>

<!-- The Modal -->
<div id="myModal2" class="modal2">
<!-- Modal content -->
	<div class="modal-content" style="height : 185px; width:450px;">
		<span class="close2">&times;</span>
		<p>사용자의 데이터가 부족해 키워드 분석을 할 수 없습니다. </p>
		<p>책을 대여해 데이터를 쌓아주세요 ! </p>
	</div>
</div>
</body>
<style>
      /* The Modal (background) */
      	.modal-content > span {
	      	text-align : right;
      	}
      	.modal-content > h3, .modal-content > p {
	      	text-align : center;
      	}
      	.modal-content > p {
      		font-size : 14px;
      		font-weight : bold;
      	}      
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        /*------------------------ */
      /* The Modal (background) */
      	.modal-content2 > span2 {
	      	text-align : right;
      	}
      	.modal-content2 > h3, .modal-content2 > p {
	      	text-align : center;
      	}
      	.modal-content2 > p {
      		font-size : 14px;
      		font-weight : bold;
      	}      
        .modal2 {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content2 {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close2 {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close2:hover,
        .close2:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }        
</style>
<script>
	// Get the modal
	var modal = document.getElementById('myModal');
	
	// Get the button that opens the modal
	var btn = document.getElementById("myBtn");
	
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];                                          
	
	// When the user clicks on the button, open the modal 
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	    modal.style.display = "none";
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
	$(document).ready(function() {
		$("#myBtn").trigger('click');
		$("#myBtn").hide();
	});
	////////////////////////
	// Get the modal
	var modal2 = document.getElementById('myModal2');
	
	// Get the button that opens the modal
	var btn2 = document.getElementById("myBtn2");
	
	// Get the <span> element that closes the modal
	var span2 = document.getElementsByClassName("close2")[0];                                          
	
	// When the user clicks on the button, open the modal 
	btn2.onclick = function() {
	    modal2.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	span2.onclick = function() {
	    modal2.style.display = "none";
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal2.style.display = "none";
	    }
	}
	$(document).ready(function() {
		$("#myBtn2").hide();
	});	
	
</script>


</html>