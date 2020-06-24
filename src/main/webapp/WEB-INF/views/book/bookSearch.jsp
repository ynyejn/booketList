<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List</title>
</head>
<style>
        .content {
            width: 1200px;
            overflow: hidden;
            margin: 120px auto 0 auto;
            height: 900px;
            background-color: aliceblue;
        }

</style>
<script>
	function textLengthOverCut(txt, len, lastTxt) {
	    if (len == "" || len == null) { // 기본값
	        len = 20;
	    }
	    if (lastTxt == "" || lastTxt == null) { // 기본값
	        lastTxt = "...";
	    }
	    if (txt.length > len) {
	        txt = txt.substr(0, len) + lastTxt;
	    }
	    return txt;
	};
	$(function() {
		

	});
	function bookListLoad(bookName, obj) {
		console.log(bookName);
		console.log($(obj).parents().find("div#listDiv").eq(4));
		$.ajax({
			url : "/rent/bookListLoad.do",
			type : "post",
			data : {bookName : bookName},
			success : function(data){
				console.log(data);
				html =	"<table border='3'><tr><th>No.</th><th>책 이름</th><th>도서 상태</th><th>반납 예정일</th></tr>";
				for(var i=0;i<data.length;i++) {
					html += "<tr><td>"+i+1+"</td></tr>";
					html += "<tr><td>"+data[i].bookName+"</td></tr>";
					html += "<tr><td>"+data[i].bookStatus+"</td></tr>";
					html += "<tr><td>"+data[i].bookPubDate+"</td></tr>";
				}
				html += "</table>";
				console.log(html);
				$(obj).parents().find("div#listDiv").append(html);
			},
			error : function() {
				console.log("아작스 실패");
			}
		});
	}

</script>

<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<form action = "/rent/searchBook2" method="get">
		<div id="searchDiv">
			<select name="categorySelect">
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
			<select name="bookAttr">
				<option value="책이름">책이름</option>
				<option value="내용">내용</option>
				<option value="작가">작가</option>
			</select>
			<input type="text" name="inputText"><button>검색</button>
		</form>
		</div>
			<div id="searchDiv2">
				<a href="#">이름순</a>
				<a href="#">평점순</a>
				<a href="#">최신순</a>
			</div>
			<div id="contentDiv">
				contentDiv
				<div id="selectDiv">
					<button type="button">전체 선택</button>
					<button type="button">선택한 책 장바구니에 담기</button>
				</div>
				<div id="MainContentDiv">
					<c:forEach items="${list }" var="n">
						<div style='border:1px solid black;' id="listDiv${n.bookName }">	
							<table border='1'>				
								<tr>
									<td rowspan="5"><input type="checkbox"></td>
									<td rowspan="5"><img src='${n.bookImg }'></td>
									<td> 
										${n.bookName}
										<input type="hidden" name="${n.bookName }" value="${n.bookName }">
									</td>
								</tr>
								<tr>
									<td>${n.bookWriter }</td>
								</tr>
								<tr>
									<td>${n.bookPublisher }</td>
								</tr>
								<tr>
									<td>${n.bookPubDate }</td>
								</tr>
								<tr>
									<c:if test="${n.cnt ne '0'}">
										<td><span id="bookListAdd" onclick="bookListLoad('${n.bookName}', this)">(파랑)대여 가능</span></td>
									</c:if>
									<c:if test="${n.cnt eq '0'}">
										<td>(빨강)대여 불가</td>
									</c:if>
								</tr>
						</table>
					</div>
					</c:forEach>					
				</div>
			</div>
			<div id="searchDiv2">
					<button type="button">전체 선택</button>
					<button type="button">선택한 책 장바구니에 담기</button>
			</div>
		</div>
		<div id="naviDiv">
			${pageNavi}
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>