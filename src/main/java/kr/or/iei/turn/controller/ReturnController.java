package kr.or.iei.turn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.turn.model.service.ReturnService;

@Controller
public class ReturnController {
	@Autowired
	private ReturnService service;
	
	@RequestMapping("/goBookReturn.do")
	public String goBookReturn() {
		return "book/returnBook";
	}
}
