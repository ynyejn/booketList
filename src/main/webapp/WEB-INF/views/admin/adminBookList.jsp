<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en" style="font-size: 18px">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>도서 관리페이지</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.js"></script>
<!-- Custom fonts for this template-->
<link
	href="/resources/adminBootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<link rel="stylesheet"
	href="/resources/adminBootstrap/css/bootstrap.css" />

<!-- Custom styles for this template-->

<link href="/resources/adminBootstrap/css/sb-admin-2.min.css" rel="stylesheet" type="text/css"/>


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
		
		if(check == '2'){			
			$('#tt2').addClass("active");
			$('#tt1').removeClass("active");
			$('#profile').addClass("active in");
			$('#home').removeClass("active in");
		}else{
			$('#tt1').addClass("active");
			$('#tt2').removeClass("active");
			$('#home').addClass("active in");
			$('#profile').removeClass("active in");
		}
		
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
			location.href = "/adminBookList.do?reqPage="+${reqPage }+"&check="+${check }+"&reqPage2="+${reqPage2 }+"&search="+search+"&searchTitle="+searchTitle;
		}); 
		$("#search").keydown(function(key){
			if(key.keyCode == 13){
				$("#sear").click();	
			}
		});
		
		$("#ck_all").click(function(){
			if($("#ck_all").prop("checked")){
				$("input[type=checkbox]").prop("checked",true);
			}else{
				$("input[type=checkbox]").prop("checked",false);
			}
		});
		
		$(".checkRow").click(function(event){
			event.stopPropagation();
		});
		
		$("#selDelete").click(function(){
			
			if($(".checkRow").is(":checked")== false){
				alert("도서를 선택해주세요");
				return false;
			}
				
				
			
			if(confirm("선택 도서를 삭제 하시겠습니까?")){
				var checkArr = new Array();
				var reqPages = ${reqPage };
				
				$(".checkRow:checked").each(function(){
					
					
					checkArr.push($(this).val());
				});
					
					$.ajax({
						url : "/deleteBookList.do",
						type : "get",
						traditional : true,
						data : {chBox : checkArr, reqPage : reqPages},
						success : function(result){
							console.log(result);
							if(result > 0){
								alert("삭제가 완료되었습니다.");
								location.href = "/adminBookList.do?reqPage="+${reqPage }+"&check=1&reqPage2=1";
							}else{
								alert("삭제가 실패 하였습니다.");
							}
						}
						
					});
			}else{
				return false;
			}
		});
		
	});
	 
	function detail(no){
		$("#delNo").val(no);
		$.ajax({
			url : "/selectOneBookList.do",
			type : "get",
			data : {bookNo : no},
			success : function(data) {
				$("#bookin").children("table").children().remove();
				html = "";
				html += "<tr><td style='width:130px;height:170px;'><img src='"+data.bookImg+"' style='width:120px;height:160px;'></td>";
				html += "<td style='line-height: 30px;'><span style='font-weight:bold;color:#0066b3'>"+data.bookName+"</span>";
				html += "<ul style='padding-left:15px;'><li style='font-size:12px;text-align:left;'>작가 : " + data.bookWriter + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>출판사 : " + data.bookPublisher + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>장르 : " + data.bookCategory + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>출판일 : " + data.bookPubDate + "</li>";
				html += "</td></tr>";
				if (data.bookContent == null) {
					html += "<tr><td colspan='2' style='height:200px;'>내용없음</td><tr>"
				} else {
					html += "<tr><td colspan='2' style='height:200px;'>" + data.bookContent+ "</td><tr>";
				}

				$("#bookin").children("table").append(html);

			},
			error : function() {
				console.log("ajax통신 실패");
			}
		});
	}
	
	function detail2(no){
		$("#selectApply").val(no);
		$.ajax({
			url : "/selectOneApplyList.do",
			type : "get",
			data : {applyNo : no},
			success:function(data){
				$("#Applyin").children("table").children().remove(); 
				html = "";
				html += "<tr><td style='width:130px;height:170px;'><img src='"+data.bookImg+"' style='width:120px;height:160px;'></td>";
				html += "<td style='line-height: 30px;'><span style='font-weight:bold;color:#0066b3'>"+data.bookName+"</span>";
				html += "<ul style='padding-left:15px;'><li style='font-size:12px;text-align:left;'>작가 : " + data.bookWriter + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>출판사 : " + data.bookPublisher + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>장르 : " + data.bookCategory + "</li>";
				html += "<li style='font-size:12px;text-align:left;'>출판일 : " + data.bookPubDate + "</li>";
				html += "</td></tr>";
				if (data.bookContent == null) {
					html += "<tr><td colspan='2' style='height:200px;'>내용없음</td><tr>"
				} else {
					html += "<tr><td colspan='2' style='height:200px;'>" + data.bookContent+ "</td><tr>";
				}
				
			
				
				$("#detailUpdate1").hide();
				$("#detailUpdate2").hide();
				if(data.applyStatus == 1){
					$("#detailUpdate2").show();
				}else if(data.applyStatus == 2){
					$("#detailUpdate1").show();
				}else{
					$("#detailUpdate1").show();
					$("#detailUpdate2").show();
				}
				
				$("#Applyin").children("table").append(html);
				
			},
			error:function(){
				console.log("ajax통신 실패");
			}
		});
	}
	
	
	function deleteBookList(no){
		no = $("#delNo").val();
		var reqPages = ${reqPage }
		
		if(confirm("선택 도서를 삭제 하시겠습니까?")){
			$.ajax({
				url : "/detailOneBookDelete.do",
				type : "get",
				traditional : true,
				data : {bookNo : no, reqPage : reqPages},
				success : function(result){

					if(result > 0){
						alert("삭제가 완료되었습니다.");
						location.href = "/adminBookList.do?reqPage="+${reqPage }+"&check=1&reqPage2=1";
					}else{
						alert("삭제가 실패 하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	}
	
	 function updateBookList1(no){
		no = $("#selectApply").val();
		var reqPages2 = ${reqPage2 }
		
		if(confirm("도서등록을 하셨습니까?")){
			$.ajax({
				url : "/detailOneApplyYes.do",
				type : "get",
				traditional : true,
				data : {applyNo : no, reqPage2 : reqPages2},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminBookList.do?reqPage2="+${reqPage2 }+"&check=2&reqPage=1";
					}else{
						alert("처리가 실패하였습니다.");
					}
				}
				
			});
		}else{
			
		}
	} 
	
	function updateBookList2(no){
		no = $("#selectApply").val();
		var reqPages2 = ${reqPage2 }
		
		if(confirm("도서등록을 하셨다면 삭제를 하셨습니까?")){
			$.ajax({
				url : "/detailOneApplyNo.do",
				type : "get",
				traditional : true,
				data : {applyNo : no, reqPage2 : reqPages2},
				success : function(result){

					if(result > 0){
						alert("처리가 완료되었습니다.");
						location.href = "/adminBookList.do?reqPage2="+${reqPage2 }+"&check=2&reqPage=1";
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
					<h1 class="h3 mb-2 text-gray-800">도서 목록</h1>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary"></h6>
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
											aria-controls="home" aria-expanded="true"><b>도서 내역</b></a></li>
										<li id="tt2" role="presentation" class=""><a
											href="#profile" role="tab" id="profile-tab" data-toggle="tab"
											aria-controls="profile" aria-expanded="false"><b>도서신청내역</b></a></li>
										<li id="searchbar">
											<div class="col-lg-6">
												<div class="input-group" style="width: 350px;">
													<div class="input-group-btn">

														<select class="form-control"
															style="width: 120px; height: 35px; margin-left: 10px;"
															id="searchTitle" name="selectColumn">
															<c:if test="${empty searchTitle }">
																<option value="도서이름" selected>도서이름</option>
																<option value="작가">작가</option>
																<option value="출판사">출판사</option>
																<option value="장르">장르</option>
															</c:if>
															<c:if test="${not empty searchTitle }">
																<option value="도서이름"
																	<c:if test="${searchTitle eq '도서이름' }">selected</c:if>>도서이름</option>
																<option value="작가"
																	<c:if test="${searchTitle eq '작가' }">selected</c:if>>작가</option>
																<option value="출판사"
																	<c:if test="${searchTitle eq '출판사' }">selected</c:if>>출판사</option>
																<option value="장르"
																	<c:if test="${searchTitle eq '장르' }">selected</c:if>>장르</option>
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
										<!-- 검색 메뉴 드롭다운 -->
									</ul>
									<!-- 도서내역 리스트 받아올 때 -->
									<div id="myTabContent" class="tab-content">
										<div role="tabpanel" class="tab-pane fade active in" id="home"
											aria-labelledby="home-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<td class="width1"><input type="checkbox" id="ck_all"></td>
														<td></td>
														<td style="float: right;"><button type="button"
																class="btn btn-default" id="insertBook"
																data-toggle="modal" data-target="#myModal2">도서등록</button></td>
														<!-- <th class="width4">출판사</th>
														<th class="width5">장르</th>
														<th class="width6">출판일</th> -->
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list1 }" var="p" varStatus="i">
														<tr class="move"
															onclick="detail('${p.bookNo }','${reqPage }')"
															data-toggle="modal" data-target="#myModal">
															<td class="width1"><input type="checkbox"
																class="checkRow" value="${p.bookNo }"></td>
															<td class="width2"><img src="${p.bookImg }"
																style="width: 110px; height: 160px;"></td>
															<td class="width3" style="text-align: left;"><span
																style="font-weight: bold; color: #0066b3">${p.bookName }</span>
																<ul style="padding-left: 15px;">
																	<li style="font-size: 12px; text-align: left;">작가
																		: ${p.bookWriter }</li>
																	<li style="font-size: 12px; text-align: left">출판사
																		: ${p.bookPublisher }</li>
																	<li style="font-size: 12px; text-align: left">장르 :
																		${p.bookCategory }</li>
																	<li style="font-size: 12px; text-align: left">출판일
																		: ${p.bookPubDate }</li>
																</ul></td>
														</tr>
													</c:forEach>

												</tbody>
											</table>
											<nav id="footNav2" style="text-align: center;">
												<div style="margin-top: 20px; float: left;">
													<button type="button" class="btn btn-default"
														id="selDelete">선택삭제</button>

												</div>
												<div id="sel" style="float: right; margin-top: 20px;">
													<button type="button" class="btn btn-default" id="back">돌아가기</button>
												</div>
												<ul class="pagination">${pageNavi1 }</ul>
											</nav>


										</div>

										<!-- 도서신청내역 리스트 받아올 때 -->
										<div role="tabpanel" class="tab-pane fade" id="profile"
											aria-labelledby="profile-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<td style="height: 30.4px; line-height: 35px;"
															class="width1"><b>번호</b></td>
														<td style="height: 30.4px; line-height: 35px;"
															class="width1"><b>신청자</b></td>
														<td style="height: 30.4px; line-height: 35px;"
															class="width1"></td>
														<td style="height: 30.4px; line-height: 35px;"
															class="width4"></td>
														<td style="height: 30.4px; line-height: 35px;"
															class="width1"><b>신청날짜</b></td>
														<td style="height: 30.4px; line-height: 35px;"
															class="width1"><b>처리상태</b></td>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list2 }" var="p" varStatus="i">
														<tr class="move" id="move2"
															onclick="detail2(${p.applyNo },${reqPage2 })"
															data-toggle="modal" data-target="#myModal3">
															<td class="width1" scope="row">${(reqPage2-1)*10 + i.count }</td>
															<td class="width1">${p.memberId }</td>
															<td class="width1" style="text-align: left;"><img
																src="${p.bookImg }" style="width: 110px; height: 160px;"></td>
															<td class="width4" style="text-align: left;"><span
																style="font-weight: bold; color: #0066b3">${p.bookName }</span>
																<ul style="padding-left: 15px;">
																	<li style="font-size: 12px; text-align: left;">작가
																		: ${p.bookWriter }</li>
																	<li style="font-size: 12px; text-align: left">출판사
																		: ${p.bookPublisher }</li>
																	<li style="font-size: 12px; text-align: left">장르 :
																		${p.bookCategory }</li>
																	<li style="font-size: 12px; text-align: left">출판일
																		: ${p.bookPubDate }</li>
																</ul></td>
															<td class="width1">${p.applyDate }</td>
															<td><c:if test="${p.applyStatus == 0}">
																처리 대기
															</c:if> <c:if test="${p.applyStatus == 1}">
																신청 완료
															</c:if> <c:if test="${p.applyStatus == 2}">
																반려
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

								<!-- 책 상세보기 모달 -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">도서 상세보기</h4>
											</div>
											<div class="modal-body" id="bookin" style="height: 500px">
												<table class="table table-bordered">
												</table>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">돌아가기</button>
												<input type="hidden" id="delNo">
												<button type="button" class="btn btn-primary"
													id="detailDelete" onclick="deleteBookList(this)">삭제</button>

											</div>
										</div>
									</div>
								</div>


								<!-- 도서신청 상세보기 모달 -->
								<div class="modal fade" id="myModal3" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">도서 상세보기</h4>
											</div>
											<div class="modal-body" id="Applyin" style="height: 500px">
												<table class="table table-bordered">
												</table>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">돌아가기</button>
												<input type="hidden" id="selectApply">
								

												<button type="button" class="btn btn-primary"
													id="detailUpdate1" onclick="updateBookList1(this)">도서
													등록</button>
												<button type="button" class="btn btn-primary"
													id="detailUpdate2" onclick="updateBookList2(this)">반려</button>

											</div>
										</div>
									</div>
								</div>

								<!-- 도서등록 모달 -->
								<div class="modal fade" id="myModal2" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">도서등록</h4>
											</div>
											<div class="modal-body" style="height: 500px;">
												<!-- <input type="text" id="searchcontent">
												<button class="searchAl">검색</button> -->
												<div class="input-group"
													style="text-align: center; width: 100%;">
													<input type="text" class="form-control"
														placeholder="도서제목검색" id="searchcontent">
													<div class="input-group-btn">
														<button class="btn btn-primary searchAl" type="submit">
															<span class="glyphicon glyphicon-search"></span>
														</button>
													</div>
												</div>
												<br> <br> <br>
												<table class="addBookList">
													<tr>

													</tr>
												</table>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal">돌아가기</button>
											</div>
										</div>
									</div>
								</div>



								<!-- /.col-lg-6 -->

								<script type="text/javascript">
   //function setParentText(){
       // opener.document.getElementById("bookName").innerHTML = document.getElementsByClassName(".bookName").innerHTML;
       // console.log(document.getElementsByClassName(".bookName").innerHTML+"dd");
   //}
   var reqPage = 1;
   var start = 1;
   var apply = "";
   var title = "";
      $(function() {
    	  $("#searchcontent").keydown(function(key){
         	 if(key.keyCode == 13){
  				$(".searchAl").click();	
  			}
          });
    	  
         $(".searchAl").click(function() {
            title = $("#searchcontent").val();
            reqPage = 1;
            start = 1;
            $(".addBookList>tbody").children(".apply").remove();
            insertSearchBook(1);
            
         })
      })
      
      function insertSearchBook(reqPage){
    	  
    	  if(reqPage != 1){
    		  start += 10;
    	  }
    	  reqPage += 1;
    	  $(".newPlus").remove();
    	  $.ajax({
              url : "/aladdin.do",
              data : { title:title, start:start },
              success : function(data){
           	  console.log(data);
                 html="";
                 for(var i=0;i<data.length;i++){
                    html+="<tr class='apply'><td style='width:130px;height:170px;'><input type='hidden' class='bookImg' value='"+data[i].bookImg+"'><img src='"+data[i].bookImg+"' style='width:120px;height:160px;'></td>";
                    html+="<td style='line-height: 30px;width:561.6px;'><span class='bookName' style='font-weight:bold;color:#0066b3'>"+data[i].bookName+"</span>";
                    html+="<ul style='padding-left:15px;'>";
                    html+="<li style='font-size:12px;text-align:left;'>작가 : <span class='bookWriter'>"+data[i].bookWriter+"</span></li>";
                    html+="<li style='font-size:12px;text-align:left;'>출판사 : <span class='bookPublisher'>"+data[i].bookPublisher+"</span></li>";
                    html+="<li style='font-size:12px;text-align:left;'>장르 : <span class='bookCategory'>"+data[i].bookCategory+"</span></li>";
                    html+="<li style='font-size:12px;text-align:left;'>출판일 : <span class='bookPubDate'>"+data[i].bookPubDate+"</span></li></ul></td>";
                    html+="<input type='hidden' class='bookContent' value='"+data[i].bookContent+"'>"
                    if(data[i].selectCheck==0){
                       html+="<td><div class='insertBtn' style='width:60px;height:60px;background-color:#0066b3;line-height:60px;border-radius:50%;text-align:center'><a href='javascript:void(0)' class ='reqBook' onclick='window.close()' style='font-size:12px;'>신청하기</a></div></td></tr>";
                    }else{
                       html+="<td><div style='width:60px;height:60px;background-color:#df0000;line-height:60px;border-radius:50%;text-align:center'><span style='font-size:12px;color:white;font-weight:bold'>보유도서</span></td></tr>";
                    }
                 }
                 $(".addBookList>tbody").append(html);
                 
                 $(".addBookList>tbody").append("<tr class='newPlus' colspan='8' onclick='insertSearchBook("+reqPage+")'><th style='text-align:center;cursor:pointer;' colspan='3'><a class='btn btn-default'>더 보기</a></th></tr>");
                 
		
                 $(".reqBook").click(function(){
               	  var checkArr = new Array();
               	  checkArr.push($(this).parent().parent().parent().find(".bookName").html());
               	  checkArr.push($(this).parent().parent().parent().children().find(".bookWriter").html());
               	  checkArr.push($(this).parent().parent().parent().children().find(".bookPublisher").html());
               	  checkArr.push($(this).parent().parent().parent().children().find(".bookCategory").html());
               	  checkArr.push($(this).parent().parent().parent().children().find(".bookImg").val());
               	  var bookPubDate = $(this).parent().parent().parent().children().find(".bookPubDate").html();
               	  
               	  var array = bookPubDate.split(",");
                     var aa = array[0].split("월 ");
                     var apply = array[1]+"-"+aa[0]+"-"+aa[1]; 
                     
					
               	  checkArr.push(apply);
               	  checkArr.push($(this).parent().parent().parent().find(".bookContent").val());
               	  
               	  
               	  if(confirm("선택 도서를 등록 하시겠습니까?")){
         					
         					$.ajax({
         						url : "/insertBookList.do",
         						type : "get",
         						traditional : true,
         						data : {insertContent : checkArr},
         						success : function(result){
         							
         							if(result > 0){
         								alert("도서 등록이 완료되었습니다.");
         								location.href = "/adminBookList.do?reqPage=1&check=1&reqPage2=1";
         							}else{
         								alert("도서가 이미 존재합니다.");
         							}
         						}
         						
         					});
         			}else{
         				return false;
         			}
               	  
                 });
              },
              error : function(){
                 console.log("ajax통신 실패")
              }
           });
      }
</script>
								<!-- /.container-fluid -->

							</div>
							<!-- End of Main Content -->
							<div class="row">

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