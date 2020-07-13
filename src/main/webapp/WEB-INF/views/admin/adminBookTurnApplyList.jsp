<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en" style="font-size: 18px;">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>BooketList</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>

<link rel="stylesheet"
	href="/resources/adminBootstrap/css/bootstrap.css" />

<!-- Custom fonts for this template-->
<link
	href="/resources/adminBootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">


<!-- Custom styles for this template-->
<link href="/resources/adminBootstrap/css/sb-admin-2.min.css"
	rel="stylesheet" type="text/css">


<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<!-- 테이블 부트스트랩 -->
<script>
	window.onload = function() {
		console.log("onload");
		var msg = '${msg }';
		if(msg=='1'){
			alert("승인완료! 예약고객분들꼐 메일 발송하였습니다.");
		}else if(msg=='2'){
			alert("승인실패 하였습니다.");
		}else if(msg=='3'){
			alert("승인완료! 예약고객님이 없어 메일을 발송하지 않았습니다.");
		}
		
		$("#back").click(function() {
			location.href = "/adminPage.do";
		});
		$("#sear").click(function() {
							$(".chBox").prop("checked", false);
							$("#allCheck").prop("checked", false);
							$("#tbody").html("");
							$(".pagination").html("");
							var selectColumn = $("#selectColumn option:selected").val();
							var search = $("#search").val();
							var smc = $("#selectBookCount option:selected").val();
							smc = parseInt(smc);
							var alignTitle = $("#alignStatus").find("span").html();
							var alignStatus = $("#alignStatus").find("input").val();
							$.ajax({
										url : "/bookSearchTurnApplyList.do",
										type : "post",
										dataType : "json",
										data : {
											alignTitle : alignTitle,
											alignStatus : alignStatus,
											selectCount : smc,
											reqPage : 1,
											selectColumn : selectColumn,
											search : search
										},
										success : function(data) {
											console.log(data.list);
											console.log(data.list[0].memberId);
											console.log(data.pageNavi);
											var resultText = "";
											for (var i = 0; i < data.list.length; i++) {
												
												resultText += "<tr><th scope=row class=num><input type=checkbox name=chBox class=chBox data-turnApply="+data.list[i].turnApply+">"
														+ ((data.reqPage - 1)
																* data.selectCount
																+ i + 1)
														+ "</th>";
												resultText += "<td class=th2>"
														+ data.list[i].memberId
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].bookName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].spotName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.arrTurnApplyDate[i]
														+ "</td>";
												resultText += "<td class=th2>"
												+ "<button class='btn btn-danger' data-turnApply="+data.list[i].turnApply+" onclick='agreeTurnApply(this)' style='border:none; background-color:#00a3e0;'>승인</button>"
												+ "</td></tr>";
											}
											$("#ajaxReqPage").val(data.reqPage);
											$("#tbody").html(resultText);
											$(".pagination").html(data.pageNavi);
										},
										error : function() {

										}
									});
						});
		$("#search").keydown(function(key) {
			if (key.keyCode == 13) {
				$("#sear").click();
			}
		});
		$("#selectBookCount").change(function() {
			$(".chBox").prop("checked", false);
			$("#allCheck").prop("checked", false);
						var smc = $("#selectBookCount option:selected").val();
							$("#tbody").html("");
							$(".pagination").html("");
							var selectColumn = $("#selectColumn option:selected").val();
							var search = $("#search").val();
							var alignTitle = $("#alignStatus").find("span").html();
							var alignStatus = $("#alignStatus").find("input").val();
							$.ajax({
										url : "/bookSearchTurnApplyList.do",
										type : "post",
										dataType : "json",
										data : {
											alignTitle : alignTitle,
											alignStatus : alignStatus,
											selectCount : smc,
											reqPage : 1,
											selectColumn : selectColumn,
											search : search
										},
										success : function(data) {
											console.log(data.list);
											console.log(data.list[0].memberId);
											console.log(data.pageNavi);
											var resultText = "";
											for (var i = 0; i < data.list.length; i++) {
												
												resultText += "<tr><th scope=row class=num><input type=checkbox name=chBox class=chBox data-turnApply="+data.list[i].turnApply+">"
														+ ((data.reqPage - 1)
																* data.selectCount
																+ i + 1)
														+ "</th>";
												resultText += "<td class=th2>"
														+ data.list[i].memberId
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].bookName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].spotName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.arrTurnApplyDate[i]
														+ "</td>";
												resultText += "<td class=th2>"
												+ "<button class='btn btn-danger' data-turnApply="+data.list[i].turnApply+" onclick='agreeTurnApply(this)' style='border:none; background-color:#00a3e0;'>승인</button>"
												+ "</td></tr>";
											}
											$("#ajaxReqPage").val(data.reqPage);
											$("#tbody").html(resultText);
											$(".pagination").html(data.pageNavi);
										},
										error : function() {

										}
									});
						});
		$("#allCheck").click(function(){
			 var chk = $("#allCheck").prop("checked");
			 if(chk) {
			  $(".chBox").prop("checked", true);
			 } else {
			  $(".chBox").prop("checked", false);
			 }
			});
		$(".chBox").click(function(){
				$("#allCheck").prop("checked", false);
		 });
		$("#excelDownLoad").click(function(){
			console.log("엑셀다운로드");
			var checkArr = new Array();
			$("input[class='chBox']:checked").each(function(){
				checkArr.push($(this).attr("data-turnApply"));
			});
			if(checkArr != 0){
				location.href="/excelTurnApplyDown.do?checkArr="+checkArr	
			}else{
				alert("선택해주세요");
			}
			

		});
		$("#excelDownLoadTotal").click(function(){
			console.log("전체엑셀다운로드");
			var part = "turnApply";
				location.href="/excelDownTotal.do?part="+part;
		});
	};
	function searchPageNavi(obj) {
		console.log($(obj).html());
		console.log("searchPageNavi 클릭");
		var alignTitle = $("#alignStatus").find("span").html();
		var alignStatus = $("#alignStatus").find("input").val();
		console.log("페이지 네비 클릭 : "+alignTitle);
		console.log("페이지 네비 클릭 : "+alignStatus);
		$(".chBox").prop("checked", false);
		$("#allCheck").prop("checked", false);
		var smc = $("#selectBookCount option:selected").val();
		smc = parseInt(smc);
		var ajaxReqPage = $("#ajaxReqPage").val();
		ajaxReqPage = parseInt(ajaxReqPage);
		console.log(ajaxReqPage);
		var reqPage;
		if ($(obj).html() == "<span>»</span>") {
			reqPage = (parseInt((ajaxReqPage-1)/5)*5+1)+5;
			console.log(reqPage);
		} else if ($(obj).html() == "<span>«</span>") {
			reqPage = (parseInt((ajaxReqPage-1)/5)*5+1)-5;
			console.log(reqPage);
		} else {
			reqPage = parseInt($(obj).html());
			console.log(reqPage);
		}
		var selectColumn = $("#selectColumn option:selected").val();
		var search = $("#search").val();
		$.ajax({
			url : "/bookSearchTurnApplyList.do",
			type : "post",
			dataType : "json",
			data : {
				alignTitle : alignTitle,
				alignStatus : alignStatus,
				selectCount : smc,
				reqPage : reqPage,
				selectColumn : selectColumn,
				search : search
			},
			success : function(data) {
				$(".pagination").html("");
				$("#tbody").html("");
				var resultText = "";
				for (var i = 0; i < data.list.length; i++) {
					
					resultText += "<tr><th scope=row class=num><input type=checkbox name=chBox class=chBox data-turnApply="+data.list[i].turnApply+">"
							+ ((data.reqPage - 1)
									* data.selectCount
									+ i + 1)
							+ "</th>";
					resultText += "<td class=th2>"
							+ data.list[i].memberId
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].bookName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].spotName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.arrTurnApplyDate[i]
							+ "</td>";
					resultText += "<td class=th2>"
					+ "<button class='btn btn-danger' data-turnApply="+data.list[i].turnApply+" onclick='agreeTurnApply(this)' style='border:none; background-color:#00a3e0;'>승인</button>"
					+ "</td></tr>";
				}
				$("#ajaxReqPage").val(data.reqPage);
				$("#tbody").html(resultText);
				$(".pagination").html(data.pageNavi);
			},
			error : function() {

			}
		});

	}
	
	function clickAlign(obj){
		console.log($(obj).find("span").html());
		console.log($(obj).find("input").val());
		var aTitle = $(obj).find("span").html();
		var aStatus = $(obj).find("input").val();
		$(".chBox").prop("checked", false);
		$("#allCheck").prop("checked", false);
		var smc = $("#selectBookCount option:selected").val();
		smc = parseInt(smc);
		var ajaxReqPage = $("#ajaxReqPage").val();
		ajaxReqPage = parseInt(ajaxReqPage);
		console.log(ajaxReqPage);
		var selectColumn = $("#selectColumn option:selected").val();
		var search = $("#search").val();
		$("#alignStatus").find("span").html(aTitle);
		if(aStatus=="0"){
			$(obj).find("input").val("1");
			$("#alignStatus").find("input").val("1");
		}else{
			$(obj).find("input").val("0");
			$("#alignStatus").find("input").val("0");
		}
		var alignTitle = $("#alignStatus").find("span").html();
		var alignStatus = $("#alignStatus").find("input").val();
		$.ajax({
			url : "/bookSearchTurnApplyList.do",
			type : "post",
			dataType : "json",
			data : {
				selectCount : smc,
				reqPage : ajaxReqPage,
				selectColumn : selectColumn,
				search : search,
				alignTitle : alignTitle,
				alignStatus : alignStatus
			},
			success : function(data){
				$(".pagination").html("");
				$("#tbody").html("");
				var resultText = "";
				for (var i = 0; i < data.list.length; i++) {
					
					resultText += "<tr><th scope=row class=num><input type=checkbox name=chBox class=chBox data-turnApply="+data.list[i].turnApply+">"
							+ ((data.reqPage - 1)
									* data.selectCount
									+ i + 1)
							+ "</th>";
					resultText += "<td class=th2>"
							+ data.list[i].memberId
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].bookName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].spotName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.arrTurnApplyDate[i]
							+ "</td>";
					resultText += "<td class=th2>"
					+ "<button class='btn btn-danger' data-turnApply="+data.list[i].turnApply+" onclick='agreeTurnApply(this)' style='border:none; background-color:#00a3e0;'>승인</button>"
					+ "</td></tr>";
				}
				$("#ajaxReqPage").val(data.reqPage);
				$("#tbody").html(resultText);
				$(".pagination").html(data.pageNavi);
				
				
				console.log("변경된 대여상태 : "+$("#alignStatus").find("input").val());
				
			},
			error : function(){
				
			}
		});
	}
	
	function agreeTurnApply(obj){
		var turnApply = $(obj).attr("data-turnApply");
		console.log(turnApply);
		location.href="/agreeTurnApply.do?turnApply="+turnApply;
		
	};
	function selectAgreeTurnApply() {
		var checkArr = new Array();
		$("input[class='chBox']:checked").each(function(){
			checkArr.push($(this).attr("data-turnApply"));
		});
		console.log(checkArr.length)
		console.log(checkArr)
		if(checkArr != 0){
		$.ajax({
				url : "/selectAgreeTurnApply.do",
				type : "post",
				dataType : "json",
				traditional : true,
				data : {
					checkArr : checkArr					
				},
				success : function(data){
					alert(checkArr.length+"명 중"+data+"명 승인하였습니다.")
					location.reload();
				},
				error : function(data){
					
				}
		});
			}else{
				alert("선택해주세요");
			}
	}
</script>
<script>
/*웹 소켓 */
	var ws;
	var memberId = '${sessionScope.member.memberId }'; 
	function connect(){
		ws = new WebSocket("ws://192.168.10.179/adminMsg.do");
		ws.onopen = function(){
			console.log("웹소켓 연결 생성");
			var msg = {
					type : "output"
			};
			ws.send(JSON.stringify(msg));
		};
		ws.onmessage = function(e){
			if(JSON.parse(e.data).totalCount == 0){
				$("#alarmss").html("");
				$("#lostAlarm").html("");
				$("#complainAlarm").html("");
			}else{
				$("#alarmss").html(JSON.parse(e.data).totalCount+"+");
				if(JSON.parse(e.data).lostbookCount == 0){
					$("#lostAlarm").html("");
					$("#complainAlarm").html(JSON.parse(e.data).complainCount);
				}else if(JSON.parse(e.data).complainCount == 0){
					$("#lostAlarm").html(JSON.parse(e.data).lostbookCount);
					$("#complainAlarm").html("");
				}else{
					$("#lostAlarm").html(JSON.parse(e.data).lostbookCount);
					$("#complainAlarm").html(JSON.parse(e.data).complainCount);
				}
			}

		};
		ws.onclose = function(){
			console.log("연결종료");
		};
	}
	
	$(function(){
		connect();
		var memberId = '${sessionScope.member.memberId }';
		
		if(memberId == ""){
			alert("로그인 후 이용해 주세요");
			location.href="mainPage.do";
		}else if(memberId != 'admin'){
			alert("관리자로 로그인 하십시오");
			location.href="mainPage.do";
		}
			$("#lostbookClick").click(function(){
				if($("#lostAlarm").html() != ""){
					var data = $("#lostAlarm").html();
					var sendMsg = {
						type : "lostbookClick",
						data : data
					};
					ws.send(JSON.stringify(sendMsg));
				}else{
					location.href="/adminLostBookList.do?reqPage=1";
				}
			});
			
		
		
		$("#complainAlarmClick").click(function(){
			if($("#complainAlarm").html() != ""){
				var data = $("#complainAlarm").html();
				var sendMsg = {
						type : "complainAlarmClick",
						data : data
				};
				ws.send(JSON.stringify(sendMsg));
			}else{
				location.href="/adminComplainList.do?reqPage=1&check=1&reqPage2=1";
			}
		});
	});
</script>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/adminPage.do">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-book"></i>
        </div>
        <div class="sidebar-brand-text mx-3">BooketList</div>
      </a>
        <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="/adminPage.do">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>관리자 페이지</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
           회원 관리
      </div>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link" href="/memberList.do?reqPage=1&selectCount=10">
          <i class="fas fa-fw fa-table"></i>
          <span>회원 목록</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#complaincollapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-cog"></i>    
          <span>회원 신고 관리</span>
        </a>
         <div id="complaincollapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebara">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">회원 신고 관리</h6>
            <a class="collapse-item" href="/adminComplainList.do?reqPage=1&check=1&reqPage2=1">신고처리대기</a>
            <a class="collapse-item" href="/adminComplainList.do?reqPage=1&check=2&reqPage2=1">신고처리완료</a>
          </div>
        </div> 
      </li>


      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
           도서 관리
      </div>
      
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePagesRent" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>도서 대여</span>
        </a>
        <div id="collapsePagesRent" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebarb">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">도서 대여</h6>
            <a class="collapse-item" href="/adminBookRentalStatusList.do?reqPage=1&selectCount=10">도서 대여 현황</a>
            <a class="collapse-item" href="/adminBookRentalApplyList.do?reqPage=1&selectCount=10">도서 대여 신청 목록</a>
            <a class="collapse-item" href="/adminBookTurnApplyList.do?reqPage=1&selectCount=10">도서 반납 신청 목록</a>
             <a class="collapse-item" href="/adminBookReservationList.do?reqPage=1&selectCount=10">도서예약내역</a>
          </div>
        </div>
      </li>
      
     <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#bookcollapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>도서 내역</span>
        </a>
        <div id="bookcollapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebarc">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">도서 내역</h6>
            <a class="collapse-item" href="/adminBookList.do?reqPage=1&check=1&reqPage2=1">도서내역</a>
            <a class="collapse-item" href="/adminBookList.do?reqPage=1&check=2&reqPage2=1">도서신청내역</a>
          </div>
        </div>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="/adminLostBookList.do?reqPage=1">
          <i class="fas fa-fw fa-cog"></i>
          <span>도서 분실 신고</span>
         </a>
      </li>
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
           SPOT 관리
      </div>
      <li class="nav-item">
           <a class="nav-link" href="/adminSpotList.do?reqPage=1&selectCount=10">
             <i class="fas fa-fw fa-table"></i>
             <span>SPOT</span></a>
      </li>
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
           챗봇 관리
      </div>
      <li class="nav-item">
        <a class="nav-link" href="https://desk.channel.io/#/channels/26438/user_chats/5efaa02f4f8c7e541dda" target="_blank">
          <i class="fas fa-fw fa-cog"></i>
          <span>챗봇</span></a>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>
          
            <div class="mr-auto">
          </div>
          <div class="mr-auto">
              
          </div>

          <!-- Topbar Search -->
           <form class="d-none d-sm-inline-block form-inline  ml-md-3 my-2 my-md-0 mw-100 navbar-search"  >
             <div class="input-group">
               <div class="input-group-append" style="margin-left:10px;">
             	<a href="/mainPage.do"><img src="/resources/imgs/bluelogo.png" style="width:280px; height:80px;"></a>
              </div> 
             </div> 
-           </form> 


          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span id="alarmss" class="badge badge-danger badge-counter" style="background-color:red;"></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                   알람
                </h6>
                <a id="lostbookClick" class="dropdown-item d-flex align-items-center" href="/adminLostBookList.do?reqPage=1">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <!-- <div class="small text-gray-500">December 12, 2019</div> -->
                    <span class="font-weight-bold">도서 분실 신고</span>
                    <span id="lostAlarm" class="badge badge-danger badge-counter danger"></span>
                  </div>
                </a>
                <a id="complainAlarmClick" class="dropdown-item d-flex align-items-center" href="/adminComplainList.do?reqPage=1&check=1&reqPage2=1">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <span class="font-weight-bold">회원신고</span>
                    <span id="complainAlarm" class="badge badge-danger badge-counter danger"></span>
                  </div>
                </a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
<!--             <li class="nav-item dropdown no-arrow mx-1"> -->
<!--               <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--                 <i class="fas fa-envelope fa-fw"></i> -->
<!--                 Counter - Messages -->
<!--                 <span class="badge badge-danger badge-counter">7</span> -->
<!--               </a> -->
<!--               Dropdown - Messages -->
<!--               <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown"> -->
<!--                 <h6 class="dropdown-header"> -->
<!--                   Message Center -->
<!--                 </h6> -->
<!--                 <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                   <div class="dropdown-list-image mr-3"> -->
<!--                     <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt=""> -->
<!--                     <div class="status-indicator bg-success"></div> -->
<!--                   </div> -->
<!--                   <div class="font-weight-bold"> -->
<!--                     <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div> -->
<!--                     <div class="small text-gray-500">Emily Fowler · 58m</div> -->
<!--                   </div> -->
<!--                 </a> -->
<!--                 <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                   <div class="dropdown-list-image mr-3"> -->
<!--                     <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt=""> -->
<!--                     <div class="status-indicator"></div> -->
<!--                   </div> -->
<!--                   <div> -->
<!--                     <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div> -->
<!--                     <div class="small text-gray-500">Jae Chun · 1d</div> -->
<!--                   </div> -->
<!--                 </a> -->
<!--                 <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                   <div class="dropdown-list-image mr-3"> -->
<!--                     <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt=""> -->
<!--                     <div class="status-indicator bg-warning"></div> -->
<!--                   </div> -->
<!--                   <div> -->
<!--                     <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div> -->
<!--                     <div class="small text-gray-500">Morgan Alvarez · 2d</div> -->
<!--                   </div> -->
<!--                 </a> -->
<!--                 <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                   <div class="dropdown-list-image mr-3"> -->
<!--                     <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt=""> -->
<!--                     <div class="status-indicator bg-success"></div> -->
<!--                   </div> -->
<!--                   <div> -->
<!--                     <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div> -->
<!--                     <div class="small text-gray-500">Chicken the Dog · 2w</div> -->
<!--                   </div> -->
<!--                 </a> -->
<!--                 <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a> -->
<!--               </div> -->
<!--             </li> -->

<!--             <div class="topbar-divider d-none d-sm-block"></div> -->

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>
                <span class="glyphicon glyphicon-user" style="font-size:15px;"></span>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="/member/findPwFrm.do">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                     비밀번호 변경
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="/member/logout.do">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>
          </ul>
        </nav>
        <!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">도서 반납 신청 목록</h1>

<style>
.tableTop {
	width: 100%;
	height: 45px;
	diplay: block;
	float: right;
}

.tableTopLeft {
	width: 10%;
	height: 45px;
	padding-left: 10px;
}

#mytab {
	position: relative;
}

#mytab>li {
	display: inline-block;
}

#searchbar {
	position: absolute;
	right: 0px;
}
.pagination{
	margin-right:120px;
}
#excelDownLoad {
	margin-top: 20px;
	float: left;
	border : none;
}
#excelDownLoadTotal {
	margin-top: 20px;
	float: left;
	margin-left : 5px;
	border : none;
}

#tbody button{
width:50px;
height:20px;
font-size:8pt;
padding-top:3px;
}
#back{
 background-color:#303538;
}
</style>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<!-- 테이블 -->
								<div class="bs-example bs-example-tabs" role="tabpanel"
									data-example-id="togglable-tabs">

									<ul id="myTab" class="nav nav-tabs" role="tablist">
										<li id="tt1" role="presentation" class="active"><a
											href="#home" id="home-tab" role="tab" data-toggle="tab"
											aria-controls="home" aria-expanded="true"><b>도서 반납 신청 목록</b></a></li>
										<li>
											<select class="form-control"
												style="width: 80px; height: 40px; float:left; margin-left: 10px;"
												id="selectBookCount" name="selectBookCount">
													<option value="10"
														<c:if test="${selectCount eq 10 }">selected</c:if>>10</option>
													<option value="25"
														<c:if test="${selectCount eq 25}">selected</c:if>>25</option>
													<option value="50"
														<c:if test="${selectCount eq 50}">selected</c:if>>50</option>
													<option value="100"
														<c:if test="${selectCount eq 100}">selected</c:if>>100</option>
											</select>
											
										</li>
										<li id="searchbar">
											<div class="row">
												<div class="col-lg-6">
													<div class="input-group" style="width: 350px;">
														<div class="input-group-btn">
												
															<select class="form-control"
																style="width: 120px; height: 35px; margin-left: 10px;"
																id="selectColumn" name="selectColumn">
																<option value="아이디"
																	<c:if test="${selectColumn eq memberId }">selected</c:if>>ID</option>
																<option value="책 제목"
																	<c:if test="${selectColumn eq bookName}">selected</c:if>>책 제목</option>
																	<option value="반납 장소"
																	<c:if test="${selectColumn eq spotName}">selected</c:if>>반납 장소</option>
															</select>

														</div>
														<!-- /btn-group -->
														<input type="text" class="form-control" aria-label="..."
															id="search" style="width: 180px; float: left;"> <span
															class="glyphicon glyphicon-search" id="sear"
															style="font-size: 20pt; margin-left: 3px; margin-top: 2px; float: left;"></span>
													</div>
													<!-- /input-group -->


												</div>
											</div>
										</li>
									</ul>
								<input type="hidden" id="ajaxReqPage" value="${reqPage }">
									<div id="myTabContent" class="tab-content">
										<div role="tabpanel" class="tab-pane fade active in" id="home"
											aria-labelledby="home-tab">
												<div id="alignStatus"><input type="hidden"><span style="display:none"></span></div>
												<table class="table table-hover">
													<thead>
														<tr>
															<th class="num" style="width:10%"><input type="checkbox" name="allCheck" id="allCheck">선택</th>
															<th class="th2" style="width:10%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>아이디</span></th>
															<th class="th2" style="width:40%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>책 제목</span></th>
															<th class="th2" style="width:15%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>반납 장소</span></th>
															<th class="th2" style="width:15%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>반납신청날짜</span></th>
															<th><button class="btn btn-danger" onclick="selectAgreeTurnApply()" style="border:none; background-color:#00a3e0;">승인</button></th>
														</tr>
													</thead>
													<tbody id="tbody">
														<c:forEach items="${list }" var="l" varStatus="i">
															<tr>
																
																<th scope="row" class="num"><input type="checkbox" name="chBox" class="chBox" data-turnApply="${l.turnApply }">${(reqPage-1)*selectCount + i.count }</th>
																<td class="th2">${l.memberId }</td>
																<td class="th2">${l.bookName }</td>
																<td class="th2">${l.spotName }</td>
																<td class="th2">${l.turnapplyDate }</td>
																<td class="th2">
																	<button class="btn btn-danger" data-turnApply="${l.turnApply }" onclick="agreeTurnApply(this)" style="border:none; background-color:#00a3e0;">승인</button>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
												
												<nav id="footNav2" style="text-align:center;">
													<button class="btn btn-primary" id="excelDownLoad">선택 항복 엑셀</button>
													<button class="btn btn-primary" id="excelDownLoadTotal">전체 목록 엑셀</button>
													<ul class="pagination">${pageNavi }</ul>
													<div id="sel" style="float: right; margin-top: 20px;">
														<button type="button" class="btn btn-primary" id="back">돌아가기</button>
													</div>
												</nav>
										</div>
									</div>
								</div>
								<!-- /.col-lg-6 -->

							</div>
							<!-- /.container-fluid -->

						</div>

						<!-- End of Main Content -->

						<!-- Footer -->
						<footer class="sticky-footer bg-white">
							<div class="container my-auto">
								<div class="copyright text-center my-auto">
									<span>Copyright &copy; Your Website 2019</span>
								</div>
							</div>
						</footer>
						<!-- End of Footer -->

					</div>
					<!-- End of Content Wrapper -->

				</div>
				<!-- End of Page Wrapper -->

				<!-- Scroll to Top Button-->
				<a class="scroll-to-top rounded" href="#page-top"> <i
					class="fas fa-angle-up"></i>
				</a>

				<!-- Logout Modal-->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">Ready to
									Leave?</h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">Select "Logout" below if you are
								ready to end your current session.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button"
									data-dismiss="modal">Cancel</button>
								<a class="btn btn-primary" href="login.html">Logout</a>
							</div>
						</div>
					</div>
				</div>

				<!-- Bootstrap core JavaScript-->

				<script src="/resources/adminBootstrap/vendor/jquery/jquery.min.js"></script>
				<script
					src="/resources/adminBootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


				<!-- Core plugin JavaScript-->
				<script
					src="/resources/adminBootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="/resources/adminBootstrap/js/sb-admin-2.min.js"></script>

				<!-- Page level plugins -->
				<script src="/resources/adminBootstrap/vendor/chart.js/Chart.min.js"></script>

				<!-- Page level custom scripts -->
				<script src="/resources/adminBootstrap/js/demo/chart-area-demo.js"></script>
				<script src="/resources/adminBootstrap/js/demo/chart-pie-demo.js"></script>
</body>

</html>
