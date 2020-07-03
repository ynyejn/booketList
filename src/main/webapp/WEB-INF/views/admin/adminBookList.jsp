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

<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>

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
		
		$(".searchList").click(function(){
			var searchSelect = $(this).html();
			$("#searchTitle").html("");
			$("#searchTitle").html(searchSelect); 
		});
		
		$('#myTab').children('a').click(function(e) {
			e.preventDefault()
			$(this).tab('show')
		});
		$("#back").click(function() {
			location.href = "/adminPage.do";
		});
	    $("#sear").click(function() {
			var search = $("#search").val();
			var searchTitle = $("#searchTitle").html();
			alert(searchTitle);
			location.href = "/adminBookList.do?reqPage="+${reqPage }+"&check="+${check }+"&reqPage2="+${reqPage2 }+"&search="+search+"&searchTitle="+$("#searchTitle").html();
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
		
		$("#selDelete").click(function(){
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
				html += "<tr><th colspan='2'>" + data.bookName + "</th><tr>"
				html += "<tr><th><img src='"+data.bookImg+"'></th>";
				html += "<th>";
				html += "<span>- 작가 : " + data.bookWriter + "</span><br>";
				html += "<span>- 출판사 : " + data.bookPublisher + "</span><br>";
				html += "<span>- 장르 : " + data.bookCategory + "</span><br>";
				html += "<span>- 출판일 : " + data.bookPubDate + "</span><br>";
				html += "</th></tr>";
				if (data.bookContent == null) {
					html += "<tr><th colspan='2'></th><tr>"
				} else {
					html += "<tr><th colspan='2'>" + data.bookContent+ "</th><tr>";
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
				html += "<tr><th colspan='2'>"+data.bookName+"</th><tr>"
				html += "<tr><th><img src='"+data.bookImg+"'></th>";
				html += "<th>";
				html += "<span>- 작가 : "+data.bookWriter+"</span><br>";
				html += "<span>- 출판사 : "+data.bookPublisher+"</span><br>";
				html += "<span>- 장르 : "+data.bookCategory+"</span><br>";
				html += "<span>- 출판일 : "+data.bookPubDate+"</span><br>";
				html += "</th></tr>";
				if(data.bookContent==null){
					html += "<tr><th colspan='2'></th><tr>"
				}else{
					html += "<tr><th colspan='2'>"+data.bookContent+"</th><tr>";
				}
				
				html += "<tr><th colspan='2'><span><신청사유></span><br>";
				html += data.applyContent+"</th><tr>";
				
				
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
		
		if(confirm("도서를 등록 하시겠습니까?")){
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
		
		if(confirm("도서를 반려 하시겠습니까?")){
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
</script>

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-book"></i>
				</div>
				<div class="sidebar-brand-text mx-3">BooketList</div>
			</a>
			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="index.html"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>관리자
						페이지</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">회원 관리</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="/memberList.do">
					<i class="fas fa-fw fa-table"></i> <span>회원 목록</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-fw fa-cog"></i> <span>회원 신고 관리</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">도서 관리</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>도서 대여</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">도서 대여</h6>
						<a class="collapse-item" href="#">도서대여현황</a> <a
							class="collapse-item" href="#">도서예약내역</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#bookcollapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>도서 내역</span>
			</a>
				<div id="bookcollapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">도서 내역</h6>
						<a class="collapse-item" href="/adminBookList.do?">도서내역</a> <a
							class="collapse-item" href="#">도서신청내역</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-fw fa-cog"></i> <span>도서 분실 신고</span></a></li>
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">SPOT 관리</div>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i
					class="fas fa-fw fa-folder"></i> <span>SPOT</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">SPOT</h6>
						<a class="collapse-item" href="#">SPOT리스트</a> <a
							class="collapse-item" href="#">SPOT생성</a>
					</div>
				</div></li>
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">챗봇 관리</div>
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-fw fa-cog"></i> <span>챗봇</span></a></li>
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
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<div style="margin-left: 350px;">
						<a href="#"><img src="/resources/imgs/bluelogo.png"
							style="width: 280px; height: 80px;"></a>
					</div>

					<!-- Topbar Search -->
					<!--           <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"> -->
					<!--             <div class="input-group"> -->
					<!--               <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2"> -->
					<!--               <div class="input-group-append"> -->
					<!--                 <button class="btn btn-primary" type="button"> -->
					<!--                   <i class="fas fa-search fa-sm"></i> -->
					<!--                 </button> -->
					<!--               </div> -->
					<!--             </div> -->
					<!--           </form> -->

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>

						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
								<span class="badge badge-danger badge-counter">3</span>
						</a> <!-- Dropdown - Alerts -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="alertsDropdown">
								<h6 class="dropdown-header">Alerts Center</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-primary">
											<i class="fas fa-file-alt text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 12, 2019</div>
										<span class="font-weight-bold">A new monthly report is
											ready to download!</span>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-success">
											<i class="fas fa-donate text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 7, 2019</div>
										$290.29 has been deposited into your account!
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-warning">
											<i class="fas fa-exclamation-triangle text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 2, 2019</div>
										Spending Alert: We've noticed unusually high spending for your
										account.
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">Show All Alerts</a>
							</div></li>

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
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">Admin</span>
								<img class="img-profile rounded-circle"
								src="/resources/imgs/bluelogo.png">
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 비밀번호 변경
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>
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
											aria-controls="home" aria-expanded="true"><b>도서 내역</b></a></li>
										<li id="tt2" role="presentation" class=""><a
											href="#profile" role="tab" id="profile-tab" data-toggle="tab"
											aria-controls="profile" aria-expanded="false"><b>도서신청내역</b></a></li>
									</ul>
									<!-- 도서내역 리스트 받아올 때 -->
									<div id="myTabContent" class="tab-content">
										<div role="tabpanel" class="tab-pane fade active in" id="home"
											aria-labelledby="home-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<th class="width1"><input type="checkbox" id="ck_all"></th>
														<th class="width2">도서이름</th>
														<th class="width3">작가</th>
														<th class="width4">출판사</th>
														<th class="width5">장르</th>
														<th class="width6">출판일</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list1 }" var="p" varStatus="i">
														<tr class="move"
															onclick="detail('${p.bookNo }','${reqPage }')"
															data-toggle="modal" data-target="#myModal">
															<th class="width1"><input type="checkbox"
																class="checkRow" value="${p.bookNo }"></th>
															<td class="width2">${p.bookName }</td>
															<td class="width3">${p.bookWriter }</td>
															<td class="width4">${p.bookPublisher }</td>
															<td class="width5">${p.bookCategory }</td>
															<td class="width6">${p.bookPubDate }</td>
														</tr>
													</c:forEach>

												</tbody>
											</table>
											<nav id="footNav2">
												<ul class="pagination">${pageNavi1 }</ul>
											</nav>
											<div id="sel">
												<button type="button" class="btn btn-default" id="selDelete">선택삭제</button>
												<button type="button" class="btn btn-default"
													id="insertBook" data-toggle="modal" data-target="#myModal2">도서등록</button>
											</div>

										</div>

										<!-- 도서신청내역 리스트 받아올 때 -->
										<div role="tabpanel" class="tab-pane fade" id="profile"
											aria-labelledby="profile-tab">
											<table class="table table-hover">
												<thead>
													<tr>
														<th class="width1">번호</th>
														<th class="width3">신청자</th>
														<th class="width2">제목</th>
														<th class="width3">작가</th>
														<th class="width5">등록일</th>
														<th class="width5">처리상태</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list2 }" var="p" varStatus="i">
														<tr class="move" id="move2"
															onclick="detail2(${p.applyNo },${reqPage2 })" data-toggle="modal" data-target="#myModal3">
															<th scope="row">${(reqPage2-1)*10 + i.count }</th>
															<td class="width1">${p.memberId }</td>
															<td class="width2">${p.bookName }</td>
															<td class="width3">${p.bookWriter }</td>
															<td class="width5">${p.applyDate }</td>
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
											<nav id="footNav2">
												<ul class="pagination">${pageNavi2 }</ul>
											</nav>
										</div>



									</div>
								</div>

								<!-- 책 상세보기 모달 -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
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
								<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
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
													id="detailUpdate1" onclick="updateBookList1(this)">도서 등록</button>
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
											<div class="modal-body" style="height: 500px">
												<input type="text" id="searchcontent">
												<button class="searchAl">검색</button>

												<table class="addBookList">
													<tr>
														<th class="width1">이미지</th>
														<th class="width1">도서이름</th>
														<th class="width3">출판일</th>
														<th class="width4">작가</th>
														<th class="width5">출판사</th>
														<th class="width6">카테 고리</th>
														<th class="width1">도서내용</th>
														<th class="width1">선택</th>
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

								<!-- 검색 메뉴 드롭다운 -->
								<div class="col-lg-6">
									<div class="input-group">
										<div class="input-group-btn">
											<button id="searchTitle"
												class="btn btn-default dropdown-toggle" type="button"
												data-toggle="dropdown" aria-expanded="false">
												<c:if test="${empty searchTitle }">도서이름</c:if>
												<c:if test="${not empty searchTitle }">${searchTitle }</c:if>
											</button>
											<ul class="dropdown-menu" role="menu">
												<li><a class="searchList">도서이름</a></li>
												<li><a class="searchList">작가</a></li>
												<li><a class="searchList">출판사</a></li>
												<li><a class="searchList">장르</a></li>
											</ul>
										</div>
									</div>
								</div>
								
								<!-- 검색창, 검색모양 -->
								<c:if test="${not empty search }">
									<input type="text" class="form-control" aria-label="..."
										id="search" value="${search }" style="witdh: 300px">
									<span class="glyphicon glyphicon-search" id="sear"></span>
								</c:if>
								<c:if test="${empty search }">
									<input type="text" class="form-control " aria-label="..."
										id="search">
									<span class="glyphicon glyphicon-search" id="sear"></span>
								</c:if>

								<!-- /.col-lg-6 -->

								<button type="button" class="btn btn-default" id="back">돌아가기</button>

<script type="text/javascript">
   //function setParentText(){
       // opener.document.getElementById("bookName").innerHTML = document.getElementsByClassName(".bookName").innerHTML;
       // console.log(document.getElementsByClassName(".bookName").innerHTML+"dd");
   //}
   var apply = "";
      $(function() {
         $(".searchAl").click(function() {
            var title = $("#searchcontent").val();
            
            $.ajax({
               url : "/aladdin.do",
               data : { title:title },
               success : function(data){
            	  console.log(data);
            	  $(".addBookList>tbody").children(".apply").remove();
                  html="";
                  for(var i=0;i<data.length;i++){
                     html+="<tr class='apply'><td><input type='hidden' class='bookImg'value='"+data[i].bookImg+"'><img src='"+data[i].bookImg+"'></td>";
                     html+="<td class='bookName'>"+data[i].bookName+"</td>";
                     html+="<td class='bookPubDate'>"+data[i].bookPubDate+"</td>";
                     html+="<td class='bookWriter'>"+data[i].bookWriter+"</td>";
                     html+="<td class='bookPublisher'>"+data[i].bookPublisher+"</td>";
                     html+="<td class='bookCategory'>"+data[i].bookCategory+"</td>";
                     if(data[i].bookContent==""){
                        html+="<td class='bookContent'>내용 없음</td>";
                     }else{
                        html+="<td class='bookContent'>"+data[i].bookContent+"</td>";
                     }
                     if(data[i].selectCheck==0){
                        html+="<td><a href='javascript:void(0)' class ='reqBook' onclick='window.close()'>신청하기</a></td></tr>";
                     }else{
                        html+="<td>이미 책이 있습니다.</td></tr>";
                     }
                     
                     
                  }
                  $(".addBookList>tbody").append(html);
                  
                  $(".reqBook").click(function () {
                	  var checkArr = new Array();
                	  checkArr.push($(this).parent().parent().find(".bookName").html());
                	  checkArr.push($(this).parent().parent().find(".bookWriter").html());
                	  checkArr.push($(this).parent().parent().find(".bookPublisher").html());
                	  checkArr.push($(this).parent().parent().find(".bookCategory").html());
                	  checkArr.push($(this).parent().parent().find(".bookImg").val());
                	  var bookPubDate = $(this).parent().parent().find(".bookPubDate").html();
                	  var array = bookPubDate.split(",");
                      var aa = array[0].split("월 ");
                      var apply = array[1]+"-"+aa[0]+"-"+aa[1]; 
                      
                      alert(apply);

                	  checkArr.push(apply);
                	  checkArr.push($(this).parent().parent().find(".bookContent").html());
                	  
                	  
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
         })
      })
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