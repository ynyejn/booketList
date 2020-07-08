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
        background-image: url(/resources/imgs/cart2.png);
        position: relative;
                	background-size : cover;
        
    }

    .black {
        background-color: #1B3A50;
        width: 100%;
        height: 100%;
        opacity: 65%;
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
        width: 1060px;
        overflow: hidden;
        margin: 0 auto;
        padding-bottom: 50px;
    }
    .contentDiv {
    	padding-top : 20px;
    	padding-bottom : 20px;
    	width: 1060px;
        margin: 0 auto;		    	
    }
    .listDiv {
 	    width : 1060px;
 	    heigth: 136px;
		padding : 20px 30px;
		margin: 0 auto;    
        border: 1px solid lightgray;
   		background-color : white;
   		margin-bottom : 10px;
    }
    .listTd1 {
    	width : 40px;
    	margin : 0 auto;
    }
    .listTd2{
    	width:130px;
    	text-align : center;
    }
    .listTd2 > img {
    	width:95px;
    	height : 135px;
    }
    .listTd3 {
    	width : 850px;
    	padding-left : 10px;
    }
    .listTd4 {
    	width : 60px;
    }
    .nameSpan {
    	font-weight: bold;
    }
    .writerSpan, .publisherSpan {
    	font-size: 14px;
    	color: #495057;
    }
    .buttonDiv1 > button, .buttonDiv2 >button, .buttonDiv1>div>button {
       	border: none;
	    background-color: #666666;
	    color: white;
	    width: 110px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
    }
    #deleteButton {
       	border: none;
	    background-color: #666666;
	    color: white;
	    width: 45px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
    }
    .buttonDiv3> button {
       	border: none;
	    background-color: #666666;
	    color: white;
	    width: 115px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
    }
    .bottomNavi {
    	width: 1060px;
    }
    .bottomNavi > div {
    	display : inline-block;
    }
    .buttonDiv2, .buttonDiv3, #naviDiv {
    	width: 350px;
    }
    .buttonDiv3 {
       	text-align : right;
    }
    #naviDiv {
    	margin : 0 auto;
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
    .emptyDiv {
    	height : 35px;
    }
    .buttonDiv1>div {
    	display : inline-block;
    	float:right;
    }

    


</style>

<script>
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
	//선택해서 삭제하기1
	$("#delSelect").click(function() {
		var chkArray = new Array();
		for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
			if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
				console.log($("input:checkbox[name=chkbox]").eq(i).val());	
				chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
			}
		}
		$.ajax({
			url : "/cart/delSelect.do",
			type : "get",
			traditional : true,
			data : {chkArray : chkArray},
			success : function(data) {
				console.log("return :"+data);
				console.log("아작스 성공");
				if(data == -1) {
					alert("책을 선택해야만 합니다. ");
				}else if(data == 0){
					alert("삭제에 실패했습니다. ");
				}else {
					var chkArraySize = chkArray.length;
					alert(data+"권이 삭제되었습니다.");
					location.href="/cart/goMyCart.do?reqPage=1";
				}
			}, error : function () {
				console.log("아작스 실패");
			}
		});
	});
	//선택해서 삭제하기2
	$("#delSelect2").click(function() {
		var chkArray = new Array();
		for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
			if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
				console.log($("input:checkbox[name=chkbox]").eq(i).val());	
				chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
			}
		}
		$.ajax({
			url : "/cart/delSelect.do",
			type : "get",
			traditional : true,
			data : {chkArray : chkArray},
			success : function(data) {
				console.log("return :"+data);
				console.log("아작스 성공");
				if(data == -1) {
					alert("책을 선택해야만 합니다. ");
				}else if(data == 0){
					alert("삭제에 실패했습니다. ");
				}else {
					var chkArraySize = chkArray.length;
					alert(data+"권이 삭제되었습니다.");
					location.href="/cart/goMyCart.do?reqPage=1";
				}
			}, error : function () {
				console.log("아작스 실패");
			}
		});
	});	
	
	/////////////////////////
	//선택한 것 렌트하기
	$("#selectedCart").click(function() {
		var chkArray = new Array();
		for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
			if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
				console.log($("input:checkbox[name=chkbox]").eq(i).val());	
				chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
			}
		}
		if(chkArray.length == 0) {
			alert("선택한 책이 없습니다. ");
			return;
		}else {
			$.ajax({
				url : "/rent/selectedCart.do",
				type : "get",
				traditional : true,
				data : {chkArray : chkArray},
				success : function(data) {
					if(data == -1) {
						alert("책을 선택해야만 합니다. ");
					}else if(data == 0){
						alert("data 0 ");
					}else {
						location.href="/rent/goSpotPage.do?bookNoList="+data;
					}
				}, error : function () {
					console.log("아작스 실패");
				}
			});			
		};
	});
	$("#selectedCart2").click(function() {
		var chkArray = new Array();
		for(var i=0; i< $("input:checkbox[name=chkbox]").length ; i++) {
			if($("input:checkbox[name=chkbox]").eq(i).is(":checked")) {
				console.log($("input:checkbox[name=chkbox]").eq(i).val());	
				chkArray.push($("input:checkbox[name=chkbox]").eq(i).val());
			}
		}
		if(chkArray.length == 0) {
			alert("선택한 책이 없습니다. ");
			return;
		}else {
			$.ajax({
				url : "/rent/selectedCart.do",
				type : "get",
				traditional : true,
				data : {chkArray : chkArray},
				success : function(data) {
					if(data == -1) {
						alert("책을 선택해야만 합니다. ");
					}else if(data == 0){
						alert("data 0 ");
					}else {
						location.href="/rent/goSpotPage.do?bookNoList="+data;
					}
				}, error : function () {
					console.log("아작스 실패");
				}
			});			
		};
	});	
	/////////////////////////////////////
});	
	//삭제 버튼으로 한 권 삭제하기
	function deleteButton(obj) {
		console.log($(obj).parent().parent().find("input").val());
		var chkArray = new Array();
		chkArray.push($(obj).parent().parent().find("input").val());
		$.ajax({
			url : "/cart/delSelect.do",
			type : "get",
			traditional : true,
			data : {chkArray : chkArray},
			success : function(data) {
				console.log("return :"+data);
				console.log("아작스 성공");
				if(data == -1) {
					alert("책을 선택해야만 합니다. ");
				}else if(data == 0){
					alert("삭제에 실패했습니다. ");
				}else {
					var chkArraySize = chkArray.length;
					alert(data+"권이 삭제되었습니다.");
					location.href="/cart/goMyCart.do?reqPage=1";
				}
			}, error : function () {
				console.log("아작스 실패");
			}
		});		
	}

</script>
<body style="line-height:normal;">
	<div class="wrapper"  style="background-color : #f3f5f7;">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="cTop">
			<div class="black"></div><span>장바구니</span>
		</div>
		<div class="emptyDiv"></div>
		<div class="content">
			<div class="buttonDiv1">
				<button type="button" id="allSelect">전체선택/선택취소</button>
				<button type="button" id="delSelect">장바구니에서 제거</button>
				<div>
					<button type="button" style='background-color:rgb(0, 102, 179);' id="selectedCart2">선택한 책 대여하기</button>					
				</div>							
			</div>
			<div class="contentDiv">
				<c:forEach items="${list }" var="n" varStatus="i">
				<div class="listDiv">
					<table class="listTable">
						<tr class="listTr">
							<td class="listTd1" style='vertical-align: 0;'><input type="checkbox" name="chkbox" id="no{i.count}" value="${n.bookName }~구분~${n.bookWriter}~구분~${n.bookPublisher}">&nbsp;&nbsp;${i.count }.</td>
							<td class="listTd2"><img src='${n.bookImg }'></td>
							<td class="listTd3" style='vertical-align: 0;'>
								<span class="nameSpan">${n.bookName }</span><br>
								<span class="writerSpan">${n.bookWriter }</span><br>
								<span class="publisherSpan">${n.bookPublisher }</span>
							</td>
							<td class="listTd4">
								<button type="button" style='background-color:df0000;' id="deleteButton" onclick='deleteButton(this);'>삭제</button>
							</td>
						</tr>					
					</table>				
				</div>
				</c:forEach>
			</div>
			<div class="bottomNavi">
				<div class="buttonDiv2">
					<button type="button" id="allSelect2">전체선택/선택취소</button>
					<button type="button" id="delSelect2">장바구니에서 제거</button>			
				</div>
				<div id="naviDiv">
					${pageNavi }
				</div>		
				<div class="buttonDiv3">
					<button type="button" style='background-color:rgb(0, 102, 179);' id="selectedCart">선택한 책 대여하기</button>	
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>