<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List openChatting방</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style type="text/css">
	.a{
		margin: 0 auto;
		padding-left: 10px;
		
		background-color: antiquewhite;
		border: 1px solid antiquewhite;
		width: 35%;
		text-align: left;
		display: block;
        float: right;
        border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	
	.b{
		margin: 0 auto;
		padding-left: 10px;
		
		background-color: cornflowerblue;
		border: 1px solid antiquewhite;
		width: 35%;
		text-align: left;
		display: block;
        float: left;
        border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	.time{
		font-size : 0.7em;
		text-align: right;
	}

	#msgArea{
	width: 100%;
	height: 360px;
	overflow:auto;
	}
	a{
		text-decoration :none;
	}
	#chatImg{
	color: white;
	line-height: 150px;
	float: left;
	display: block;
	border: 1px solid white;
	text-align: center;
	width: 100%;
	height: 150px;
	font-size : 2.5em;
	background-image: url(/resources/imgs/bookChat.jpg);
	margin: 0 auot;
	background-size: 100%;
	}
	html{
	margin: 0 auot;
	padding: 0;
	}
	 .fileImg{
        width: 40px;
        height: 50px;
        cursor:pointer;
        
    }
    #sendBtn{
    border: none;
        background-color: #666666;
        color: white;
        width: 50px;
        height: 35px;
        font-size: 14px;
        border-radius: 2px;
    }
    #sendBtntd{
    	padding-bottom: 5px;
    }
    body {
    overflow-y: hidden; overflow-x: hidden;
    }
	.nick{
		font-weight:bold;
	}
</style>
</head>

<body onresize="parent.resizeTo(500,660)" onload="parent.resizeTo(500,660)">
<div id="chatImg">${c.chatTitle }오픈채팅방</div>

<div>
<div id="msgArea">
</div>
	<br>
	
	<table class="msgChat">
        <tr>
            <td>
            <form  id="ajaxFrom" method="post">

            <input type="file" name="file" class="fileImg"id="file" style="display:none;" onchange="document.getElementById('chatMsg').value=this.value;">
                <img class="fileImg"src="/resources/imgs/cameraIcon.png"onclick="document.getElementById('file').click();" />
<input type="hidden" id="chatPeople"value="${c.chatPeople }">
<input type="hidden" id="chatTitle"value="${c.chatTitle }">
<input type="hidden" id="memberNickname"value="${c.memberNickname }">


</form>
            </td>
            <td>
            <textarea id="chatMsg" name="chatMsg" rows="2" cols="50"  style = "resize : none;"></textarea>
            
            </td>
            <td id="sendBtntd">
                <button id="sendBtn" type="button" >전송</button>
            </td>
        </tr>
    </table>
</div>
	
<script>
	var ws;
	var memberId = '${sessionScope.member.memberId}';
	var memberNickname = '${sessionScope.member.memberNickname}';
	var	title = $("#chatTitle").val();
	var	chatPeople = $("#chatPeople").val();
	

	function connect() {
		ws = new WebSocket("ws://172.30.109.200/openChatting.do?memberNickname="+memberNickname+" "+title);

		
		ws.onopen = function () {
			console.log("웹소켓 연결 생성");
			console.log(title);
			var msg = {
					type : "register",
					memberNickname : memberNickname,
					title : title,
					chatPeople : chatPeople
			}
			
			ws.send(JSON.stringify(msg));//스트링으로 풀어서 보내기 type : "register",memberId : 'tjehdrjs1230';
		}
		
		ws.onmessage = function (e) {
			var msg = e.data;
			var chat =$("#msgArea").html()+"<div style='margin: 0 auto;width:100%; overflow:hidden;'><p class='b' id='chatMsgg'>"+msg+"</p></div><br>";
			$("#msgArea").html(chat);
			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
		
			$("a[name=${sessionScope.member.memberId}]").hide();
		}
		
		ws.onclose = function () {
		
			
			console.log("연결종료");
		}
		
		
	}
	$(function() {
		connect();
		
		 
				$("a[name=${sessionScope.member.memberId}]").hide();
			
				$('input[type=file]').change(function () {
			         var filePath=$('#file').val(); 
					console.log(filePath);
			         $("#chatMsg").val(filePath);
			         
			     });
		
		$('#msgArea').scrollTop($('#msgArea').prop('scrollHeight'));
	
		$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 1000);
		let today = new Date();
	    let hours = today.getHours()<10?"0"+today.getHours():today.getHours(); // 시
	    let minutes = today.getMinutes()<10?"0"+today.getMinutes():today.getMinutes();  // 분
		var	title = $("#chatTitle").val();
		$("#chatMsg").keydown(function (key) {
			 if(key.keyCode == 13){
		            searchBook();
		        }
		})
		 searchBook = function () {
			$(".memberId").hide();
	        var form = $("#ajaxFrom")[0];
	        var formData = new FormData(form);
	        var fileName = "";
	        formData.append("file", $("#file")[0].files[0]);
			if($("#file")[0].files[0]!=null){
				
	        $.ajax({
	              url : "/chat/ajaxFormReceive.do?title="+title
	            , type : "POST"
	            , processData : false
	            , contentType : false
	            , data : formData
	            , success:function(data) {
	            	console.log(data);
	               fileName = data;
	               console.log(fileName);
	   			var chat = "<input type='hidden' id='memberId' value='${sessionScope.member.memberNickname}'><input type='hidden' id='fileName' value='"+fileName+"'><span class='nick'>"+memberNickname+"</span><br><img id='img-view' width='150' src='"+fileName+"'><br><a href='javascript:fileDownload();'>다운로드</a><a  name='"+memberId+"'href='/complain/complain.do?memberIds=${sessionScope.member.memberId }&fileName="+fileName+"' onclick='window.open(this.href,`_blank`, ` location=no,width=500,height=600,toolbars=no,scrollbars=no`); return false;'>신고하기</a><span class='time'>"+hours+":"+minutes+"</span>";
	   			var msg = $("#msgArea").html()+"<div style='margin: 0 auto;width:100%; overflow:hidden;'><p class='a' id='chatMsgg'>"+chat+"</p></div><br>";
	   			$("#file").val("");
	   			$("#msgArea").html(msg);
	   			$("#chatMsg").val("");
	   			var sendMsg = {
	   					type : "chat",
	   					msg : chat,
	   					title : title,
	   					memberNickname : memberNickname
	   			};
	   			var socketMsg = JSON.stringify(sendMsg);
	   			ws.send(socketMsg);
	   			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
	   			$("a[name=${sessionScope.member.memberId}]").hide();
	            }
	              
	        });
			}else{
				
				var chat = "<input type='hidden' id='memberId' value='${sessionScope.member.memberNickname}'><span class='nick'>"+memberNickname+"</span><br>"+$("#chatMsg").val()+"<br><a name='"+memberId+"' href='/complain/complain.do?memberIds=${sessionScope.member.memberId }&complainContent="+$("#chatMsg").val()+"'  onclick='window.open(this.href, `_blank`, ` location=no,width=500,height=600,toolbars=no,scrollbars=no`); return false;'>신고하기</a><span class='time'>"+hours+":"+minutes+"</span><br>";
	   			var msg = $("#msgArea").html()+"<div style='margin: 0 auto;width:100%; overflow:hidden;'><p class='a' id='chatMsgg'>"+chat+"</p></div><br>";
	   			$("#msgArea").html(msg);
	   			$("#chatMsg").val("");
	   			var sendMsg = {
	   					type : "chat",
	   					msg : chat,
	   					title : title,
	   					memberNickname : memberNickname
	   			};
	   			var socketMsg = JSON.stringify(sendMsg);
	   			ws.send(socketMsg);
	   			$('#msgArea').stop().animate({ scrollTop: $('#msgArea')[0].scrollHeight }, 300);
	   			$("a[name=${sessionScope.member.memberId}]").hide();
			}
	        
		}
		$("#sendBtn").click(function () {
			searchBook();
	        
		});
		
	});
	function fileDownload() {
		var filepath=document.getElementById("fileName").value;
		console.log(filepath);
		var newFilepath = encodeURIComponent(filepath);
		location.href = "/chat/fileDownload.do?filepath=" + newFilepath;
	}
	</script>
</body>
</html>