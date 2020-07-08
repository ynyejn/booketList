package kr.or.iei.admin.controller;


import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

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
import kr.or.iei.reservation.model.vo.ReservationPage;
import kr.or.iei.reservation.model.vo.ReservationSearchPage;
import kr.or.iei.turn.model.vo.BookTurnApplyPage;
import kr.or.iei.turn.model.vo.BookTurnApplySearchPage;
import kr.or.iei.turn.model.vo.TurnApply;

@Controller
public class AdminController {
	
	@Autowired
	@Qualifier("adminService")
	private AdminService service;
	@Autowired
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
	public String memberList(Model model, int reqPage, int selectCount,String msg) {
		System.out.println("AdminController");
		MemberPageData	mpd = service.selectMember(reqPage, selectCount);
		model.addAttribute("msg",msg);
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
			return "redirect:/memberList.do?reqPage=1&selectCount=10&msg=1";
		}else {
			return "redirect:/memberList.do?reqPage=1&selectCount=10msg=2";
		}
		
	}
	@RequestMapping("/adminBookRentalStatusList.do")
	public String adminBookRentalStatusList(Model model, int reqPage, int selectCount){
		Date endDate;	
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String todayDate = dateFormat.format(time.getTime());
		
		BookRentalStatusPage brsp= service.bookRentalStatusList(reqPage,selectCount);
		String [] compareStatus = new String[brsp.getList().size()];
		for(int i=0;i<brsp.getList().size();i++) {
			endDate = brsp.getList().get(i).getRentEndDate();
			String stringEndDate = dateFormat.format(endDate);
			int compare = todayDate.compareTo(stringEndDate);
			System.out.println(compare);
			if(compare>0) {
				System.out.println("연체");
				compareStatus[i]="1";
			}else if(compare<0) {
				System.out.println("연체아님");
				compareStatus[i]="0";
			}else {
				System.out.println("같은날임");
				compareStatus[i]="0";
			}
		}
		model.addAttribute("compare",compareStatus);
		model.addAttribute("list",brsp.getList());
		model.addAttribute("pageNavi",brsp.getPageNavi());
		model.addAttribute("reqPage",reqPage);
		model.addAttribute("selectCount",selectCount);
		return "admin/adminBookRentalStatusList";
	}
		
		@ResponseBody
		@RequestMapping(value="/bookSearchRentalStatusList.do", produces="application/json;charset=utf-8")
		public String BookSearchRentalList(HttpServletRequest request) {
			String returnStatus = request.getParameter("returnStatus");
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
			BookRentalStatusPage brsp = service.bookSearchRentalStatusList(selectColumn,search,aReqPage,selectCount,alignTitle,alignStatus,returnStatus);
			
			ArrayList<BookRentalStatus> list = brsp.getList();
			String pageNavi = brsp.getPageNavi();
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			String [] arrRentStartDate = new String[list.size()];
			String [] arrRentEndDate = new String[list.size()];
			String [] compareStatus = new String[list.size()];
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
					Calendar time = Calendar.getInstance();
					String todayDate = sdFormat.format(time.getTime());
					int compare = todayDate.compareTo(strEndDate);
					System.out.println(compare);
					if(compare>0) {
						System.out.println("연체");
						compareStatus[i]="1";
					}else if(compare<0) {
						System.out.println("연체아님");
						compareStatus[i]="0";
					}else {
						System.out.println("같은날임");
						compareStatus[i]="0";
					}
				}
			}
			System.out.println("pageNavi : "+pageNavi);
			BookRentalStatusSearchPage brssp = new BookRentalStatusSearchPage(list, pageNavi, arrRentStartDate,arrRentEndDate, aReqPage,selectCount,compareStatus);
			return new Gson().toJson(brssp);
		
		}
		
		@RequestMapping("/adminBookRentalApplyList.do")
		public String adminBookRentalApplyList(Model model, int reqPage, int selectCount,String msg){
			
			BookRentalApplyPage brap= service.bookRentalApplyList(reqPage,selectCount);
			
			model.addAttribute("msg",msg);
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
							int updateResult = service.updateBookRentApply(selectRentApply.getBookNo());
								if(updateResult>0) {
									System.out.println("insert,delete,update성공");
									return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10&msg=1";
								}else {
									System.out.println("insert,delete성공,update실패");
									return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10&msg=2";
								}
					}else {
						System.out.println("delete실패");
						return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10&msg=2";
					}
			}else {
				System.out.println("insert실패");
				return "redirect:/adminBookRentalApplyList.do?reqPage=1&selectCount=10&msg=2";
			}
		}
		@RequestMapping(value="/adminBookTurnApplyList.do")
		public String adminBookturnApplyList(Model model, int reqPage, int selectCount,String msg){
			
			BookTurnApplyPage brap= service.bookTurnApplyList(reqPage,selectCount);
			
			model.addAttribute("msg",msg);
			System.out.println(msg);
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
		public String agreeTurnApply(HttpServletRequest request,Model model) {
			int turnApply = Integer.parseInt(request.getParameter("turnApply"));
			//반납신청테이블에서 반납신청번호로 정보조회해오기
			TurnApply selectTurnApplyOneList = service.selectTurnApplyOneList(turnApply);
			//반납신청테이블에서 불러온 목록에 책넘버로 도서테이블에서 책목록 가져오기
			Book bookList = service.selectBookListTurnApply(selectTurnApplyOneList.getBookNo());
			//bookList에 도서제목,도서출판사,도서 작가를 예약테이블에 보내줘서 해당하는 리스트 불러오기
			System.out.println(bookList.getBookWriter());
			ArrayList<Reservation> reservationList = (ArrayList<Reservation>)service.selectReservationListTurnApply(bookList.getBookName(),bookList.getBookPublisher(),bookList.getBookWriter());
			//예약테이블에서 불러온 리스트중에서 member_id값으로 멤버테이블에 해당 멤버이메일들을 불러오기
			//예약자 있을경우 밑에 로직 처리
			String[] memberEmail = new String[reservationList.size()];
			for(int i=0;i<reservationList.size();i++) {
				String memberId = reservationList.get(i).getMemberId();
				String Email = service.selectMemberEmailTurnApply(memberId);
				memberEmail[i]=Email;
			}
			if(memberEmail.length !=0) {
			System.out.println("반납한 도서 이름 : "+bookList.getBookName());
			System.out.println("반납한 도서 출판사 : "+bookList.getBookPublisher());
			System.out.println("반납한 도서 작가 : "+bookList.getBookWriter());
			System.out.println("예약자 리스트 길이 : "+memberEmail.length);
			String Writer;
			if(bookList.getBookWriter()==null) {
				Writer="작가미상";
			}else {
				Writer=bookList.getBookWriter();
			}
			String setfrom = "booketlistmaster@gmail.com";
			String[]tomail = memberEmail;
			String title =  "[BooketList] 예약하신 도서 ("+bookList.getBookName()+") 가 대여가능 합니다";
			String textContent = "<div style='border:1px solid gray;width:500px;height:480px;text-align:center;margin:0 auto;'>" + 
					"<a href='http://192.168.10.155'><img src='http://192.168.10.155/resources/imgs/bluelogo.png' style='width:400px;'></a>" + 
					"        <table style='margin:0 auto;border-top:1px solid #0066b3;border-bottom:1px solid #0066b3;width:450px;'>" + 
					"            <tr>" + 
					"                <td rowspan='2' style='width:100px;'><img src='"+bookList.getBookImg()+"'></td>" + 
					"                <td style='font-size:20px; font-weight:bolder;'>"+bookList.getBookName()+"</td>" + 
					"            </tr>" + 
					"            <tr>" + 
					"                <td style='font-size:14px;'>"+Writer+"</td>" + 
					"            </tr>" +
					"        </table>" + 
					"        <div style='margin-top:50px;'>" + 
					"            <span>해당도서를 대여하시겠습니까?</span><br><br>" + 
					"            <div style='margin:0 auto;border:1px solid black;width:150px;height:40px;background-color:#0066b3;font-size:10pt;color:white;line-height:40px;display:block;'>"
					+ "<a href='http://192.168.10.155/rent/goBookSearch.do?reqPage=1' style='text-decoration:none;color:white;display:block;'>대여페이지로 이동</a></div>" + 
					"        </div>" + 
					"    </div>";
			MimeMessage message = mailSender.createMimeMessage();
			System.out.println("메세지: "+message);
			try {
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText("", textContent);
				
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
								return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=1";
							}else {
								return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=2";
							}
					}else {
						return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=2";
					}
			}else {
				return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=2";
			}
		}else {
			int result = service.deleteTurnApply(turnApply);
			if(result>0) {
				int updateResult = service.updateBookTurnApply(selectTurnApplyOneList.getBookNo());
					if(updateResult>0) {
						return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=3";
					}else {
						return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=2";
					}
			}else {
				return "redirect:/adminBookTurnApplyList.do?reqPage=1&selectCount=10&msg=2";
			}
		}
			
			
		}
		@RequestMapping(value = "/excelRentApplyDown.do")
		public void excelRentApplyDown(HttpServletResponse response,int[]checkArr) throws Exception {
		    ArrayList<RentApply> list = new ArrayList<RentApply>();
		    ArrayList<RentApply> selList = new ArrayList<RentApply>();
		    System.out.println("컨트롤러");
		    for(int rentApply : checkArr) {
		    	// 게시판 목록조회
		    	selList=(ArrayList<RentApply>)service.selectExcelRentApplyList(rentApply);
		    	int excelRentApply = selList.get(0).getRentApply();
		    	int excelBookNo = selList.get(0).getBookNo();
		    	String excelMemberId = selList.get(0).getMemberId();
		    	String excelBookName = selList.get(0).getBookName();
		    	String excelSpotName = selList.get(0).getSpotName();
		    	Date excelRentApplyDate = selList.get(0).getRentApplyDate();
		    	
		    	
		    	RentApply excelRentApplyList = new RentApply();
		    	excelRentApplyList.setRentApply(excelRentApply);
		    	excelRentApplyList.setBookNo(excelBookNo);
		    	excelRentApplyList.setMemberId(excelMemberId);
		    	excelRentApplyList.setBookName(excelBookName);
		    	excelRentApplyList.setSpotName(excelSpotName);
		    	excelRentApplyList.setRentApplyDate(excelRentApplyDate);
		    	list.add(excelRentApplyList);
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
		    cell.setCellValue("대여 신청 번호");
		    
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
		    cell.setCellValue("대여장소");
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(headStyle);
		    cell.setCellValue("대여 신청 날짜");
		    
		    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		    // 데이터 부분 생성
		    for(RentApply vo : list) {
		        row = sheet.createRow(rowNo++);
		        cell = row.createCell(0);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getRentApply());
		        
		        cell = row.createCell(1);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookNo());
		        
		        cell = row.createCell(2);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getMemberId());
		        
		        cell = row.createCell(3);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookName());
		        
		        cell = row.createCell(4);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getSpotName());
		        
		        String strRentDate = sdFormat.format(vo.getRentApplyDate());
		        cell = row.createCell(5);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(strRentDate);
		        

		    }
		    response.setContentType("application/vnd.ms-excel");

		    response.setHeader("Content-Disposition", "attachment;filename=test.xls");
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    
		}
		
		@RequestMapping(value = "/excelTurnApplyDown.do")
		public void excelTurnApplyDown(HttpServletResponse response,int[]checkArr) throws Exception {
		    ArrayList<TurnApply> list = new ArrayList<TurnApply>();
		    ArrayList<TurnApply> selList = new ArrayList<TurnApply>();
		    System.out.println("컨트롤러");
		    for(int turnApply : checkArr) {
		    	// 게시판 목록조회
		    	selList=(ArrayList<TurnApply>)service.selectExcelTurnApplyList(turnApply);
		    	int excelTurnApply = selList.get(0).getTurnApply();
		    	String excelBookNo = selList.get(0).getBookNo();
		    	String excelMemberId = selList.get(0).getMemberId();
		    	String excelBookName = selList.get(0).getBookName();
		    	String excelSpotName = selList.get(0).getSpotName();
		    	Date excelTurnApplyDate = selList.get(0).getTurnapplyDate();
		    	
		    	
		    	TurnApply excelTurnApplyList = new TurnApply();
		    	excelTurnApplyList.setTurnApply(excelTurnApply);
		    	excelTurnApplyList.setBookNo(excelBookNo);
		    	excelTurnApplyList.setMemberId(excelMemberId);
		    	excelTurnApplyList.setBookName(excelBookName);
		    	excelTurnApplyList.setSpotName(excelSpotName);
		    	excelTurnApplyList.setTurnapplyDate(excelTurnApplyDate);
		    	list.add(excelTurnApplyList);
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
		    cell.setCellValue("반납 신청 번호");
		    
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
		    cell.setCellValue("반납장소");
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(headStyle);
		    cell.setCellValue("반납 신청 날짜");
		    
		    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		    // 데이터 부분 생성
		    for(TurnApply vo : list) {
		        row = sheet.createRow(rowNo++);
		        cell = row.createCell(0);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getTurnApply());
		        
		        cell = row.createCell(1);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookNo());
		        
		        cell = row.createCell(2);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getMemberId());
		        
		        cell = row.createCell(3);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookName());
		        
		        cell = row.createCell(4);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getSpotName());
		        
		        String strTurnDate = sdFormat.format(vo.getTurnapplyDate());
		        cell = row.createCell(5);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(strTurnDate);
		        

		    }
		    response.setContentType("application/vnd.ms-excel");

		    response.setHeader("Content-Disposition", "attachment;filename=test.xls");
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    
		}
		@RequestMapping(value = "/excelDownTotal.do")
		public void excelTurnApplyDownTotal(HttpServletResponse response,String part) throws Exception {
			ArrayList<Member> memberList = new ArrayList<Member>();
		    ArrayList<Member> memberSelList = new ArrayList<Member>();
			ArrayList<BookRentalStatus> rentStatusList = new ArrayList<BookRentalStatus>();
		    ArrayList<BookRentalStatus> rentStatusSelList = new ArrayList<BookRentalStatus>();
			ArrayList<RentApply> rentApplyList = new ArrayList<RentApply>();
		    ArrayList<RentApply> rentApplySelList = new ArrayList<RentApply>();
			ArrayList<TurnApply> turnList = new ArrayList<TurnApply>();
		    ArrayList<TurnApply> turnSelList = new ArrayList<TurnApply>();
		    System.out.println("컨트롤러");
		    if(part.equals("member")) {
		    	memberSelList=(ArrayList<Member>)service.excelMemberListTotal();
		    	for(int i=0;i<memberSelList.size();i++) {
		    	int excelMemberNo = memberSelList.get(i).getMemberNo();
		    	String excelMemberId = memberSelList.get(i).getMemberId();
		    	String excelMemberName = memberSelList.get(i).getMemberName();
		    	String excelMemberEmail = memberSelList.get(i).getMemberEmail();
		    	String excelMemberPhone = memberSelList.get(i).getMemberPhone();
		    	String excelMemberCategory1 =memberSelList.get(i).getMemberCategory1();
		    	String excelMemberCategory2 =memberSelList.get(i).getMemberCategory2();
		    	String excelMemberCategory3 =memberSelList.get(i).getMemberCategory3();
		    	int excelDelayStatus = memberSelList.get(i).getDelayStatus();
		    	int excelComplainStatus = memberSelList.get(i).getCompainStatus();
		    	String excelMemberNickName = memberSelList.get(i).getMemberNickname();
		    	Date excelEnrollDate = memberSelList.get(i).getEnrollDate();
		    	
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
		    	memberList.add(excelMember);
		    	System.out.println(memberList.size());
		    	}
		    }else if(part.equals("rentStatus")){
		    	rentStatusSelList=(ArrayList<BookRentalStatus>)service.excelRentListTotal();
		    	for(int i=0;i<rentStatusSelList.size();i++) {
		    	int excelRentNo = rentStatusSelList.get(i).getRentNo();
		    	int excelBookNo = rentStatusSelList.get(i).getBookNo();
		    	String excelMemberId = rentStatusSelList.get(i).getMemberId();
		    	String excelBookName = rentStatusSelList.get(i).getBookName();
		    	Date excelRentStartDate = rentStatusSelList.get(i).getRentStartDate();
		    	Date excelRentEndDate = rentStatusSelList.get(i).getRentEndDate();
		    	int excelRentReturn = rentStatusSelList.get(i).getRentReturn();
		    	
		    	BookRentalStatus excelRent = new BookRentalStatus();
		    	excelRent.setRentNo(excelRentNo);
		    	excelRent.setBookNo(excelBookNo);
		    	excelRent.setMemberId(excelMemberId);
		    	excelRent.setBookName(excelBookName);
		    	excelRent.setRentStartDate(excelRentStartDate);
		    	excelRent.setRentEndDate(excelRentEndDate);
		    	excelRent.setRentReturn(excelRentReturn);
		    	rentStatusList.add(excelRent);
		    	System.out.println(rentStatusList.size());
		    	}
		    }else if(part.equals("rentApply")) {
		    	rentApplySelList=(ArrayList<RentApply>)service.excelRentApplyListTotal();
		    	for(int i=0;i<rentApplySelList.size();i++) {
		    	int excelRentApply = rentApplySelList.get(i).getRentApply();
		    	int excelBookNo = rentApplySelList.get(i).getBookNo();
		    	String excelMemberId = rentApplySelList.get(i).getMemberId();
		    	String excelBookName = rentApplySelList.get(i).getBookName();
		    	String excelSpotName = rentApplySelList.get(i).getSpotName();
		    	Date excelRentApplyDate = rentApplySelList.get(i).getRentApplyDate();
		    	
		    	RentApply excelRentApplyList = new RentApply();
		    	excelRentApplyList.setRentApply(excelRentApply);
		    	excelRentApplyList.setBookNo(excelBookNo);
		    	excelRentApplyList.setMemberId(excelMemberId);
		    	excelRentApplyList.setBookName(excelBookName);
		    	excelRentApplyList.setSpotName(excelSpotName);
		    	excelRentApplyList.setRentApplyDate(excelRentApplyDate);
		    	rentApplyList.add(excelRentApplyList);
		    	System.out.println(rentApplyList.size());
		    	}
		    }else if(part.equals("turnApply")) {
		    	// 게시판 목록조회
		    	turnSelList=(ArrayList<TurnApply>)service.excelTurnApplyListTotal();
		    	for(int i=0;i<turnSelList.size();i++) {
		    	int excelTurnApply = turnSelList.get(i).getTurnApply();
		    	String excelBookNo = turnSelList.get(i).getBookNo();
		    	String excelMemberId = turnSelList.get(i).getMemberId();
		    	String excelBookName = turnSelList.get(i).getBookName();
		    	String excelSpotName = turnSelList.get(i).getSpotName();
		    	Date excelTurnApplyDate = turnSelList.get(i).getTurnapplyDate();
		    	
		    	TurnApply excelTurnApplyList = new TurnApply();
		    	excelTurnApplyList.setTurnApply(excelTurnApply);
		    	excelTurnApplyList.setBookNo(excelBookNo);
		    	excelTurnApplyList.setMemberId(excelMemberId);
		    	excelTurnApplyList.setBookName(excelBookName);
		    	excelTurnApplyList.setSpotName(excelSpotName);
		    	excelTurnApplyList.setTurnapplyDate(excelTurnApplyDate);
		    	turnList.add(excelTurnApplyList);
		    	System.out.println(turnList.size());
		    	}
		    }
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
		    if(part.equals("member")) {
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
		 	    for(Member vo : memberList) {
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
		    }else if(part.equals("rentStatus")){
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
			    for(BookRentalStatus vo : rentStatusList) {
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
		    }else if(part.equals("rentApply")) {
		    	row = sheet.createRow(rowNo++);
			    cell = row.createCell(0);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue("대여 신청 번호");
			    
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
			    cell.setCellValue("대여장소");
			    
			    cell = row.createCell(5);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue("대여 신청 날짜");
			    
			    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			    // 데이터 부분 생성
			    for(RentApply vo : rentApplyList) {
			        row = sheet.createRow(rowNo++);
			        cell = row.createCell(0);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(vo.getRentApply());
			        
			        cell = row.createCell(1);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(vo.getBookNo());
			        
			        cell = row.createCell(2);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(vo.getMemberId());
			        
			        cell = row.createCell(3);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(vo.getBookName());
			        
			        cell = row.createCell(4);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(vo.getSpotName());
			        
			        String strRentApplyDate = sdFormat.format(vo.getRentApplyDate());
			        cell = row.createCell(5);
			        cell.setCellStyle(bodyStyle);
			        cell.setCellValue(strRentApplyDate);
			        
			    	}
		    }else if(part.equals("turnApply")) {
		    row = sheet.createRow(rowNo++);
		    cell = row.createCell(0);
		    cell.setCellStyle(headStyle);
		    cell.setCellValue("반납 신청 번호");
		    
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
		    cell.setCellValue("반납장소");
		    
		    cell = row.createCell(5);
		    cell.setCellStyle(headStyle);
		    cell.setCellValue("반납 신청 날짜");
		    
		    DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		    // 데이터 부분 생성
		    for(TurnApply vo : turnList) {
		        row = sheet.createRow(rowNo++);
		        cell = row.createCell(0);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getTurnApply());
		        
		        cell = row.createCell(1);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookNo());
		        
		        cell = row.createCell(2);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getMemberId());
		        
		        cell = row.createCell(3);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getBookName());
		        
		        cell = row.createCell(4);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(vo.getSpotName());
		        
		        String strTurnDate = sdFormat.format(vo.getTurnapplyDate());
		        cell = row.createCell(5);
		        cell.setCellStyle(bodyStyle);
		        cell.setCellValue(strTurnDate);
		        

		    	}
		    }
		    response.setContentType("application/vnd.ms-excel");

		    response.setHeader("Content-Disposition", "attachment;filename=test.xls");
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    
		}
		@RequestMapping("/adminBookReservationList.do")
		public String adminBookReservationList(Model model, int reqPage, int selectCount){
			ReservationPage rp= service.bookReservationList(reqPage,selectCount);
			
			model.addAttribute("list",rp.getList());
			model.addAttribute("pageNavi",rp.getPageNavi());
			model.addAttribute("reqPage",reqPage);
			model.addAttribute("selectCount",selectCount);
			return "admin/adminBookReservationList";
		}
		
		@ResponseBody
		@RequestMapping(value="/bookSearchReservationList.do", produces="application/json;charset=utf-8")
		public String BookSearchReservationList(HttpServletRequest request) {
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
			ReservationPage rp = service.bookSearchReservationList(selectColumn,search,aReqPage,selectCount,alignTitle,alignStatus);
			
			ArrayList<Reservation> list = rp.getList();
			String pageNavi = rp.getPageNavi();
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			String [] arrReserveDate = new String[list.size()];
			for(int i=0;i<list.size();i++) {
				Date reserveDate = rp.getList().get(i).getReserveDate();
					String strReserveDate = sdFormat.format(reserveDate);
					arrReserveDate[i] = strReserveDate;
			}
			System.out.println("pageNavi : "+pageNavi);
			ReservationSearchPage rsp = new ReservationSearchPage(list, pageNavi, arrReserveDate, aReqPage,selectCount);
			return new Gson().toJson(rsp);
		
		}
}


