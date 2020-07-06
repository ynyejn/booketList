package kr.or.iei.admin.controller;


import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.apply.model.vo.ApplyPageData;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndRent;
import kr.or.iei.book.model.vo.BookAndRentPageData;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.book.model.vo.BookRentalStatus;
import kr.or.iei.book.model.vo.BookRentalStatusPage;
import kr.or.iei.book.model.vo.BookRentalStatusSearchPage;
import kr.or.iei.complain.model.vo.Complain;
import kr.or.iei.complain.model.vo.ComplainPageData;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.MemberPageData;
import kr.or.iei.member.model.vo.MemberPageSearchData;
import kr.or.iei.rent.model.vo.BookRentalApplyPage;
import kr.or.iei.rent.model.vo.BookRentalApplySearchPage;
import kr.or.iei.rent.model.vo.RentApply;
import kr.or.iei.reservation.model.vo.Reservation;
import kr.or.iei.turn.model.vo.BookTurnApplyPage;
import kr.or.iei.turn.model.vo.BookTurnApplySearchPage;
import kr.or.iei.turn.model.vo.TurnApply;

@Controller
public class AdminController {
	
	@Autowired
	@Qualifier("adminService")
	private AdminService service;
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/login.do")
	public String loginFrm() {
		return "admin/loginFrm";
	}
	
	@RequestMapping(value="/userLostBook.do")
	public String userLostBook(HttpSession session,Model model) {
		Member m = (Member)session.getAttribute("member");
//		System.out.println(m.getMemberId());
		ArrayList<BookAndRent> list = (ArrayList<BookAndRent>)service.userLostBook(m);
		System.out.println(list);
		model.addAttribute("list", list);
		return "admin/userLostBook";
	}
	@ResponseBody
	@RequestMapping(value="/userLostBookUpdate.do")
	public int userLostBookUpdate(HttpServletRequest request) {
		String[] params = request.getParameterValues("chBox");
		int result = service.userLostBookUpdate(params);
		System.out.println(result);
		if(result>0) {
			int result2 = service.userLostRentUpdate(params);
			System.out.println(result2);
			return result2;
		}
		return 0;
	}
	
	@RequestMapping(value="/logins.do")
	public String login(String id, String pass, HttpSession session) {
		Member m = new Member();
		m.setMemberId(id);
		m.setMemberPw(pass);
		Member member = service.login(m);
		if(member==null) {
			return "admin/loginFrm";
		}else {
			session.setAttribute("member", member);
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="/adminPage.do")
	public String adminPageFrm() {
		return "/admin/adminPage";
	}
	
	@RequestMapping(value="/adminBookList.do")
	public String adminBookList(Model model, int reqPage, int check, int reqPage2, String search, String searchTitle) {
		
		model.addAttribute("check", check);
		BookPageData bpd = null;
		ApplyPageData apd = null;
		
		if(!(search == null || search.equals(""))) {
			bpd = service.selectList3(reqPage,search,searchTitle);
			apd = service.selectList4(reqPage2,search,searchTitle);
		}else {
			bpd = service.selectList1(reqPage);
			apd = service.selectList2(reqPage2);
		}

		
		model.addAttribute("list1",bpd.getList());
		model.addAttribute("pageNavi1",bpd.getPageNavi());
		
		model.addAttribute("reqPage", reqPage);
		model.addAttribute("list2", apd.getList());
		model.addAttribute("pageNavi2", apd.getPageNavi());
		model.addAttribute("reqPage2", reqPage2);
		model.addAttribute("search", search);
		model.addAttribute("searchTitle", searchTitle);

		
		return "admin/adminBookList";
	}
	

	@ResponseBody
	@RequestMapping(value="/deleteBookList.do")
	public int deleteBookList(HttpServletRequest request, Model model, int reqPage) {
		String[] params = request.getParameterValues("chBox");
		int result = service.deleteBookList(params);
		model.addAttribute("reqPage", reqPage);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectOneBookList.do",produces = "application/json;charset=utf-8")
	public String selectOneBookList(int bookNo) {
		System.out.println(bookNo);
		Book book = service.selectOneBookList(bookNo);
		System.out.println(book.getBookNo());
		return new Gson().toJson(book);
	}
	
	@ResponseBody
	@RequestMapping(value="/selectOneApplyList.do",produces = "application/json;charset=utf-8")
	public String selectOneApplyList(int applyNo) {
		System.out.println(applyNo);
		Apply apply = service.selectOneApplyList(applyNo);
		System.out.println(apply.getApplyNo());
		return new Gson().toJson(apply);
	}
	
	@ResponseBody
	@RequestMapping(value="/detailOneBookDelete.do")
	public int detailOneBookDelete(Model model, int reqPage, int bookNo) {
		int result = service.detailOneBookDelete(bookNo);
		model.addAttribute("reqPage", reqPage);
		System.out.println("result : "+result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/detailOneApplyNo.do")
	public int detailOneApplyNo(Model model, int reqPage2, int applyNo) {
		int result = service.detailOneApplyNo(applyNo);
		model.addAttribute("reqPage2", reqPage2);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/detailOneApplyYes.do")
	public int detailOneApplyYes(Model model, int reqPage2, int applyNo) {
		int result = service.detailOneApplyYes(applyNo);
		model.addAttribute("reqPage2", reqPage2);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/insertBookList.do")
	public int insertBookList(HttpServletRequest request) {
		String[] insertContent = request.getParameterValues("insertContent");
		int result = 0;
		for(int i=0;i<insertContent.length;i++) {
			System.out.println(insertContent[i]);
		}
		
		
		Book book = service.checkBookList(insertContent[0]);
		System.out.println(book);
		
		if(book != null) {
			result = 0;
		}else {
			result = service.insertBookList(insertContent);
		}
		
		
		return result;
	}
	

	@RequestMapping(value="/memberList.do")
	public String memberList(Model model, int reqPage, int selectCount) {
		System.out.println("AdminController");
		MemberPageData	mpd = service.selectMember(reqPage, selectCount);
		model.addAttribute("list",mpd.getList());
		model.addAttribute("pageNavi",mpd.getPageNavi());
		model.addAttribute("reqPage", reqPage);
		model.addAttribute("selectCount",selectCount);
		System.out.println(mpd.getList().size());
		return "/admin/memberList";
	}
	

	
	@ResponseBody
	@RequestMapping(value="/memberSearchList.do", produces="application/json;charset=utf-8")
	public String MemberSearchList(HttpServletRequest request) {
		int reqPage = (Integer.parseInt(request.getParameter("reqPage")));
		String selectColumn = request.getParameter("selectColumn");
		String search = request.getParameter("search");
		int selectCount = Integer.parseInt(request.getParameter("selectCount"));
		System.out.println("선택한 컬럼 : "+selectColumn);
		System.out.println("찾고자 하는 검색어 : "+search);
		String alignTitle  = request.getParameter("alignTitle");
		String alignStatus = request.getParameter("alignStatus");
		MemberPageData mpd = service.MemberSearchList(selectColumn,search,reqPage,selectCount,alignTitle,alignStatus);
		ArrayList<Member> list = mpd.getList();
		String pageNavi = mpd.getPageNavi();
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String [] arrEnrollDate = new String[list.size()];
		for(int i=0;i<list.size();i++) {
			Date date = mpd.getList().get(i).getEnrollDate();
			String strDate = sdFormat.format(date);
			arrEnrollDate[i] = strDate;
		}
		MemberPageSearchData mpsd = new MemberPageSearchData(list, pageNavi, arrEnrollDate, reqPage,selectCount);
		return new Gson().toJson(mpsd);
	
	}

	@RequestMapping(value="/adminComplainList.do")
	public String adminComplainList(Model model, int reqPage, int check, int reqPage2, String search, String searchTitle) {
		model.addAttribute("check", check);
		ComplainPageData cpd = null;
		ComplainPageData cpd2 = null;
		
		if(!(search == null || search.equals(""))) {
			cpd = service.complainSelectList3(reqPage,search,searchTitle);
			cpd2 = service.complainSelectList4(reqPage2,search,searchTitle);
		}else {
			cpd = service.complainSelectList1(reqPage);
			cpd2 = service.complainSelectList2(reqPage2);
		}
		
		model.addAttribute("list1",cpd.getList());
		model.addAttribute("pageNavi1",cpd.getPageNavi());
		model.addAttribute("reqPage", reqPage);
		
		model.addAttribute("list2", cpd2.getList());
		model.addAttribute("pageNavi2", cpd2.getPageNavi());
		model.addAttribute("reqPage2", reqPage2);
		model.addAttribute("search", search);
		model.addAttribute("searchTitle", searchTitle);
		
		return "admin/adminComplainList";
		
	}
	

	@ResponseBody
	@RequestMapping(value="/selectOneComplainList.do",produces = "application/json;charset=utf-8")
	public String selectOneComplainList(int ComplainNo) {
		System.out.println(ComplainNo);
		Complain complain = service.selectOneComplainList(ComplainNo);
		return new Gson().toJson(complain);
	}
	
	@ResponseBody
	@RequestMapping(value="/detailComplainYes.do")
	public int detailComplainYes(Model model, int reqPage, int ComplainNo) {
		System.out.println(ComplainNo);
		int result = service.detailComplainYes(ComplainNo);
		
		model.addAttribute("reqPage", reqPage);
		System.out.println("result : "+result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/detailComplainNo.do")
	public int detailComplainNo(Model model, int reqPage, int ComplainNo) {
		int result = service.detailComplainNo(ComplainNo);
		model.addAttribute("reqPage", reqPage);
		System.out.println("result : "+result);
		return result;
	}
	
	@RequestMapping(value="/adminLostBookList.do")
	public String adminLostBookList(Model model, int reqPage, String search, String searchTitle) {
			
		BookAndRentPageData barpd = null;
		
		if(!(search == null || search.equals(""))) {
			barpd = service.LostBookselectList3(reqPage,search,searchTitle);
		}else {
			barpd = service.LostBookselectList1(reqPage);
		}
		
		model.addAttribute("list1",barpd.getList());
		model.addAttribute("pageNavi1",barpd.getPageNavi());
		model.addAttribute("reqPage", reqPage);
		model.addAttribute("search", search);
		model.addAttribute("searchTitle", searchTitle);
		
		return "admin/adminLostBookList";
	}
	
	@ResponseBody
	@RequestMapping(value="/cancelLostBookList.do")
	public int cancelLostBookList(HttpServletRequest request,Model model, int reqPage) {
		String[] params = request.getParameterValues("chBox");
		model.addAttribute("reqPage", reqPage);
		int result = service.cancelLostBookList(params); // book_status 5에서 0 으로
		if(result>0) {
			int result2 = service.cancelLostBookList2(params); // rent table의 반납일자와 상태를 반납완료로 바꿈
			return result2;
		}
		
		return 0;
	}


	@RequestMapping(value = "/excelDown.do")
	public void excelDown(HttpServletResponse response,String[]checkArr) throws Exception {
	    ArrayList<Member> list = new ArrayList<Member>();
	    ArrayList<Member> selList = new ArrayList<Member>();
	    System.out.println("컨트롤러");
	    for(String id : checkArr) {
	    	// 게시판 목록조회
	    	selList=(ArrayList<Member>)service.selectExcelList(id);
	    	int excelMemberNo = selList.get(0).getMemberNo();
	    	String excelMemberId = selList.get(0).getMemberId();
	    	String excelMemberName = selList.get(0).getMemberName();
	    	String excelMemberEmail = selList.get(0).getMemberEmail();
	    	String excelMemberPhone = selList.get(0).getMemberPhone();
	    	String excelMemberCategory1 =selList.get(0).getMemberCategory1();
	    	String excelMemberCategory2 =selList.get(0).getMemberCategory2();
	    	String excelMemberCategory3 =selList.get(0).getMemberCategory3();
	    	int excelDelayStatus = selList.get(0).getDelayStatus();
	    	int excelComplainStatus = selList.get(0).getCompainStatus();
	    	String excelMemberNickName = selList.get(0).getMemberNickname();
	    	Date excelEnrollDate = selList.get(0).getEnrollDate();
	    	Member excelMember = new Member();
	    	excelMember.setMemberNo(excelMemberNo);
	    	excelMember.setMemberId(excelMemberId);
	    	excelMember.setMemberName(excelMemberName);
	    	excelMember.setMemberEmail(excelMemberEmail);
	    	excelMember.setMemberPhone(excelMemberPhone);
	    	excelMember.setMemberCategory1(excelMemberCategory1);
	    	excelMember.setMemberCategory2(excelMemberCategory2);
	    	excelMember.setMemberCategory3(excelMemberCategory3);
	    	excelMember.setDelayStatus(excelDelayStatus);
	    	excelMember.setCompainStatus(excelComplainStatus);
	    	excelMember.setMemberNickname(excelMemberNickName);
	    	excelMember.setEnrollDate(excelEnrollDate);
	    	list.add(excelMember);
	    }
	    System.out.println(list.size());
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("게시판");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("번호");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("아이디");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이름");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이메일");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("전화번호");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("닉네임");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("가입일");
	    
	    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
	    // 데이터 부분 생성
	    for(Member vo : list) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberNo());
	        
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberId());
	        
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberName());
	        
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberEmail());
	        
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberPhone());
	        
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberNickname());
	        
	        
	        String strDate = sdFormat.format(vo.getEnrollDate());
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(strDate);

	    }
	    response.setContentType("application/vnd.ms-excel");

	    response.setHeader("Content-Disposition", "attachment;filename=test.xls");
	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    
	}
	@RequestMapping(value = "/excelRentDown.do")
	public void excelRentDown(HttpServletResponse response,int[]checkArr) throws Exception {
	    ArrayList<BookRentalStatus> list = new ArrayList<BookRentalStatus>();
	    ArrayList<BookRentalStatus> selList = new ArrayList<BookRentalStatus>();
	    System.out.println("컨트롤러");
	    for(int rentNo : checkArr) {
	    	// 게시판 목록조회
	    	selList=(ArrayList<BookRentalStatus>)service.selectExcelRentList(rentNo);
	    	int excelRentNo = selList.get(0).getRentNo();
	    	int excelBookNo = selList.get(0).getBookNo();
	    	String excelMemberId = selList.get(0).getMemberId();
	    	String excelBookName = selList.get(0).getBookName();
	    	Date excelRentStartDate = selList.get(0).getRentStartDate();
	    	Date excelRentEndDate = selList.get(0).getRentEndDate();
	    	int excelRentReturn = selList.get(0).getRentReturn();
	    	
	    	BookRentalStatus excelRent = new BookRentalStatus();
	    	excelRent.setRentNo(excelRentNo);
	    	excelRent.setBookNo(excelBookNo);
	    	excelRent.setMemberId(excelMemberId);
	    	excelRent.setBookName(excelBookName);
	    	excelRent.setRentStartDate(excelRentStartDate);
	    	excelRent.setRentEndDate(excelRentEndDate);
	    	excelRent.setRentReturn(excelRentReturn);
	    	list.add(excelRent);
	    }
	    System.out.println(list.size());
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("게시판");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("대여 번호");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("도서 번호");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("아이디");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("도서 제목");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("대여일");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("반납 예정일");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("대여 상태");
	    
	    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
	    // 데이터 부분 생성
	    for(BookRentalStatus vo : list) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getRentNo());
	        
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getBookNo());
	        
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMemberId());
	        
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getBookName());
	        
	        String strRentDate = sdFormat.format(vo.getRentStartDate());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(strRentDate);
	        
	        String endRentDate = sdFormat.format(vo.getRentEndDate());
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(endRentDate);
	        
	        if(vo.getRentReturn() ==0) {
	        	cell = row.createCell(6);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue("대여중");
	        }else {
	        	cell = row.createCell(6);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue("반납완료");
	        }
	        

	    }
	    response.setContentType("application/vnd.ms-excel");

	    response.setHeader("Content-Disposition", "attachment;filename=test.xls");
	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    
	}
	@RequestMapping("/adminDeleteMember.do")
	public String adminDeleteMember(String memberId) {
		System.out.println(memberId);
		int result = service.adminDeleteMember(memberId);
		System.out.println(result);
		if(result > 0) {
			return "redirect:/memberList.do?reqPage=1&selectCount=10";
		}else {
			return "redirect:/memberList.do?reqPage=1&selectCount=10";
		}
		
	}
	@RequestMapping("/adminBookRentalStatusList.do")
	public String adminBookRentalStatusList(Model model, int reqPage, int selectCount){
		
		BookRentalStatusPage brsp= service.bookRentalStatusList(reqPage,selectCount);
		for(int i=0;i<brsp.getList().size();i++) {
			brsp.getList().get(i).getBookNo();
		}
		model.addAttribute("list",brsp.getList());
		model.addAttribute("pageNavi",brsp.getPageNavi());
		model.addAttribute("reqPage",reqPage);
		model.addAttribute("selectCount",selectCount);
		return "admin/adminBookRentalStatusList";
	}
		
		@ResponseBody
		@RequestMapping(value="/bookSearchRentalStatusList.do", produces="application/json;charset=utf-8")
		public String BookSearchRentalList(HttpServletRequest request) {
			int aReqPage = (Integer.parseInt(request.getParameter("reqPage")));
			System.out.println("페이징 reqPage : "+aReqPage);
			String selectColumn = request.getParameter("selectColumn");
			String search = request.getParameter("search");
			int selectCount = Integer.parseInt(request.getParameter("selectCount"));
			System.out.println("선택한 컬럼 : "+selectColumn);
			System.out.println("찾고자 하는 검색어 : "+search);
			String alignTitle  = request.getParameter("alignTitle");
			String alignStatus = request.getParameter("alignStatus");
			System.out.println("선택한 배열 제목 : "+alignTitle);
			System.out.println("선택한 배열 상태 : "+alignStatus);
			BookRentalStatusPage brsp = service.bookSearchRentalStatusList(selectColumn,search,aReqPage,selectCount,alignTitle,alignStatus);
			
			ArrayList<BookRentalStatus> list = brsp.getList();
			String pageNavi = brsp.getPageNavi();
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			String [] arrRentStartDate = new String[list.size()];
			String [] arrRentEndDate = new String[list.size()];
			for(int i=0;i<list.size();i++) {
				Date startDate = brsp.getList().get(i).getRentStartDate();
				Date endDate = brsp.getList().get(i).getRentEndDate();
				if(startDate == null && endDate == null) {
					arrRentStartDate[i] = null;
					arrRentEndDate[i] = null;
				}else {
					String strStartDate = sdFormat.format(startDate);
					String strEndDate = sdFormat.format(endDate);
					arrRentStartDate[i] = strStartDate;
					arrRentEndDate[i] = strEndDate;
				}
			}
			System.out.println("pageNavi : "+pageNavi);
			BookRentalStatusSearchPage brssp = new BookRentalStatusSearchPage(list, pageNavi, arrRentStartDate,arrRentEndDate, aReqPage,selectCount);
			return new Gson().toJson(brssp);
		
		}
		
		@RequestMapping("/adminBookRentalApplyList.do")
		public String adminBookRentalApplyList(Model model, int reqPage, int selectCount){
			
			BookRentalApplyPage brap= service.bookRentalApplyList(reqPage,selectCount);
			
			model.addAttribute("list",brap.getList());
			model.addAttribute("pageNavi",brap.getPageNavi());
			model.addAttribute("reqPage",reqPage);
			model.addAttribute("selectCount",selectCount);
			return "admin/adminBookRentalApplyList";
		}
		@ResponseBody
		@RequestMapping(value="/bookSearchRentalApplyList.do", produces="application/json;charset=utf-8")
		public String BookSearchRentalApplyList(HttpServletRequest request) {
			int aReqPage = (Integer.parseInt(request.getParameter("reqPage")));
			System.out.println("페이징 reqPage : "+aReqPage);
			String selectColumn = request.getParameter("selectColumn");
			String search = request.getParameter("search");
			int selectCount = Integer.parseInt(request.getParameter("selectCount"));
			System.out.println("선택한 컬럼 : "+selectColumn);
			System.out.println("찾고자 하는 검색어 : "+search);
			String alignTitle  = request.getParameter("alignTitle");
			String alignStatus = request.getParameter("alignStatus");
			System.out.println("선택한 배열 제목 : "+alignTitle);
			System.out.println("선택한 배열 상태 : "+alignStatus);
			BookRentalApplyPage brap = service.bookSearchRentalApplyList(selectColumn,search,aReqPage,selectCount,alignTitle,alignStatus);
			
			ArrayList<RentApply> list = brap.getList();
			String pageNavi = brap.getPageNavi();
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			String [] arrRentApplyDate = new String[list.size()];
			for(int i=0;i<list.size();i++) {
				Date rentApplyDate = brap.getList().get(i).getRentApplyDate();
					String strRentApplyDate = sdFormat.format(rentApplyDate);
					arrRentApplyDate[i] = strRentApplyDate;
			}
			System.out.println("pageNavi : "+pageNavi);
			BookRentalApplySearchPage brasp = new BookRentalApplySearchPage(list, pageNavi, arrRentApplyDate, aReqPage,selectCount);
			return new Gson().toJson(brasp);
		
		}
		
		@RequestMapping(value="/agreeRentApply.do")
		public String AgreeRentApply(HttpServletRequest request) {
			int rentApply = Integer.parseInt(request.getParameter("rentApply"));
			RentApply selectRentApply = service.selectOneRentApply(rentApply);
			int insertResult = service.insertAgreeRentApply(selectRentApply);
			if(insertResult>0) {
				int deleteResult = service.deleteAgreeRentApply(rentApply);
					if(deleteResult>0) {
						System.out.println("insert,delete성공");
						return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10";
					}else {
						System.out.println("delete실패");
						return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10";
					}
			}else {
				System.out.println("insert실패");
				return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10";
			}
		}
		@RequestMapping("/adminBookTurnApplyList.do")
		public String adminBookturnApplyList(Model model, int reqPage, int selectCount){
			
			BookTurnApplyPage brap= service.bookTurnApplyList(reqPage,selectCount);
			
			model.addAttribute("list",brap.getList());
			model.addAttribute("pageNavi",brap.getPageNavi());
			model.addAttribute("reqPage",reqPage);
			model.addAttribute("selectCount",selectCount);
			return "admin/adminBookTurnApplyList";
		}
		
		@ResponseBody
		@RequestMapping(value="/bookSearchTurnApplyList.do", produces="application/json;charset=utf-8")
		public String BookSearchTurnApplyList(HttpServletRequest request) {
			int aReqPage = (Integer.parseInt(request.getParameter("reqPage")));
			System.out.println("페이징 reqPage : "+aReqPage);
			String selectColumn = request.getParameter("selectColumn");
			String search = request.getParameter("search");
			int selectCount = Integer.parseInt(request.getParameter("selectCount"));
			System.out.println("선택한 컬럼 : "+selectColumn);
			System.out.println("찾고자 하는 검색어 : "+search);
			String alignTitle  = request.getParameter("alignTitle");
			String alignStatus = request.getParameter("alignStatus");
			System.out.println("선택한 배열 제목 : "+alignTitle);
			System.out.println("선택한 배열 상태 : "+alignStatus);
			BookTurnApplyPage btap = service.bookSearchTurnApplyList(selectColumn,search,aReqPage,selectCount,alignTitle,alignStatus);
			
			ArrayList<TurnApply> list = btap.getList();
			String pageNavi = btap.getPageNavi();
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			String [] arrTurnApplyDate = new String[list.size()];
			for(int i=0;i<list.size();i++) {
				Date turnApplyDate = btap.getList().get(i).getTurnapplyDate();
					String strTurnApplyDate = sdFormat.format(turnApplyDate);
					arrTurnApplyDate[i] = strTurnApplyDate;
			}
			System.out.println("pageNavi : "+pageNavi);
			BookTurnApplySearchPage brasp = new BookTurnApplySearchPage(list, pageNavi, arrTurnApplyDate, aReqPage,selectCount);
			return new Gson().toJson(brasp);
		
		}
		
		@RequestMapping(value="/agreeTurnApply.do")
		public String agreeTurnApply(HttpServletRequest request) {
			int turnApply = Integer.parseInt(request.getParameter("turnApply"));
			//반납신청테이블에서 반납신청번호로 정보조회해오기
			TurnApply selectTurnApplyOneList = service.selectTurnApplyOneList(turnApply);
			//반납신청테이블에서 불러온 목록에 책넘버로 도서테이블에서 책목록 가져오기
			Book bookList = service.selectBookListTurnApply(selectTurnApplyOneList.getBookNo());
			//bookList에 도서제목,도서출판사,도서 작가를 예약테이블에 보내줘서 해당하는 리스트 불러오기
			ArrayList<Reservation> reservationList = (ArrayList<Reservation>)service.selectReservationListTurnApply(bookList.getBookName(),bookList.getBookPublisher(),bookList.getBookWriter());
			//예약테이블에서 불러온 리스트중에서 member_id값으로 멤버테이블에 해당 멤버이메일들을 불러오기
			String[] memberEmail = new String[reservationList.size()];
			for(int i=0;i<reservationList.size();i++) {
				String memberId = reservationList.get(i).getMemberId();
				String Email = service.selectMemberEmailTurnApply(memberId);
				memberEmail[i]=Email;
			}
			String setfrom = "pjyub1297@gmail.com";
			String title =  "[BooketList]예약하신 도서("+bookList.getBookName()+")가 대여가능 합니다";
			
			MimeMessage message = mailSender.createMimeMessage();
			try {
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(memberEmail);
				messageHelper.setSubject(title);
				messageHelper.setText("", "<h1>예약도서<h1>"
						+ "<a href='http://192.168.10.155/rent/goBookSearch.do?reqPage=1' style='font-size:10pt'>도서대여 페이지로 이동</a>"
						+"<table border=1>"
						+"<tr>"
						+"<th>제목</th>"
						+"<th>내용</th>"
						+"</tr>"
						+"<tr>"
						+"<td>제목111</td>"
						+"<td>내용111</td>"
						+"</tr>"
						+ "</table>");
				
				mailSender.send(message);				
			} catch (Exception e) {
				System.out.println(e);
			}
			//반납신청테이블에서 승인버튼을 눌러준것만 지워주고
			//메일을 보내준 멤버 예약테이블에서 지워주고 
			//도서 테이블에서 해당 도서넘버에 해당하는 도서상태 대여가능으로 바꿔주기
			int result = service.deleteTurnApply(turnApply);
			if(result>0) {
				int reservationResult = service.deleteReservationTurnApply(bookList.getBookName(),bookList.getBookPublisher(),bookList.getBookWriter());
					if(reservationResult>0) {
						int updateResult = service.updateBookTurnApply(selectTurnApplyOneList.getBookNo());
							if(updateResult>0) {
								return null;
							}else {
								return null;
							}
					}else {
						return null;
					}
			}else {
				return null;
			}
			
			return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10";
		}
}


