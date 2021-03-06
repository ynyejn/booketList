<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="font-size: 18px">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>회원 신고 관리페이지</title>

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

<link rel="stylesheet" href="/resources/css/admin/adminBookList.css">

<script>
	$(function() {
		var check = '${check }';

		if (check == '2') {
			$('#tt2').addClass("active");
			$('#tt1').removeClass("active");
			$('#profile').addClass("active in");
			$('#home').removeClass("active in");
		} else {
			$('#tt1').addClass("active");
			$('#tt2').removeClass("active");
			$('#home').addClass("active in");
			$('#profile').removeClass("active in");
		}

		/* $(".searchList").click(function() {
			var searchSelect = $(this).html();
			$("#searchTitle").html("");
			$("#searchTitle").html(searchSelect);
		}); */

		$('#myTab').children('a').click(function(e) {
			e.preventDefault()
			$(this).tab('show')
		});
		
		$("#back").click(function() {
			location.href = "/adminPage.do";
		});
		$("#sear").click(function() {
			var search = $("#search").val();
			var searchTitle = $("#searchTitle").find("option:selected").html();
			location.href = "/adminComplainList.do?reqPage="+${reqPage }+"&check="+${check }+"&reqPage2="+${reqPage2 }+"&search="+search+"&searchTitle="+searchTitle;
		});
		
		
		$("#search").keydown(function(key) {
			if (key.keyCode == 13) {
				$("#sear").click();
			}
		});

	});

	function detail(no) {
		$("#complainHoldNo").val(no);
		$.ajax({
			url : "/selectOneComplainList.do",
			type : "get",
			data : {ComplainNo : no},
			success:function(data){
				$("#ComplainHold").children("table").children().remove(); 
				html = "";
				html += "<tr><th>신고한 id</th>";
				html += "<td>"+data.memberId+"</td></tr>";
				html += "<tr><th>신고당한 id</th>";
				html += "<td>"+data.attacker+"</td></tr>";
				html += "<tr><th>신고 날짜</th>";
				html += "<td>"+data.complainDate+"</td></tr>";
				html += "<tr><th>신고 카테고리</th>";
				html += "<th>"+data.complainCategory+"</th></tr>";
				html += "<tr><th>신고 내용</th>";
				if(data.complainFilename == null){
					html += "<th>"+data.complainContent+"</th></tr>";
				}else{
					html += "<th><img src='"+data.complainFilename+"'><br>"+data.complainContent+"</th></tr>";
				}
				$("#ComplainHold").children("table").append(html);
				
			},
			error:function(){
				console.log("ajax통신 실패");
			}
		});
	}

	function detail2(no) {
		$("#complainCompleteNo").val(no);
		$.ajax({
			url : "/selectOneComplainList.do",
			type : "get",
			data : {ComplainNo : no},
			success:function(data){
				$("#ComplainHold2").children("table").children().remove(); 
				html = "";
				html += "<tr><th>신고한 id</th>";
				html += "<th>"+data.memberId+"</th></tr>";
				html += "<tr><th>신고당한 id</th>";
				html += "<th>"+data.attacker+"</th></tr>";
				html += "<tr><th>신고 날짜</th>";
				html += "<th>"+data.complainDate+"</th></tr>";
				html += "<tr><th>신고 카테고리</th>";
				html += "<th>"+data.complainCategory+"</th></tr>";
				html += "<tr><th>신고 내용</th>";
				if(data.complainFilename == null){
					html += "<th>"+data.complainContent+"</th></tr>";
				}else{
					html += "<th><img src='"+data.complainFilename+"'><br>"+data.complainContent+"</th></tr>";
				}
				
				html += "<tr><th>신고 상태</th>";
				
				if(data.complainStauts == 1){
					html += "<th>신고처리</th></tr>";	
				}else if(data.complainStauts == 2){
					html += "<th>신고반려</th></tr>";
				}
				
				$("#detailUpdate1").hide();
				$("#detailUpdate2").hide();
				if(data.complainStauts == '2'){
					$("#detailUpdate1").show();
				}else{
					$("#detailUpdate2").show();
				}
				$("#ComplainHold2").children("table").append(html);
				$("#complainStatus").val(data.complainStauts);
				
			},
			error:function(){
				console.log("ajax통신 실패");
			}
		});
	}
	
	function updateComplainYesList(no){
		
		no = $("#complainHoldNo").val();
		var reqPages = ${reqPage }
		
		if(confirm("신고 처리 하시겠습니까?")){
			$.ajax({
				url : "/detailComplainYes.do",
				type : "get",
				traditional : true,
				data : {ComplainNo : no, reqPage : reqPages},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminComplainList.do?reqPage="+${reqPage }+"&check=1&reqPage2=1";
					}else{
						alert("처리가 실패 하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	}
	
	function updateComplainYesList2(no){
		
		no = $("#complainCompleteNo").val();
		var reqPages = ${reqPage }
		
		if(confirm("신고 처리 하시겠습니까?")){
			$.ajax({
				url : "/detailComplainYes.do",
				type : "get",
				traditional : true,
				data : {ComplainNo : no, reqPage : reqPages},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminComplainList.do?reqPage="+${reqPage }+"&check=2&reqPage2=1";
					}else{
						alert("처리가 실패 하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	}
	
	function updateComplainNoList(no){
		no = $("#complainHoldNo").val();
		var reqPages = ${reqPage }
		
		if(confirm("신고반려처리를 하시겠습니까?")){
			$.ajax({
				url : "/detailComplainNo.do",
				type : "get",
				traditional : true,
				data : {ComplainNo : no, reqPage : reqPages},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminComplainList.do?reqPage="+${reqPage }+"&check=1&reqPage2=1";
					}else{
						alert("처리가 실패 하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	}
	
	function updateComplainNoList2(no){
		no = $("#complainCompleteNo").val();
		var reqPages = ${reqPage }
		
		if(confirm("신고반려처리를 하시겠습니까?")){
			$.ajax({
				url : "/detailComplainNo.do",
				type : "get",
				traditional : true,
				data : {ComplainNo : no, reqPage : reqPages},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminComplainList.do?reqPage="+${reqPage }+"&check=2&reqPage2=1";
					}else{
						alert("처리가 실패 하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	}
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
			/* $("#alarmss").html(JSON.parse(e.data).totalCount);
			$("#lostAlarm").html(JSON.parse(e.data).lostbookCount); */
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
                    <span id="lostAlarm" class="badge badge-danger badge-counter danger" style="background-color:red;"></span>
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
                    <span id="complainAlarm" class="badge badge-danger badge-counter danger" style="background-color:red;"></span>
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
					<h1 class="h3 mb-2 text-gray-800">회원신고관리</h1>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">List</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<!-- 테이블 -->
								<div class="bs-example bs-example-tabs" role="tabpanel"
									data-example-id="togglable-tabs">
									<!-- 탭 -->
									<ul id="myTab" class="nav nav-tabs" role="tablist">
										<li id="tt1" role="presentation" class="active"><a
											href="#home" id="home-tab" role="tab" data-toggle="tab"
											aria-controls="home" aria-expanded="true"><b>신고처리대기</b></a></li>
										<li id="tt2" role="presentation" class=""><a
											href="#profile" role="tab" id="profile-tab" data-toggle="tab"
											aria-controls="profile" aria-expanded="false"><b>신고처리완료</b></a></li>
										<!-- 검색 메뉴 드롭다운 -->
										<li id="searchbar">
											<div class="col-lg-6">
												<div class="input-group" style="width: 350px;">
													<div class="input-group-btn">

														<select class="form-control"
															style="width: 120px; height: 35px; margin-left: 10px;"
															id="searchTitle" name="selectColumn">
															<c:if test="${empty searchTitle }">
																<option value="신고한id" selected>신고한id</option>
																<option value="신고당한id">신고당한id</option>
															</c:if>
															<c:if test="${not empty searchTitle }">
																<option value="신고한id"
																	<c:if test="${searchTitle eq '신고한id' }">selected</c:if>>신고한id</option>
																<option value="신고당한id"
																	<c:if test="${searchTitle eq '신고당한id' }">selected</c:if>>신고당한id</option>

															</c:if>
														</select>
													</div>
													<!-- 검색창, 검색모양 -->
													<c:if test="${not empty search }">
														<input type="text" class="form-control" aria-label="..."
															id="search" value="${search }"
															style="width: 180px; float: left;">
														<span class="glyphicon glyphicon-search" id="sear"
															style="font-size: 20pt; margin-left: 3px; margin-top: 2px; float: left;"></span>
													</c:if>
													<c:if test="${empty search }">
														<input type="text" class="form-control " aria-label="..."
															style="width: 180px; float: left;" id="search">
														<span class="glyphicon glyphicon-search" id="sear"
															style="font-size: 20pt; margin-left: 3px; margin-top: 2px; float: left;"></span>
													</c:if>
												</div>
											</div>

										</li>
									</ul>

									<!-- 신고내역 리스트 받아올 때 -->
									<div id="myTabContent" class="tab-content">
										<div role="tabpanel" class="tab-pane fade active in" id="home"
											aria-labelledby="home-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<td class="width1"><b>번호</b></td>
														<td class="width6"><b>신고한 id</b></td>
														<td class="width6"><b>신고당한 id</b></td>
														<td class="width6"><b>신고날짜</b></td>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list1 }" var="p" varStatus="i">
														<tr class="move"
															onclick="detail('${p.complainNo }','${reqPage }')"
															data-toggle="modal" data-target="#myModal">
															<td class="width1">${(reqPage-1)*10 + i.count }</td>
															<td class="width6">${p.memberId }</td>
															<td class="width6">${p.attacker }</td>
															<td class="width6">${p.complainDate }</td>
														</tr>
													</c:forEach>

												</tbody>
											</table>
											<nav id="footNav2" style="text-align: center;">
												
												<div id="sel" style="float: right; margin-top: 20px;">
													<button type="button" class="btn btn-default" id="back">돌아가기</button>
												</div>
												<ul class="pagination">${pageNavi1 }</ul>
											</nav>


										</div>

										<!-- 신고완료내역 리스트 받아올 때 -->
										<div role="tabpanel" class="tab-pane fade" id="profile"
											aria-labelledby="profile-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<td class="width1"><b>번호</b></td>
														<td class="width5"><b>신고한 id</b></td>
														<td class="width5"><b>신고당한 id</b></td>
														<td class="width6"><b>신고한 날짜</b></td>
														<td class="width5"><b>신고유무(Y/N)</b></td>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list2 }" var="p" varStatus="i">
														<tr class="move" id="move2"
															onclick="detail2(${p.complainNo },${reqPage2 })"
															data-toggle="modal" data-target="#myModal3">
															<td class="width1" scope="row">${(reqPage2-1)*10 + i.count }</td>
															<td class="width5">${p.memberId }</td>
															<td class="width5">${p.attacker }</td>
															<td class="width6">${p.complainDate }</td>
															<td class="width5"><c:if test="${p.complainStauts == 1}">
																Y
															</c:if> <c:if test="${p.complainStauts == 2}">
																N
															</c:if></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<nav id="footNav2" style="text-align: center;">
												
												<div id="sel" style="float: right; margin-top: 20px;">
													<button type="button" class="btn btn-default" id="back">돌아가기</button>
												</div>
												<ul class="pagination">${pageNavi2 }</ul>
											</nav>
										</div>



									</div>
								</div>




								<!-- 신고처리대기 상세보기 모달 -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">신고처리대기</h4>
											</div>
											<div class="modal-body" id="ComplainHold"
												style="height: 400px">
												<table class="table table-bordered">
												</table>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">돌아가기</button>
												<input type="hidden" id="complainHoldNo">

												<button type="button" class="btn btn-primary"
													id="detailUpdateYes" onclick="updateComplainYesList(this)">신고등록</button>
												<button type="button" class="btn btn-primary"
													id="detailUpdateNo" onclick="updateComplainNoList(this)">신고반려</button>
											</div>
										</div>
									</div>
								</div>

								<!-- 신고처리완료 상세보기 모달 -->
								<div class="modal fade" id="myModal3" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">신고처리완료</h4>
											</div>
											<div class="modal-body" id="ComplainHold2"
												style="height: 400px">
												<table class="table table-bordered">
												</table>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">돌아가기</button>
												<input type="hidden" id="complainCompleteNo">


												<button type="button" class="btn btn-primary"
													id="detailUpdate1" onclick="updateComplainYesList2(this)">신고등록</button>

												<button type="button" class="btn btn-primary"
													id="detailUpdate2" onclick="updateComplainNoList2(this)">신고철회</button>
											</div>
										</div>
									</div>
								</div>
								<!-- /.container-fluid -->

							</div>
							<!-- End of Main Content -->
							<div class="row">

								<!-- Footer -->
								<footer class="sticky-footer bg-white">
									<div class="container my-auto">
										<div class="copyright text-center my-auto">
											<span></span>
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
						<div class="modal fade" id="logoutModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
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

						<script
							src="/resources/adminBootstrap/vendor/jquery/jquery.min.js"></script>
						<script
							src="/resources/adminBootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


						<!-- Core plugin JavaScript-->
						<script
							src="/resources/adminBootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

						<!-- Custom scripts for all pages-->
						<script src="/resources/adminBootstrap/js/sb-admin-2.min.js"></script>

						<!-- Page level plugins -->
						<script
							src="/resources/adminBootstrap/vendor/chart.js/Chart.min.js"></script>

						<!-- Page level custom scripts -->
						<script src="/resources/adminBootstrap/js/demo/chart-area-demo.js"></script>
						<script src="/resources/adminBootstrap/js/demo/chart-pie-demo.js"></script>
</body>
</html>