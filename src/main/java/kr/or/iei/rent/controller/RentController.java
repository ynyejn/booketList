package kr.or.iei.rent.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.book.model.vo.BookData;
import kr.or.iei.rent.model.service.RentService;

@Controller
@RequestMapping("/rent")
public class RentController {
	
	@Autowired
	@Qualifier("rentService")
	private RentService service;
	
	@RequestMapping("/goBookSearch.do")
	public String GoBookSearch(int reqPage, Model model) {
		BookData bd = service.selectBookPage(reqPage);
		model.addAttribute("list", bd.getBook());
		model.addAttribute("list", bd.getPageNavi());
		return "book/bookSearch";
	}
}
