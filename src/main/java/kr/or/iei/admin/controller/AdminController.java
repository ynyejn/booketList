package kr.or.iei.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.member.model.vo.Member;

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
		System.out.println(search);
		System.out.println(searchTitle);
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
	@RequestMapping(value="/memberList.do")
	public String memberList(Model model) {
		System.out.println("AdminController");
		ArrayList<Member>list = service.selectMember();
		model.addAttribute("list",list);
		return "/admin/memberList";
	}
}
