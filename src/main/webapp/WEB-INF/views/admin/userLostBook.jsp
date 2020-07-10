<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="/resources/css/admin/adminBookList.css">
<style>
	.payInfo {
		font-size: 16px;
		line-height: 42px;
		height: 42px;
		color: #535253;
		vertical-align: text-bottom;
		width: 1100px;
		height: 140px;
		margin: 0 auto;
		
	}
	
	.check {
		width: 20px;
		height: 20px;
		vertical-align: -2px;
	}
	#contentDiv {
		    width : 1100px;
			padding : 20px;
			margin: 0 auto;    
	    	border-top: 1px solid #e5e5e5;
	   		
    }
    #ck_all{
    	border: none;
	    background-color: #666666;
	    color: white;
	    width: 110px;
	    height: 35px;
	    font-size: 14px;
	    border-radius: 2px;
	    cursor:pointer;
	    margin-bottom : 30px;
    }
    #needCenter{
    	width: 300px;
    	margin: 0 auto;
    }
    #payBtn{
    	width : 300px;
    	height : 60px;
    	margin-bottom : 50px;
    	background-color : black;
    	color: white;
    	font-size : 20px;
    	font-weight : bold;
    	border : 0px;
    	cursor : pointer;
    }
    
</style>
<script>
var ws;
var memberId = '${sessionScope.member.memberId }'; 
function connect(){
	ws = new WebSocket("ws://192.168.10.181/adminMsg.do");
	ws.onopen = function(){
		console.log("웹소켓 연결 생성");
		
	};
	ws.onmessage = function(e){
		
	};
	ws.onclose = function(){
		console.log("연결종료");
	};
}


	$(function() {
		connect();
		var chk = 0;
		
		$("#allSelect").click(function () {
			
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
		
		$(".checkRow").click(function() {
			var count = 0;
			$(".checkRow:checked").each(function() {
				count += 1000;
			});
			$(".payPrice").html(count);
		});

		$("#ck_all").click(function() {
			var count = 0;
			if (chk==0) {
				$(".checkRow").prop("checked", true);
				chk = 1;
			} else {
				$("input[type=checkbox]").prop("checked", false);
				chk = 0;
			}

			$(".checkRow:checked").each(function() {
				count += 20000;
			});
			$(".payPrice").html(count);
		});
		if($(".checkRow").is(":checked")== false){
			$("#payBtn")
		}
	});
	function payFunc() {
		if($(".checkRow").is(":checked")== false){
			alert("도서를 선택해 주세요");
			return false;
		}
		$("#payBtn").attr("disabled",false);
		if ($(".payPrice").html() == "0") {
			alert("분실한 책을 선택하세요");
		} else {
			var d = new Date();
			var date = d.getFullYear() + "" + (d.getMonth() + 1) + ""
					+ d.getHours() + "" + d.getMinutes() + "" + d.getSeconds();
			
			var payPrice = Number($(".payPrice").html());
			IMP.init("imp03735690");
			IMP.request_pay({
				//결제정보넘김
				merchant_uid : '상품명_'+ date,
				name : 'BooketList',
				amount : payPrice,
				buyer_email : 'test@naver.com',
				buyer_name : '${sessionScope.member.memberName}',
				buyer_tel : '010-1111-2222',
				buyer_postcode : '01234'
			}, function(rsp) {
				if (rsp.success) {
					//결제 성공햇을때
					var checkArr = new Array();
					var count = 0;
					$(".checkRow:checked").each(function() {
						checkArr.push($(this).val());
						count = count + 1;
					});
						console.log("결제성공 아작스보내기전");
					$.ajax({
						url : "/userLostBookUpdate.do",
						type : "get",
						traditional : true,
						data : {
							chBox : checkArr
						},
						success : function(result) {
							console.log("아작스 성공");
							console.log(result);
							if (result > 0) {
								alert("분실신고가 완료되었습니다.");
								alert(count);
								var sendMsg = {
										type : "lostBookAlarmCount",
										data : count
								};
								ws.send(JSON.stringify(sendMsg));
								/* location.href = "/userLostBook.do"; */
							} else {
								alert("수정이 실패 하였습니다.");
							}
						}
					});

				} else {
					console.log(rsp);
					alert("결제가 취소 되었습니다.");
				}
			});
		}

	}

	$("#selDelete").click(function() {
		if (confirm("선택 도서를 삭제 하시겠습니까?")) {
			var checkArr = new Array();
			/* var reqPages = ${reqPage }; */

		} else {
			return false;
		}
	});
	
	
</script>
</head>
<body>
	<h2>분실신고</h2>
	<div id="contentDiv">
		<button type="button" id="ck_all" >전체 선택</button>
		<div id="MainContentDiv">
			<table>
				<tbody>
					<c:forEach items="${list }" var="p" varStatus="i">
						<tr>
							<th class="width0"><input type="checkbox" class="checkRow"
								value="${p.bookNo }"></th>
							<td class="width2"><img src="${p.bookImg }"
									style="width: 110px; height: 160px;"></td>
								<td class="width3" style="text-align: left;"><span
									style="font-weight: bold; color: #0066b3">${p.bookName }</span>
									<ul style="padding-left: 15px;">
										<li style="font-size: 13px; text-align: left; margin-bottom:3px;">작가
											: ${p.bookWriter }</li>
										<li style="font-size: 13px; text-align: left; margin-bottom:3px;">출판사
											: ${p.bookPublisher }</li>
										<li style="font-size: 13px; text-align: left; margin-bottom:3px;">장르 :
											${p.bookCategory }</li>
										<li style="font-size: 13px; text-align: left; margin-bottom:3px;">출판일
											: ${p.bookPubDate }</li>
									</ul>
								</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
	</div>
	<div class="payInfo">
		<div id ="needCenter" class="payBackground">
		<img src="/resources/imgs/bluecheck.png" class="check"><span
			class="payPrice" style="font-size:20px; font-weight:bold;">0</span><b><small>원</small></b><small
			style="color: gray; margin-left: 15px; font-weight:bold">한 권당 <span style="color:red;">20000</span>원 씩
			계산됩니다</small>
			<button id="payBtn" onclick="payFunc()">결제하기</button>
		</div>
		
	</div>
</body>
</html>