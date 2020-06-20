package kr.or.iei.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.admin.service.AdminService;
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
	public String adminBookList() {
		
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
