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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
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
		
		model.addAttribute("list1",bpd.getList());
		model.addAttribute("pageNavi1",bpd.getPageNavi());
		
		model.addAttribute("list2", bpd2.getList());
		model.addAttribute("pageNavi2", bpd2.getPageNavi());
		
		return "admin/adminBookList";
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
