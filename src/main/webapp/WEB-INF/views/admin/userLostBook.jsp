<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>

<style>
.payInfo {
        font-size: 16px;
        line-height: 42px;
        height: 42px;
        color: #535253;
        vertical-align: text-bottom;
    }
    .check {
        width: 20px;
        height: 20px;
        vertical-align: -2px;
    }

</style>
<script>
$(function(){
	$(".checkRow").click(function(){
		var count = 0;
		$(".checkRow:checked").each(function(){
			count += 20000;
		});
		$(".payPrice").html(count);	
	});
	
	$("#ck_all").click(function(){
		var count = 0;
		if($("#ck_all").prop("checked")){
			$(".checkRow").prop("checked",true);
			
		}else{
			$("input[type=checkbox]").prop("checked",false);
		}
		
		$(".checkRow:checked").each(function(){
			count += 20000;
		});
		$(".payPrice").html(count);	
	});
		
	
	
});
function payFunc() {
    var payPrice=Number($(".payPrice").html());
    IMP.init("imp03735690");
    IMP.request_pay({
        //결제정보넘김
        merchant_uid: '상품명_' + date,
        name: 'BooketList',
        amount: payPrice,
        buyer_email: 'test@naver.com',
        buyer_name: '${sessionScope.member.memberName}',
        buyer_tel: '010-1111-2222',
        buyer_postcode: '01234'
    }, function(rsp) {
        if (rsp.success) {
            //결제 성공햇을때
            $(".delayBox").attr("status", "true");
            $(".delayFrame").hide();
        } else {
            alert("결제취소")
        }
    });
}



$("#selDelete").click(function(){
	if(confirm("선택 도서를 삭제 하시겠습니까?")){
		var checkArr = new Array();
		/* var reqPages = ${reqPage }; */
		
		
	}else{
		return false;
	}
});
</script>
</head>
<body>
	<table border="1">
		<thead>
			<tr>
				<th class="width1"><input type="checkbox" id="ck_all"></th>
				<th class="width2">도서이름</th>
				<th class="width3">작가</th>
				<th class="width4">출판사</th>
				<th class="width5">장르</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="p" varStatus="i">
				<tr class="move">
					<th class="width1"><input type="checkbox" class="checkRow"
						value="${p.bookNo }"></th>
					<td class="width2">${p.bookName }</td>
					<td class="width3">${p.bookWriter }</td>
					<td class="width4">${p.bookPublisher }</td>
					<td class="width5">${p.bookCategory }</td>

				</tr>
			</c:forEach>

		</tbody>
	</table>
	<div class="payInfo">
		<img src="/resources/imgs/bluecheck.png" class="check"> 연체료 | <span class="payPrice">0</span>원<small
			style="color: #3cbcc7; margin-left: 15px;">한 권당 20000원 씩
			계산됩니다</small>
		<button id="payBtn" >결제하기</button>
	</div>
</body>
</html>