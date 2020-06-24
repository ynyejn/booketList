<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 도서 검색</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<input type="text" id="title">
	<button>검색</button>
	
	<table>
		<tr>
			<th>이미지</th>
			<th>도서이름</th>
			<th>출판일</th>
			<th>작가</th>
			<th>출판사</th>
			<th>카테 고리</th>
			<th>도서내용</th>
			<th>선택</th>
		</tr>
	</table>
	
	<script type="text/javascript">
	//function setParentText(){
       // opener.document.getElementById("bookName").innerHTML = document.getElementsByClassName(".bookName").innerHTML;
       // console.log(document.getElementsByClassName(".bookName").innerHTML+"dd");
	//}
	var apply = "";
		$(function() {
			$("button").click(function() {
				var title = $("#title").val();
				$.ajax({
					url : "/aladdin.do",
					data : { title:title },
					success : function(data){
						html="";
						for(var i=0;i<data.length;i++){
							html+="<tr class='apply'><td><input type='hidden' class='bookImg'value='"+data[i].bookImg+"'><img src='"+data[i].bookImg+"'></td>";
							html+="<td class='bookName'>"+data[i].bookName+"</td>";
							html+="<td class='bookPubDate'>"+data[i].bookPubDate+"</td>";
							html+="<td class='bookWriter'>"+data[i].bookWriter+"</td>";
							html+="<td class='bookPublisher'>"+data[i].bookPublisher+"</td>";
							html+="<td class='bookCategory'>"+data[i].bookCategory+"</td>";
							html+="<td class='bookContent'><c:if test='${data[i].bookContent==null }'>내용 없음</c:if>"+data[i].bookContent+"</td>";
							html+="<td><c:if test='${data[i].selectCheck == 0 }'><a href='javascript:void(0)' class ='reqBook' onclick='window.close()'>신청하기</a></c:if><c:if test='${data[i].selectCheck == 1 }'>이미 있는 책입니다.</c:if></td></tr>";
						}
						
						$("table>tbody").append(html);
						$(".reqBook").click(function () {
							console.log($(this).parent().parent().find(".bookName"));
							var bookName = $(this).parent().parent().find(".bookName").html();
							var bookPubDate = $(this).parent().parent().find(".bookPubDate").html();
							var bookWriter = $(this).parent().parent().find(".bookWriter").html();
							var bookPublisher = $(this).parent().parent().find(".bookPublisher").html();
							var bookCategory = $(this).parent().parent().find(".bookCategory").html();
							var bookContent = $(this).parent().parent().find(".bookContent").html();
							var bookImg = $(this).parent().parent().find(".bookImg").val();
							var array = bookPubDate.split(",");
							var aa = array[0].split("월 ");
							
							var apply = array[1]+"-"+aa[0]+"-"+aa[1]; 
							
							alert(apply);
							
							
							
							opener.document.getElementById("bookImg1").src = bookImg;
							opener.document.getElementById("bookPubDates").value = apply;
							opener.document.getElementById("bookWriter").value = bookWriter;
							opener.document.getElementById("bookPublisher").value = bookPublisher;
							opener.document.getElementById("bookCategory").value = bookCategory;
							opener.document.getElementById("bookContent").value = bookContent;
							opener.document.getElementById("bookName").value = bookName;
							opener.document.getElementById("bookImg2").value = bookImg;
						})
					},
					error : function(){
						console.log("ajax통신 실패")
					}
				});
			})
		})
	</script>
</body>
</html>