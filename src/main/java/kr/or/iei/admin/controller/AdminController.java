package kr.or.iei.admin.controller;


import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

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

	public String adminBookList(Model model, int reqPage, int check, int reqPage2) {
		BookPageData bpd = service.selectList1(reqPage);
		BookPageData bpd2 = service.selectList2(reqPage2);
		model.addAttribute("check", check);

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
		

		model.addAttribute("list2", bpd2.getList());
		model.addAttribute("pageNavi2", bpd2.getPageNavi());

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

	  @RequestMapping(value = "/ExcelPoi.do")
	  public void ExcelPoi(@RequestParam String fileName, HttpServletResponse response, Model model) throws Exception {

	  HSSFWorkbook objWorkBook = new HSSFWorkbook();
	  HSSFSheet objSheet = null;// 시트생성
	  HSSFRow objRow = null;// 행 생성
	  HSSFCell objCell = null;// 셀 생성

	  HSSFFont font = objWorkBook.createFont();
	  font.setFontHeightInPoints((short) 14);
	  // 글자 굵게 하기
	  font.setBoldweight((short) font.BOLDWEIGHT_BOLD);
	  // 폰트 설정
	  font.setFontName("맑은고딕");

	  // 제목 스타일에 폰트 적용, 정렬
	  HSSFCellStyle styleHd = objWorkBook.createCellStyle();// 제목 스타일
	  // 폰트 설정
	  styleHd.setFont(font);
	  // 가운데 정렬
	  styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	  styleHd.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	  objSheet = objWorkBook.createSheet("첫번째 시트"); // 워크시트 생성

	  List rowList = service.selectRow();

	  // 행으로 제작을 하네
	  // 1행
	  objRow = objSheet.createRow(0);
	  objRow.setHeight((short) 0x150);

	  objCell = objRow.createCell(0);
	  objCell.setCellValue("아이디");
	  objCell.setCellStyle(styleHd);

	  objCell = objRow.createCell(1);
	  objCell.setCellValue("이름");
	  objCell.setCellStyle(styleHd);

	  objCell = objRow.createCell(2);
	  objCell.setCellValue("나이");
	  objCell.setCellStyle(styleHd);

	  objCell = objRow.createCell(3);
	  objCell.setCellValue("이메일");
	  objCell.setCellStyle(styleHd);

	  int index = 1;
	  for (Map map : rowList) {
	    objRow = objSheet.createRow(index);
	    objRow.setHeight((short) 0x150);

	    objCell = objRow.createCell(0);
	    objCell.setCellValue((String)map.get("custId"));
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(1);
	    objCell.setCellValue((String)map.get("custName"));
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(2);
	    objCell.setCellValue((String)map.get("custAge"));
	    objCell.setCellStyle(styleHd);

	    objCell = objRow.createCell(3);
	    objCell.setCellValue((String)map.get("custEmail"));
	    objCell.setCellStyle(styleHd);
	    index++;
	  }

	  for (int i = 0; i < rowList.size(); i++) {
	    objSheet.autoSizeColumn(i);
	  }

	  response.setContentType("Application/Msexcel");
	  response.setHeader("Content-Disposition", "ATTachment; Filename="
	      + URLEncoder.encode(fileName, "UTF-8") + ".xls");

	  OutputStream fileOut = response.getOutputStream();
	  objWorkBook.write(fileOut);
	  fileOut.close();

	  response.getOutputStream().flush();
	  response.getOutputStream().close();
	}
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

}

