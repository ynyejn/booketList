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
            /* height: 900px; */
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
	function bookListLoad(bookName, obj, numb) {
		$.ajax({
			url : "/rent/bookListLoad.do",
			type : "post",
			data : {bookName : bookName},
			success : function(data){
				var html = "";
				html =	"<table id='bookList"+numb+"' border='3'><tr><th>No.</th><th>책 이름</th><th>도서 상태</th><th>출판일</th></tr>";
				for(var i=0;i<data.length;i++) {
					html += "<tr><td>"+(i+1)+"</td>";
					html += "<td>"+data[i].bookName+"</td>";
					if(data[i].bookStatus == 0) {
						html += "<td>대여 가능</td>";						
					}else if(data[i].bookStatus == 1) {
						html += "<td>대여 신청중</td>";
					}else if(data[i].bookStatus == 2) {
						html += "<td>대여중</td>";
					}else if(data[i].bookStatus == 3) {
						html += "<td>반납신청중</td>";
					}else if(data[i].bookStatus == 4) {
						html += "<td>연체중</td>";
					}else if(data[i].bookStatus == 5) {
						html += "<td>반납완료</td>";
					}else if(data[i].bookStatus == 6) {
						html += "<td>분실중</td>";
					}
					html += "<td>"+data[i].bookPubDate+"</td></tr>";
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
	}
	function bookListRemove(obj, numb) {
		$(obj).prev().show();
		$(obj).parents().find("div#listDiv"+numb).children().eq(1).remove();
		$(obj).hide();
	};		
	
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
	
</script>

<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
		<div id="searchDiv">
		<form action = "/rent/searchBookDetail.do" method="get">
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
				<option value="book_name">책이름</option>
				<option value="book_content">내용</option>
				<option value="book_writer">작가</option>
			</select>
			<input type="hidden" name="reqPage" value="1">
			<input type="hidden" name="sort" value="book_name">
			<input type="text" name="inputText" value="${inputText }"><input type="submit" value="검색">
		</form>
		</div>
			<div id="searchDiv2">
			${categorySelect }
			${bookAttr }
			${inputText }
				<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=book_name">이름순</a>
				<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=avg_score">평점순</a>
				<a href="/rent/searchBookDetail.do?reqPage=1&categorySelect=${categorySelect }&bookAttr=${bookAttr }&inputText=${inputText }&sort=book_pub_date">최신작순</a>
			</div>
			<div id="contentDiv">
				contentDiv
				<div id="selectDiv">
					<button type="button" id="allSelect">전체 선택/취소</button>
					<button type="button">선택한 책 장바구니에 담기</button>
				</div>
				<div id="MainContentDiv">
					<c:forEach items="${list }" var="n" varStatus="i">
						<div style='border:1px solid black;' id="listDiv${i.count}">	
							<table border='1' id="bookTable${i.count }">				
								<tr>
									<td rowspan="5">
										<c:if test="${n.cnt ne '0'}">
											<input type="checkbox" id="no${i.count }" name="chkbox">
										</c:if>
										<c:if test="${n.cnt eq '0'}">
											<input type="checkbox" id="no${i.count }" name="chkboxDisabled" disabled="disabled">
										</c:if>										
									</td>
									<td rowspan="5"><img src='${n.bookImg }'></td>
									<td> 
										${n.bookName}  
										<input type="hidden" name="${n.bookName }" value="${n.bookName }">
									</td>
								</tr>
								<tr>
									<td>
										<c:if test="${not empty n.bookWriter}">
											${n.bookWriter }
										</c:if>
										<c:if test="${empty n.bookWriter}">
											작가 없음
										</c:if>
									</td>
								</tr>
								<tr>
									<td>
										<c:if test="${not empty n.bookPublisher}">
											${n.bookPublisher}
										</c:if>
										<c:if test="${empty n.bookPublisher}">
											출판사 없음
										</c:if>
									
									</td>
								</tr>
								<tr>
									<td>${n.bookPubDate }</td>
								</tr>
								<tr>
									<td id="bookListAddTd">
									<c:if test="${n.cnt ne '0'}">
										<span id="bookListAdd" onclick="bookListLoad('${n.bookName}', this, ${i.count})">(파랑)대여 가능 -펼치기-</span>
										<span id='bookListRemove' style='display:none;' onclick='bookListRemove(this, ${i.count})'>(파랑)대여 가능 -닫기-</span>
									</c:if>
									<c:if test="${n.cnt eq '0'}">
										<span id="bookListAdd" onclick="bookListLoad('${n.bookName}', this, ${i.count})">(파랑)대여 불가 -펼치기-</span>
										<span id='bookListRemove' style='display:none;' onclick='bookListRemove(this, ${i.count})'>(파랑)대여 불가 -닫기-</span>
									</c:if>
									</td>
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