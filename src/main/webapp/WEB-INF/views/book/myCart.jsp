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
        .content {
            width: 1200px;
            overflow: hidden;
            margin: 120px auto 0 auto;
            /* height: 900px; */
            background-color: aliceblue;
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
	
	//선택해서 삭제하기
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
						location.href="/cart/selectSpot.do";
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
<div class="wrapper" >
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">
			<h3>장바구니</h3>
			${list }
			<hr>
			<button type="button" id="allSelect">전체선택/선택취소</button><button type="button" id="delSelect">선택한 책 장바구니에서 제거</button>
			<table border='1'>
				<tr>
					<th>선택</th>
					<th colspan='2'>책정보</th>
					<th>삭제</th>
				</tr>
			<c:forEach items="${list }" var="n" varStatus="i">
				<tr>
					<th><input type="checkbox" name="chkbox" id="no{i.count}" value="${n.bookName }~구분~${n.bookWriter}~구분~${n.bookPublisher}"></th>
					<td><img src='${n.bookImg }'></td>
					<td>
						${n.bookName }<br>
						${n.bookWriter }<br>
						${n.bookPublisher }
					</td>
					<td><button type="button" id="deleteButton" onclick='deleteButton(this);'>삭제</button></td>
				</tr>
			</c:forEach>
			</table>
			<hr>
			<button type="button" id="allSelect">전체선택/선택취소</button><button type="button" id="delSelect">선택한 책 장바구니에서 제거</button>			
			<br>
			<button type="button" id="selectedCart">선택한 책 대여하기</button>	
			<div>
				${pageNavi }
			</div>		
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>