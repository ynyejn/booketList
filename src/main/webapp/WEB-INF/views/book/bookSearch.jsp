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
<style>
     .cTop {
        margin-top: 120px;
        width: 100%;
        height: 160px;
        background-image: url(/resources/imgs/title.jpg);
        position: relative;
                	background-size : cover;
    }

    .black {
        background-color: #1B3A50;
        width: 100%;
        height: 100%;
        opacity: 35%;
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
        padding-bottom: 50px;
/*         border: 1px solid lightgray; */
    }
    #searchDiv {
    	width : 1100px;
    	padding : 30px 20px;
    	margin : 0 auto;
    	border-top: 2px solid #585858;
	    border-bottom: 2px solid #585858;
    }
    #searchDiv1-2 {
    	width : 1060px;
    	background-color : white;
    	padding : 50px 80px;
    	margin : 0 auto;
    	border: 1px solid #e5e5e5;
    }
    #inputText {
    	width : 800px;
    	height : 50px;
    	border: 1px solid #03166c;
	    outline: none;
    	box-sizing: border-box;
    	margin : 0;
    }
    #select1, #select2 {
		width: 150px;		
       	height : 50px;
    	border: 1px solid #03166c;
	    outline: none;
    	box-sizing: border-box;    
    }
    .bookListDiv {
	    background-color : white;
	    border : 1px solid #e5e5e5;
	    width : 1060px;
        overflow: hidden;
        margin-bottom : 10px;
       	padding : 20px 10px;
        
    }
    #contentDiv {
	    width : 1100px;
		padding : 20px;
		margin: 0 auto;    
    	border-top: 1px solid #e5e5e5;
   		border-bottom: 1px solid #e5e5e5;	
    }
    .bookTable1 {
    	width:1000px;
     	margin : 0 auto;
     	margin-top : 0;
    }
    .bookTable2 {
    	border : 3;
    }
    .writerSpan, .pubDateSpan, .categorySpan, .publisherSpan {
    	font-size : 14px;
    	color : #495057;
    }
    #searchDiv2 {
    	width : 1060px;
    	margin : 0 auto;
    }    
    #selectDiv > button, #searchDiv2 > button {
    	border: none;
	    background-color: #666666;
	    color: white;
	    width: 110px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
    }
    #searchDiv2 > a {
    	float : right;
    	margin : 10px;
    }
    #searchDiv2 >a:hover {
    	font-weight : bold;
    	color : #0066b3;
    }
    #naviDiv > div {
    	display : inline-block;
    	width:33px;
    	height:33px;
    	border : 1px solid #e5e5e5;
    	line-height : 33px;
    	text-align : center;
    	border-radius : 3px;
    	margin : 3px;
    	background-color : white;
    }
    #naviDiv > .numberNavi2:hover, #naviDiv > .nextNavi:hover, #naviDiv > .prevNavi:hover {
    	background-color : rgb(2, 132, 230);
    	cursor : pointer;
    }
    #naviDiv > .numberNavi2:hover > a, #naviDiv > .nextNavi:hover > a, #naviDiv > .prevNavi:hover > a {
    	color : white;
    	display:inline-block;
    	width:100%;
    	height:100%;
    }
    #naviDiv {
    	text-align : center;
    }
    .numberNavi1 {
    	font-size : 16px;
    	font-weight : bold;
    }
    .numberNavi1 > span {
    	color : white;
    }
    .numberNavi2 {
    	font-size : 16px;
    }
    #reservationButton {
    	float : right;
    	border: none;
	    background-color: #666666;
	    color: white;
	    width: 60px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
    }
    #bookListAdd:hover, #bookListRemove:hover {
    	cursor : pointer;
    }
    #goToCartBtn, #cancelBtn {
    	border: none;
	    background-color: #666666;
	    color: white;
	    width: 70px;
	    height: 30px;
	    font-size: 14px;
	    border-radius: 2px;    
	    margin : 10px;
	    display : inline-block;
    }
    #allSelect:hover, #insertCart:hover, #allSelect2:hover, #insertCart2:hover {
	    background-color: rgb(0, 102, 179);
    }    
    

</style>
	<!-- 로딩 -->
	<style>
		.loader {
	    position: absolute;
	    left: 50%;
	    top: 50%;
	    z-index: 1;
	    width: 150px;
	    height: 150px;
	    margin: -75px 0 0 -75px;
	    border: 16px solid #f3f3f3;
	    border-radius: 50%;
	    border-top: 16px solid #3498db;
	    width: 120px;
	    height: 120px;
	    -webkit-animation: spin 2s linear infinite;
	    animation: spin 2s linear infinite;
	}
	
	
	@-webkit-keyframes spin {
	    0% { -webkit-transform: rotate(0deg); }
	    100% { -webkit-transform: rotate(360deg); }
	}
	
	@keyframes spin {
	    0% { transform: rotate(0deg); }
	    100% { transform: rotate(360deg); }
	}
	</style>
	<script>
		var _showPage = function() {
			  var loader = $("div.loader");
			  var container = $("div.loaderDiv"); 
			  loader.css("display","none");
			  container.css("display","block"); 
		};
	</script>
<script>
$(function(){
	if("${msg}"!=""){
		if("${msg}"==0){
			alert("대여신청이 완료되었습니다.");
		}else{
			alert("대여신청이 실패했습니다.");
		}
	}
});
	function bookListLoad(bookName, obj, numb) {
		$("div.loader").css("display","block");
		$.ajax({
			url : "/rent/bookListLoad.do",
			type : "post",
			data : {bookName : bookName},
			success : function(data){
				var html = "";
				html =	"<table class='bookTable2' id='bookList"+numb+"' style='width:900px; margin-left:80px; border: 1px solid #e5e5e5; margin-top:10px;'><tr style='height:40px; text-align:center;'><th style='width:5%; background-color:#f7f8f8;  font-size:14px; '>No.</th><th style='background-color:#f7f8f8; font-size:14px; text-align:center;'>책 이름</th><th style='background-color:#f7f8f8; width:10%; font-size:14px; text-align:center;'>도서 상태</th><th style='background-color:#f7f8f8; width:10%; font-size:14px; text-align:center;'>출판일</th></tr>";
				for(var i=0;i<data.length;i++) {
					html += "<tr style='height : 40px;  border: 1px dashed #e5e5e5; '><td style='font-size:14px; text-align:center;'>"+(i+1)+"</td>";
					html += "<td style='font-size:14px; text-align:center;'>"+data[i].bookName+"</td>";
					if(data[i].bookStatus == 0) {
						html += "<td style='font-size:13px; color:#0066b3; font-weight:bold; text-align:center;'>대여 가능</td>";						
					}else if(data[i].bookStatus == 1) {
						html += "<td style='font-size:13px; text-align:center;'>대여 신청중</td>";
					}else if(data[i].bookStatus == 2) {
						html += "<td style='font-size:13px; text-align:center;'>대여중</td>";
					}else if(data[i].bookStatus == 3) {
						html += "<td style='font-size:13px;  text-align:center;'>반납신청중</td>";
					}else if(data[i].bookStatus == 4) {
						html += "<td style='font-size:13px; color:brown; font-weight:bold;  text-align:center;'>연체중</td>";
					}else if(data[i].bookStatus == 5) {
						html += "<td style='font-size:13px; text-align:center;'>반납완료</td>";
					}else if(data[i].bookStatus == 6) {
						html += "<td style='font-size:13px; color:brown; font-weight:bold; text-align:center;'>분실중</td>";
					}
					if((data[i].bookPubDate).split(' ')[0].split('월')[0].length == 1) {						
	 					var month = "0"+(data[i].bookPubDate).split(' ')[0].split('월')[0]; 
					}else {
	 					var month = (data[i].bookPubDate).split(' ')[0].split('월')[0]; 
					}
					if((data[i].bookPubDate).split(' ')[1].split(',')[0].length == 1) {
						var day = "0"+(data[i].bookPubDate).split(' ')[1].split(',')[0]; 						
					}else {
						var day = (data[i].bookPubDate).split(' ')[1].split(',')[0]; 												
					}
 					var year = (data[i].bookPubDate).split(' ')[2]; 					
					var date = year +"-"+ month+"-"+ day
					
					html += "<td style='font-size:14px; text-align:center;'>"+date+"</td></tr>";
				}
				html += "</table>";
				$(obj).parents().find("div#listDiv"+numb).append(html);
				$(obj).next().show();
				$(obj).hide();
			},
			error : function() {
				console.log("아작스 실패");
			}
		});
		$("div.loader").css("display","none");
	}
	function bookListRemove(obj, numb) {
		$(obj).prev().show();
		$(obj).parents().find("div#listDiv"+numb).children().eq(1).remove();
		$(obj).hide();
	};		

	//셀렉트 선택
	$(function () {
		var chk = 0;
		$("#allSelect").click(function () {
			console.log($("input:checkbox[name=chkbox]"));
			console.log($("input:checkbox[name=chkbox]").length);
			if(chk==0) {			
				for(var i=0; i < $("input:checkbox[name=chkbox]").length; i++) {
					$("input:checkbox[name=chkbox]").eq(i).prop("checked", true);
					
				}
				chk = 1;
			}else {
				for(var i=0; i < $("input:checkbox[name=chkbox]").length; i++) {
					$("input:checkbox[name=chkbox]").eq(i).prop("checked", false);
				}
				chk = 0;
			}
		});
		$("#allSelect2").click(function () {
			console.log($("input:checkbox[name=chkbox]"));
			console.log($("input:checkbox[name=chkbox]").length);
			if(chk==0) {			
				for(var i=0; i < $("input:checkbox[name=chkbox]").length; i++) {
					$("input:checkbox[name=chkbox]").eq(i).prop("checked", true);
					
				}
				chk = 1;
			}else {
				for(var i=0; i < $("input:checkbox[name=chkbox]").length; i++) {
					$("input:checkbox[name=chkbox]").eq(i).prop("checked", false);
				}
				chk = 0;
			}
		});		
	});
	
	//카테고리 셀렉트 옵션 자동 선택
	$(function() {
		console.log($("select[name=categorySelect] option").length);
		for(var i=0; i<$("select[name=categorySelect] option").length; i++) {
			if($("select[name=categorySelect] option").eq(i).val() == "${categorySelect}") {
				$("select[name=categorySelect] option").eq(i).attr("selected", "selected");
			}
		}
		console.log($("select[name=bookAttr] option").length);
		for(var i=0; i<$("select[name=bookAttr] option").length; i++) {
			if($("select[name=bookAttr] option").eq(i).val() == "${bookAttr}") {
				$("select[name=bookAttr] option").eq(i).attr("selected", "selected");
			}
		}		
	})
	$(function () {
		//장바구니에 넣기1
		$("#insertCart").click(function () {
			$("div.loader").css("display","block");
			var chkArray = new Array();
			for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
				if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
					console.log($("input:checkbox[name=chkbox]").eq(i).val());	
					chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
				}
			}
			$.ajax({
				url : "/rent/insertCart.do",
				type : "get",
				traditional : true,
				data : {chkArray : chkArray},
				success : function(data) {
					if(data == -1) {
						$("#myBtn").trigger('click');
					}else if(data == 0){
						$("#myBtn2").trigger('click');
					}else {
						$("#cartCountSpan").html(data);
						$("#myBtn5").trigger('click');
					}
				}, error : function () {
					console.log("아작스 실패");
				}
			});
			$("div.loader").css("display","none");
		});
		//장바구니에 넣기2
		$("#insertCart2").click(function () {
			$("div.loader").css("display","block");
			var chkArray = new Array();
			for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
				if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
					console.log($("input:checkbox[name=chkbox]").eq(i).val());	
					chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
				}
			}
			$.ajax({
				url : "/rent/insertCart.do",
				type : "get",
				traditional : true,
				data : {chkArray : chkArray},
				success : function(data) {
					if(data == -1) {
						$("#myBtn").trigger('click');
					}else if(data == 0){
						$("#myBtn2").trigger('click');
					}else {
						$("#cartCountSpan").html(data);
						$("#myBtn5").trigger('click');
					}
				}, error : function () {
					console.log("아작스 실패");
				}
			});
			$("div.loader").css("display","none");
		});		

		//예약하기
		$("#reservationButton").click(function() {
			$("div.loader").css("display","block");
			var resVal = $("#reservationInput").val();
			console.log(resVal);
			$.ajax({
				url : "/reservation/insertReservation.do",
				type :"get",
				data : {resVal : resVal},
				success : function(data) {
					if(data == -1) {
						$("#myBtn4").trigger('click');
					}else {
						$("#myBtn3").trigger('click');
					}
				}, error : function(){
					console.log("아작스 실패");
				}
			});
			$("div.loader").css("display","none");
		});
	});
	function goToCartBtn() {
		location.href="/cart/goMyCart.do?reqPage=1";
	}
</script>

<body>
<div class="wrapper" style="background-color : #f3f5f7;">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="cTop">
			<div class="black"></div><span>도서 검색</span>
		</div>
		<div class="content">
			<div class="emptyDiv" style="height:35px;"></div>
			<div id="searchDiv">
				<div id="searchDiv1-2">
					<form action = "/rent/searchBookDetail.do" method="get">
						<select name="categorySelect" id="select1">
							<option value="">카테고리</option>
							<option value="가정/요리/뷰티">가정/요리/뷰티</option>
							<option value="건강/취미/레저">건강/취미/레저</option>
							<option value="경제경영">경제경영</option>
							<option value="과학">과학</option>
							<option value="달력/기타">달력/기타</option>
							<option value="만화">만화</option>
							<option value="사회과학">사회과학</option>
							<option value="소설/시/희곡">소설/시/희곡</option>
							<option value="수험서/자격증">수험서/자격증</option>
							<option value="어린이">어린이</option>
							<option value="에세이">에세이</option>
							<option value="여행">여행</option>
							<option value="역사">역사</option>
							<option value="예술/대중문화">예술/대중문화</option>
							<option value="외국어">외국어</option>
							<option value="유아">유아</option>
							<option value="인문학">인문학</option>
							<option value="자기계발">자기계발</option>
							<option value="잡지">잡지</option>
							<option value="전집/중고전집">전집/중고전집</option>
							<option value="종교/역학">종교/역학</option>
							<option value="좋은부모">좋은부모</option>
							<option value="청소년">청소년</option>
							<option value="초등학교참고서">초등학교참고서</option>
							<option value="중학교참고서">중학교참고서</option>
							<option value="고등학교참고서">고등학교참고서</option>
							<option value="대학교재/전문서적">대학교재/전문서적</option>
							<option value="컴퓨터/모바일">컴퓨터/모바일</option>
						</select>
						<select name="bookAttr"  id="select1">
							<option value="book_name">책이름</option>
							<option value="book_content">내용</option>
							<option value="book_writer">작가</option>
						</select>
						<input type="hidden" name="reqPage" value="1">
						<input type="hidden" name="sort" value="book_name">
						<div style="height:50px; margin-top:10px;">
							<input type="text" name="inputText" id="inputText" style='padding : 0px;' value="${inputText }">
							<input type="image" value="submit" src="/resources/imgs/searchImg.PNG" style='width:49px; height:50px; vertical-align:top; margin-left:-5px;'>
						</div>
					</form>
				</div>
			</div>
			<div class="emptyDiv" style="height:35px;"></div>
			<div id="searchDiv2">
				<button type="button" id="allSelect">전체 선택/취소</button>
				<c:if test="${not empty sessionScope.member }">
					<!-- 로그인이 되어있을 때 -->
					<button type="button" id="insertCart">장바구니에 담기</button>
				</c:if>
				<c:if test="${empty bookAttr}">
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=book_name&inputText=${inputText }&sort=book_name">이름순</a>
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=book_name&inputText=${inputText }&sort=avg_score">평점순</a>
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=book_name&inputText=${inputText }&sort=book_pub_date">최신작순</a>
				</c:if>
				<c:if test="${not empty bookAttr}">	
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=book_name">이름순</a>
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=avg_score">평점순</a>
					<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=book_pub_date">최신작순</a>
				</c:if>
			</div>
			<div id="contentDiv">
				<div id="MainContentDiv">
					<c:choose>
						<c:when test="${not empty list}">
							<c:forEach items="${list }" var="n" varStatus="i">
								<div class="bookListDiv" id="listDiv${i.count}">	
									<table id="bookTable${i.count }" class="bookTable1">				
										<tr>
											<td rowspan="5"  style="vertical-align : 0; width:40px;">
												<c:if test="${n.cnt ne '0'}">
													<input type="checkbox" id="no${i.count }" name="chkbox" value="${n.bookName }~구분~${n.bookWriter }~구분~${n.bookPublisher}~구분~${n.bookImg}">
												</c:if>
												<c:if test="${n.cnt eq '0'}">
													<input type="checkbox" id="no${i.count }" name="chkboxDisabled" disabled="disabled">
												</c:if>
												<span>&nbsp;&nbsp;${i.count }.</span>										
											</td>
											<td rowspan="5" style='width:130px; text-align:center; padding-top:0;'><img style='width : 95px; height: 135px;' src='${n.bookImg }'></td>
											<td rowspan="5" style='wdith:730px; padding-left : 10px;'> 
												<c:if test="${n.avgScore > 4 }">
													<span style='font-weight:bold;display:inline-block; white-space:nowrap; width:750px;overflow:hidden;text-overflow:ellipsis' class='nameSpan'>${n.bookName}</span>&nbsp;&nbsp;&nbsp;<div style='border-radius:5px; display:inline;font-weight:bold; font-size:12px; background-color:green; color:white;'>&nbsp;${n.avgScore }&nbsp;</div> 
												</c:if>
												<c:if test="${n.avgScore >= 3 && n.avgScore < 4 }">
													<span style='font-weight:bold;display:inline-block; white-space:nowrap; width:750px;overflow:hidden;text-overflow:ellipsis' class='nameSpan'>${n.bookName}</span>&nbsp;&nbsp;&nbsp;<div style='border-radius:5px; display:inline;font-weight:bold; font-size:12px; background-color:orange; color:white;'>&nbsp;${n.avgScore }&nbsp;</div> 
												</c:if>
												<c:if test="${n.avgScore < 3 }">
	 												<span style='font-weight:bold;display:inline-block;  white-space:nowrap; width:750px;overflow:hidden;text-overflow:ellipsis' class='nameSpan'>${n.bookName}</span>&nbsp;&nbsp;&nbsp;<div style='border-radius:5px; display:inline;font-weight:bold; font-size:12px; background-color:brown; color:white;'>&nbsp;${n.avgScore }&nbsp;</div>
												</c:if>
												<br>
												<c:if test="${not empty n.bookWriter}">
													<span class='writerSpan'>${n.bookWriter }</span>
												</c:if>
												<c:if test="${empty n.bookWriter}">
													<span class='writerSpan'>작가 없음</span>
												</c:if>
												<br>
													<span  class='categorySpan'>${n.bookCategory }</span>
													<c:if test="${n.cnt eq '0'}">
														<button type="button" style='background-color:rgb(0, 102, 179);' id="reservationButton">예약하기</button>
														<input type="hidden" id="reservationInput" value="${n.bookName }~구분~${n.bookWriter }~구분~${n.bookPublisher}~구분~${n.bookCategory}">
													</c:if>
												<br>
												<c:if test="${not empty n.bookPublisher}">
													<span class='publisherSpan'>${n.bookPublisher}</span>
												</c:if>
												<c:if test="${empty n.bookPublisher}">
													<span class='publisherSpan'>출판사 없음</span>
												</c:if>
												<br>													
													<span class='pubDateSpan'>${n.bookPubDate }</span>
												<br>
												<c:if test="${n.cnt ne '0'}">
													<span id="bookListAdd" onclick="bookListLoad('${n.bookName}', this, ${i.count})"><span style='color:#0066b3; font-weight:bold; font-size:15px;'>대여 가능</span><img style='margin-left : 5px; width:13px; height:13px;' src="/resources/imgs/openIcon.png"></span>
													<span id="bookListRemove" style='display:none;' onclick='bookListRemove(this, ${i.count})'><span style='color : #0066b3; font-weight:bold; font-size:15px;'>대여 가능</span><img style='margin-left : 5px; width:13px; height:13px;' src="/resources/imgs/closeIcon.png"></span>
												</c:if>
												<c:if test="${n.cnt eq '0'}">
													<span id="bookListAdd" onclick="bookListLoad('${n.bookName}', this, ${i.count})"><span style='color : #c80b0f; font-weight:bold; font-size:15px;'>대여 불가</span><img style='margin-left : 5px; width:13px; height:13px;' src="/resources/imgs/openIcon.png"></span>
													<span id='bookListRemove' style='display:none;' onclick='bookListRemove(this, ${i.count})'><span style='color : #c80b0f; font-weight:bold; font-size:15px;'>대여 불가</span><img style='margin-left : 5px; width:13px; height:13px;' src="/resources/imgs/closeIcon.png"></span>
												</c:if>
												<input type="hidden" name="${n.bookName }" value="${n.bookName }">
											</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div id="listDivEmpty" style='width:100%; height:200px;'>
								<span id="listDivEmptySpan">검색 결과가 없습니다. </span><br>
								<span id="listDivEmptySpan">혹시 다른 검색어로 검색해보시는건 어떠세요? </span>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div id="searchDiv2">
				<button type="button" id="allSelect2">전체 선택/취소</button>
				<c:if test="${not empty sessionScope.member }">
					<!-- 로그인이 되어있을 때 -->
					<button type="button" id="insertCart2">장바구니에 담기</button>
				</c:if>
			</div>
			<div id="naviDiv">
				${pageNavi}
			</div>
		</div>
		<!-- 로딩로딩 -->
		<!-- 로딩 페이지 -->
	<div class="loader" style='display:none;'></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</div>
<button id="myBtn" style='display:none;'>Open Modal</button>
<div id="myModal" class="modal">
	<div class="modal-content" style="height : 120px; width : 280px;">
		<span class="close">&times;</span>                                         
		<p>책을 선택해야만 합니다. </p>
	</div>
</div>
<button id="myBtn2" style='display:none;'>Open Modal</button>
<div id="myModal2" class="modal">
	<div class="modal-content" style="height : 120px; width : 280px;">
		<span class="close">&times;</span>                                         
		<p>이미 장바구니에 있는 책입니다. </p>
	</div>
</div>
<button id="myBtn3" style='display:none;'>Open Modal</button>
<div id="myModal3" class="modal">
	<div class="modal-content" style="height : 120px; width : 280px;">
		<span class="close">&times;</span>                                         
		<p>예약하였습니다 :) </p>
	</div>
</div>
<button id="myBtn4" style='display:none;'>Open Modal</button>
<div id="myModal4" class="modal">
	<div class="modal-content" style="height : 120px; width : 280px;">
		<span class="close">&times;</span>                                         
		<p>이미 예약된 책입니다 :) </p>
	</div>
</div>
<button id="myBtn5" style='display:none;'>Open Modal</button>
<div id="myModal5" class="modal">
	<div class="modal-content" style="height : 195px; width : 400px;">
		<br>
		<p>선택하신 <span id="cartCountSpan"></span>권이 장바구니에 들어갔습니다</p>
		<p>장바구니로 이동하시겠습니까</p>
		<div style="width:100%; text-align : center;">
			<button style="display:inline-block;" type="button" id="goToCartBtn" onclick="goToCartBtn();">이동</button>
			<button style="display:inline-block;"  type="button" id="cancelBtn">취소</button>		
		</div>
	</div>
</div>
</body>
<style>
	#listDivEmpty {
		text-align : center;
		padding-top : 80px;
	}
	#listDivEmptySpan {
		font-size : 18px;
		font-weight : bold;
	}
</style>
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
        .modal-content5 {
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
      
</style>
<script>
	var modal = document.getElementById('myModal');
	var btn = document.getElementById("myBtn");
	var span = document.getElementsByClassName("close")[0];                                          
	var modal2 = document.getElementById('myModal2');
	var btn2 = document.getElementById("myBtn2");
	var span2 = document.getElementsByClassName("close")[1];                                          
	var modal3 = document.getElementById('myModal3');
	var btn3 = document.getElementById("myBtn3");
	var span3 = document.getElementsByClassName("close")[2];                                          
	var modal4 = document.getElementById('myModal4');
	var btn4 = document.getElementById("myBtn4");
	var span4 = document.getElementsByClassName("close")[3];
	var modal5 = document.getElementById('myModal5');
	var btn5 = document.getElementById("myBtn5");
	var closeBtn = document.getElementById("cancelBtn");
	var span5 = document.getElementsByClassName("close")[4];
	
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	span.onclick = function() {
	    modal.style.display = "none";
	}
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
	btn2.onclick = function() {
	    modal2.style.display = "block";
	}
	span2.onclick = function() {
	    modal2.style.display = "none";
	}
	btn3.onclick = function() {
	    modal3.style.display = "block";
	}
	span3.onclick = function() {
	    modal3.style.display = "none";
	}
	btn4.onclick = function() {
	    modal4.style.display = "block";
	}
	span4.onclick = function() {
	    modal4.style.display = "none";
	}
	btn5.onclick = function() {
	    modal5.style.display = "block";
	}
	btn5.onclick = function() {
	    modal5.style.display = "block";
	}
	closeBtn.onclick = function() {
	    modal5.style.display = "none";
	}	
	span5.onclick = function() {
	    modal5.style.display = "none";
	}
	$(document).ready(function() {
		$("#myBtn").hide();
		$("#myBtn2").hide();
		$("#myBtn3").hide();
		$("#myBtn4").hide();
		$("#myBtn5").hide();
	});
</script>
</html>