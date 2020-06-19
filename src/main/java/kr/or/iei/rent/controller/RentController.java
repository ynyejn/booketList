package kr.or.iei.rent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/rent")
public class RentController {
	
	
	@RequestMapping("/goBookSearch.do")
	public String GoBookSearch() {
		return "book/bookSearch";
	}
}
