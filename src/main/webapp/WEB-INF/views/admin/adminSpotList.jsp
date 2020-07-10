<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
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

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 테이블 부트스트랩 -->
<script>
var result = new Array("false", "false");
var updateResult = new Array("success", "success");
$("#spotAddr").val("");
$("#spotCheckStatus").html("");
$("#updateSpotCheckStatus").html("");
	window.onload = function() {
		console.log("onload");
		var msg = '${msg }';
		if(msg=='1'){
			alert("승인완료 하였습니다.");
		}else if(msg=='2'){
			alert("승인실패 하였습니다.");
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
										url : "/spotSearchList.do",
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
												resultText += "<tr><input type='hidden' id='ajaxReqPage' value="+data.reqPage+">";
												resultText += "<th scope=row class=num><input type=checkbox name=chBox class=chBox data-spotNo="+data.list[i].spotNo+">"
														+ ((data.reqPage - 1)
																* data.selectCount
																+ i + 1)
														+ "</th>";
												resultText += "<td class=th2>"
														+ data.list[i].spotName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].spotAddr
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].localName
														+ "</td>";
												resultText +="<td class='th2'><button type='button' class='btn btn-primary' data-spotNo='"+data.list[i].spotNo+"' onclick='selectOneSpot(this)' data-toggle='modal' data-target='#myModal2'>수정</button>"
												 + "<button class='btn btn-danger' data-spotNo='"+data.list[i].spotNo+"'onclick='deleteSpot(this)'>삭제</button></td></tr>";
											}
											$("#tbody").html(resultText);
											$(".pagination").html(data.pageNavi);
										},
										error : function() {

										}
									});
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
										url : "/spotSearchList.do",
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
												resultText += "<tr><input type='hidden' id='ajaxReqPage' value="+data.reqPage+">";
												resultText += "<th scope=row class=num><input type=checkbox name=chBox class=chBox data-spotNo="+data.list[i].spotNo+">"
														+ ((data.reqPage - 1)
																* data.selectCount
																+ i + 1)
														+ "</th>";
												resultText += "<td class=th2>"
														+ data.list[i].spotName
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].spotAddr
														+ "</td>";
												resultText += "<td class=th2>"
														+ data.list[i].localName
														+ "</td>";
												resultText +="<td class='th2'><button type='button' class='btn btn-primary' data-spotNo='"+data.list[i].spotNo+"' onclick='selectOneSpot(this)' data-toggle='modal' data-target='#myModal2'>수정</button>"
												 + "<button class='btn btn-danger' data-spotNo='"+data.list[i].spotNo+"'onclick='deleteSpot(this)'>삭제</button></td></tr>";
											}
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
				checkArr.push($(this).attr("data-spotNo"));
			});
			if(checkArr!=0){
				location.href="/excelSpotListDown.do?checkArr="+checkArr	
			}else{
				alert("선택해주세요");
			}
		
		});
		$("#excelDownLoadTotal").click(function(){
			console.log("전체엑셀다운로드");
			var part = "spot";
				location.href="/excelDownTotal.do?part="+part;
		});
	
		$("#addrSearch").click(function(){
			new daum.Postcode({
				oncomplete : function(data) {
					$("#spotAddr").val(data.roadAddress);
					result[1] = "success";
					console.log(result);
				},
			}).open();
		});
		$("#spotAddr").change(function(){
			if($(this).val()==''){
				result[1] = "false";
				console.log(result);
			}else{
				result[1] = "success";
				console.log(result);
			}
		});
		$("#spotName").keyup(function(){
			var spotName = $("#spotName").val();
			$.ajax({
				url : "/spotNameChecked.do",
				type : "post",
				data : {
					spotName : spotName
				},
				success : function(data){
					if(data=="1"){
						$("#spotCheckStatus").css("color","red");
						$("#spotCheckStatus").html("스팟이름이 중복입니다.");
						result[0] = "false";
						console.log(result);
					}else{
						$("#spotCheckStatus").css("color","green");
						$("#spotCheckStatus").html("사용할 수 있는 스팟이름입니다.");
						result[0] = "success";
						console.log(result);
						
					}
				},
				error : function(data){	
				}
			});
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
			url : "/spotSearchList.do",
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
					resultText += "<tr><input type='hidden' id='ajaxReqPage' value="+data.reqPage+">";
					resultText += "<th scope=row class=num><input type=checkbox name=chBox class=chBox data-spotNo="+data.list[i].spotNo+">"
							+ ((data.reqPage - 1)
									* data.selectCount
									+ i + 1)
							+ "</th>";
					resultText += "<td class=th2>"
							+ data.list[i].spotName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].spotAddr
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].localName
							+ "</td>";
					resultText +="<td class='th2'><button type='button' class='btn btn-primary' data-spotNo='"+data.list[i].spotNo+"' onclick='selectOneSpot(this)' data-toggle='modal' data-target='#myModal2'>수정</button>"
					 + "<button class='btn btn-danger' data-spotNo='"+data.list[i].spotNo+"'onclick='deleteSpot(this)'>삭제</button></td></tr>";
				}
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
			url : "/spotSearchList.do",
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
					resultText += "<tr><input type='hidden' id='ajaxReqPage' value="+data.reqPage+">";
					resultText += "<th scope=row class=num><input type=checkbox name=chBox class=chBox data-spotNo="+data.list[i].spotNo+">"
							+ ((data.reqPage - 1)
									* data.selectCount
									+ i + 1)
							+ "</th>";
					resultText += "<td class=th2>"
							+ data.list[i].spotName
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].spotAddr
							+ "</td>";
					resultText += "<td class=th2>"
							+ data.list[i].localName
							+ "</td>";
					resultText +="<td class='th2'><button type='button' class='btn btn-primary' data-spotNo='"+data.list[i].spotNo+"' onclick='selectOneSpot(this)' data-toggle='modal' data-target='#myModal2'>수정</button>"
					 + "<button class='btn btn-danger' data-spotNo='"+data.list[i].spotNo+"'onclick='deleteSpot(this)'>삭제</button></td></tr>";
				}
				$("#tbody").html(resultText);
				$(".pagination").html(data.pageNavi);
				
				
				console.log("변경된 대여상태 : "+$("#alignStatus").find("input").val());
				
			},
			error : function(){
				
			}
		});
	}
	
	function check(){
		if(result[0] == "false"){
			return false;
		}else if(result[1] == "false"){
			return false;
		}else{
			return true;
		}
	}
	function updateCheck(){
		if(updateResult[0] == "false"){
			return false;
		}else if(updateResult[1] == "false"){
			return false;
		}else{
			return true;
		}
	}
	function selectOneSpot(obj){
		var spotNo = $(obj).attr("data-spotNo");
		console.log(spotNo);
		$.ajax({
			url : "/selectOneSpot.do",
			type : "post",
			data : {
				spotNo : spotNo
			},
			success : function(data){
			$("#updateModalSpot").children().remove();
			console.log(data.spotAddr);
			
			html = "";
			html += "<input type='hidden' id='updateSpotNo' name='spotNo' value='"+data.spotNo+"'/>";
			html += "<input type='text' id='updateSpotName' onkeyup='updateSpotNameChecked()' name='spotName' style='width: 200px; height: 35px; font-size: 10pt; display: inline-block;' data-spotName='"+data.spotName+"' value='"+data.spotName+"' required/>";
			html += "<input type='text' id='updateSpotAddr' onchange='updateSpotAddrNull()' name='spotAddr' style='width: 200px; height: 35px; font-size: 10pt;'value='"+data.spotAddr+"' readonly='readonly' required='required'/>";
			html += "<button type='button' onclick='updateAddrSearch()' class='btn btn-warning px-3' style='height: 35px;'>주소검색</button>";
			$("#updateModalSpot").append(html);
			},
			error : function(){
				
			}
		});
	}
	function updateAddrSearch(){
		new daum.Postcode({
			oncomplete : function(data) {
				$("#updateSpotAddr").val(data.roadAddress);
				updateResult[1] = "success";
				console.log(updateResult);
			},
		}).open();
	}
	function deleteSpot(obj){
		var spotNo = $(obj).attr("data-spotNo");
		var result = confirm("삭제하시겠습니까?");
		if(result){
			location.href = "/deleteSpot.do?spotNo="+spotNo
		}else{
			
		}
	}
	function updateSpotNameChecked(){
		var dataSpotName = $("#updateSpotName").attr("data-spotName");
		console.log(dataSpotName);
		var spotName = $("#updateSpotName").val();
		$.ajax({
			url : "/updateSpotNameChecked.do",
			type : "post",
			data : {
				spotName : spotName,
				dataSpotName : dataSpotName
			},
			success : function(data){
				if(data=="1"){
					$("#updateSpotCheckStatus").css("color","red");
					$("#updateSpotCheckStatus").html("스팟이름이 중복입니다.");
					updateResult[0] = "false";
					console.log(updateResult);
				}else if(data=="2"){
					$("#updateSpotCheckStatus").css("color","green");
					$("#updateSpotCheckStatus").html("원래 스팟이름입니다.");
					updateResult[0] = "success";
					console.log(updateResult);
				}else{
					$("#updateSpotCheckStatus").css("color","green");
					$("#updateSpotCheckStatus").html("사용할 수 있는 스팟이름입니다.");
					updateResult[0] = "success";
					console.log(updateResult);
					
				}
			},
			error : function(data){	
			}
		});
	}
	function updateSpotAddrNull(){
		if($("#updateSpotAddr").val()==''){
			updateResult[1] = "false";
			console.log(updateResult);
		}else{
			updateResult[1] = "success";
			console.log(updateResult);
		}
	}
// 	$("#updateSpotAddr").change(function(){
// 		if($(this).val()==''){
// 			updateResult[1] = "false";
// 			console.log(updateResult);
// 		}else{
// 			updateResult[1] = "success";
// 			console.log(updateResult);
// 		}
// 	});
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
				href="/adminPage.do"> <i class="fas fa-fw fa-tachometer-alt"></i>
					<span>관리자 페이지</span></a></li>

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
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#complaincollapsePages" aria-expanded="true" aria-controls="collapsePages">
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


      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
           도서 관리
      </div>
      
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>도서 대여</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
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
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#LostcollapsePages" aria-expanded="true" aria-controls="collapsePages">
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

			<!-- Heading -->
			<div class="sidebar-heading">SPOT 관리</div>
			<li class="nav-item">
        	<a class="nav-link" href="/adminSpotList.do?reqPage=1&selectCount=10">
          	<i class="fas fa-fw fa-table"></i>
          	<span>SPOT</span></a>
      </li>
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
					<h1 class="h3 mb-2 text-gray-800">SPOT 목록</h1>

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

#excelDownLoad {
	margin-top: 20px;
	float: left;
}
#excelDownLoadTotal {
	float: left;
}
#tbody button{
width:50px;
height:20px;
font-size:8pt;
padding-top:3px;
}

</style>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h4 class="m-0 font-weight-bold text-primary">List</h4>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<!-- 테이블 -->
								<div class="bs-example bs-example-tabs" role="tabpanel"
									data-example-id="togglable-tabs">

									<ul id="myTab" class="nav nav-tabs" role="tablist">
										<li id="tt1" role="presentation" class="active"><a
											href="#home" id="home-tab" role="tab" data-toggle="tab"
											aria-controls="home" aria-expanded="true"><b>SPOT 리스트</b></a></li>
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
																<option value="스팟명 "
																	<c:if test="${selectColumn eq spotName }">selected</c:if>>스팟명</option>
																<option value="도로명 주소"
																	<c:if test="${selectColumn eq spotAddr}">selected</c:if>>도로명 주소</option>
																	<option value="지역명"
																	<c:if test="${selectColumn eq localName}">selected</c:if>>지역명</option>
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

									<div id="myTabContent" class="tab-content">
										<div role="tabpanel" class="tab-pane fade active in" id="home"
											aria-labelledby="home-tab">
												<div id="alignStatus"><input type="hidden"><span style="display:none"></span></div>
												<table class="table table-hover">
													<thead>
														<tr>
															<th class="num" style="width:10%"><input type="checkbox" name="allCheck" id="allCheck">선택</th>
															<th class="th2" style="width:15%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>스팟명</span></th>
															<th class="th2" style="width:40%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>도로명 주소</span></th>
															<th class="th2" style="width:15%" onclick="clickAlign(this)"><input type="hidden" value="0"><span>지역명</span></th>
														</tr>
													</thead>
													<tbody id="tbody">
														<c:forEach items="${list }" var="l" varStatus="i">
															<tr>
																<input type="hidden" id="ajaxReqPage" value="${reqPage }">
																<th scope="row" class="num"><input type="checkbox" name="chBox" class="chBox" data-spotNo="${l.spotNo }">${(reqPage-1)*selectCount + i.count }</th>
																<td class="th2">${l.spotName }</td>
																<td class="th2">${l.spotAddr }</td>
																<td class="th2">${l.localName }</td>
																<td class="th2">
																<button type="button" class="btn btn-primary" data-spotNo="${l.spotNo }" onclick="selectOneSpot(this)" data-toggle="modal" data-target="#myModal2">수정</button>
																<button class="btn btn-danger" data-spotNo="${l.spotNo }" onclick="deleteSpot(this)">삭제</button></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
												
												<nav id="footNav2" style="text-align: center;">
													<button class="btn btn-primary" id="excelDownLoad">엑셀
														다운로드</button>
													<ul class="pagination">${pageNavi }</ul>
													<div id="sel" style="float: right; margin-top: 20px;">
														<button type="button" class="btn btn-primary" id="back">돌아가기</button>
													</div>
												</nav>
												<button class="btn btn-primary" id="excelDownLoadTotal">전체 목록 엑셀
														다운로드</button>
												<button class="btn btn-primary" data-toggle="modal" data-target="#myModal">스팟 생성</button>
	<!-- 스팟생성 모달 -->
                        <div class="modal fade" id="myModal" tabindex="-1"
                           role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog modal-lg">
                              <div class="modal-content">
                                 <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">SPOT 생성</h4>
                                 </div>
                                 <form action="/insertSpot.do" name="insertSpot" id="insertSpot" method="post" onsubmit="return check()">
	                                 <div class="modal-body" style="height: 200px; text-align:center; line-height:200px;">
	                                    <input type="text" id="spotName" name="spotName" style="width: 200px; height: 35px; font-size: 10pt; display: inline-block;" placeholder="스팟이름" required/> 
	                                    <input type="text" id="spotAddr" name="spotAddr" style="width: 200px; height: 35px; font-size: 10pt;"placeholder="도로명주소" readonly="readonly" required="required"/>
										<button type="button" id="addrSearch" class="btn btn-warning px-3" style="height: 35px;">주소검색</button><br/>
	                                 </div>
	                                 <div class="modal-footer">
	                                 	<span id="spotCheckStatus" style="position: absolute; left:320px;"></span>
	                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="position: relative;">돌아가기</button>
	                                    <button type="submit" class="btn btn-primary" id="submit">생성</button>
	                                 </div>
                                 </form>
                              </div>
                           </div>
                        </div>
<!-- --------- -->
<!-- 스팟수정 모달 -->
                        <div class="modal fade" id="myModal2" tabindex="-1"
                           role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                           <div class="modal-dialog modal-lg">
                              <div class="modal-content">
                                 <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">SPOT 수정</h4>
                                 </div>
                                 <form action="/updateSpot.do" name="updateSpot" id="updateSpot" method="post" onsubmit="return updateCheck()">
	                                 <div class="modal-body" id="updateModalSpot" style="height: 200px; text-align:center; line-height:200px;">
	                                    
	                                 </div>
	                                 <div class="modal-footer">
	                                 	<span id="updateSpotCheckStatus" style="position: absolute; left:320px;"></span>
	                                    <button type="button" class="btn btn-default" data-dismiss="modal" style="position: relative;">돌아가기</button>
	                                    <button type="submit" class="btn btn-primary" id="submit">수정</button>
	                                 </div>
                                 </form>
                              </div>
                           </div>
                        </div>
<!-- --------- -->
<script>

</script>
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
