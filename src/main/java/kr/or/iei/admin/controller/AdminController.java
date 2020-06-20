package kr.or.iei.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping(value="/adminPage.do")
	public String adminPageFrm() {
		return "/admin/adminPage";
	}
	@RequestMapping(value="/adminBookList.do")
	public String adminBookList() {
		
		return "admin/adminBookList";
	}
	@RequestMapping(value="/memberList.do")
	public String memberList() {
		return "/admin/memberList";
	}
}
