<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


 <!DOCTYPE html>
<html lang="en" style="font-size:18px;">

<head>
<!--
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>BooketList</title>
   

  Custom fonts for this template
  <link href="/resources/adminBootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  
  
  <link rel="stylesheet"
	href="/resources/adminBootstrap/css/bootstrap.css" />
	Custom styles for this template
  
  <link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<link href="/resources/adminBootstrap/css/sb-admin-2.min.css" rel="stylesheet" type="text/css"/>


<script>
/*웹 소켓 */
	var ws;
	var memberId = '${sessionScope.member.memberId }'; 
	function connect(){
		ws = new WebSocket("ws://192.168.10.181/adminMsg.do");
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
				$("#alarmss").html(JSON.parse(e.data).totalCount);
				if(JSON.parse(e.data).lostbookCount == 0){
					$("#lostAlarm").html("");
					$("#complainAlarm").html(JSON.parse(e.data).complainCount+"+");
				}else if(JSON.parse(e.data).complainCount == 0){
					$("#lostAlarm").html(JSON.parse(e.data).lostbookCount+"+");
					$("#complainAlarm").html("");
				}else{
					$("#lostAlarm").html(JSON.parse(e.data).lostbookCount+"+");
					$("#complainAlarm").html(JSON.parse(e.data).complainCount+"+");
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
		$("#lostbookClick").click(function(){
			var data = $("#lostAlarm").html();
			var sendMsg = {
					type : "lostbookClick",
					data : data
			};
			ws.send(JSON.stringify(sendMsg));
		});
		
		$("#complainAlarmClick").click(function(){
			var data = $("#complainAlarm").html();
			var sendMsg = {
					type : "complainAlarmClick",
					data : data
			};
			ws.send(JSON.stringify(sendMsg));
		});
	});
</script>
End Channel Plugin
</head>

<body id="page-top">

  Page Wrapper
  <div id="wrapper">

    Sidebar
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      Sidebar - Brand
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-book"></i>
        </div>
        <div class="sidebar-brand-text mx-3">BooketList</div>
      </a>
        Divider
      <hr class="sidebar-divider my-0">

      Nav Item - Dashboard
      <li class="nav-item active">
        <a class="nav-link" href="/adminPage.do">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>관리자 페이지</span></a>
      </li>

      Divider
      <hr class="sidebar-divider">

      Heading
      <div class="sidebar-heading">
           회원 관리
      </div>
      Nav Item - Pages Collapse Menu
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
         <div id="complaincollapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">회원 신고 관리</h6>
            <a class="collapse-item" href="/adminComplainList.do?reqPage=1&check=1&reqPage2=1">신고처리대기</a>
            <a class="collapse-item" href="/adminComplainList.do?reqPage=1&check=2&reqPage2=1">신고처리완료</a>
          </div>
        </div> 
      </li>


      Divider
      <hr class="sidebar-divider">

      Heading
      <div class="sidebar-heading">
           도서 관리
      </div>
      
      Nav Item - Pages Collapse Menu
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePagesRent" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>도서 대여</span>
        </a>
        <div id="collapsePagesRent" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
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
        <div id="bookcollapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">도서 내역</h6>
            <a class="collapse-item" href="/adminBookList.do?reqPage=1&check=1&reqPage2=1">도서내역</a>
            <a class="collapse-item" href="/adminBookList.do?reqPage=1&check=2&reqPage2=1">도서신청내역</a>
          </div>
        </div>
      </li>
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#LostcollapsePages" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa-cog"></i>
          <span>도서 분실 신고</span>
         </a>
         <div id="LostcollapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">분실 내역</h6>
            <a class="collapse-item" href="/userLostBook.do">분실 신고</a>
            <a class="collapse-item" href="/adminLostBookList.do?reqPage=1">분실 내역</a>
          </div>
        </div>
      </li>
      <hr class="sidebar-divider">

      Heading
      <div class="sidebar-heading">
           SPOT 관리
      </div>
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa-folder"></i>
          <span>SPOT</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">SPOT</h6>
            <a class="collapse-item" href="#">SPOT리스트</a>
            <a class="collapse-item" href="#">SPOT생성</a>
          </div>
        </div>
      </li>
      <hr class="sidebar-divider">

      Heading
      <div class="sidebar-heading">
           챗봇 관리
      </div>
      <li class="nav-item">
        <a class="nav-link" href="https://desk.channel.io/#/channels/26438/user_chats/5efaa02f4f8c7e541dda" target="_blank">
          <i class="fas fa-fw fa-cog"></i>
          <span>챗봇</span></a>
      </li>
      Divider
      <hr class="sidebar-divider d-none d-md-block">

      Sidebar Toggler (Sidebar)
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    End of Sidebar

    Content Wrapper
    <div id="content-wrapper" class="d-flex flex-column">

      Main Content
      <div id="content">

        Topbar
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          Sidebar Toggle (Topbar)
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>
          
          <div style="margin-left:350px;">
             <a href="#"><img src="/resources/imgs/bluelogo.png" style="width:280px; height:80px;"></a>
          </div>

          Topbar Search
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          Topbar Navbar
          <ul class="navbar-nav ml-auto">

            Nav Item - Search Dropdown (Visible Only XS)
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              Dropdown - Messages
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

            Nav Item - Alerts
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                Counter - Alerts
                <span id="alarmss" class="badge badge-danger badge-counter danger"></span>
              </a>
              Dropdown - Alerts
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
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">도서 분실 신고</span>
                    <span id="lostAlarm" class="badge badge-danger badge-counter danger"></span>
                  </div>
                </a>
                <a if="complainAlarmClick" class="dropdown-item d-flex align-items-center" href="#">
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
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div>
            </li>

            Nav Item - Messages
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                Counter - Messages
                <span class="badge badge-danger badge-counter">7</span>
              </a>
              Dropdown - Messages
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler · 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog · 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            Nav Item - User Information
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>
                <img class="img-profile rounded-circle" src="/resources/imgs/bluelogo.png">
              </a>
              Dropdown - User Information
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                     비밀번호 변경
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>
          </ul>
        </nav>
        End of Topbar -->
<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>
	<body id="page-top">
        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <!-- <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"></h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          </div> -->

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">누적 도서 대여량</div>
                      <div id="monthlyRentBooks" class="h5 mb-0 font-weight-bold text-gray-800">&nbsp;&nbsp;${sumRentBooks }</div>
                    </div>
                    <div class="col-auto">
                      <img style="width:40px; height:40px; opacity:0.2;" src="/resources/imgs/bookicon.png">
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">월 평균 도서 대여량</div>
                      <div id="anuualRentBooks" class="h5 mb-0 font-weight-bold text-gray-800">&nbsp;&nbsp;${monthlyRentBooks }</div>
                    </div>
                    <div class="col-auto">
                      <!-- <i class="fas fa-dollar-sign fa-2x text-gray-300"></i> -->
                      <img style="width:40px; height:40px; opacity:0.3;" src="/resources/imgs/books.png">
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">미처리 대여 신청 건 수</div>
                        <div class="col-auto">
                          <div class="h5 mb-0 font-weight-bold text-gray-800">${requestRentBooks }</div>
                        </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">미처리 반납 신청 건 수</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">&nbsp;&nbsp;${requestReturnBooks }</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">월별 대여량</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header"><!-- Dropdown Header: --></div>
<!--                       <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a> -->
                      <div class="dropdown-divider"></div>
<!--                       <a class="dropdown-item" href="#">Something else here</a> -->
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart"></canvas>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pie Chart -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">장르별 대여 비율</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
<!--                       <div class="dropdown-header">Dropdown Header:</div>
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Something else here</a> -->
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <div class="chart-pie pt-4 pb-2">
                    <canvas id="myPieChart"></canvas>
                  </div>
                  <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i id="bookCategoryI1" class="fas fa-circle text-primary"></i>
                    </span>
                    <span class="mr-2">
                      <i id="bookCategoryI2" class="fas fa-circle text-success"></i>
                    </span>
                    <span class="mr-2">
                      <i id="bookCategoryI3" class="fas fa-circle text-info"></i>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->
         <%-- <div class="row">

            <!-- Content Column -->
            <div class="col-lg-6 mb-4">

              <!-- Project Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Summary</h6>
                	<h4 style="position : absolute; right:61px; top:20px;" class="m-0 small font-weight-bold text-secondary">도서 총 권수 : </h4>
                	<h4 style="position : absolute; right:30px; top:20px;" class="m-0 small font-weight-bold text-secondary">${sumBooks }</h4>
                </div>
                <div class="card-body">
                  <h4 class="small font-weight-bold">도서 대여율 <span id="rentSpan" class="float-right"></span></h4>
                  <div class="progress">
                    <div id="rentDiv" class="progress-bar bg-success" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                  <h4 class="small font-weight-bold">도서 분실율 <span id="lostSpan" class="float-right"></span></h4>
                  <div class="progress mb-4">
                    <div id="lostDiv" class="progress-bar bg-danger" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
              </div>

              Color System
              <div class="row">
                <div class="col-lg-6 mb-4">
                  <div class="card bg-primary text-white shadow">
                    <div class="card-body">
                      Primary
                      <div class="text-white-50 small">#4e73df</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-success text-white shadow">
                    <div class="card-body">
                      Success
                      <div class="text-white-50 small">#1cc88a</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-info text-white shadow">
                    <div class="card-body">
                      Info
                      <div class="text-white-50 small">#36b9cc</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-warning text-white shadow">
                    <div class="card-body">
                      Warning
                      <div class="text-white-50 small">#f6c23e</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-danger text-white shadow">
                    <div class="card-body">
                      Danger
                      <div class="text-white-50 small">#e74a3b</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-secondary text-white shadow">
                    <div class="card-body">
                      Secondary
                      <div class="text-white-50 small">#858796</div>
                    </div>
                  </div>
                </div>
              </div>

            </div>

 
            <div class="col-lg-6 mb-4" style="height : 50px;">
 
              Illustrations
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
                </div>
                <div class="card-body">
                  <div class="text-center">
                    <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="img/undraw_posting_photo.svg" alt="">
                  </div>
                  <p>Add some quality, svg illustrations to your project courtesy of <a target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a constantly updated collection of beautiful svg images that you can use completely free and without attribution!</p>
                  <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on unDraw &rarr;</a>
                </div>
              </div>

 
              Approach
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Development Approach</h6>
                </div>
                <div class="card-body">
                  <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce CSS bloat and poor page performance. Custom CSS classes are used to create custom components and custom utility classes.</p>
                  <p class="mb-0">Before working with this theme, you should become familiar with the Bootstrap framework, especially the utility classes.</p>
                </div> 
              </div>

            </div>
          </div> --%>

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
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  
  <script src="/resources/adminBootstrap/vendor/jquery/jquery.min.js" ></script>
  <script src="/resources/adminBootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  

  <!-- Core plugin JavaScript-->
  <script src="/resources/adminBootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/adminBootstrap/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="/resources/adminBootstrap/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/resources/adminBootstrap/js/demo/chart-area-demo.js"></script>
  <script src="/resources/adminBootstrap/js/demo/chart-pie-demo.js"></script>
 
</body>

<script>

	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';
	
	function number_format(number, decimals, dec_point, thousands_sep) {
	  // *     example: number_format(1234.56, 2, ',', ' ');
	  // *     return: '1 234,56'
	  number = (number + '').replace(',', '').replace(' ', '');
	  var n = !isFinite(+number) ? 0 : +number,
	    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
	    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
	    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
	    s = '',
	    toFixedFix = function(n, prec) {
	      var k = Math.pow(10, prec);
	      return '' + Math.round(n * k) / k;
	    };
	  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
	  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	  if (s[0].length > 3) {
	    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	  }
	  if ((s[1] || '').length < prec) {
	    s[1] = s[1] || '';
	    s[1] += new Array(prec - s[1].length + 1).join('0');
	  }
	  return s.join(dec);
	}
	
	// Area Chart Example

	var rentDateCountList = ${rentDateCountList};
 	var rentDateCountListSize = Object.keys(rentDateCountList).length; 
 	console.log(rentDateCountListSize);
	if(rentDateCountListSize > 12) {
		for(var i=0; i<12; i++) {
			rentDateCountList[i] = rentDateCountList[rentDateCountListSize-12+i];
		}
	}
	
	var lostBooksData = ${lostBooks};
	var nowRentBooksData = ${nowRentBooks};
	var sumBooksData = ${sumBooks};
	var lostBooks = ((lostBooksData/sumBooksData)*100).toFixed(2);
	var rentBooks = ((nowRentBooksData/sumBooksData)*100).toFixed(2);
	var lostBooksLetter = lostBooks+"%";
	var rentBooksLetter = rentBooks+"%";
	console.log(lostBooks);
	console.log(rentBooks);

	console.log(lostBooksLetter);
	console.log(rentBooksLetter);
	$("#rentSpan").html(rentBooksLetter);	
	$("#lostSpan").html(lostBooksLetter);
 	$("#rentDiv").attr("width", rentBooksLetter);
	$("#lostDiv").attr("width", "30");
	

	var ctx = document.getElementById("myAreaChart");
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
	    labels: 
			[rentDateCountList[0]["rentDate"], rentDateCountList[1]["rentDate"],
	    		rentDateCountList[2]["rentDate"], rentDateCountList[3]["rentDate"],
	    		rentDateCountList[4]["rentDate"], rentDateCountList[5]["rentDate"], 
	    		rentDateCountList[6]["rentDate"], rentDateCountList[7]["rentDate"], 
	    		rentDateCountList[8]["rentDate"], rentDateCountList[9]["rentDate"], 
	    		rentDateCountList[10]["rentDate"], rentDateCountList[11]["rentDate"]]
		,datasets: [{
	      label: "대여 권수",
	      lineTension: 0.3,
	      backgroundColor: "rgba(78, 115, 223, 0.05)",
	      borderColor: "rgba(78, 115, 223, 1)",
	      pointRadius: 3,
	      pointBackgroundColor: "rgba(78, 115, 223, 1)",
	      pointBorderColor: "rgba(78, 115, 223, 1)",
	      pointHoverRadius: 3,
	      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
	      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
	      pointHitRadius: 10,
	      pointBorderWidth: 2,
	      data: [rentDateCountList[0]["cnt"], rentDateCountList[1]["cnt"], 
	    	  rentDateCountList[2]["cnt"], rentDateCountList[3]["cnt"], 
	    	  rentDateCountList[4]["cnt"], rentDateCountList[5]["cnt"], 
	    	  rentDateCountList[6]["cnt"], rentDateCountList[7]["cnt"], 
	    	  rentDateCountList[8]["cnt"], rentDateCountList[9]["cnt"], 
	    	  rentDateCountList[10]["cnt"]], //, rentDateCountList[11]["cnt"]
	    }],
	  },
	  options: {
	    maintainAspectRatio: false,
	    layout: {
	      padding: {
	        left: 10,
	        right: 25,
	        top: 25,
	        bottom: 0
	      }
	    },
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'date'
	        },
	        gridLines: {
	          display: false,
	          drawBorder: false
	        },
	        ticks: {
	          maxTicksLimit: 7
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          maxTicksLimit: 5,
	          padding: 10,
	          // Include a dollar sign in the ticks
	          callback: function(value, index, values) {
	            return number_format(value)+'권';
	          }
	        },
	        gridLines: {
	          color: "rgb(234, 236, 244)",
	          zeroLineColor: "rgb(234, 236, 244)",
	          drawBorder: false,
	          borderDash: [2],
	          zeroLineBorderDash: [2]
	        }
	      }],
	    },
	    legend: {
	      display: false
	    },
	    tooltips: {
	      backgroundColor: "rgb(255,255,255)",
	      bodyFontColor: "#858796",
	      titleMarginBottom: 10,
	      titleFontColor: '#6e707e',
	      titleFontSize: 14,
	      borderColor: '#dddfeb',
	      borderWidth: 1,
	      xPadding: 15,
	      yPadding: 15,
	      displayColors: false,
	      intersect: false,
	      mode: 'index',
	      caretPadding: 10,
	      callbacks: {
	        label: function(tooltipItem, chart) {
	          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	          return datasetLabel + " : " + number_format(tooltipItem.yLabel);
	        }
	      }
	    }
	  }
	});
	
	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';

	// Pie Chart Example
	var ctx = document.getElementById("myPieChart");
	var rentAndCountList = ${rentAndCountList};
 	var rentAndCountListLength = ${rentAndCountList}.length; 
	/* var rentAndCountListLength = 12; */

	var extra = 0;
 	$("#bookCategoryI1").html(rentAndCountList[0]["bookCategory"]);
	$("#bookCategoryI2").html(rentAndCountList[1]["bookCategory"]);
	$("#bookCategoryI3").html(rentAndCountList[2]["bookCategory"]);
	
	for(var i=3; i<rentAndCountListLength; i++) {
		extra += rentAndCountList[i]["cnt"];
	}
	
	
	var myPieChart = new Chart(ctx, {
	  type: 'doughnut',
	  data: {
	    labels: [rentAndCountList[0]["bookCategory"], rentAndCountList[1]["bookCategory"],
	    		rentAndCountList[2]["bookCategory"], "그 외"],
	    datasets: [{
	      data: [rentAndCountList[0]["cnt"], rentAndCountList[1]["cnt"],
	    	  rentAndCountList[2]["cnt"], 20],
	      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
	      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
	      hoverBorderColor: "rgba(234, 236, 244, 1)",
	    }],
	  },
	  options: {
	    maintainAspectRatio: false,
	    tooltips: {
	      backgroundColor: "rgb(255,255,255)",
	      bodyFontColor: "#858796",
	      borderColor: '#dddfeb',
	      borderWidth: 1,
	      xPadding: 15,
	      yPadding: 15,
	      displayColors: false,
	      caretPadding: 10,
	    },
	    legend: {
	      display: false
	    },
	    cutoutPercentage: 80,
	  },
	});
	
</script>

</html>