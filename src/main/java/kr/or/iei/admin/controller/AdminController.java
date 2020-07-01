package kr.or.iei.admin.controller;


import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.apply.model.vo.ApplyPageData;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.complain.model.vo.ComplainPageData;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.MemberPageData;
import kr.or.iei.member.model.vo.MemberPageSearchData;

@Controller
public class AdminController {
	
	@Autowired
	@Qualifier("adminService")
	private AdminService service;

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
		MemberPageData mpd = service.MemberSearchList(selectColumn,search,reqPage,selectCount);
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
	@RequestMapping("/adminDeleteMember.do")
	public String adminDeleteMember(String memberId) {
		int result = service.adminDeleteMember(memberId);
		System.out.println(result);
		if(result > 0) {
			return "redirect:/memberList.do?reqPage=1&selectCount=10";
		}else {
			return "redirect:/memberList.do?reqPage=1&selectCount=10";
		}
		
	}
}

