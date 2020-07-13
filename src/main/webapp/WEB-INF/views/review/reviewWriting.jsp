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
	  input{
    	text-overflow: ellipsis;
    }
    
	.reviewType{
		width: 100%;
		height: 30px;
		text-overflow: ellipsis;
	}
	h1{
		text-align: center;
	}
	p{
	text-align: center;
	}
	.reviewSta{
		text-align: center;
	}
	.reviewDiv{
	margin:0 auto;
		width: 80%;
	}
	.reviewSubmit{
	border: none;
	background-color: #007bff;
	color: white;
	width: 160px;
	height: 40px;
	font-size: 14px;
	border-radius: 2px;
	display: inline-block;
	margin: 10px;
	}
	#cancle {
	border: none;
	background-color: #666666;
	color: white;
	width: 160px;
	height: 40px;
	font-size: 14px;
	border-radius: 2px;
	display: inline-block;
	margin: 0;
}
.reviewContent{
	width: 96%;
	height: 50px;
	font-size: 1.2em;
}
</style>
</head>
<body  onresize="parent.resizeTo(500,660)" onload="parent.resizeTo(500,660)">
	<h1>후기 작성</h1>
	<div class="reviewDiv">
	<form action="/review/reviewInsert.do" method="post" enctype="multipart/form-data" target="reviewWriting.do">
	<table>
	<tr>
		<th>닉네임 </th>
		<th colspan="2"> <input type="hidden" name="memberNickName" value="${m.memberNickname }">${m.memberNickname }<br></th>
	</tr>
	<tr>
		<th>책 선택</th>
		<th colspan="2">
		<select id="type" name="type" class="reviewType"></select>
		</th>
	</tr>
	<tr>
		<th>평점</th>
		<td class="reviewSta"><img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	<img class="sta" src="/resources/star/star3.jpg">
	
	
	<input type="hidden" name="reviewScore" value="0"></td>
	<th><span id="reviewScore">0점</span></th>
	</tr>
	<tr>
		<th>이미지 첨부</th>
		<td colspan="2"><input type="file" name="file" id="file" onchange="loadImg(this);"></td>
	</tr>
	<tr>
		<th>이미지 보기</th>
		<td colspan="2"><img id="img-view" width="250" height="150px"></td>
	</tr>
	<tr>
		<th>후기 내용</th>
		<td colspan="2">
		<textarea id="reviewContent" name="reviewContent" rows="4" cols="32.5"  style = "resize : none;" required></textarea>
		</td>
	</tr>
	<tr>
		
		<td colspan="3"><input type="submit" value="작성하기" class="reviewSubmit"><input id="cancle"type="reset" onclick="window.close()"value="취소"></td>
	</tr>
	</table>
	</form>
	</div>
<script type="text/javascript">
function popupClose(form) {
           
    form.target = opener.name;
    
    form.submit();
  
}



function loadImg(f) {
	if (f.files.length != 0 && f.files[0] != 0) {
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(e) { //파일업로드 기달리는거
			$("#img-view").show();
			$("#img-view").attr("src", e.target.result);
		}
	} else {
		$("#img-view").hide();
		$("#img-view").attr("src", "");
	}
}
	$(function () {
		var memberId ='${sessionScope.member.memberId}';
		var memberNickName =$("input[name=memberNickName]").val();
		
		$.ajax({
			url : "/review/reviewSelectBook.do",
			type : "post",
			data : { memberId:memberId ,memberNickName:memberNickName},
			success : function(data){
				html="";
				html2="";
				for(var i=0;i<data.length;i++){
					html+="<option value='"+data[i].bookName+"'>"+data[i].bookName;+"</option>";
					html2+= "<input type='hidden' name='bookPublisher'value='"+data[i].bookPublisher+"'>";
					html2+= "<input type='hidden' name='bookWriter'value='"+data[i].bookWriter+"'>";
					html2+= "<input type='hidden' name='bookCategory'value='"+data[i].bookCategory+"'>";
				}
				$("#type").append(html);
				$("#book").html(html2);
			}
		});
		
		$(".sta").mouseover(function () {
			
			var index = $(".sta").index($(this));
			
			$(".sta").attr("src","/resources/star/star3.jpg");
			 for(var i=0;i<=index;i++){ 
				 $(".sta").eq(i).attr("src","/resources/star/star2.jpg");
             } 
			 
		$(".sta").click(function(){
			$("#reviewScore").html("");
            $("#reviewScore").html((Number(index)+1)+"점");
            $("input[name=reviewScore]").val((Number(index)+1));
        });
		
		
		})
	})
</script>
</body>
</html>