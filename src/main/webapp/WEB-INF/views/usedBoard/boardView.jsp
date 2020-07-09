<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Booket List-기증/판매 게시판</title>
</head>
<style>
    div {
        box-sizing: border-box;
    }

    .cTop {
        margin-top: 120px;
        width: 100%;
        height: 160px;
        background-image: url(/resources/imgs/bookStore3.jpg);
        position: relative;
    }

    .black {
        background-color: #1B3A50;
        width: 100%;
        height: 100%;
        opacity: 45%;
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
        width: 1200px;
        overflow: hidden;
        margin: 0 auto;
        padding-top: 30px;
        padding-bottom: 200px;
    }

    /*--------------------------------------------------------------------------------------------------*/
    .content>span {
        margin-left: 50px;
        font-size: 16px;
        color: #666;
    }

    .boardFrame {
        overflow: hidden;
        width: 1100px;
        padding: 50px;
        margin: 0 auto;
        margin-top: 10px;
        border: 1px solid #e5e5e5;
        border-top: 1px solid #999;
        background-color: #ffffff;
        position: relative;
    }

    .bTitle>span {
        display: inline-block;
        font-size: 15px;
        background-color: white;
        text-align: center;
        margin-top: 5px;
        margin-left: 10px;
        margin-right: 20px;
        width: 77px;
        height: 33px;
        color: #111111;
        line-height: 33px;
        font-weight: 100;
    }

    .bTitle {
        border-bottom: 2px solid #585858;
        height: 50px;
        line-height: 42px;
        font-size: 28px;
        font-weight: bold;
        position: relative;
    }

    .bTitle>button {
        position: absolute;
        border: none;
        font-size: 14px;
        width: 90px;
        height: 30px;
        line-height: 30px;
        top: 6px;
        border-radius: 3px;
    }

    #modBtn {
        background-color: #f3f4fa;
        color: #03169a;
        right: 110px;
    }

    #delBtn {
        background-color: #e5e5e5;
        right: 0;
    }

    .bContent {
        overflow: hidden;
        padding: 50px;
    }

    .bInfo {
        height: 40px;
        line-height: 40px;
        background-color: #f3f5f7;
        border-bottom: 1px solid #e0e0e0;
        text-align: right;
    }

    .bInfo>span {
        font-size: 15px;
        height: 15px;
        line-height: 14px;
        color: #898989;
        display: inline-block;
        padding-left: 15px;
        padding-right: 19px;
        border-right: 1px solid #898989;
    }

    .bInfo>span:nth-of-type(3) {
        border: none;
    }

    .bInfo>span:last-of-type {
        border: none;
        background-color: #585858;
        color: white;
        font-size: 14px;
        border-radius: 5px;
        padding-left: 19px;
        height: 30px;
        line-height: 30px;
    }

    /*---------------------------------------------댓글-----------------------------------------------------*/
    #showComment {
        height: 40px;
        background-color: white;
        text-align: center;
        border-bottom: 2px solid #585858;
    }
    .tag{
        display: inline-block;
        padding: 2px 35px;
        font-size:17px;
        background-color: #03166c;
        border: 1px solid black;
        border-bottom: none;
        border-top-left-radius: 7px;
        border-top-right-radius: 7px; 
        color: #f3f5f7;
        margin-left: 80px;
    }

    .comment-write {
        border: 1px solid #b3b3b3;
        width: 900px;
        margin: 0 auto;
    }

    .commentFrame {
        overflow: hidden;
        padding-top: 60px;
        display: none;
    }
    .commentZone{
        padding-bottom: 60px;
    }

    .commentBox {
        border-bottom: 1px solid #e0e0e0;
        overflow: hidden;
        width: 90%;
        margin: 0 auto;
        /*        border-top: 1px solid #dddddd;*/
        border-top: 1px solid #585858;
        border-bottom: 1px solid #dddddd;
        padding-bottom: 15px;
    }

    .commentBox:first-of-type {
        border-top: 1px solid #585858;
    }

    .commentBox:last-of-type {
        border-bottom: 1px solid #585858;
    }

    .commentWriter {
        border-bottom: 1px solid #dddddd;
        padding: 3px 30px;
    }

    .commentDate {
        float: right;
        color: #898989;
        font-size: 15px;
    }

    .memberId {
        color: black;
        font-weight: bold;
        font-size: 15px;
        /*        border-bottom: 3px solid #00a3e0;*/
    }

    .commentContent {
        padding: 3px 30px;
        margin-top: 4px;
    }

    .smallImg {
        float: left;
        display: inline-block;
        width: 50px;
        margin-right: 10px;
        background-size: cover;
        height: 50px;
        border: 1px solid black;
        opacity: 70%;
    }


    .commentFiles {
        padding: 3px 30px;
    }

    .bigImg {
        opacity: 0;
        position: fixed;
        overflow: hidden;
        top: 30%;
        left: 58%;
        width: 600px;
        z-index: 300;
        background-color: white;
        border: 1px solid black;
        -webkit-transition: all 0.3s;
        transition: all 0.3s;
    }

    .bigImg>img {
        width: 100%;
    }

    .smallImg:hover>.bigImg {
        opacity: 100%;
        -webkit-transition: all 0.3s;
        transition: all 0.3s;
    }
    .smallImg:hover>.bigImg>img{
        opacity: 100%;
    }
    .words {
        height: 25px;
        line-height: 25px;
        text-align: right;
        padding-right: 20px;
        font-size: 15px;
        color: #898989;
        border-bottom: 1px solid #e5e5e5;
    }

    label[for=files] {
        opacity: 60%;
        padding-left: 20px;
        font-size: 14px;
        margin-top: 12px;
        display: inline-block;
    }

    label[for=files]:hover {
        opacity: 90%;
        cursor: pointer;
    }

    lable[for=files]>img {
        vertical-align: text-bottom;
    }

    .writeBottom {
        height: 45px;
        border-top: 1px solid #e5e5e5;
    }
    
    .writeBottom>select{
        margin-left: 598px;
        font-size: 15px;
    }
    #commentSubmit {
        float: right;
        border: none;
        border-radius: 0;
        width: 68px;
        height: 40px;
        font-size: 14px;
        border: 1px solid #454545;
        background: #525252;
        color: white;
        line-height: 40px;
    }
    
    #commentSubmit:hover {
        background: #222222;
        border: 1px solid #222222;
    }

    .textareaBox {
        padding: 20px;
        padding-bottom: 0;
    }

    /*   ------------------------------------- 파일첨부*/
    .img-view {
        display: inline-block;
        position: relative;
        background-size: cover;
        width: 80px;
        height: 80px;
        border: 1px solid black;
        margin: 0 20px;
        margin-right: 0px;
    }

    #fileSection {
        margin: 15px;
        padding: 20px;
        background-color: #f3f4fa;
        border: 1px dashed lightgray;
    }

    .subDiv {
        width: 22px;
        height: 22px;
        background-color: white;
        position: absolute;
        opacity: 80%;
        right: 0px;
        border: none;
    }

    .subDiv>img {
        width: 13px;
        height: 13px;
        margin-bottom: 1px;
    }
    

</style>

<body style="line-height: normal;">
    <div class="wrapper" style="background-color: #f3f5f7;">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div class="cTop">
            <div class="black"></div>
            <span>기증 / 판매</span>
        </div>
        <div class="content">
            <span>기증/판매 게시판 > 상세글 보기</span>
            <div class="boardFrame">
                <div class="bTitle">${ub.usedTitle}
                    <span>/ 도서 ${ub.usedType}</span>
                    <c:if test="${sessionScope.member.memberId eq ub.memberId}">
                        <button id="modBtn" onclick="modifyFunc(${ub.usedNo});">수정</button>
                        <button id="delBtn" onclick="delFunc(${ub.usedNo});">삭제</button>
                    </c:if>
                </div>
                <div class="bInfo">
                    <span>${ub.memberId}</span> <span>${ub.usedDate}</span> <span>조회
                        ${ub.readCount}</span>
                    <c:if test="${ub.usedStatus eq 0}">
                        <span>요청 완료</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 1}">
                        <span>피드백 요청</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 2}">
                        <span>피드백 완료</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 3}">
                        <span>기증/판매 확정</span>
                    </c:if>
                    <c:if test="${ub.usedStatus eq 4}">
                        <span>기증/판매 반려</span>
                    </c:if>
                </div>
                <div class="bContent">${ub.usedContent}</div>
                <div id="showComment" data-toggle="tooltip" title="댓글창을 펼칩니다.">
                    <img src="/resources/imgs/openIcon.png">
                </div>
                <div class="commentFrame">
                    <div class="commentZone">
                        <span class="tag">댓글 목록</span>
                        <c:forEach items="${ucList }" var="uc">
                            <div class="commentBox">
                                <input type="hidden" name="commentNo" value="${uc.commentNo}">
                                <div class="commentWriter"><span class="memberId">${uc.commentWriter}</span><span class="commentDate">${uc.commentDate}</span></div>
                                <div class="commentContent">${uc.commentContent}</div>
                                <div class='commentFiles'>
                                    <c:forEach items="${uc.usedFiles }" var="uf">
                                        <div class='smallImg' style='background-image:url(/resources/upload/usedBoard/${uf.commentFilepath })'>
                                            <div class="bigImg"><img src="/resources/upload/usedBoard/${uf.commentFilepath }"></div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                    <c:if test="${not empty sessionScope.member }">
                        <span class="tag">댓글 입력</span>
                        <div class="comment-write">
                            <!-- 작성자, 게시글번호, 댓글레벨, 댓글번호 보내줘야함-->
                            <form action="/usedCommentInsert.do" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="commentWriter" value="${sessionScope.member.memberId }"> <input type="hidden" name="usedNo" value="${ub.usedNo}">
                                <!-- 댓글써지는 글번호 -->
                                <div class="textareaBox">
                                    <textarea name="commentContent" id="commentContentWrite" style="width:850px;height:60px; border:none; outline:none;resize:none;" placeholder="댓글을 입력해주세요."></textarea>
                                </div>
                                <div class="words">0/150</div>
                                <!--드래그앤드랍-->
                                <div id="fileSection" class="file-droparea">
                                    <div id="upFileName">파일을 드래그하거나 사진첨부를 이용해주세요.</div>
                                </div>
                                <div class="writeBottom"><label for="files"><img src="resources/imgs/cameraIcon.png" style="width:20px; height:20px;vertical-align: text-bottom;">사진첨부</label>
                                    <input type="file" name="files" multiple="multiple" id="files" accept="image/*" onchange="loadImg(this);" style="display:none;">
                                    <c:if test="${sessionScope.member.memberId eq 'admin' }">
                                    <select name="usedStatus">
                                    <option value=1>피드백 요청</option>
                                     <option value=3>기증/판매 확정</option>
                                     <option value=4>기증/판매 완료</option>
                                    </select>
                                    </c:if>
                                    <c:if test="${sessionScope.member.memberId ne 'admin' }">
                                        <select name="usedStatus" style="display:none;"><option value="${ub.usedStatus}" selected>${ub.usedStatus}</option></select></c:if>
                                        <input type="submit" value="등록" id="commentSubmit"></div>

                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>

<script>
    var files = [];
    var files2 = [];
    
    function pro11(file, fileName){
        return new Promise(function(resolve,reject){
             var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function(e) {
                resolve("<span class='img-view' fileName='"+fileName+"'style='background-image:url(" + e.target.result + ");'><button class='subDiv' type='button' onclick='subFunc(this);' style='padding:0;'><img src='/resources/imgs/x.png'></button></span>");
            }            
        });
    }
    function pro22(file, fileName){
        return new Promise(function(resolve,reject){
             var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function(e) {
                resolve("<span class='img-view' fileName='"+fileName+"'style='background-image:url(" + e.target.result + ");'><button class='subDiv' type='button' onclick='subFunc(this);' style='padding:0;'><img src='/resources/imgs/x.png'></button></span>");
            }            
        });
    }
    $(function() {
        var obj = $("#fileSection");
        //drop 영역에 들어오면
        obj.on('dragenter', function(e) {
            e.stopPropagation(); //이벤트 버블링방지코드(부모 요소의 이벤트가 같이실행되는것을 막기위함)
            e.preventDefault(); //기본이벤트를 작동하지 않도록 하는 코드(ex. a 태그 수행시 클릭 -> 페이지이동 이지만 사용하면 click만가능하고 페이지이동은 안됨)
            $(this).css('border', '2px solid gray'); //div의 border 실선으로 변경함
        });
        //drop 영역에서 나가면
        obj.on('dragleave', function(e) {
            $(this).css('border', '1px dashed gray'); //div의 border를 점선으로 변경
            e.preventDefault();

        });
        //drop 영역위로 지나가면
        obj.on('dragover', function(e) {
            $(this).css('border', '2px solid gray');
            e.stopPropagation();
            e.preventDefault();
        });
        //drop 영역에 파일을 두면
        obj.on('drop',async function(e) {
            $(this).css('border', '1px dashed gray'); //div의 border를 점선으로 변경
            e.preventDefault();
            var count = files.length;
            for (var i = 0; i < e.originalEvent.dataTransfer.files.length; i++) {
                files[count + i] = e.originalEvent.dataTransfer.files[i];

            }
            console.log(files);
            var upFileName = $('#upFileName');
            upFileName.empty();
            for (var i = 0; i < files.length; i++) {
                var fileName = files[i].name;
                var span = await pro11(files[i],fileName);                
                upFileName.append(span);
            }

        });
        
        //댓글창 열기닫기
        var openStatus = 0;
        $("#showComment").click(function(){
            if(openStatus==0){
                $(".commentFrame").slideDown();
                openStatus=1;
                $("#showComment").empty();
                $("#showComment").append("<img src='/resources/imgs/closeIcon.png'>");
                $("#showComment").attr("data-original-title","댓글창을 닫습니다.");
                
            }else{
                $(".commentFrame").slideUp();
                openStatus=0;
                $("#showComment").empty();
                $("#showComment").append("<img src='/resources/imgs/openIcon.png'>");
                $("#showComment").attr("data-original-title","댓글창을 펼칩니다.");
            }
           
        });

    });
    //파일삭제
    function subFunc(ev) {
        for (var i = 0; i < files.length; i++) {
            console.log(files[i].name + "/" + $(ev).parent("span").attr("fileName"));
            if (files[i].name === $(ev).parent("span").attr("fileName")) {
                files.splice(i, 1);
            }
        }
        console.log(files);
        if (files.length == 0) {
            $('#upFileName').html("파일을 올려주세요");
            $('#upFileName').css('color', '');
            $('#upFileName').css('font-size', '');
        }
        $(ev).parent("span").remove();
    }

    function delFunc(usedNo) {
        if (confirm("정말 삭제하시겠습니까?")) {
            location.href = "/deleteUsedBoard.do?usedNo=" + usedNo;
        }
    }

    function modifyFunc(usedNo) {
        location.href = "/goModifyUsedBoard.do?usedNo=" + usedNo;
    }

    async function loadImg(f) {
        var upFileName = $('#upFileName');
        upFileName.empty();
        var count = files.length;
        for (var i = 0; i < f.files.length; i++) {
            files[count + i] = f.files[i];
        }
        if (f.files.length != 0 && f.files[0] != 0) { //파일이 하나이상 올라왔거나 파일이 용량이 0이 아닐경우
            for (var i = 0; i < files.length; i++) {
                var fileName = files[i].name;
                var span = await pro22(files[i],fileName);                
                upFileName.append(span);
            }
        }
        console.log(files);
    }
    $("#commentContentWrite").keyup(function() {
        var inputLength = $(this).val().length;
        if (inputLength > 150) {
            alert("최대 150자까지 입력 가능합니다.");
            $(this).val($(this).val().substring(0, 150));
            inputLength = 150;
        }
        $(".words").html(inputLength + "/150");
    });

</script>

</html>
