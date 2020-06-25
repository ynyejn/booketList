package kr.or.iei.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.MemberPageData;

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
		BookPageData bpd2 = null;
		if(!(search == null || search.equals(""))) {
			bpd = service.selectList3(reqPage,search,searchTitle);
			bpd2 = service.selectList3(reqPage2,search,searchTitle);
		}else {
			bpd = service.selectList1(reqPage);
			bpd2 = service.selectList2(reqPage2);
		}
		
		model.addAttribute("list1",bpd.getList());
		model.addAttribute("pageNavi1",bpd.getPageNavi());
		model.addAttribute("reqPage", reqPage);
		
		model.addAttribute("list2", bpd2.getList());
		model.addAttribute("pageNavi2", bpd2.getPageNavi());
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
	@RequestMapping(value="/detailOneBookDelete.do")
	public int detailOneBookDelete(Model model, int reqPage, int bookNo) {
		int result = service.detailOneBookDelete(bookNo);
		model.addAttribute("reqPage", reqPage);
		System.out.println("result : "+result);
		return result;
	}
	
	@RequestMapping(value="/memberList.do")
	public String memberList(Model model, int reqPage, int selectCount) {
		System.out.println("AdminController");
		MemberPageData mpd = service.selectMember(reqPage,selectCount);
		model.addAttribute("list",mpd.getList());
		model.addAttribute("pageNavi",mpd.getPageNavi());
		model.addAttribute("reqPage", reqPage);
		System.out.println(mpd.getList().size());
		return "/admin/memberList";
	}
}
