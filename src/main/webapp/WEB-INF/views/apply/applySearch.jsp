<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="font-size: 18px">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Booket List 도서 검색</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>

<link rel="stylesheet"
	href="/resources/adminBootstrap/css/bootstrap.css" />

<!-- Custom fonts for this template-->
<link
	href="/resources/adminBootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">


<!-- Custom styles for this template-->
<link href="/resources/adminBootstrap/css/sb-admin-2.min.css"
	rel="stylesheet" type="text/css">


<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="/resources/css/admin/adminBookList.css">
</head>
<body>
	<div class="input-group" style="text-align: center; width: 100%;">
		<input type="text" class="form-control" placeholder="도서제목검색"
			id="searchcontent">
		<div class="input-group-btn">
			<button class="btn btn-primary searchAl" type="submit">
				<span class="glyphicon glyphicon-search">검색</span>
			</button>
		</div>
	</div>
	<br>
	<br>
	<br>
	<table class="addBookList">
		<tr>

		</tr>
	</table>

	<script type="text/javascript">
		var reqPage = 1;
		var start = 1;
		var apply = "";
		var title = "";
		$(function() {
			$("#searchcontent").keydown(function(key) {
				if (key.keyCode == 13) {
					$(".searchAl").click();
				}
			});

			$(".searchAl").click(function() {
				title = $("#searchcontent").val();
				reqPage = 1;
				start = 1;
				$(".addBookList>tbody").children(".apply").remove();
				insertSearchBook(1);

			})
		})

		function insertSearchBook(reqPage) {

			if (reqPage != 1) {
				start += 10;
			}
			reqPage += 1;
			$(".newPlus").remove();
			$
					.ajax({
						url : "/aladdin.do",
						data : {
							title : title,
							start : start
						},
						success : function(data) {
							console.log(data);
							html = "";
							for (var i = 0; i < data.length; i++) {
								html += "<tr class='apply'><td style='width:130px;height:170px;'><input type='hidden' class='bookImg' value='"+data[i].bookImg+"'><img src='"+data[i].bookImg+"' style='width:120px;height:160px;'></td>";
								html += "<td style='line-height: 30px;width:561.6px;'><input type='hidden' class='bookName' value='"+data[i].bookName+"'><input type='hidden' class='bookContent' value='"+data[i].bookContent+"'><span  style='font-weight:bold;color:#0066b3'>"
										+ data[i].bookName + "</span>";
								html += "<ul style='padding-left:15px;'>";
								html += "<li style='font-size:12px;text-align:left;'>작가 : <input type='hidden' class='bookWriter' value='"+data[i].bookWriter+"'><span >"
										+ data[i].bookWriter + "</span></li>";
								html += "<li style='font-size:12px;text-align:left;'>출판사 : <input type='hidden' class='bookPublisher' value='"+data[i].bookPublisher+"'><span >"
										+ data[i].bookPublisher
										+ "</span></li>";
								html += "<li style='font-size:12px;text-align:left;'>장르 :  <input type='hidden' class='bookCategory' value='"+data[i].bookCategory+"'><span>"
										+ data[i].bookCategory + "</span></li>";
								html += "<li style='font-size:12px;text-align:left;'>출판일 : <input type='hidden' class='bookPubDate' value='"+data[i].bookPubDate+"'><input type='hidden' class='bookContent' value='"+data[i].bookContent+"'><span >"
										+ data[i].bookPubDate
										+ "</span></li></ul></td>";
								if (data[i].selectCheck == 0) {
									html += "<td><div class='insertBtn' style='width:60px;height:60px;background-color:#0066b3;line-height:60px;border-radius:50%;text-align:center'><a href='javascript:void(0)' class ='reqBook' onclick='window.close()' style='font-size:12px;'>신청하기</a></div></td></tr>";
								} else {
									html += "<td><div style='width:60px;height:60px;background-color:#df0000;line-height:60px;border-radius:50%;text-align:center'><span style='font-size:12px;color:white;font-weight:bold'>보유도서</span></td></tr>";
								}
							}
							$(".addBookList>tbody").append(html);

							$(".addBookList>tbody").append("<tr class='newPlus' colspan='8' onclick='insertSearchBook("+ reqPage+ ")'><th style='text-align:center;cursor:pointer;' colspan='3'><a class='btn btn-default'>더 보기</a></th></tr>");
							
							$(".reqBook").click(function() {
							
							bookName =$(this).parent().parent().parent().children().find(".bookName").val();
							bookWriter = $(this).parent().parent().parent().parent().children().find(".bookWriter").val();
							bookPublisher = $(this).parent().parent().parent().children().find(".bookPublisher").val();
							bookCategory=$(this).parent().parent().parent().children().find(".bookCategory").val();
							bookImg = $(this).parent().parent().parent().children().find(".bookImg").val();
							bookPubDate = $(this).parent().parent().parent().children().find(".bookPubDate").val();
							bookContent = $(this).parent().parent().parent().children().find(".bookContent").val();
							
												
							array = bookPubDate
							.split(",");
					aa = array[0].split("월 ");
					apply = array[1] + "-"
							+ aa[0] + "-" + aa[1];

												opener.document.getElementById("bookImg1").src = bookImg;
							                     opener.document.getElementById("bookPubDates").value = apply;
							                     opener.document.getElementById("bookWriter").value = bookWriter;
							                     opener.document.getElementById("bookPublisher").value = bookPublisher;
							                     opener.document.getElementById("bookCategory").value = bookCategory;
							                     opener.document.getElementById("bookContent").value = bookContent;
							                     opener.document.getElementById("bookName").value = bookName;
							                     opener.document.getElementById("bookImg").value = bookImg;

											});
						},
						error : function() {
							console.log("ajax통신 실패")
						}
					});
		}
	</script>
</body>
</html>