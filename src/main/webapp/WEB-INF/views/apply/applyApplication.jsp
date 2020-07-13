<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List 도서신청</title>


<style>
      
        .content {
        width: 1200px;
        overflow: hidden;
        margin: 0 auto;
        padding-bottom: 100px;
        background-color: aliceblue;
    }
        .black {
        background-color: #1B3A50;
        width: 100%;
        height: 100%;
        opacity: 35%;
    }
    .cTop {
        margin-top: 120px;
        width: 100%;
        height: 200px;
        background-image: url(/resources/imgs/applBook.jpg);
        position: relative;
    }
	  .cTop>span {
        color: #eeeeee;
        font-size: 40px;
        font-weight: bolder;
        position: absolute;
        padding-left: 300px;
        padding-right: 30px;
        top: 55px;
        left: 0px;
        text-shadow: 1px 1px 2px black;
        border-bottom: 5px solid #dddddd;
        box-shadow: 0px 1px 0px black;
    }
    #searchDiv {
    	width : 1100px;
    	padding : 30px 20px;
    	margin : 0 auto;
    	border-top: 2px solid #585858;
	    border-bottom: 2px solid #585858;
	    text-align: center;
    }
    table{
    margin : 0 auto;
    padding: 0;
    font-size: 1.5em;
    }
    .btnBox {
        text-align: right;
        width: 95%;
        height: 100%;
        display: inline-block;
    }
     .allCheck{
        border: none;
        background-color: #666666;
        color: white;
        width: 110px;
        height: 35px;
        font-size: 14px;
        border-radius: 2px;
    }
     .check {
        width: 25px;
        height: 25px;
        vertical-align: -7px;
    }
    input{
    	text-overflow: ellipsis;
    }
    #Space{
    	width: 40px;
    }
    #applyCon{
    	padding:0;
		    padding-bottom: 110px;
    }
    #applyCon2{
    	padding:0;
		    padding-bottom: 150px;
    }
    [name=returnBtn] {
        width: 250px;
        display: inline-block;
        height: 70px;
        background-color: #303538;
        color: white;
        line-height: 70px;
        text-align: center;
        border-radius: 5px;
        cursor: pointer;
    }
    [name=returnBtn]:hover, #payBtn:hover{
        background-color: #222222;
    }
    
    #bookImg1{
    color: white;
    	 
    }
   .reviewSubmit{
   	text-align: center;
   }
</style>
</head>
<body>
<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
			<div class="cTop">
			<div class="black"></div><span>도서 신청</span>
		</div>
		<div class="content">
		<div class="emptyDiv" style="height:35px;"> 
                    </div>
                    <div class="btnBox">
                    <span>
                   <img src="/resources/imgs/bookicon.png" class="check"> 도서를 검색해 주세요.
                   </span><button class="allCheck" type="button">도서 검색</button>
                </div>

			<form action="/apply/applyInsert.do" method="post">
			<div id="searchDiv">
			
			<input type="hidden" name="memberId" value="${sessionScope.member.memberId }">
				<table>
					<tr>
						<th>도서이름</th>
						<td id="Space"></td>
						<th>
						<input type="text" id="bookName" name="bookName" style="width: 603px;height: 40px;"readonly>
						</th>
					</tr>
					<tr>
						<th>출판일</th>
						<td id="Space"></td>
						<th>
						<input type="text" id="bookPubDates" name="bookPubDates"style="width: 603px;height: 40px;"readonly>
						</th>
					</tr>
					<tr>
						<th>작가</th>
						<td id="Space"></td>
						<th>
						<input type="text" id="bookWriter" name="bookWriter"style="width: 603px;height: 40px;"readonly>
						</th>
					</tr>
					<tr>
						<th>출판사</th>
						<td id="Space"></td>
						<th>
						<input type="text" id="bookPublisher" name="bookPublisher"style="width: 603px;height: 40px;"readonly>
						</th>
					</tr>
					<tr>
						<th>카테 고리</th>
						<td id="Space"></td>
						<th>
						<input type="text" id="bookCategory" name="bookCategory"style="width: 603px;height: 40px;"readonly>
						</th>
					</tr>
					<tr>
						<th id="applyCon2">이미지</th>
						<td id="Space"></td>
						<td><img id="bookImg1"name="bookImg1" width="150px" height="200px" >
						<input type="hidden" id="bookImg" name="bookImg">
						</td>
					</tr>
					<tr>
						<th>도서내용</th>
						<td id="Space"></td>
						<th><input type="text" id="bookContent" name="bookContent"style="width: 603px;height: 40px;"readonly></th>
					</tr>
					<tr>
						<th id="applyCon">신청 사유</th>
						<td id="Space"></td>
						<th><textarea id="applyContent" name="applyContent" rows="8" cols="49"  style = "resize : none;"></textarea></th>
					</tr>
					<tr>
						<td colspan="3"></td>
					</tr>
				</table>
			</div>
			<div class="emptyDiv" style="height:35px;"> 
                    </div>
			<div class="reviewSubmit"><input type="submit" name="returnBtn"value="신청하기"></div>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
<script type="text/javascript">
	$(function () {
		$("button").click(function () {
			window.name="apply"
			var url = "/apply/applySearch.do";
			var title = "도서 검색";
			var style = "width=500,height=600,top=100,left=400";
			window.open(url,title,style);
			
		});
	})
</script>
</body>
</html>