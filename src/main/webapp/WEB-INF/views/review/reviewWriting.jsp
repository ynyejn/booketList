<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 후기 작성</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style type="text/css">
	.sta{
		width: 20px;
		height: 20px;
	}
	.sta:hover{
		background-image:url("/resources/star/star2.jpg");
	}
</style>
</head>
<body>
	<h1>후기 작성</h1>
	닉네임 : <input type="text" name="memberNickName"><br>
	책 선택 : <select select name="type"><br>
		
	</select><br>
	<p>평점 : <img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<span id="sta"></span>
	</p><br>
	이미지 첨부 : <input type="file" name="reviewFilename" onchange="loadImg(this);"><br>
	이미지 보기  : <img id="img-view" width="350"><br>
	후기 내용 : <input type="text" name="reviewContent"><br>
<script type="text/javascript">
function loadImg(f) {
	if (f.files.length != 0 && f.files[0] != 0) {
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(e) { //파일업로드 기달리는거
			$("#img-view").attr("src", e.target.result);
		}
	} else {
		$("#img-view").attr("src", "");
	}
}
	$(function () {
		
		$(".sta").mouseover(function () {
			var index = $(".sta").index($(this));
			
			$(".sta").attr("src","/resources/star/star3.jpg");
			 for(var i=0;i<=index;i++){
                 
				 $(".sta").eq(i).attr("src","/resources/star/star2.jpg");
             } 
			
		$("p").click(function(){
            $("#sta").html((Number(index)+1)+"점");
        });
		
		})
	})
</script>
</body>
</html>