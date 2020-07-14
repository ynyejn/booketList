<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style type="text/css">
	* {
		font-family: 'Noto Sans KR', sans-serif;
		color: #333333;
	}
	body {

	}
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
		width: 95%;
		height: 35px;
 		text-overflow: ellipsis; 
 		border:1px solid lightgary;
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
		width: 100%;
		margin-top:80px;
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
#tableMain {
	width: 100%;
	height : 450px;
	margin:0 auto;
	border-collapse: separate;
	border-spacing: 0;
	table-layout:fixed;
}
#tableMain  tr {

	height: 40px;
}
.nameTag {
	width : 25%;
	font-size : 16px;
	font-weight: bold;
	text-align:center;
	background-color : #f3f4fa;
	color : #585858;
}
.spanMemberName {
	font-size : 14px;
/* 	font-weight: bold; */
}
.reviewSta {
	width : 65%;
}
#title {
	width:100%;
	position : absolute;
	left:0;
	top :0;
	height:70px;
	background-color:rgb(0, 102, 179);
}
#titleTag {
       color: #eeeeee;
       font-size: 24px;
       font-weight: bolder;
       position: absolute;
       padding-left: 45px;
       top: 15px;
       text-shadow: 1px 1px 2px black;
       border-bottom: 2px solid #dddddd;
       box-shadow: 0px 1px 0px black;
}
.reviewSubmit:hover, #cancle:hover {
	cursor:pointer;
}
.nameTag2 {
	padding-left :3px;
}

</style>
</head>
<body  onresize="parent.resizeTo(500,660)" onload="parent.resizeTo(500,660)">
	<div id="title">
		<span id="titleTag">후기 수정</span>
	</div>
	
	<div class="reviewDiv">
	<form action="/review/reviewUpdate.do" method="post" enctype="multipart/form-data" target="reviewUpdate.do">
	<table id="tableMain">
	<tr>
		<td class="nameTag"><input type="hidden" name="reviewNo" value="${r.reviewNo }">닉네임 </td>
		<td class="nameTag2" colspan="2"> <input type="hidden" name="memberNickName" value="${r.memberNickName }"><span class="spanMemberName">${r.memberNickName }</span></td>
	</tr>
	<tr>
		<td class="nameTag">책 제목</td>
		<td  class="nameTag2" colspan="2" >
			${r.bookName }
		</td>
	</tr>
	<tr>
		<td class="nameTag">평점</td>
		
			
		
		<td><input type="hidden" name="reviewScore" value="${r.reviewScore }"><span id="reviewScore">${r.reviewScore }점</span></td>
	</tr>
	<tr>
		<td class="nameTag">이미지 첨부</td>
		<td  class="nameTag2" colspan="2">
		<input type="hidden" name="status" value="stay">
                        <c:if test="${not empty r.reviewFilename }">
                         <input type="hidden" name="reviewFilename" value="${r.reviewFilename }">
                        <input type="hidden" name="filepath1" value="${r.reviewFilepath }">
                            <img id="img-views"src="${r.reviewFilepath }" width="20px" height="20px;">
                            
							<input type="file" name="file" id="file" style="display:none;" onchange="loadImg(this);">
                            <button type="button" id="fileDelBtn" class="delFile" >파일 삭제</button>
                            <span class="delFile1" >${r.reviewFilepath }</span>
                            
                        </c:if>
						<c:if test="${empty r.reviewFilename }">
						
							<input type="file" name="file" id="file" onchange="loadImg(this);">
						</c:if></td>
	</tr>
	<tr>
		<td class="nameTag">이미지 보기</td>
		<td  class="nameTag2" colspan="2"><img id="img-view" style="width:95%; height:140px;"src="${r.reviewFilepath }"></td>
	</tr>
	<tr>
		<td class="nameTag">후기 내용</td>
		<td  class="nameTag2" colspan="2">
		<textarea id="reviewContent" name="reviewContent" style="width:93%; height:100px; resize: none; border:1px solid lightgary;">${r.reviewContent }</textarea>
	</tr>
	<tr>
		<td colspan="3" style='width:100%; text-align:center;'>
			<input type="submit" value="작성하기" class="reviewSubmit" onclick="window.close()">
			<input id="cancle"type="reset" onclick="window.close()"value="취소">
		</td>
	</tr>
	</table>
	</form>
	</div>
	<script type="text/javascript">
	$(function () {
		$("#fileDelBtn").click(function() {
		    $(".delFile").hide();
		    $(".delFile1").html("");
		    $("#file").show();
		    $("input[name=status]").val('delete');
		    $("#img-view").attr("src", "");
		    $("#img-views").attr("src", "");
		    $("#img-view").hide();
		    $("#img-views").hide();
		});
		$("#file1").change(function() {
			$("#file1").hide();
			$(".delFile").show();
		    $("#fileDelBtn").show();
		    $(".delFile1").html(e.target.result);
		   
		})
	})
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
				    $("#img-views").show();
				$("#img-view").attr("src", e.target.result);
				$("#img-views").attr("src",e.target.result);
			}
		} else {
		
			$("#img-view").attr("src", "");
		}
	}
	</script>
</body>
</html>